Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 20:08:45 +0200 (CEST)
Received: from mail-bn1bon0070.outbound.protection.outlook.com ([157.56.111.70]:45056
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028732AbcEJSInr9t9r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 May 2016 20:08:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=l/EdEJNnIEWN3HNuqDb3TBFHT2pPOTm0xg/xmdVCIaQ=;
 b=ElHbFyUegmwj47cpJF3AcETJz3If0GhLZO44AdfHdNFpGkezhFNe5NAGrOM0C0y0Zvmw6bklXbuJqXS1z5izgMGFquDF3d1Tm6p8zdrhQAuhgj8OxGGXkZAqXCZV2nhrwcIG403G9TMfXLBMjwJ+RRPcCXUIizZqGKUKhtdZdO4=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from [10.0.0.3] (173.22.116.65) by
 CY1PR0701MB1097.namprd07.prod.outlook.com (10.160.145.16) with Microsoft SMTP
 Server (TLS) id 15.1.492.11; Tue, 10 May 2016 18:05:29 +0000
To:     LMO <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Fix type and FCSR mask.
CC:     Ralf Baechle <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@caviumnetworks.com>
Message-ID: <573222E5.6050801@caviumnetworks.com>
Date:   Tue, 10 May 2016 13:05:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.116.65]
X-ClientProxiedBy: CY1PR0201CA0009.namprd02.prod.outlook.com (10.163.30.147)
 To CY1PR0701MB1097.namprd07.prod.outlook.com (10.160.145.16)
