package com.gridgain.eav.config;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.LinkedHashMap;
import org.apache.ignite.cache.CacheAtomicityMode;
import org.apache.ignite.cache.CacheKeyConfiguration;
import org.apache.ignite.cache.CacheMode;
import org.apache.ignite.cache.QueryEntity;
import org.apache.ignite.configuration.CacheConfiguration;
import org.apache.ignite.configuration.DataRegionConfiguration;
import org.apache.ignite.configuration.DataStorageConfiguration;
import org.apache.ignite.configuration.IgniteConfiguration;
import org.apache.ignite.spi.discovery.tcp.TcpDiscoverySpi;
import org.apache.ignite.spi.discovery.tcp.ipfinder.vm.TcpDiscoveryVmIpFinder;

/** This file was generated by Ignite Web Console (08/27/2020, 13:47) **/
public class ServerConfigurationFactory {
    /**
     * Configure grid.
     * 
     * @return Ignite configuration.
     * @throws Exception If failed to construct Ignite configuration instance.
     **/
    public static IgniteConfiguration createConfiguration() throws Exception {
        IgniteConfiguration cfg = new IgniteConfiguration();

        cfg.setIgniteInstanceName("eav");

        TcpDiscoverySpi discovery = new TcpDiscoverySpi();

        TcpDiscoveryVmIpFinder ipFinder = new TcpDiscoveryVmIpFinder();

        ipFinder.setAddresses(Arrays.asList("127.0.0.1:47500..47510"));

        discovery.setIpFinder(ipFinder);

        cfg.setDiscoverySpi(discovery);

        cfg.setAuthenticationEnabled(true);

        DataStorageConfiguration dataStorageCfg = new DataStorageConfiguration();

        DataRegionConfiguration dataRegionCfg = new DataRegionConfiguration();

        dataRegionCfg.setMetricsEnabled(true);
        dataRegionCfg.setPersistenceEnabled(true);

        dataStorageCfg.setDefaultDataRegionConfiguration(dataRegionCfg);

        dataStorageCfg.setStoragePath("db_eav");
        dataStorageCfg.setWalPath("db_eav/wal");
        dataStorageCfg.setWalArchivePath("db_eav/wal/archive");
        dataStorageCfg.setMetricsEnabled(true);
        dataStorageCfg.setWalCompactionEnabled(true);

        cfg.setDataStorageConfiguration(dataStorageCfg);

        cfg.setCacheConfiguration(
            cacheAttributeCache(),
            cacheEntityAttributeCache(),
            cacheEntityCache(),
            cacheValueCache()
        );

        return cfg;
    }

    /**
     * Create configuration for cache "AttributeCache".
     * 
     * @return Configured cache.
     **/
    public static CacheConfiguration cacheAttributeCache() {
        CacheConfiguration ccfg = new CacheConfiguration();

        ccfg.setName("AttributeCache");
        ccfg.setCacheMode(CacheMode.REPLICATED);
        ccfg.setAtomicityMode(CacheAtomicityMode.ATOMIC);
        ccfg.setCopyOnRead(true);
        ccfg.setSqlSchema("EAV");
        ccfg.setEagerTtl(true);
        ccfg.setStatisticsEnabled(true);
        ccfg.setManagementEnabled(true);

        ArrayList<QueryEntity> qryEntities = new ArrayList<>();

        QueryEntity qryEntity = new QueryEntity();

        qryEntity.setKeyType("java.lang.String");
        qryEntity.setValueType("com.gridgain.eav.model.Attribute");
        qryEntity.setKeyFieldName("name");

        HashSet<String> keyFields = new HashSet<>();

        keyFields.add("name");

        qryEntity.setKeyFields(keyFields);

        LinkedHashMap<String, String> fields = new LinkedHashMap<>();

        fields.put("datatype", "java.lang.String");
        fields.put("description", "java.lang.String");
        fields.put("name", "java.lang.String");

        qryEntity.setFields(fields);
        qryEntities.add(qryEntity);

        ccfg.setQueryEntities(qryEntities);

        return ccfg;
    }

