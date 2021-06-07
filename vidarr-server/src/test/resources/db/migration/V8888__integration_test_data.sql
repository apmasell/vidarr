SET TIMEZONE='America/Toronto';

-- Disable all triggers
BEGIN;
ALTER TABLE active_workflow_run DISABLE TRIGGER active_workflow_run_update;
ALTER TABLE analysis DISABLE TRIGGER analysis_update;
ALTER TABLE external_id DISABLE TRIGGER external_id_update;
ALTER TABLE workflow DISABLE TRIGGER workflow_update;
ALTER TABLE workflow_definition DISABLE TRIGGER workflow_definition_update;
ALTER TABLE workflow_run DISABLE TRIGGER workflow_run_update;
ALTER TABLE workflow_version DISABLE TRIGGER workflow_version_update;

INSERT INTO workflow (id, is_active, labels, max_in_flight, modified, name) VALUES
  (4, false, null, 1, NOW(), 'bcl2fastq'),
  (5, true, null, 8, NOW(), 'import_fastq')
  ON CONFLICT DO NOTHING;

  INSERT INTO workflow_definition (id, hash_id, modified, workflow_file, workflow_language) VALUES
    (8, 'cc77e42b11c4b4f4078138dc1b0a7c3695cd1d3ba6d39df5f7ef1e787ff0d92c',('2021-05-14 09:53:52-04'::timestamptz), 14010515, 'NIASSA'),
    (9, 'fda21dd38f908cb11d7596d587c5c478c3e7627d78312a66c9657869a2ee95cf',('2021-05-14 09:53:52-04'::timestamptz), 14244254, 'NIASSA'),
    (10, 'f217aea7b3d62b86611b094252ff19aed3db6b29110f11c77368fe8595ae5d7a',('2021-05-14 09:53:52-04'::timestamptz), 538766, 'WDL_1_0'),
    (11, '6f229aace247e07be3c667175891bc8f3bcec6ca66138d885cf09c2547721298',('2021-05-14 09:53:52-04'::timestamptz), 14696389, 'NIASSA'),
    (12, '322142e016e988712de8c373dd1ede27b243aec64b61cd4aa5aa5137e3754b54',('2021-05-14 09:53:52-04'::timestamptz), 11034, 'NIASSA'),
    (13, '9e39c488f09ead0403b8fe3a1d31942ecb6a5d32e379d96eab5b3f5ef0e2bd6f',('2021-05-14 09:53:52-04'::timestamptz), 996126, 'NIASSA'),
    (14, '97b9d803e1548bf0ea24a418503010828528067dca30b3f7031d17a638fb8991',('2021-05-14 09:53:52-04'::timestamptz), 1753095, 'NIASSA'),
    (15, 'f67c4e055cf8f126d9429db4a36d6a269eb95a4b6bdb3c10be4b793ff1cd5af1',('2021-05-14 09:53:52-04'::timestamptz), 5300868, 'NIASSA'),
    (16, '926603f4b849faca0ed789e638a24bd9c5df8c09c4e1c48cd1298bf0d0c4a7d8',('2021-05-14 09:53:52-04'::timestamptz), 5300924, 'NIASSA'),
    (17, '390869b8e74f26ec66460caaf1e8196cb8371d6bf645dcbaf8d966d198e4c33b',('2021-05-14 09:53:52-04'::timestamptz), 15031683, 'NIASSA'),
    (18, 'f4891cc74201c8790bbd017ad88bfd89cd1331fecd17a741d6a3e76dd70cc1e2',('2021-05-14 09:53:52-04'::timestamptz), 17040615, 'NIASSA'),
    (19, '5f5e1bf5e856a1c923be41e1a272a51af19168e0597cd78c433a268849b2f892',('2021-05-14 09:53:52-04'::timestamptz), 17835339, 'NIASSA'),
    (20, '706ca65c70cce56c9df57674e805cebeea31867e8194dc29b78fa791563b0184',('2021-05-14 09:53:52-04'::timestamptz), 12901362, 'NIASSA'),
    (21, '926603f4b849f9b8e772a51af19168e0597cf1e8196cb88528067dca371d6b30',('2021-05-14 09:53:52-04'::timestamptz), 29438457, 'NIASSA')
    ON CONFLICT DO NOTHING;

