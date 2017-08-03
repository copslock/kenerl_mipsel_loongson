Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2017 08:20:42 +0200 (CEST)
Received: from mail-ve1eur01on0128.outbound.protection.outlook.com ([104.47.1.128]:22642
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992604AbdHCGUfS4iBo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Aug 2017 08:20:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kAVlfF0LEx34ObcavWb+NJaGItdv0hT450pbkDdNiak=;
 b=h+W7i+8Nl6rEjUrJ1sAE+VJ+xo5HQF82U6i3exe3eFqbS86la/4zVmzKd4AT8TTxAbCPPqXNVZ2LeXT10KgRAxYy9IKFBn3HBwqKGtlGZjU1H31Z0Pb4ca599TXvvlAWIoUpazIEJGFHtHwyDourchseavbPFAhh90WWM69Hdw4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=matija.glavinic-pecotic.ext@nokia.com; 
Received: from [10.144.127.146] (131.228.2.29) by
 VI1PR07MB1102.eurprd07.prod.outlook.com (2a01:111:e400:534c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1304.10; Thu, 3
 Aug 2017 06:20:27 +0000
To:     linux-mips@linux-mips.org,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
From:   Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Subject: [PATCH] mips: Fix race on setting and getting cpu_online_mask
Message-ID: <77b85cd2-2ee8-ae51-a27f-ff046900c3f9@nokia.com>
Date:   Thu, 3 Aug 2017 08:20:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.2.29]
X-ClientProxiedBy: VI1PR0102CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::27) To VI1PR07MB1102.eurprd07.prod.outlook.com
 (2a01:111:e400:534c::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 827425bc-c033-42d2-52d7-08d4da37bc5a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:VI1PR07MB1102;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1102;3:q3rzqovhx15t5h1hXfL70nw3y97SqlxC5s0BtHDb9oYeLCHToIXdKqNWpkXaEzgovuaHCj/8wKndCk11ax/8sKI2klVNCzfgZp0L6qvC72HYTQOC6qthSRamMZSGkBI8qhCoQxP+JP7YC+yY51VQ9vLoj7UTgHuooxV8fY5HVzP5nJz1gz/0rnBFv6/WqqTkgrarYguAbqmUUU6KNvK/XyDGcwz7HsWJ9JfBKUPw5q3qUnC62nAFUCdOZOz0k8qM;25:zZ5RIwoBzS3vhhU9+jIA1pM9JXX2iWKB/yoEIbde1S+TtU/5pLahWJNJX4K/XLrRIrJj38PYttWIgJVEnO20DV6QfCuqRV4kEu6rqPYFMM1bBd2ovH312AvUijjUd5fVjikDeIkdKcpJUCKwAN7boWcrnW4IfEvrcRIYQauTtkfiykZlLcME48/Xg8LrAfzkabdHy/6WFd6vVDtqM4YV8K++G8Yeg75Wa4NujRp+aifKKJohFZR4kHkqW2NaF2U9oAHQ9T7Kdfb9PFrjregawBV+o8AlEg/Aczhmzn/5wQ3D8f76st2A0jO3NVxYrtMRW+4SBq3esBKsaIeh4LGmPQ==;31:fKGsxt/khNlpHGgI5K9XZiHRoJCZYYPhS/lXvP+LvBonQR2G4Md4GAflhjSlnWC5jUFfs3mKV0eV6PXzzccuCeSqhwxv+psm6huJva7DO4pZHcqdxZJG0uOz1HPJf9nYospCn5cQveXB7bC6zijpdhOEnA/EsSU3tANodgMvQ6uH0Qs0i0k/ruDr5m0YjeaDqcYbtLr4klM9r1sB2/pcMq0cd/o15Dx070WQOHICRhc=
X-MS-TrafficTypeDiagnostic: VI1PR07MB1102:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1102;20:GhWCJeq4lBIvOh2QCFxqE+04th4rb9rseP1riy3eshJ1ihHQdv35I78nK2ndT3NkQN+hcxgWcan/sZT6tuErusdclBE1xsgIndfidat+pYOtVZqbKd3BxWL3ZtsOKtjzW0S4Vd0GpKUKsYcnHZ/ArhMhK9hv1by2FcauyfaKRmbQvWJF+t7iJXl1L1fWLFQKVlm1vOeCnDD5Sjuf4cxKEEMTrfm/MA95Ct36rSWET8a+Zyo3fedakOJ7iOUd/QsN4zkw6BgefvcKsGEcZhpd6HQdO1fOVkxAUdX10+ojEdxPnxyjWldxegLCEAEKGM846WYIacBqVsxq3w24uFlEyi58gyI+I0ZZMOHnpq5Ae5tQnTrb97GWQD7cMQYISIU0ok5QpGOthHs0dfSRJARmCbDRbHdT32xZU92+pCXgeJKFr9rmVDaPpDcNDmTDPNMC5i3CIy4LDfVDYdTTwPXRlhZVYXIzVQmrVN0ZXXJbMcCilviVH2VTIkfFE2yeWA4vWpE2GUUQv9MevcblqTdjoF/bqmBkr7xXrAytbkHbD6+wWA7oC5uFVl1J12lYdQQko9RkfzYbcJekxx3chjYvffPSyy1rPuYPUv1xffi9XdY=
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(82608151540597)(84791874153150);
X-Microsoft-Antispam-PRVS: <VI1PR07MB110240A6511C3FDC64E9172DFFB10@VI1PR07MB1102.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(93006095)(93001095)(100000703101)(100105400095)(3002001)(10201501046)(6055026)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123560025)(20161123555025)(20161123562025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:VI1PR07MB1102;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:VI1PR07MB1102;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1102;4:F/555QIB1L/ntX7bVRGoZy0nq3NaCCohiKrzJc4JHIAK/1RN44z4I/nN768vUPTnHP+6davEj0M9JhrBCf5pnedeIh6i6vtVyHxwialVRLqs0bGVGFfPuuFDjlc04wcQfBLvvWWpDUtEjn/HKAhNzKPVLT/J+0wck86rG859dN4eyrlnIXVawSzW1ibuRvVE7dFUk6tT7UnVkgK8JTIBOIbm8USAsn3+2zNdMO2p6kv98tTwZ808YdGo2DZz8t+HU/EJm+s5payB17kkPakUL8tjnyBTaUGvTHWCHAG7fy1u9Fe7qHrKhPaMfJDVQT0G4jt2WRblsFYsfzmfw0aE1VUrCn9rOZkbjLAm2VN7g7eqt57NNpeNN9WlMJ/ESMyv
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(7370300001)(4630300001)(6009001)(6049001)(39860400002)(39400400002)(39850400002)(39410400002)(39840400002)(39450400003)(189002)(199003)(189998001)(64126003)(305945005)(7736002)(33646002)(101416001)(77096006)(83506001)(6486002)(47776003)(7350300001)(66066001)(5660300001)(53936002)(50986999)(6306002)(6862004)(478600001)(42186005)(31686004)(38730400002)(110136004)(106356001)(8676002)(50466002)(68736007)(105586002)(97736004)(2906002)(54356999)(81156014)(81166006)(31696002)(230700001)(4001350100001)(6636002)(6666003)(36756003)(86362001)(966005)(25786009)(23676002)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1102;H:[10.144.127.146];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA3TUIxMTAyOzIzOlpUVFhRdmovQ3p6V0x3NVRCYVVoRUN1VEhQ?=
 =?utf-8?B?cGtEeHAvZ2RrS2dZakNNclVlTXhqUHQ3QkV3dTFRRE82SURBY2pWajIvSkFZ?=
 =?utf-8?B?NEJlVXFMc0ExYllrUms1eFgxS2tSa21zSzBldFZCeHBjTDdEODF3YjlHYTZy?=
 =?utf-8?B?UzUyaEs4bjNLWW5yVDZEZThiYWZwR3ZocEhZNW5peXQ4b204SUc5cHRTWVlD?=
 =?utf-8?B?Y3o4N2RpMkRBWW91dTFvUHFxYzhPSlVqNEQzQnZ2cnZjeXZNUHMrWUh0cDJP?=
 =?utf-8?B?NHlEenNETTNMRitJMWZmQVlmNEgzU0RLaStWNTdoYUltdktFTm9CaFg2TXFF?=
 =?utf-8?B?eVJjVjFITGNJcEk0Sy9tb1dZdnNQZFVhL3JWb2F0YkhrRDBjYUd6QVp3cERa?=
 =?utf-8?B?UFVrN3MzeW56dWRGalJkRmhQdk9nbmJGcTJSTU85SjMzLzgyRDRLWHBTbDlk?=
 =?utf-8?B?aXVrYXpCL1RYNU1KTklYeXJwcWg0RGQ2SmxUYmFvYmEzZEdhbkZOMGJTdHhi?=
 =?utf-8?B?Qm1zaHNpVlp5WkR0eEgyWmovcmJ3aUpaU2J0QlVRWk44OGpYS0Y0ajJNQzBX?=
 =?utf-8?B?M0FFUmlhbTlLYVgvYXFDUmZIRys3QXpRVFREZGwrcDhKUnFlM1YxTU5URXFu?=
 =?utf-8?B?TzN4dlBJVTQ0aHljTElkZmNuSE8vUW8xYS80aWpBNHoyUzg1WGNMOEs2L1dp?=
 =?utf-8?B?R0FWd1ZpSVhkM0JCSUV4THk5dElrVWNIYStJVS9HYk0xMGsxNndMUUpmRWxx?=
 =?utf-8?B?WXhRZnZHUjlEMTdQZkVJa0g0TTdETldYS1FrQVpoT3lUdTRhR05EeitIZlE0?=
 =?utf-8?B?ejRoWFp5VDZhbnVKd29VU1R2SWFZYkEyeHBBV3hpcTZrd1dxUmljQ0dGZTBW?=
 =?utf-8?B?RXNYZWsrcFZvcURYZHlyZFQxOFE3SHZVMkRvSlJhTmc4NXlhWjl2QzBoUjRx?=
 =?utf-8?B?MTJWRUExRU5Ea1pjclhJYlNPdHVTRnRPTTAvd3g0bC8va2R1ZmovZ3FHTlBC?=
 =?utf-8?B?UWNLeFMrSGJ0Z3Z5Rnl1c1N5eU0wVFdKY09GSHNXcHdPZEY1UUN6WXBKU1lJ?=
 =?utf-8?B?SzR3NXBsL2YveUY2ZkNIcWdKaWhIYVhXYlBBSEkxOFFvcE11U1RXOExQRnpL?=
 =?utf-8?B?RS9RTXUvam04aTFOemxEc3BHdEFUZEtiZGEzQ01kZktzRkZ0RVBjZytmQkVK?=
 =?utf-8?B?Yjk5dlJoTTlOeFAvRER5SVo0U01JeTVCRzUvN3d5a08ydUJDb2l6dU5EWmRB?=
 =?utf-8?B?azMrUmk1R0I2a1VzWXJiZ2Z3NlpRUHY0Ti90TnByWWlKZVZQQjdRRStEK2VU?=
 =?utf-8?B?TUc2ckw5dWpBWEM0Q3dNSGw5dlNVYkpOdkJMeFFWWi9xVHkwY0JmVEJjQ0Jq?=
 =?utf-8?B?WFFUelhQYkYyU3RwWHZzdzhoWkZ1ZU9kbmVsK3BFU0RieUFXSW0vR1BhcEdT?=
 =?utf-8?B?K3FhZGQ3SnR3VUdKL2QvVEQ3Z1ZLaS9xVlRsNDNUMHdlUXhzekNEeHVablpK?=
 =?utf-8?B?QU1kWnMxayt0WVVuQm1sa2R1RXhFTy9mN0pVMlVrQ1lFZzBhQ05jZDlKeG5z?=
 =?utf-8?B?SnFGV0UwSW1EemxOdnovRVN0VVJvK093VVJEdDVWbG1hTGJOSEtwNkhNajlG?=
 =?utf-8?B?SFkxMGsrYjdWQk5jWlhGczg2T2NHaHdCMnJaSHRXbGF0dzRxNkpMY05zMkRW?=
 =?utf-8?B?bENCZ056K2t0QnhUbGZlK1M2ZWl1a3AwMkkxK09hbTlKYzU1M0J1MTZqeWg4?=
 =?utf-8?B?eCttOFRQclhvRE1kWjBoSmdXNk92TE1peG1Vc3l3VktWZGltbDVtdm9wQkNN?=
 =?utf-8?B?YS9JV3dmZkVFVk82U0xKTk1pdnY5UHJneUpndG1kNngyZXFTbVV5emZtSTdW?=
 =?utf-8?Q?R0YgHCWN/Pg=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1102;6:+Df9QAKkz3QtE3TeXlxmwFwIrKI2bzB04StA5ptP5a/YrvSPsPWa+vvc0CI9FwvxAiGhAu7X/NQ/xSiiZdqTOS9cRmYUEz+0euKpEt0rdBDsmippDEG+R+nPgcGTwH0+WzD7aPx80CjO8DRDqoSquxcKYUSfWRKN5E9qM7xYh3+aF82SeDmrEF0z4napAP0pSyM0+tEmIU5Bj5jppRJMVH4OAJrbYT0t5TFEk36DYiGy7QKl/wLHC9f0gwPItemrw9pgMrxtJWHWQXtJubXFLCF+vV545+P+wXb7DyYP9ISoIRrwdLd5ZpJUQdHXBMcP2xIisqVBMympj1uVqDYZqg==;5:SGxBHpiElC75VGCRS+XrCQNPMdgnsC7zGCJUvFaa59uakB+YG6+Wc9MDIA6sgt5vkZ0a/QdOGMw1wM5ONJpFxhKsyGzQ/nhiRuE4sT8uySOWgGWLYcBVVjuFsUIYOoU6tOZ8foxOtUPN7KbLwit8HA==;24:ggzWc9swhpjeonQO/left8ibZI3GzYMWJqCNzGgaW6PIs7anpkEER/R5VMV1n548ktrEp4KQqq0SkHMlV2ncNxSLDD+VBQ7WBKwF1dyYe/U=;7:kD81xUIdoW1IE1H/8I7NmXonXKyPOPLlXzl9Rg+sVTI8ri2KAgleOkjQ4YBXHQQXlGIW8I3deQp/9uTvaNhRiaikdwy1gyMQpBHA7gvE+P3bx6bAR/XyC+HMuwfvVWPzOwA0Vks2UD0bYekuSq7q+G6WtFA8nZ1Kdpuc3Dxc5FNZ/bIJObnjLKuzeuIXINDx42MCL0y6+I2srfRO43GPyz6AaOlju3gcBOD1aFv1bGg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2017 06:20:27.9956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1102
Return-Path: <matija.glavinic-pecotic.ext@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matija.glavinic-pecotic.ext@nokia.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

While testing cpu hoptlug (cpu down and up in loops) on kernel 4.4, it was
observed that occasionally check for cpu online will fail in kernel/cpu.c,
_cpu_up:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/kernel/cpu.c?h=v4.4.79#n485
 518        /* Arch-specific enabling code. */
 519        ret = __cpu_up(cpu, idle);
 520
 521        if (ret != 0)
 522                goto out_notify;
 523        BUG_ON(!cpu_online(cpu));

Reason is race between start_secondary and _cpu_up. cpu_callin_map is set
before cpu_online_mask. In __cpu_up, cpu_callin_map is waited for, but cpu
online mask is not, resulting in race in which secondary processor started
and set cpu_callin_map, but not yet set the online mask,resulting in above
BUG being hit.

Upstream differs in the area. cpu_online check is in bringup_wait_for_ap,
which is after cpu reached AP_ONLINE_IDLE,where secondary passed its start
function. Nonetheless, fix makes start_secondary safe and not depending on
other locks throughout the code. It protects as well against cpu_online
checks put in between sometimes in the future.

Fix this by moving completion after all flags are set.

Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
---
 arch/mips/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 770d4d1..6bace76 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -376,9 +376,6 @@ asmlinkage void start_secondary(void)
 	cpumask_set_cpu(cpu, &cpu_coherent_mask);
 	notify_cpu_starting(cpu);
 
-	complete(&cpu_running);
-	synchronise_count_slave(cpu);
-
 	set_cpu_online(cpu, true);
 
 	set_cpu_sibling_map(cpu);
@@ -386,6 +383,9 @@ asmlinkage void start_secondary(void)
 
 	calculate_cpu_foreign_map();
 
+	complete(&cpu_running);
+	synchronise_count_slave(cpu);
+
 	/*
 	 * irq will be enabled in ->smp_finish(), enabling it too early
 	 * is dangerous.
-- 
2.1.4