X-MS-Office365-Filtering-Correlation-Id: 80384c7f-252f-49af-fd6a-08d378fdabf8
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1097;2:yTcxStN0f7z2zVha3ngOMjEz4UHD+vlkpuTe62HikmzzBUNxz3skt9hj0WjocL8VPpJ/aZNYIboFhqV6sFJOMVJg+Zfru0DOQKC+JOidPMYPOzVWJ+eBJKGi0JOpz4g5zd9OfwchB5GLdS6G3j+G1nttZHExluRcfPVN7CIvkXk8JxdJ/hqO3lczCzhd20++;3:XVaSu3IJF1oJwg0Q+NkU9ujLvgpgvLFGexGAt69ABrQvYCcfnO9ZNjceF0vmSPs/iWQ7sJnY8tOAVuHzul55nFe15IBi7np50xqMsn6ozNJbXQvT8jvvPEOK1M/IfFVC
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1097;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1097;25:I5QxgdSJos4RSHxtuVKlZ9XuTugetKhksvjwPLIEqt5XzwDNWLfsKr5+uBhB5eAYkn4FeEQHdtRiyhtT4De4XG4Slz6qFSQ+6ib6wCoLcZ0oQTcsRvFcUQKKbjjHw45yQmvNrhHh8i+jZmUwfoksuZztMAhwPJhlG7LWP6pstHGogJ0AxNzbiCcxpIHPBQB3ynM2LMwDYmYnpS4KTaqVZ5wd3KZPeODapmgBxT5vrwuCFznjNCSorZ+/Ttheg0n2CTuEynTwKN18o8U2fp1RaFl+hkbOCGwTdeSAkeiew29Mlb5xJfD2seuScrjmDcd7wa1X8e4u4LqWKgNY3JF+n32pW4V8ifhJT/O5CtYJK0Ra7miR0TQC4JyP/M36IYowucpfgubadI33EtouACxS4TqMfyb6la3EILuaoOy83sjdfldgqNpboOfCJE/U1mlVmlkmn6BSMkks8HhU9y6kdUAuMFBfN/9YkfORy3jFbXckT0Y3geUQdLCp+2k/CBtXoxdPGsoMnTFvP9u/9QQUxH2YyctSDH3CF8RgbuIgRB3CsWGe8qhDLBlVvoR2LLhpKSd6flW02MFdf/etDP6SGDwsyrN4FzrqrA+499CQwaH/a7CIPoLbgTloxkUydM/uYqW3mn1YiMysX+IATC7Y+AKwRLx1UaIn1xju2PF4g0I1/GcXh9iQ/3gAn/dbPmRmCYxY2cLei27t5HmuZ2/wHcxhEjKb0g0VcPnlo2ylZldlxE8Ns2CLnWt8yGqr5sBlZqAlZUSlAlOcCeOCfQmZfQ==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1097;20:5vyycIcEj8VKPABLqgcPnla3ju0otnGRbdcR6E2oH6ZOECR3L/3q9gU8nyZWx9H/elPBjIyFB6pRAZl1Dgq0T9eWFaG/jZapwJnO/dA0ZDZCZe27ET0PMvw9OXz+ywzn2KSXNuoc0Hi/DAL+hRnxnze+T2EQjbS8DR5x4dTRaSiHcsk8WHkJkHPdhZB3rDhhypX7gZ2L4lcK4/F3lMqsUkpz2hejgOM3rCjVcWEjKp8UM7HnYyGnt+m1K5P67NyDNgFeKPqrei6Wv+x2L5XBqWQBY0vx8v6jjBh4H3aSmPjwZsOD12Ft13oLGRMZtR3A6yxkatgK3U2GSW5beNRxGz3chk2n7p4XeTM2daGbySxJjFINpWyCNsF2YPlAiigyFLa0YYAwlO2aGhse0IP8u/Z+1l34jkTiAKu6DgyLfeKNUUVTEUhSHRnpqzfuljiJziGUhXB7q9ZDuxzRh4FQ5fmr7T+wsTsopVB9+GE08FVxffIJS67Bp1Y32JxVtFajQFaskwNZ4wqBTyUkEVNIic5SAOmv+qkjEAsTmfcOuL/gi/oLxZaPdPjWE8Ke8XKxV+CnX8bS8k/IdJd8W/A3i1CZ6DUwuy08940GI/p1PSI=
X-Microsoft-Antispam-PRVS: <CY1PR0701MB109793A0E6085E2659C2F27680710@CY1PR0701MB1097.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:CY1PR0701MB1097;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1097;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1097;4:/vJ5/armoZyJ/FDPtYBSoigbOCpNSC4oRUt+ILab2v6xIrDKUIZUB4mIOl1e8vQWGeVic7IQnNuPpRMN5/IVOc5DURhw9/611ETBJw/RGDFRiilkO1GRf+aPHs7WvsuoXMBqm8NEwtEl/ojwkznD58krOdUpL7mFZYNDSZhQW9YZ560qtQRUkeEkW9GbaRBnrrMj69TNlwhHRlgNBmYCLDDArvyo7xbX1+lG9Le4nmoRhQX1wW/lT/+Z34aKFq/rIUWpLEXZNcb2JnJYyZculyjh8qPZD/AZ0FkrFgA9p0TpssnUHZS2GF+Kn2NN49JbcnE2zdKuwk/Quqnc8UYBKDDVqg2NDwaQB18jFWH+zT9CCjYZc9qpJMk7ldZfaitM
X-Forefront-PRVS: 0938781D02
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(99136001)(5008740100001)(110136002)(189998001)(81166006)(4326007)(42186005)(3846002)(586003)(6116002)(4001350100001)(50466002)(5004730100002)(65816999)(87266999)(54356999)(50986999)(2906002)(80316001)(47776003)(19580405001)(33656002)(36756003)(77096005)(19580395003)(92566002)(65806001)(65956001)(66066001)(23676002)(450100001)(83506001)(64126003)(229853001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1097;H:[10.0.0.3];FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjA3MDFNQjEwOTc7MjM6ZG1QdWJYR2FzcWtvbUZzcVFpeTJOR21z?=
 =?utf-8?B?N08rcUZ2Zk84cW1WaU9TUzJia25MQ2NqU0hZNzg5Wjh3TU5rMm5pdENiQmkv?=
 =?utf-8?B?TEE1RCtMd1NGU3Q5c3VjUFNlK2FYbXV0Wmt5ZFZCT3BCMkpPK280cUdSRHl1?=
 =?utf-8?B?bFdGQW1vRDVrYzVJTmQ5SEsrT09DNjhGeTc1eFZISkZURDJwNzRwVTI5OVZR?=
 =?utf-8?B?WjZSYTVhMnpRUEdManpXV2tuOU1haW01SDNYOERqWUw4dDVjZHAzdm8yY1RR?=
 =?utf-8?B?YVU2WU1KeVU0Wkt5MXpSU1ZJNU1JMnRzSCt2UTBuNnA5b2dUeDRobXR5Q3BY?=
 =?utf-8?B?b0IwL1ozQk1pajhwL3R2MXRraTkwRml1djIyQVZvRVBHUktWb1pacWJraWk0?=
 =?utf-8?B?K3VnWS9TL3g4bVl6R1RZb203WkRnazBUNDhsblFJMDFpbERCT1AzRVZuSEhQ?=
 =?utf-8?B?ejVJcGhKQzVnTGNadUJrZHdvaWdyZFFDUWdBTDRJNTN6YlF6UkF0aklKLzk0?=
 =?utf-8?B?NlprTWg4T01HMThMVG9VTkJZNjU5V0FNNnNPQzdQa0o3TXREbmRJWW56Ty9t?=
 =?utf-8?B?YnVRNkRubWpSbk5nb055bUhveG11bEdrYTJMNWdmSlhQVTFlUEd6TmlTcGZB?=
 =?utf-8?B?emxXeHVta2UxTDNMUTVBd29pcllVNUNudlBwRXdVc3VoSWp3a1hCWUNvRERU?=
 =?utf-8?B?eVZCQ1VUUkxwQWtYL0M2U3BwZ3pDYkd2TVpnOFVYQ3hEczVhelhmRlVzSFRM?=
 =?utf-8?B?RFluT0pVQ1NqdC9GbWtXUG85Uld5Rm5hc2pJTVY3WU5EUThzNWZ6UGFPUTVi?=
 =?utf-8?B?aFdZUDk4eEVZYWxBeVE1QXhldGNzdk9qcjFNclV0RlE1OEkyNVlLUnVmMmRJ?=
 =?utf-8?B?S0MwbStjUDhHU1ZQQVpVZ0p0bnM3WEhETXFSRzNIS2JkZEhmZ0ZlYnlQS0VW?=
 =?utf-8?B?VnRxL2RES0R6Qk5WV2UxNWI4STRTNmZycDRNYmZNYUp4Wmxlc2VmcExWVFpX?=
 =?utf-8?B?dXByN2oxamhHUC9xMHo5MWduSTJWM3lvVXhyeFBVRm5TYklQc0t2Y0Q0Qm93?=
 =?utf-8?B?QVRjWnJTaml6UWhMalREbkQ1OUlMVDhJV0V6K2V4TjJuamV0WXBsbE9Dek5O?=
 =?utf-8?B?b0tRZkQ4QUpsTStzdElwOGVvR2lYMTZzdE1VS3FORmpWNE5YclUzdDljY2JW?=
 =?utf-8?B?MkNPVW1zSmVydkp6aVZadEtZbWdFTEJ6bWNCeGRnNkF1akRldU9GNlVHdlVu?=
 =?utf-8?B?Rkl5MS8wQm1SM25uSTdZZVh6UXBWcWQrMXVHaHRLV0dNekxUdE8zRUwwZVA3?=
 =?utf-8?Q?ZgHoNL5NzBGS+Pgt+WGWPcsMnJlkFsnmwI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1097;5:R1tEMBJP0MK5A9iAKaMK8vKBjfzUohGYIYxWBNf0j9jreNEbPW40f1tVMUi32PgnFsoNEbSSdfZV6FL2UdRBGoWjDBzJOlFc9cROZl3oKqxd/SmL/fr6m0GMCzeLISl+GFkdrkzLsLdPb3OeIMmslw==;24:X2g5aZPd31Jp/gnRAXs1lHwPlZs2wJyITRZTYj8OBM31ZZvdLsTIOhWKSy13aLaZFALAMOjToklzcYbfknXXdOnSHJLta4rnZd5ElxYscyA=;7:e/H4L+DOXudlhqVWI4l8xrKu1mA/V40Mcrb3Ln9V9Dv1GK+G5KAUTDp1Q7Ne/VU4sgqqR1STwuGMR4m31zaFT1CchtuZklo9QE32VXgxWOSqLeABPrMtznj6EFPkgEvhTrF3w3dYiweRR++9RirwtlrFivJqynnRuieNX1ROJXtxeub6ctaC7be62UuVDS/V
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2016 18:05:29.4621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1097
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@caviumnetworks.com
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

The FCSR register is always 32-bits regardless if the platform is
32 or 64-bits. Change the type from 'long' to 'int' to reflect this.
The entire upper half-word of the FCSR register orginally set all
the bits to 1. Some platforms like the Octeon III simulator will
actually fault if ones are written to the reserved and/or the FPU
bits. Correct the mask to avoid this.
    
Signed-off-by: Steven J. Hill <Steven.Hill@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b725b71..4aa8c76 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -75,7 +75,7 @@ static inline unsigned long cpu_get_msa_id(void)
  */
 static inline void cpu_set_fpu_fcsr_mask(struct cpuinfo_mips *c)
 {
-	unsigned long sr, mask, fcsr, fcsr0, fcsr1;
+	unsigned int sr, mask, fcsr, fcsr0, fcsr1;
 
 	fcsr = c->fpu_csr31;
 	mask = FPU_CSR_ALL_X | FPU_CSR_ALL_E | FPU_CSR_ALL_S | FPU_CSR_RM;
@@ -87,7 +87,7 @@ static inline void cpu_set_fpu_fcsr_mask(struct cpuinfo_mips *c)
 	write_32bit_cp1_register(CP1_STATUS, fcsr0);
 	fcsr0 = read_32bit_cp1_register(CP1_STATUS);
 
-	fcsr1 = fcsr | ~mask;
+	fcsr1 = fcsr | (FPU_CSR_COND | FPU_CSR_FS | FPU_CSR_CONDX);
 	write_32bit_cp1_register(CP1_STATUS, fcsr1);
 	fcsr1 = read_32bit_cp1_register(CP1_STATUS);
 