INSERT INTO workflow_version (id, hash_id, metadata, modified, name, parameters, version, workflow_definition) VALUES
  (14, 'c3ba7a890c24fa35137411f59949ce262625814ae5c24efea1d03c0315f26072', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'bcl2fastq', '{"workflowRunSWID": "integer"}', '1.0.0.14010515', 8),
  (15, 'c0f95e56510d1466a09121194de214b71756e8507a5196c5b0b101786ffeb535', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'bcl2fastq', '{"workflowRunSWID": "integer"}', '1.1.0.14244254',9),
  (16, '89869d251d24036217782fc5b7766c6459b47b79d762967e4a5a025e52535336', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'bcl2fastq', '{"workflowRunSWID": "integer"}', '1.1.0.538766', 10),
  (17, 'd0bf0d52bdd51d85563f5e18297a3b3799f0426416d0cae6a2dd394c6519c09e', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'bcl2fastq', '{"workflowRunSWID": "integer"}', '1.2.0.14696389', 11),
  (18, '387ae7c71982983534624f52ae1570ed95760cbb5961265d7f153a1c6624c7e2', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'bcl2fastq', '{"workflowRunSWID": "integer"}', '1.8.2.11034', 12),
  (19, '59a02e740082093328cf0e9d9e894484cded7a864599be82c7e9cefd7ee6625e', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'bcl2fastq', '{"workflowRunSWID": "integer"}', '2.6.0.996126', 13),
  (20, '1ec38d70365417963f876bfbf3ee02cb96661224371ae4e06dd54a54162f1527', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'bcl2fastq', '{"workflowRunSWID": "integer"}', '2.7.0.1753095', 14),
  (21, 'fdaada0ee6a472996db76741d8991fbc24bf2316c2b1b5e88e89da86402a107e', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'bcl2fastq', '{"workflowRunSWID": "integer"}', '2.7.1.5300868', 15),
  (22, '23c46b7d0315b27b524158a9daa672dc23b16eef76f50ef1dfa2b5a115e63d33', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'bcl2fastq', '{"workflowRunSWID": "integer"}', '2.9.1.5300924', 16),
  (23, '2422aa2eeafa9dd706af2e6d7f24990460750c4f2b887ced5888a8cab05ed030', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'bcl2fastq', '{"workflowRunSWID": "integer"}', '2.9.2.15031683', 17),
  (24, 'a63acbac3576d2c9f03b28370af67b18a9651a480b099819327c046f02ed2eb6', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'bcl2fastq', '{"workflowRunSWID": "integer"}', '3.0.0.17040615', 18),
  (25, 'b74a04bc488c209aa6bf3ab55c5d66073ee46c919497ba4dde33cd83e1a000c3', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'bcl2fastq', '{"workflowRunSWID": "integer"}', '3.1.2.17835339', 19),
  (26, '7669b2774ce0502a21a6eb4937837f28ad71e4105fbd38a6e6c34eed2a3bd0c1', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'import_fastq', '{"workflowRunSWID": "integer"}', '1.0.0.12901362', 20),
  (27, 'b524158a9da21a6eb493ef76f528a2422aa2e05fb28370daada0ee6a47299633', '{"fastqs": "files"}',('2021-05-14 09:53:52-04'::timestamptz), 'import_fastq', '{"workflowRunSWID": "integer"}', '1.1.0', 21)
  ON CONFLICT DO NOTHING;

