
LOG("Hooked version! ----------------------------------------")

function SpawnWeatherAtClusterList( ClusterData, MapStyle, EffectType )

    LOG("Running hooked version!")

    local numClusters = table.getn( ClusterData )
    local WeatherEffects = MapWeatherList[MapStyle][EffectType]
    
    -- Exit out early, if for some reason, we have no effects defined for this
    if (WeatherEffects == nil) or (WeatherEffects != nil and (table.getn(WeatherEffects) == 0)) then
      return	
    end
    
    -- Parse through cluster position and datal
    for i = 1, numClusters do
      -- Determine whether current cluster should spawn or not
      if ClusterData[i].spawnChance < 1 then
        local pick
        if util.GetRandomFloat( 0, 1 ) > ClusterData[i].spawnChance then
          LOG( 'Cluster ' .. i .. ' No clouds generated ' )
          continue
        end
      end
    
      local clusterSpreadHalfSize = ClusterData[i].clusterSpread * 0.5
      local numCloudsPerCluster = nil
      if ClusterData[i].cloudCountRange != 0 then
        numCloudsPerCluster = util.GetRandomInt(ClusterData[i].cloudCount - ClusterData[i].cloudCountRange / 2,ClusterData[i].cloudCount + ClusterData[i].cloudCountRange / 2)
      else
        numCloudsPerCluster = ClusterData[i].cloudCount
      end
      local clusterEffectMaxScale = ClusterData[i].emitterScale + ClusterData[i].emitterScaleRange
      local clusterEffectMinScale = ClusterData[i].emitterScale - ClusterData[i].emitterScaleRange
    
      LOG( 'Cluster ' .. i .. ', Clouds generated ', numCloudsPerCluster )
      
      -- Calculate weather cluster entity positional range
      local LeftX = ClusterData[i].position[1] - clusterSpreadHalfSize
      local TopZ = ClusterData[i].position[3] - clusterSpreadHalfSize
      local RightX = ClusterData[i].position[1] + clusterSpreadHalfSize
      local BottomZ = ClusterData[i].position[3] + clusterSpreadHalfSize		
      
      -- Get base height and height range
      local BaseHeight = ClusterData[i].position[2] + ClusterData[i].cloudHeight
      local HeightOffset = ClusterData[i].cloudHeightRange	
      
      -- Choose weather cluster effects
      local clusterWeatherEffects = WeatherEffects
      local numEffects = table.getn(WeatherEffects) 
      if ClusterData[i].forceType != "None" then
        clusterWeatherEffects = MapWeatherList[MapStyle][ClusterData[i].forceType] 
        LOG( 'Force Effect Type: ', ClusterData[i].forceType )			
        numEffects = table.getn(clusterWeatherEffects) 
      end
      
      -- Generate Clouds for our cluster
      for j = 0, numCloudsPerCluster do
        local cloud = Entity()

        -- make sure it always has vision
        cloud:SetVizToAllies('Always')
        cloud:SetVizToEnemies('Always')
        cloud:SetVizToNeutrals('Always')
        cloud:SetVizToFocusPlayer('Always')

        local x = util.GetRandomInt( LeftX, RightX )
        local y = BaseHeight + util.GetRandomInt(-HeightOffset,HeightOffset)
        local z = util.GetRandomInt( TopZ, BottomZ )
        Warp( cloud, Vector(x,y,z) )
        --LOG( 'Generating cloud at: ', x .. ' ' .. y .. ' ' .. z )	
        
        local EmitterGroupSeed = util.GetRandomInt(1,numEffects)
        local numEmitters = table.getn(clusterWeatherEffects[EmitterGroupSeed])
        local effects = clusterWeatherEffects[EmitterGroupSeed]
        
        for k, v in clusterWeatherEffects[EmitterGroupSeed] do

-- Method    Moho
-- __index    moho.IEffect
-- Destroy    moho.IEffect.Destroy
-- OffsetEmitter    moho.IEffect.OffsetEmitter
-- ResizeEmitterCurve    moho.IEffect.ResizeEmitterCurve
-- ScaleEmitter    moho.IEffect.ScaleEmitter
-- SetBeamParam    moho.IEffect.SetBeamParam
-- SetEmitterCurveParam    moho.IEffect.SetEmitterCurveParam
-- SetEmitterParam    moho.IEffect.SetEmitterParam

-- :SetEmitterCurveParam('X_POSITION_CURVE',0,sx * 1.5)
-- :SetEmitterCurveParam('Z_POSITION_CURVE',0,sz * 1.5)

          emitter = CreateEmitterAtBone(cloud,-2,-1,v)
          emitter:ScaleEmitter(util.GetRandomFloat( clusterEffectMaxScale, clusterEffectMinScale ))		
          emitter:SetEmitterParam("EMITIFVISIBLE", 0)	
        end
      end
    end
  end