    /**
     * Create configuration for cache "EntityAttributeCache".
     * 
     * @return Configured cache.
     **/
    public static CacheConfiguration cacheEntityAttributeCache() {
        CacheConfiguration ccfg = new CacheConfiguration();

        ccfg.setName("EntityAttributeCache");
        ccfg.setCacheMode(CacheMode.REPLICATED);
        ccfg.setAtomicityMode(CacheAtomicityMode.ATOMIC);
        ccfg.setCopyOnRead(true);
        ccfg.setSqlSchema("EAV");

        ccfg.setKeyConfiguration(new CacheKeyConfiguration[] {
            new CacheKeyConfiguration("com.gridgain.eav.model.EntityattributeKey", "entity")
        });

        ccfg.setEagerTtl(true);

        ArrayList<QueryEntity> qryEntities = new ArrayList<>();

        QueryEntity qryEntity = new QueryEntity();

        qryEntity.setKeyType("com.gridgain.eav.model.EntityAttributeKey");
        qryEntity.setValueType("com.gridgain.eav.model.EntityAttribute");

        HashSet<String> keyFields = new HashSet<>();

        keyFields.add("entity");

        keyFields.add("attr");

        qryEntity.setKeyFields(keyFields);

        LinkedHashMap<String, String> fields = new LinkedHashMap<>();

        fields.put("entity", "java.lang.String");
        fields.put("attr", "java.lang.String");
        fields.put("sequence", "java.math.BigDecimal");

        qryEntity.setFields(fields);
        qryEntities.add(qryEntity);

        ccfg.setQueryEntities(qryEntities);

        return ccfg;
    }

    /**
     * Create configuration for cache "EntityCache".
     * 
     * @return Configured cache.
     **/
    public static CacheConfiguration cacheEntityCache() {
        CacheConfiguration ccfg = new CacheConfiguration();

        ccfg.setName("EntityCache");
        ccfg.setCacheMode(CacheMode.REPLICATED);
        ccfg.setAtomicityMode(CacheAtomicityMode.ATOMIC);
        ccfg.setCopyOnRead(true);
        ccfg.setSqlSchema("EAV");
        ccfg.setEagerTtl(true);

        ArrayList<QueryEntity> qryEntities = new ArrayList<>();

        QueryEntity qryEntity = new QueryEntity();

        qryEntity.setKeyType("java.lang.String");
        qryEntity.setValueType("com.gridgain.eav.model.Entity");
        qryEntity.setKeyFieldName("name");

        HashSet<String> keyFields = new HashSet<>();

        keyFields.add("name");

        qryEntity.setKeyFields(keyFields);

        LinkedHashMap<String, String> fields = new LinkedHashMap<>();

        fields.put("description", "java.lang.String");
        fields.put("ontology", "java.lang.String");
        fields.put("name", "java.lang.String");

        qryEntity.setFields(fields);
        qryEntities.add(qryEntity);

        ccfg.setQueryEntities(qryEntities);

        return ccfg;
    }

    /**
     * Create configuration for cache "ValueCache".
     * 
     * @return Configured cache.
     **/
    public static CacheConfiguration cacheValueCache() {
        CacheConfiguration ccfg = new CacheConfiguration();

        ccfg.setName("ValueCache");
        ccfg.setCacheMode(CacheMode.PARTITIONED);
        ccfg.setAtomicityMode(CacheAtomicityMode.ATOMIC);
        ccfg.setBackups(1);
        ccfg.setReadFromBackup(true);
        ccfg.setCopyOnRead(true);
        ccfg.setSqlSchema("EAV");

        ccfg.setKeyConfiguration(new CacheKeyConfiguration[] {
            new CacheKeyConfiguration("com.gridgain.eav.model.ValueKey", "attr")
        });

        ccfg.setEagerTtl(true);

        ArrayList<QueryEntity> qryEntities = new ArrayList<>();

        QueryEntity qryEntity = new QueryEntity();

        qryEntity.setKeyType("com.gridgain.eav.model.ValueKey");
        qryEntity.setValueType("com.gridgain.eav.model.Value");

        HashSet<String> keyFields = new HashSet<>();

        keyFields.add("entity");

        keyFields.add("id");

        keyFields.add("attr");

        qryEntity.setKeyFields(keyFields);

        LinkedHashMap<String, String> fields = new LinkedHashMap<>();

        fields.put("entity", "java.lang.String");
        fields.put("id", "java.lang.Integer");
        fields.put("attr", "java.lang.String");
        fields.put("val", "java.lang.String");

        qryEntity.setFields(fields);
        qryEntities.add(qryEntity);

        ccfg.setQueryEntities(qryEntities);

        return ccfg;
    }
}