INSERT INTO workflow_run (id, arguments, completed, created, engine_parameters, hash_id, input_file_ids, labels, last_accessed, metadata, modified, started, workflow_version_id) VALUES
  (1, '{"workflowRunSWID": "14718214"}',('2019-07-15 15:27:27.206-04'::timestamptz),('2019-07-15 15:00:27.206-04'::timestamptz), '{}', '2f52b25df0a20cf41b0476b9114ad40a7d8d2edbddf0bed7d2d1b01d3f2d2b56', '{}', '{}',('2019-07-16 15:01:27.206-04'::timestamptz), '{}',('2019-07-15 15:01:27.206-04'::timestamptz), ('2019-07-15 15:27:27.206-04'::timestamptz), 22),
  (2, '{"workflowRunSWID": "17532441"}',('2020-07-03 09:55:31.188-04'::timestamptz),('2020-07-03 09:00:31.188-04'::timestamptz), '{}', 'a5f036ac00769744f9349775b376bf9412a5b28191fb7dd5ca4e635338e9f2b5', '{}', '{}',('2020-07-04 09:01:31.188-04'::timestamptz), '{}',('2020-07-03 09:01:31.188-04'::timestamptz), ('2020-07-03 09:55:31.188-04'::timestamptz), 24),
  (3, '{"workflowRunSWID": "12939836"}',('2018-11-19 14:19:52.533-05'::timestamptz),('2018-11-19 14:00:52.533-05'::timestamptz), '{}', '0e56d35b158b72bc209ff97e7792b0cdf0371691913a9a2495be324b20b061ba', '{}', '{}',('2018-11-20 14:01:52.533-05'::timestamptz), '{}',('2018-11-19 14:01:52.533-05'::timestamptz), ('2018-11-19 14:19:52.533-05'::timestamptz), 21),
  (4, '{"workflowRunSWID": "19633441"}',('2021-01-14 00:18:39.604-05'::timestamptz),('2021-01-14 00:00:39.604-05'::timestamptz), '{}', '89efe1cab1cd5146ff5a0d9c3f570308bc9fcfb940fbdec5d043572c7b479dd3', '{}', '{}',('2021-01-15 00:01:39.604-05'::timestamptz), '{}',('2021-01-14 00:01:39.604-05'::timestamptz), ('2021-01-14 00:18:39.604-05'::timestamptz), 25),
  (5, '{"workflowRunSWID": "19826975"}',('2021-01-28 10:31:35.742-05'::timestamptz),('2021-01-28 10:00:35.742-05'::timestamptz), '{}', '93431099bef945c960ade939f2a1d0fcb728f3873f2cccddcb438273afa8cb98', '{}', '{}',('2021-01-29 10:01:35.742-05'::timestamptz), '{}',('2021-01-28 10:01:35.742-05'::timestamptz), ('2021-01-28 10:31:35.742-05'::timestamptz), 25),
  (6, '{"workflowRunSWID": "20285172"}',('2021-02-22 18:19:56.782-05'::timestamptz),('2021-02-22 18:00:56.782-05'::timestamptz), '{}', '9bf843d58986baa7469ce1c73e921ef294caf27e8e4b65a7f2ff65646f0ff770', '{}', '{}',('2021-02-23 18:01:56.782-05'::timestamptz), '{}',('2021-02-22 18:01:56.782-05'::timestamptz), ('2021-02-22 18:19:56.782-05'::timestamptz), 25),
  (7, '{"workflowRunSWID": "20102946"}',('2021-02-15 19:49:28.291-05'::timestamptz),('2021-02-15 19:00:28.291-05'::timestamptz), '{}', '5d93d47a8dfc7e038bdc3ffc4b7faf6a53a22c51ae9df7d683aef912510b0a88', '{}', '{}',('2021-02-16 19:01:28.291-05'::timestamptz), '{}',('2021-02-15 19:01:28.291-05'::timestamptz), ('2021-02-15 19:49:28.291-05'::timestamptz), 25),
  (8, '{"workflowRunSWID": "18757570"}',('2020-11-13 11:57:05.97-05'::timestamptz),('2020-11-13 11:00:05.97-05'::timestamptz), '{}', '40456ae079abc87805ba3ece5eebaf747170c794daa111bcf0107a81e59f7043', '{}', '{}',('2020-11-14 11:01:05.97-05'::timestamptz), '{}',('2020-11-13 11:01:05.97-05'::timestamptz), ('2020-11-13 11:57:05.97-05'::timestamptz), 25),
  (9, '{"workflowRunSWID": "15496738"}',('2019-12-09 12:29:51.791-05'::timestamptz),('2019-12-09 12:00:51.791-05'::timestamptz), '{}', '0bcb6c06a54d454fb89a99c3761e474b1fe332c5b7fd61216b76ba9c97c13cb5', '{}', '{}',('2019-12-10 12:01:51.791-05'::timestamptz), '{}',('2019-12-09 12:01:51.791-05'::timestamptz), ('2019-12-09 12:29:51.791-05'::timestamptz), 17),
  (10, '{"workflowRunSWID": "1423144"}',('2015-02-19 03:08:48.262-05'::timestamptz),('2015-02-19 03:00:48.262-05'::timestamptz), '{}', 'df7d833b96031f6e8a7e869d16972706013e84434f6dd040df25f7f662ca1c8f', '{}', '{}',('2015-02-20 03:01:48.262-05'::timestamptz), '{}',('2015-02-19 03:01:48.262-05'::timestamptz), ('2015-02-19 03:08:48.262-05'::timestamptz), 19),
  (11, '{"workflowRunSWID": "4444444"}', NULL,('2015-02-19 03:00:48.262-05'::timestamptz), '{}', 'df7df7df7df7df7df7df7df7df7df70df7df7df7df7df7df7df7df7df7df7df7', '{}', '{}', '2021-05-14 09:53:51.566519-04', '{}',('2015-02-20 03:01:48.262-05'::timestamptz),('2015-02-19 03:01:48.262-05'::timestamptz), 19)
  ON CONFLICT DO NOTHING;

