Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 09:36:39 +0100 (CET)
Received: from mail-dm3nam03on0082.outbound.protection.outlook.com ([104.47.41.82]:54240
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992111AbcLIIgcmzSA2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2016 09:36:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=h2ZwymBZaWXEsHVw/MZ9PwH8PrPZMfpQZqMNIYEm86s=;
 b=kcS9j9CwgV2rmUv/ZqbFZa6b1wm3Nqh77uOebNHsm9u+MIjAx/PGHDqlV4CrsJB0lGyO+pa87vS4YdZzR5DzNOcHpWILchd9q7RkTTgZsgWt3m2O79fRPQcwsF/zuib77AByiJa4Y9D0Tyt7oXFboXa20v8p0mMLvAzOiVv4uBc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 BN6PR07MB3203.namprd07.prod.outlook.com (10.172.105.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.761.9; Fri, 9 Dec 2016 08:36:25 +0000
Subject: [PATCH] MIPS: Relocatable: Provide plat_post_relocation hook
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <8b0da9cb-62a4-f3f6-d1bf-761c4a7bfa15@cavium.com>
Date:   Fri, 9 Dec 2016 02:36:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: DM3PR18CA0013.namprd18.prod.outlook.com (10.164.243.23) To
 BN6PR07MB3203.namprd07.prod.outlook.com (10.172.105.149)
X-MS-Office365-Filtering-Correlation-Id: 9e375f9b-750a-4509-f541-08d4200e767e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BN6PR07MB3203;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;3:8gfz/WCjkeUu8ApDn5xFldcU3e8nRlbDPiLjhWbsG6fL6uDR91v5VHMEoK4/3Z1bCB4VKK2Jsjs15Q75SDLz4CNMgeeg0Dke9cVqoPMMK4+qDYpxtSVe+jwt97xtUrIR7jVdTXcXQfjDdfqNRWFy49x5IIZcnNigK96pA1Aqtq3haR4bgGSDwKTNONtnmkgolzu6ksKlvmeVmFvDHcHTAlCheoD4tkz8huT7aBXRkb9/Ddz3HZ6tAKZeyPO+TsQt9mcWDzulOIsiA8jsTvc9MA==;25:pwd3jLtYEl5Zq0xnH3YK2N/pJ3KEwk0A6bCmrBFam4We8K51+7QxhKBTpHjPGXYFxrD6mQNvy9wBhqbkTyDdD+d4LAiOXbfFsM6Od8s8S8iCUxOIg6SNamGFK8Mw+yBdsGaXhGNlvarkaVn0NouI/9ipjufr8v1W2WrWayspfGc0aEf1VS6YqoysY2FUpY8fvB+Sz0iSPq4LeY5OtfmPX55QS9v8cHwO2cs0Yk5UFSGFDAc6KhcNnP+FWU2klGwn94jpDwXstkgjJMJxm0JX05vV1YWE2pmBWgkVnLmMAg9BO4vZT+KaOTmjDhAxPvMBxyv6cAsMeAYx5OsiJUxmqkal9ZmmxfW3RFQolTncmeZjjrf8LPyMKByDAGC0Kvfua4atyeDI6mOXzh0b3Rj4wSJ+kug/eBD8d4xgzfkoNkUh0Vq23+zhMATuwtWWJsOjry9XdD1AlJQlhRM6dmL3Gw==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;31:o+eU+I7Opw+3ttSwvgerUcel+qVTl0YPWTc4isJVuryErp42gzT34/mLsXf9PX2mO6bUgzU9Auyy21/Uk58BUqGxehvENL154g77Rz1oCOgmEIe/D6z+IYmqSTEXSFLwrjcteFggrF/vgQoj8u/d63GoiaEDjx39NNQmLByMWsZNzRL8MTmEBukgPR8miXzwnoOhLpLrDHfzOhMwjeJHKzJ/rKadEEQ8wVUqnVpD0maoI8u7vQSRgNSlXlGWdU5je2N/MJJ5xaxm4ia3GIiNmX2hjS5iSg39JTrdha6cscg=;20:qp289E1mZ4VPZ2tHeDB8SSqY2Om+/AXeB2qOZ9c5WR6xntGZgEIX4IuBWBeG++iLRHB6DnHneMrhE5ihLeTJwzRxBJb0oI57IoAXIudFbbvKvBhUK8iduWBwpprn7vrxnR1ZI0l+Bn23UoTwtJahN3UkUBQtYqJbIZxK4ag08LpQsHgDfPhXjUVf7fqP45UNv3gMecRojwNXpg6YTMu4r2ByWDexUiJykPsUUxzFCHb68I9i3UfMmTjhOatInzdN86eM7QpZa4POHlWDubrttG/+PY8II4Ovl5xu2UFqkCWMLr/qM5ZlS7mnp14FCEfo8YnQ/f4wBc+v8866DpNtVU+zSWPtat6rxcgKgTPSphqhlfpa66OsQ0G1lH8YVEIQa19N9CoQg7KUuCFySgIrFclVsgxNNuDjfiGMzSmfxR0ATUbB3afrMU2WsHC1tqVNhn9jlYzr+Izio7O1R3dk0ttkwkwf6NrOo+tjAfALeHBKX0GYMlxzLTGOltZwDawQ
X-Microsoft-Antispam-PRVS: <BN6PR07MB32039690256DF831DD1AC83180870@BN6PR07MB3203.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123560025)(20161123564025)(20161123562025)(20161123555025)(6072148);SRVR:BN6PR07MB3203;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3203;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;4:M9cc7YHRmqaBdvbq7bY9uiZHE8t/pFR6nuTWnfFVgdGn3Y/VyLdj0aNQIwyNPtkYug9wbJ3taDCWt1P6TUU2JYMAsW+1aEOflJ/Dg9OVQjPwDmtvtkNAPN8IbRsUG+i/d2QDYwC8ZDGknigJqdm5cErUNXSZt/utUqJ6zG1LjBASGxw76vCv5rDLirJObj7CHOszSU1gLeGvlykE32enk8uCFDyvdn2k27oi0qXLzyyfk36tkCE5cuLKj/fagrg4Vy9eynlZubSAh5les19jBp1A83fGWj7BaHU/GdF5/u54wWmxqoKp+muloH0uq/QmPE5r3Y6kzVyWLcbQjgc9Y+cnA4j886B3e5hR5AnF/vA/pXXDMIuDz3tT94wNcOgwmSHX5FR/EGzf32p6Sii1UkXTB9NEum4/CRIzMnR60oeDPPvIaPcCfrrCFcNbf+vFhgo5bsmhLx0+wv5Y+ztnDOl9uesYj/Ej1OqKGi4/7uNWx3CZF1vbzxoE2TrtTRZ8yA+tyASDK/vh5r90lbfBBr5dbMvwxf2g2VV/I3g3vefRnq2Q5edmTOWi5MGwyQTJZpQ8potulLHmqIN5q+8PIg==
X-Forefront-PRVS: 015114592F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(39410400002)(39450400003)(39840400002)(39850400002)(189002)(199003)(66066001)(65806001)(65826007)(65956001)(7736002)(4001350100001)(83506001)(68736007)(36756003)(31696002)(305945005)(90366009)(38730400001)(733004)(189998001)(6486002)(47776003)(77096006)(64126003)(23676002)(97736004)(230700001)(6916009)(5660300001)(3846002)(50986999)(6116002)(450100001)(54356999)(42186005)(50466002)(31686004)(33646002)(101416001)(86362001)(106356001)(105586002)(110136003)(81156014)(8676002)(81166006)(2906002)(6666003)(92566002)(2351001)(4326007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3203;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzMjAzOzIzOkh0WUJUcnF0bE5lMjgybTl0MS9yVHo1d25H?=
 =?utf-8?B?L1kwTzAzWHpFWmtQUURzTktsaTJPL3A5LzM2VkZrRndHNFUwNXVHczJNMUgz?=
 =?utf-8?B?SnBuRndMNkZnNUNWdTZTT0VlbXNnRitKVDRlK3V6c1E5MDBPNXduUmJoUG1v?=
 =?utf-8?B?VXpPUTJvWTdkWEJPcXQ5aUlScVNoZWNHRHJWWnRFRTcxdDA0ZUFqRWY2M0pH?=
 =?utf-8?B?Y3dHbEl1UFRkNmRQbjFEcnFLK3FuMTM2SFcyWTgwaHhOTVdLMXRJQ1dha2hY?=
 =?utf-8?B?SGk4VTFRN05TbDJnVU03aUloQVV6VjNxWGt6Z3J3VE52Szc1eWUwNzhoR1U5?=
 =?utf-8?B?MURaWG5RRm5tTEQvTklPTjZSc1RhWU4ycnZMWnZsTmJoUlppclQ1aGpCdm5X?=
 =?utf-8?B?VlErRVJEK25wSS9vRm1Qa21TbWNETVJSU0tHUkxPWkd6b3Uxd3Z0NFQ4ODZz?=
 =?utf-8?B?UlcvMkNvcDBHVWYyMitRWlcyVHJGV0lVZXUzRXNzcGtVdFZFYUtXVHN0NmNI?=
 =?utf-8?B?dDQrSEpoWjl1ZmhLOHgxeHZCajhKeldoMUhHSUk3c0VHREhITVlwMUFLdjVn?=
 =?utf-8?B?U2RUbUgxclNPalozSkRBQXJKdXN1ZWp6T1FnR09XQnlFNTNuTUJpSW1sMzZx?=
 =?utf-8?B?TTkxbDZDYmhmUTRHQy9ucDNwNEFEU3ppRmtOb1hzaDRTalBzUmZYS3huNGQw?=
 =?utf-8?B?dVd1SjRCbDl3ajJBTjRxRWgxa0NtN0xadGY1Q0U1UHpFc21EK3RaU1Q0TWRV?=
 =?utf-8?B?N3I1WWl5YTJVY1ZPV1RhcGh5TVU1YXJwbXVlVEZBZDFmWHc3UmVLMFM1c2hr?=
 =?utf-8?B?bk1vbFVieSthb0ZVVVRqWHhKbGRKZVZXV3BST3VhTWMwUXkxajRjYld6Tnc4?=
 =?utf-8?B?RG00NnB1cjV1SVkwREpudURRWXRIL25qVWF3VmNKcVF1cTZMMkoyTllDbFFv?=
 =?utf-8?B?dXVZcUh1aVBLNWExZm1IKzMxd056Sis5WHJ4RlFkL2FJOVhIWlZjeWJRbnND?=
 =?utf-8?B?UFhkS2owMkNBZ1Jhcjl3TGJjUFU1WTJBMU9mVGJrN1lic0xXSHdWM1lyeVFP?=
 =?utf-8?B?OC90UEN4QnQ5M3hld0pCZm5VZGk1REFTTWpVY1hrY2tNN0dWdE11QjM0ejkv?=
 =?utf-8?B?Rmlya2YwVW9nUTFLc1EvTWVscDFSRUxuZy9CQ3crV2lJZjkrNjhCRFJpTFVL?=
 =?utf-8?B?THpjRDFmYWZZUmtDTittRmVWMk5wZDIwOUdjMm9yZWFEbUkyV1FpWnZsTTBC?=
 =?utf-8?B?czkwTjdadW5kT0FIc0V4b1R1QXR3cmxwYmc2M0trZ2ZuRlpFbjY3bjlOTG5s?=
 =?utf-8?B?eEpRM2dabE9idHltdDRYWDVrbXk1WHREMHY5bENPVTZpQnZycVBLYTl5eDhz?=
 =?utf-8?B?cG9pcUNTOFl4anVoTFppeWxwN0JMcjdXbFh6dml2cWZJQ2w5VUZYN0M2Vkxi?=
 =?utf-8?B?eDR0N1B5blcwSE9ubStpOWM0K21wS2dPRHo0S2pZUzZiZGkwK3Z0cmhEQUNy?=
 =?utf-8?B?QzNPcG0vbm80eHFhSFdPdmduSDF6OW1mSkt5bHcwMFovV3UzZkYybWVMaVhR?=
 =?utf-8?B?VmZTeFUrOGw1NTh0dzNTTFRXQk9pZ1c3UDdZVXpUeDZTSnNRcHNXeWFGak96?=
 =?utf-8?B?NXEydUxpMGk4NkJCTURzRVRLWUhUOXloZU15ZlNtZ0ZMY1dtRDVWdFBReHFW?=
 =?utf-8?B?bHlhVzg0TGJVYkVnV003WUZ5ZndNWUhoVkFPT0ZjMk9GL3hHR2U4N24yeEhB?=
 =?utf-8?B?NUtMM1B3TWdQWVZFNUR3QW03WVhvZlFkNGF2R0pWblg2UGdEVUhkWW1PcW9h?=
 =?utf-8?Q?64eYOHUMEpyZf?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;6:9yeRaWsQxpTVPC9prVDIFBd2bSGDYQZlPtW2tadBx2OfyBACa5zXFfrWK/R67pJ3wdiIfxGYGHLV2lR9uUtAsc6bFJhd0SxkIap9jZw6O8DYLgEzTyNooaRbVG2SpovKpDbWN+w7o/R3D4UTDtZKCcy9PJF0pF18xcY+8PNytbxi7qQBSaknAKid5+lTk6Kvcbt9BT8KcndwzL/647mJdTddslg3HSVxwmn5PROHjobe4pxUaOxQRZ5934MUZqnVJu6/0z2gKB72nkwZIyYf2+mSihpp/CgyGySGgjqz1XRV/+6rIYjX4WnmUlPRUD0QhhuDOX3jWLrWDrqXQT9U+6T2uCWz/xfQy4J6Ye1AHXdZIfR9kzTCl/MINVulvYu+wAv1v7MlvnAWfI9wBn1xRGzL6fvNKZnf3DdQyS/3Y0M=;5:p4g6ZBZGWkCOBRXpcfjWql/9nDiL2f0vyt0rIBe1LJoLa7lWbo9U9sFT9DmE4TW7RDv1Jv0nNNH1SKIM5uyaaaMgINSWhVL5dInZd8g/Jj1RpjTSkw5r80L0zeT3MXpHlnDC95zidEXTGOa1ANG/TA==;24:VpbLaDGkIaOmAv/v9/ab/WLp8HcAMP0RImfUP8O85kE3oHEBHKuH4mOxDJuP2Bk/MWEM8PgBYrg1DEy+rjEgoQQCOdn7tfFBIoBCq3ARXvo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;7:uM7qeEdff3bC9cB4HAmz024ll3SU/xDBVsDRYSFW8N0m4fCf5FsBFKgo7r7hhMC31c1ID4t9OrP3PYPA5rNDd0VNvnt7Utd2JIEnHP3OtGFPY3eSjMewkNXx90dSX96fMv6ElQKvENBMdPzzPUUS00vuOiHM+vGWdAd7DHEldOeCQVLz0enXB+NoexlZU9PF2NdVbLFT8t3BdDsFK7185HRV/ihwfYyOmgmNxJ7JYGehp6lVLFJTLuLmziFFFmtFqrtGpALzvGrclqPl+RwfU/A477ow+PPKm5PGDF0BzPTtd9Fmn1AaF22giKnOVR1zg4yA8dL7xXzQKZdMsj93msjdioi65TyEWwqgPqF3utoQev1bYVSuVYcTt2E0uH61LqlE7k/KbtoIt0w8bUCuE6Ave3gXjIXjLNOpsY3eHc34CPRa4sWEEt+uqtoa5MbViUco+/S27tlcbKnPdBgq7Q==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2016 08:36:25.1772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3203
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

This hook provides the platform the chance to perform any required
setup before the boot processor switches to the relocated kernel.
The relocated kernel has been copied and fixed up ready for execution
at this point. Secondary CPUs may wish to switch to it early. There
is also the opportunity for the platform to abort jumping to the
relocated kernel if there is anything wrong with the chosen offset.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/kernel/relocate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index 1958910..c822885 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -31,6 +31,17 @@
 extern long __start___ex_table;	/* Start exception table */
 extern long __stop___ex_table;	/* End exception table */

+/*
+ * This function may be defined for a platform to perform any post-relocation
+ * fixup necessary.
+ * Return non-zero to abort relocation
+ */
+int __weak plat_post_relocation(long offset)
+{
+	return 0;
+}
+
+
 static inline u32 __init get_synci_step(void)
 {
 	u32 res;
@@ -338,6 +349,15 @@ void *__init relocate_kernel(void)
 		 */
 		memcpy(RELOCATED(&__bss_start), &__bss_start, bss_length);

+		/*
+		 * Last chance for the platform to abort relocation.
+		 * This may also be used by the platform to perform any
+		 * initialisation required now that the new kernel is
+		 * resident in memory and ready to be executed.
+		 */
+		if (plat_post_relocation(offset))
+			goto out;
+
 		/* The current thread is now within the relocated image */
 		__current_thread_info = RELOCATED(&init_thread_union);

-- 
1.9.1