INSERT INTO analysis (id, analysis_type, created, file_md5sum, file_metatype, file_path, file_size, hash_id, labels, modified, workflow_run_id) VALUES
  (1, 'file',('2019-07-15 15:27:27.206-04'::timestamptz), 'f48142a9bee7e789c15c21bd34e9adec', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/CASAVA_2.9.1/83779816/SWID_14718190_DCRT_016_Br_R_PE_234_MR_obs528_P016_190711_M00146_0072_000000000-D6D3B_ACTGAT_L001_R2_001.fastq.gz', 7135629, '916df707b105ddd88d8979e41208f2507a6d0c8d3ef57677750efa7857c4f6b2', '{"read_number": "2", "niassa-file-accession": "14718426"}',('2021-05-14 09:53:52-04'::timestamptz), 1),
  (2, 'file',('2019-07-15 15:27:27.206-04'::timestamptz), 'f5a9bc38226eefd2fc0fd2f184b96bbd', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/CASAVA_2.9.1/83779816/SWID_14718190_DCRT_016_Br_R_PE_234_MR_obs528_P016_190711_M00146_0072_000000000-D6D3B_ACTGAT_L001_R1_001.fastq.gz', 6895259, 'b08b70c9842d9b459fe66be4b22fcdc70bf7e90da8d881e17351026638c969be', '{"read_number": "1", "niassa-file-accession": "14718436"}',('2021-05-14 09:53:52-04'::timestamptz), 1),
  (3, 'url',('2020-07-03 09:55:31.188-04'::timestamptz), 'a929ad83fc66b98184cc6ae0f661dd8d', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/bcl2fastq_3.0.0/17532441/PBCM_0097_Ly_n_PE_230623_CM_200702_A00469_0109_AHTCFJDMXX_1_AGAGTAGC-TACGCCTT_R1.fastq.gz', 2329084144, 'dbaac5f6b09b46f68d575bc36d024d4198883dbff8377be3a6c9fd62c3605a54', '{"read_count": "456352644", "read_number": "1", "niassa-file-accession": "17532714"}',('2021-05-14 09:53:52-04'::timestamptz), 2),
  (4, 'url',('2020-07-03 09:55:31.188-04'::timestamptz), 'ed1034c2ca50df41eed0b8c38f04658b', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/bcl2fastq_3.0.0/17532441/PBCM_0097_Ly_n_PE_230623_CM_200702_A00469_0109_AHTCFJDMXX_1_AGAGTAGC-TACGCCTT_R2.fastq.gz', 2472983492, '325e788eaef18eda73a5e2676a952f0acb8315bae952dde9e4eee27b41c285d6', '{"read_count": "456352644", "read_number": "2", "niassa-file-accession": "17532733"}',('2021-05-14 09:53:52-04'::timestamptz), 2),
  (5, 'file',('2018-11-19 14:19:52.533-05'::timestamptz), '4d98d892a46bb33f9ce3e7606728d597', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/CASAVA_2.7.1/70071008/SWID_12939619_SCRM_0934_Bn_M_PE_1014_WT_NoGroup_181116_D00353_0302_BHMY7MBCX2_GCTACGCT-AGAGTAGA_L001_R1_001.fastq.gz', 120160832, '618ddba635776bad843e603aaffa3e9da8fda9d00c71e27252424102ea8f6731', '{"read_number": "1", "niassa-file-accession": "12940448"}',('2021-05-14 09:53:52-04'::timestamptz), 3),
  (6, 'file',('2018-11-19 14:19:52.533-05'::timestamptz), '4ea960be985e36822377fce25ac251f3', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/CASAVA_2.7.1/70071008/SWID_12939619_SCRM_0934_Bn_M_PE_1014_WT_NoGroup_181116_D00353_0302_BHMY7MBCX2_GCTACGCT-AGAGTAGA_L001_R2_001.fastq.gz', 127352498, 'd3c4740250e41c66f2f6d01690ed50eae9d09e277eceb4bee9376a2bfb3ab8f2', '{"read_number": "2", "niassa-file-accession": "12940450"}',('2021-05-14 09:53:52-04'::timestamptz), 3),
  (7, 'file',('2021-01-14 00:18:39.604-05'::timestamptz), '47f1b4a573e82dd9a55fa43b47b69fce', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/bcl2fastq_3.1.2/19633441/SCTSF_0007_nn_U_PE_326000_TS_210112_A00469_0146_BH2CMMDRXY_1_ACGGTCCAAC-TGATGTAAGA_R1.fastq.gz', 160006, '86551ed78a887ed1ac1c4f37fcb75c4ad4c965118c7e9bb24c52cf73217c5973', '{"read_count": "2592", "read_number": "1", "niassa-file-accession": "19634281"}',('2021-05-14 09:53:52-04'::timestamptz), 4),
  (8, 'file',('2021-01-14 00:18:39.604-05'::timestamptz), '439d7d28467e69448f3211e58c8cf518', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/bcl2fastq_3.1.2/19633441/SCTSF_0007_nn_U_PE_326000_TS_210112_A00469_0146_BH2CMMDRXY_1_ACGGTCCAAC-TGATGTAAGA_R2.fastq.gz', 152551, 'e02d19583c5daa1b71e18c8ea33564aa957fb0bc3e611b97a0d434ad3c36d383', '{"read_count": "2592", "read_number": "2", "niassa-file-accession": "19634309"}',('2021-05-14 09:53:52-04'::timestamptz), 4),
  (9, 'file',('2021-01-28 10:31:35.742-05'::timestamptz), '376e9f50f03f891eff4e7170dd130e06', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/bcl2fastq_3.1.2/19826975/KLCS_0020_Ly_R_PE_386_TS_210127_M00753_0319_000000000-DBGJW_1_AGTGGATC-GTCATCGA_R1.fastq.gz', 3602022, '1577543f8837af5590972226890f508db390e74d7d17f94c3a6351169afeb535', '{"read_count": "29627", "read_number": "1", "niassa-file-accession": "19827413"}',('2021-05-14 09:53:52-04'::timestamptz), 5),
  (10, 'file',('2021-01-28 10:31:35.742-05'::timestamptz), 'df1219b30ebeb7a4b9eb6d09c67caf4b', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/bcl2fastq_3.1.2/19826975/KLCS_0020_Ly_R_PE_386_TS_210127_M00753_0319_000000000-DBGJW_1_AGTGGATC-GTCATCGA_R2.fastq.gz', 3716749, '9235e57bac06186f303a2bc844d2b81edfd4eb239d61069cf34838b430430f08', '{"read_count": "29627", "read_number": "2", "niassa-file-accession": "19827421"}',('2021-05-14 09:53:52-04'::timestamptz), 5),
  (11, 'file',('2021-02-22 18:19:56.782-05'::timestamptz), '5b60257a56561bfab6d03d0e0127e54c', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/bcl2fastq_3.1.2/20285172/SCTSF_0008_nn_U_PE_377_TS_210219_A00469_0156_BH37MLDRXY_1_GGATTATGGA-CTCTATCGGA_R1.fastq.gz', 27981081, 'f4d67445af4103e1e48c02f1feb31e762b3209095067b798881a253e7cb8cf66', '{"read_count": "205618", "read_number": "1", "niassa-file-accession": "20285693"}',('2021-05-14 09:53:52-04'::timestamptz), 6),
  (12, 'file',('2021-02-22 18:19:56.782-05'::timestamptz), '6b03c585ec7326db101f0166e8973dbb', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/bcl2fastq_3.1.2/20285172/SCTSF_0008_nn_U_PE_377_TS_210219_A00469_0156_BH37MLDRXY_1_GGATTATGGA-CTCTATCGGA_R2.fastq.gz', 27694626, '78269bec2283e6d7a5d0fb91595325bde5bb4616d13f3e8ccb421ea33fbb5ced', '{"read_count": "205618", "read_number": "2", "niassa-file-accession": "20285707"}',('2021-05-14 09:53:52-04'::timestamptz), 6),
  (13, 'file',('2021-02-15 19:49:28.291-05'::timestamptz), '42eadbd804bdcc432e70b7acbff2819b', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/bcl2fastq_3.1.2/20102946/CCGP_0342_Np_n_PE_380_TS_210212_A00469_0150_BH37YLDRXY_1_AAGCATCTTG-TTGTTGAATG_R1.fastq.gz', 41345815, '6104978a4561846fa0d72e3f61e55c405ad82451cd33b053fcdfe09f7ce9ccdc', '{"read_count": "267505", "read_number": "1", "niassa-file-accession": "20105397"}',('2021-05-14 09:53:52-04'::timestamptz), 7),
  (14, 'file',('2021-02-15 19:49:28.291-05'::timestamptz), '2273ab46b6fca8e63262d43ccbfbbff5', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/bcl2fastq_3.1.2/20102946/CCGP_0342_Np_n_PE_380_TS_210212_A00469_0150_BH37YLDRXY_1_AAGCATCTTG-TTGTTGAATG_R2.fastq.gz', 41964245, '6256fb1d605103fd38126dbfa3bc45e7894b062ce93219d14162eaaf340dfcc7', '{"read_count": "267505", "read_number": "2", "niassa-file-accession": "20105423"}',('2021-05-14 09:53:52-04'::timestamptz), 7),
  (15, 'file',('2020-11-13 11:57:05.97-05'::timestamptz), '3de40105e1827c5ee2a84ac8322c1d32', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/bcl2fastq_3.1.2/18757570/HPCC_0073_01_LB01-02_201112_M06816_0061_000000000-D9RDP_1_CATACCAC-CGGTTGTT_R1.fastq.gz', 599691, 'e0ce61cfc43e2deee2e8fb7501b3db80ae194e3d2cef796a72f3f0e40c36ee19', '{"read_count": "5685", "read_number": "1", "niassa-file-accession": "18758605"}',('2021-05-14 09:53:52-04'::timestamptz), 8),
  (16, 'file',('2020-11-13 11:57:05.97-05'::timestamptz), '0b74be24616768271c45ce683afed5d8', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_12/hsqwprod/seqware-results/bcl2fastq_3.1.2/18757570/HPCC_0073_01_LB01-02_201112_M06816_0061_000000000-D9RDP_1_CATACCAC-CGGTTGTT_R2.fastq.gz', 627082, 'a4bdb8711007d2fae8b5e86e2c01fcf9cb459ba01733946b9fc0a6c0748eea2b', '{"read_count": "5685", "read_number": "2", "niassa-file-accession": "18758633"}',('2021-05-14 09:53:52-04'::timestamptz), 8),
  (17, 'file',('2019-12-09 12:29:51.791-05'::timestamptz), '6169212ca692d8d4fcc23cd23fbfcf47', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware-results/chromium_mkfastq_1.2.0/55541237/SWID_15496653_CPTP_0954_Pb_n_PE_449_SC_NoGroup_191204_M00753_0192_000000000-D7LK3_SI-GA-E12_L001_R2_001.fastq.gz', 3384808, 'b0a8372d1647f312e33df6624ee52a355b88d723ab88ed24f9595c820806d04c', '{"read_number": "2", "niassa-file-accession": "15498417"}',('2021-05-14 09:53:52-04'::timestamptz), 9),
  (18, 'file',('2019-12-09 12:29:51.791-05'::timestamptz), '0eb14fb8d8964f5d5954686932fde8ac', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware-results/chromium_mkfastq_1.2.0/55541237/SWID_15496653_CPTP_0954_Pb_n_PE_449_SC_NoGroup_191204_M00753_0192_000000000-D7LK3_SI-GA-E12_L001_R1_001.fastq.gz',    3296265, '001f66cb3df5ce70de67b6b76f9666b066b7bae6927a66c581852576e83e6e8a', '{"read_number": "1", "niassa-file-accession": "15498443"}',('2021-05-14 09:53:52-04'::timestamptz), 9),
  (19, 'file',('2015-02-19 03:08:48.262-05'::timestamptz), '61813787b67b282e381be248ace6ce18', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_8/hsqwprod/results/CASAVA_2.6/85993576/SWID_1422951_PCSI_0410_Ag_M_PE_316_MR_NoGroup_150213_D00355_0080_BC5UR0ANXX_ACAGTG_L001_R1_001.fastq.gz', 5199399607, '211bb229faf3e699a58858189286b58e1f4c88e6247c7306b2df16594b4ab4dd', '{"read_number": "1", "niassa-file-accession": "1423314"}',('2021-05-14 09:53:52-04'::timestamptz), 10),
  (20, 'file',('2015-02-19 03:08:48.262-05'::timestamptz), '9ac8c565482212441a3e958dbad846fe', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_8/hsqwprod/results/CASAVA_2.6/85993576/SWID_1422951_PCSI_0410_Ag_M_PE_316_MR_NoGroup_150213_D00355_0080_BC5UR0ANXX_ACAGTG_L001_R2_001.fastq.gz', 5413926184, 'a260cd9a64e2d4f055ab87adaa304cfbf878c617659beccdf76996cbe8cc4c4a', '{"read_number": "2", "niassa-file-accession": "1423321"}',('2021-05-14 09:53:52-04'::timestamptz), 10),
  (21, 'file',('2015-01-01 01:00:00.001-05'::timestamptz), 'abcdefabcdefabcdefabcdefabcdefab', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_8/hsqwprod/results/CASAVA_2.6/85993576/SWID_1414141_AAAA_0001_nn_n_PE_316_MR_NoGroup_150213_D00355_0080_BC5UR0ANXX_ACAGTG_L001_R1_001.fastq.gz', 5199399607, 'abcdefabcedfabcdefabcdefabcdefabcedfabcdefabcdefabcdefabcedfabcd', '{"read_number": "1", "niassa-file-accession": "1414141"}',('2021-05-14 09:53:52-04'::timestamptz), 11),
  (22, 'file',('2015-01-01 01:00:00.001-05'::timestamptz), 'fedcbafedcbafedcbafedcbafedcbafe', 'chemical/seq-na-fastq-gzip', '/analysis/archive/seqware/seqware_analysis_8/hsqwprod/results/CASAVA_2.6/85993576/SWID_1414141_AAAA_0001_nn_n_PE_316_MR_NoGroup_150213_D00355_0080_BC5UR0ANXX_ACAGTG_L001_R2_001.fastq.gz', 5413926184, 'fedcbafedcbafedcbafedcbafedcbafedcbafedcbafedcbafedcbafedcbafedc', '{"read_number": "2", "niassa-file-accession": "1414144"}',('2021-01-01 01:00:00-04'::timestamptz), 11)
  ON CONFLICT DO NOTHING;

INSERT INTO external_id (id, workflow_run_id, external_id, provider, created, modified, requested) VALUES
  (1, 1, '3786_1_LDI31800', 'pinery-miso',('2021-05-14 09:53:52-04'::timestamptz),('2021-05-14 09:53:52-04'::timestamptz), false),
  (2, 2, '4615_1_LDI42200', 'pinery-miso',('2021-05-14 09:53:52-04'::timestamptz),('2021-05-14 09:53:52-04'::timestamptz), false),
  (3, 3, '3305_1_LDI26863', 'pinery-miso',('2021-05-14 09:53:52-04'::timestamptz),('2021-05-14 09:53:52-04'::timestamptz), false),
  (4, 4, '5018_1_LDI55039', 'pinery-miso',('2021-05-14 09:53:52-04'::timestamptz),('2021-05-14 09:53:52-04'::timestamptz), false),
  (5, 5, '5042_1_LDI55100', 'pinery-miso',('2021-05-14 09:53:52-04'::timestamptz),('2021-05-14 09:53:52-04'::timestamptz), false),
  (6, 6, '5102_1_LDI59953', 'pinery-miso',('2021-05-14 09:53:52-04'::timestamptz),('2021-05-14 09:53:52-04'::timestamptz), false),
  (7, 7, '5085_1_LDI59083', 'pinery-miso',('2021-05-14 09:53:52-04'::timestamptz),('2021-05-14 09:53:52-04'::timestamptz), false),
  (8, 8, '4892_1_LDI49466', 'pinery-miso',('2021-05-14 09:53:52-04'::timestamptz),('2021-05-14 09:53:52-04'::timestamptz), false),
  (9, 9, '4291_1_LDI34910', 'pinery-miso',('2021-05-14 09:53:52-04'::timestamptz),('2021-05-14 09:53:52-04'::timestamptz), false),
  (10, 10, '221_1_LDI9339', 'pinery-miso',('2021-05-14 09:53:52-04'::timestamptz),('2021-05-14 09:53:52-04'::timestamptz), false),
  (11, 11, '4141_1_LDI41414', 'pinery-miso',('2021-01-01 01:00:00-04'::timestamptz),('2021-01-01 01:00:00-04'::timestamptz), false)
  ON CONFLICT DO NOTHING;

INSERT INTO external_id_version (id, created, external_id_id, key, requested, value) VALUES
  (1,('2021-05-14 09:53:52-04'::timestamptz), 1, 'pinery-hash-2',('2021-05-14 09:53:52-04'::timestamptz), 'bea8063d6c8e66e4c6faae52ddc8e5e7ab249782cb98ec7fb64261f12e82a3bf'),
  (2,('2021-05-14 09:53:52-04'::timestamptz), 2, 'pinery-hash-7',('2021-05-14 09:53:52-04'::timestamptz), '54dd4613e80f7d2ddad8f74ce0f67908903ed7a8edc2f0204370f0f6a2b33766'),
  (3,('2021-05-14 09:53:52-04'::timestamptz), 3, 'pinery-hash-1',('2021-05-14 09:53:52-04'::timestamptz), 'ef349261a0c79197233d1d6b22d9ed6b2eabed18b769eb4ae77c14a9478fe673'),
  (4,('2021-05-14 09:53:52-04'::timestamptz), 4, 'pinery-hash-7',('2021-05-14 09:53:52-04'::timestamptz), '73970559356b3fe062f33fd589fb4a5601f6a83469c7302141be205a25bcd4fe'),
  (5,('2021-05-14 09:53:52-04'::timestamptz), 5, 'pinery-hash-7',('2021-05-14 09:53:52-04'::timestamptz), '352c909830446caef298323d36cfe959803854031fa0ce7444cffeac37fc4993'),
  (6,('2021-05-14 09:53:52-04'::timestamptz), 6, 'pinery-hash-7',('2021-05-14 09:53:52-04'::timestamptz), 'c6d3676c951eea321e95a8b99198af1c79a21b894fb03f78350b2c39af345135'),
  (7,('2021-05-14 09:53:52-04'::timestamptz), 7, 'pinery-hash-7',('2021-05-14 09:53:52-04'::timestamptz), 'fdbe8adf1a7d66cda20ce925adbbf4cc38e3805b4993df0dfe2d1ad876acfd9b'),
  (8,('2021-05-14 09:53:52-04'::timestamptz), 8, 'pinery-hash-7',('2021-05-14 09:53:52-04'::timestamptz), 'ee31b80cbb5b55c48e0af5bda82c085e99d76331f935bba9159775a24fa57c39'),
  (9,('2021-05-14 09:53:52-04'::timestamptz), 9, 'pinery-hash-2',('2021-05-14 09:53:52-04'::timestamptz), 'f8feea33f0ff3d72f59c238e5740abeb8de9a2f95e8893da060fbd8756b97a4f'),
  (10,('2021-05-14 09:53:52-04'::timestamptz), 10, 'pinery-hash-8',('2021-05-14 09:53:52-04'::timestamptz), 'c662d6f6e829e5fa182aa6d140d0db47540d8eb40fec47cbbbc297144266b6fb'),
  (11,('2021-01-01 01:00:00-04'::timestamptz), 11, 'pinery-hash-8',('2021-01-01 01:00:00-04'::timestamptz), 'acabacabacabacabacabacabacabacabacabacabacabacabacabacabacabacab')
  ON CONFLICT DO NOTHING;

INSERT INTO analysis_external_id (external_id_id, analysis_id) VALUES
  (1, 1),
  (1, 2),
  (2, 3),
  (2, 4),
  (3, 5),
  (3, 6),
  (4, 7),
  (4, 8),
  (5, 9),
  (5, 10),
  (6, 11),
  (6, 12),
  (7, 13),
  (7, 14),
  (8, 15),
  (8, 16),
  (9, 17),
  (9, 18),
  (10, 19),
  (10, 20),
  (11, 21),
  (11, 22)
  ON CONFLICT DO NOTHING;

INSERT INTO active_workflow_run (id, attempt, cleanup_state, completed, consumable_resources, created, engine_phase, external_input_ids_handled, modified, preflight_okay, real_input, started, target, waiting_resource, workflow_run_url) VALUES
(11, 1, '{"ok": "maybe"}', NULL, '{"required_services": ["inhibited-workflow"]}',('2021-01-01 02:00:00-04'::timestamptz), 0, true,('2021-01-01 02:00:00-04'::timestamptz), true, '{"gimme": "data"}', NULL, NULL, 'prometheus-alert-manager', NULL)
ON CONFLICT DO NOTHING;

-- Re-enable all triggers
ALTER TABLE active_workflow_run ENABLE TRIGGER active_workflow_run_update;
ALTER TABLE analysis ENABLE TRIGGER analysis_update;
ALTER TABLE external_id ENABLE TRIGGER external_id_update;
ALTER TABLE workflow ENABLE TRIGGER workflow_update;
ALTER TABLE workflow_definition ENABLE TRIGGER workflow_definition_update;
ALTER TABLE workflow_run ENABLE TRIGGER workflow_run_update;
ALTER TABLE workflow_version ENABLE TRIGGER workflow_version_update;

COMMIT;