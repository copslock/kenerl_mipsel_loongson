Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 20:10:37 +0200 (CEST)
Received: from mail-bn1bon0095.outbound.protection.outlook.com ([157.56.111.95]:19040
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028735AbcEJSKcj2Ryr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 May 2016 20:10:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MPKnsbaEuy7gXyDuPeHWKI7yWHvUPWlNe/vClcEVfoE=;
 b=i6mcNnPdzcFAF/A9qrRQbySQctHhFH/Czf2PvsA7L9ARkGK7i4hleEiYlA9WydAwrIDtIC/lfYPbk4bo64tAMo8RExmmYQlhHsc8/Idr7+5O8j5LuRXNRiiOgV9ZV0pUC6X8gWAbJLl/T4CXpXDkj2xfvgkSr8b54xOUZS0W6Is=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from [10.0.0.3] (173.22.116.65) by
 BY1PR0701MB1094.namprd07.prod.outlook.com (10.160.104.16) with Microsoft SMTP
 Server (TLS) id 15.1.492.11; Tue, 10 May 2016 18:10:22 +0000
To:     LMO <linux-mips@linux-mips.org>
Subject: [PATCH v2] MIPS: Fix type and FCSR mask.
CC:     Ralf Baechle <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@caviumnetworks.com>
Message-ID: <57322408.5060702@caviumnetworks.com>
Date:   Tue, 10 May 2016 13:10:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.116.65]
X-ClientProxiedBy: BLUPR17CA0056.namprd17.prod.outlook.com (10.162.85.152) To
 BY1PR0701MB1094.namprd07.prod.outlook.com (10.160.104.16)
X-MS-Office365-Filtering-Correlation-Id: edb88ea4-8834-48a4-3576-08d378fe5a90
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1094;2:QIQZNWiUfJR/s6LWIaT8r+94ULGmQ2W9wekUiKOp0HDa4ECayJ0G3NZWHr4FxyEo9XOQ0TbvNOQO4HdLr4pdYIAqiKZIwiR3FiXK/zbRtDoi7JRy9sKa2ltWlQibY2dJ1+v32xDU11RjV7hVS3sod9tjHLTsYXvtdLfhJQ3rvAJsybKdrOB4zDmiI5Y315Ke;3:uRHveMJPK5yv/UlRFMffnmNm8gH6o1lsaety/x7OkysQQlIzRIObaHA0309ei76xZw3ZhoU3dQhYdgYx4S9jFqp0vN7rYFcOpnRXIYvjMt41sDpWvFlXCZ2TJxjXwFHU
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1094;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1094;25:rtVVPiX6cbfoSrA+c1cImBMS2annovxm2jJJMebywADEgH28cwVfhF49zdrbvDvWscm1K1JUJspOKUeogXQIBw9xhxu6ZWOm2rBcINleT4PhS8/mTyoP/lh15rcijBov8Qx2+MVkmaXCjJ4jWHXM5vD0wwJL1kZOC6Ktpcr3GcJ0lSfGBGJL/+7a7dAVyaBnAz0P9zfXuL/vxW0Ii6G3knpuq1USEvOPO5wpJbNMLr9+0rj9GTWFsBnpNf4X3PoK/ej0RM2PBmlpJPu/DlXF9uo99L44EFtcgo6+uSs/gNjIgSgGNw6D0fWuBYDwHGOg+14WOL2Emx1bxbJFeB2XF0FGDghYGQl78UdaG+39XEK0T82VNv2CeMA1t7sP+MeBCqFjM6d83w2kikKxYZ0Y3RNZD1ZP9sWdYIGKzK/6odxS7Tddu9rXV0cBIEo8wp2qMPaYtl+NAI2HIi36y4AmC+bhwPvSJihkLmJ7SuZ3rMrmFenUiaqFj3MRWt+kKPJoVPonnzWOfzEhObkhaUMPTeAvHS62/HNLL7Uj0yrzL/fv8apuUyuMZqak0GTnu+5CMG+nDNmRciOC3EECyUAlrTHd1lvsqpaxqLrzdZI2xmvVEXXz9Y6NFFDmd/eDgBe63x5Y4cFrtn/GsA83Yu9r3lCh6xJWCXXbjpoRdbI6AN+EK70H1LluiObhzkVHPNN9pRy+yBU7RLzpsclOwAhQnEfcHqVZeZkIIHCDz/h4UWDOClroKXoQlajy0zakHwKmOZoYvfw6di7V1eXIRxB+jQ==
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1094;20:QgwxETxK8y7ndp9hDqRjrcgzBH3XSsYjdNxCWFLjO8jHcS4LlpEKI4nN3nYHqKMIXbSvlzcO7xLubhCvDBRit3V/WRMMreiK1APQWTTk99wShpq6JWQ4wYimszcVETYNwg6MjBhBoC7fwQbi42wejiaTuWVQTguMJYZMgMGbYkhejH1XZ79fIbMpbiy7JwxVCL7r2zGJ7fC2JOqdzGBYrbhF0KVWrw7yJx59MqM6TQ31o5E+nWkcX+ZDR9kwRMoV+rv1/IFNCBAxgv/jNGvS+MoR+8UP5oIqSJUghx/+f7waTPsz69cbU2MYPpqOqEDoisfJbKCTS94RD8nV7shPti/3hoeDo0u3KNI47yQuFL7msMIqn1whPkb1Uw2YC1yIqb73JjNklSsZhZdiqDJ3EAH+BLk2T9UfXiEnq1BLc6gWHz3JPinIOJApcK1y+DN2m+lQQmbIMrWQAzEsc5I3+AwIbvg+Mit47VpgAOYNG1UUgh3alOu5E+rwGTkMm/kvZrR0Dc5i8xmi1TIlT9V5TU0O8JtE/VoGmbR2FuboYNc771W9/rQ0+fA7Upz1XN9ezIIsbZ3OY1zjsboN++FlQstcetOwk3WSQvjXH95QhCw=
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1094B178CD6FBD50FDBCD47980710@BY1PR0701MB1094.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:BY1PR0701MB1094;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1094;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1094;4:PH+vfJGlebYchb+PSgPRU1F8bE40b81yL3NoueXJaMmbAyM9hDm+K6au0mGYDIAd38vaMJhx4ux6++jYUs1zAHd4HI14t9b4NEBl+Yb1uDQVFpkTShWpXvi9PgQQA9mTsSDKU1Gm0A822szPaqy8SXAy5NxHqQ7E8aklJZntXrgK9zivMGDR6ETUeyDklYSRoB5TDXuj+jN8iSJFzg+7Y76nGvPA9Bc9Cx40eFGbdF9GhLaPXhg7ldJ2KU8uTtbYiUBM3XisR4AAnWZSKke4P5kMIIz4HQaZepMH/DmYWVaTZteYY3iA2JvorCiRTSI8vYVa7zKhk/WvpA+mQhwlK+H29EzIBG07TKgz3L37NEn4kglBZKEmTCQE0thmsb23
X-Forefront-PRVS: 0938781D02
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(3846002)(64126003)(586003)(450100001)(6116002)(117636001)(19580395003)(54356999)(110136002)(50986999)(83506001)(36756003)(19580405001)(2906002)(4001350100001)(4326007)(99136001)(5004730100002)(5008740100001)(87266999)(189998001)(65816999)(23676002)(47776003)(50466002)(122286003)(229853001)(92566002)(65806001)(65956001)(66066001)(77096005)(42186005)(81166006)(62816006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1094;H:[10.0.0.3];FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTFQUjA3MDFNQjEwOTQ7MjM6bjErYlZIdzNHVTU3UmtwQzFzMjIrMHNK?=
 =?utf-8?B?a29keUFvTis3eDVkYy9HaklxVXlGK0o4emZIbHNqaWJkN1hIQjd0M2JkVVF5?=
 =?utf-8?B?UnJmSk5Edk9rTWxtZ2d0N2JiNVVFQ0NMR3V5N1BnQjNRTzR0Tzd2cmo5dG1x?=
 =?utf-8?B?bXNhNkJoV3Z3VnRiNHI2TzlWaHpJU2o0cUFtMVRWRlVXYmdQTVlXWm1jbm1m?=
 =?utf-8?B?MHZ5dERFdzRXdERkT0tuZE1aak92ckpuZFhlbzJYOXpQZW9Yd1BrZ2dyRkQz?=
 =?utf-8?B?OWplOGc1bHkrRmF6bDhmV2F1STRhTm1zZ0RQcjc0Q2VwQi9qRE1OeUkxTXZ4?=
 =?utf-8?B?S0VGdDFLUGdEMHI1eU5FS2pnWkRVdzY3emFycFlKQkcvdzF4RDZtQ2pSTjd5?=
 =?utf-8?B?UkdmYVdnZjVqWmJIc1Y1eWNxckllSEMvc1MrQ1VjSWk3eW9jbmhxN0RSWW1n?=
 =?utf-8?B?WXNFUmJBMU5XRkpxTVRuSHBKbWV3Q29jZ2pPUlI0elQxSW5sK05qbVdpTzVX?=
 =?utf-8?B?dEMwRUFzbzB3K3c0aC9TY2JmR2N1dHlFWjAva1RQcEgxUEF5czd6MWlTSVlT?=
 =?utf-8?B?RTlxZ29rUWE0SnhBSlNKcmV3aFZoclB3WFhxc0xBbTBFemx1K0NSOUE3TDZB?=
 =?utf-8?B?VU1kWnVJalFBS3N3cm9GV3IxR1ZPVm5nWXYvWjl5c2pmSm5hSy8xdEU5SnRh?=
 =?utf-8?B?WFlRN2Q2V1lhMGE5MGU4WCtwcWJzN3JsdkRCL2dhckQxYkRNQTdpQ1ZIbUhV?=
 =?utf-8?B?V1I5TEhQcm03UDc2RXJZOUpnc3FsNysrTnRqN0tsY1VmYVVDTXlDWE85Smlj?=
 =?utf-8?B?Q0M0dnc2cHladXBXWndndnBWWjJ1Q0dTMVdnT2MzeFJXVDdNbUZpTmdUU2FM?=
 =?utf-8?B?WVV1Q0hWbC9xWnpBTUVGajg1T0ZDRis3OW9zaU4wdzZCcUE5Um1Gc0pkeXBx?=
 =?utf-8?B?N1dIN0padk85QldSK0JWU0tsc2oxMWpBK1BOOXByY2FvZTV6TW1pMk5mb1BJ?=
 =?utf-8?B?bFNHNHg5TThwNmhES1pVVnVNYUl2TXhuVkQ3cDg1bUZnZlZnQzQ5VEx3R3Za?=
 =?utf-8?B?cEJIV0dvOU92ODMyU0hVQVVzTUUyRmw1NXR0MG4rQW1uc2haYXE2SElLRjVm?=
 =?utf-8?B?cWZuNU5qZzFHQmVCc1JSVVNvV01weUhPTzBST09BaHlkaXdIRlVlRElDQVpP?=
 =?utf-8?B?ejVDZFpkNWJVSUNYVzJEODh1YWtyZ01xZ0hmeHMzTlYvYWNtOHU1TEZwekhz?=
 =?utf-8?B?cUZESXZFWjBuV1ZmaHRLSkNQMUNMWnJ6blRUWDQwV1FCTGdkNkE1MDBQMmdC?=
 =?utf-8?B?U0JpMDJIK0ExWC80NldIb3p0M3lPcWZ3MDF0TWt3eU5lUFR1Rjc1bnR3SFVh?=
 =?utf-8?Q?/mTHzmv2zY?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1094;5:r51wtVPhMvANXJYKeCM/lR/z7flSeU8DQLtR66UVG3iRqTTRmfAaQWC8//m++FYawxWCfZQk/JM3LHwchyx37t80090wLJs47TUNTUAm68uBkfA9fRx4WZGdKTeY7DIvzuvf06AWDPwInMidj+yqvQ==;24:kZtbtYrrLO65HAjpjOJ/8ee4vJ4LqwuxN6Fc/IqQbDRHAi7fRasD5JqWaKYODK7rUCCYaBd2D0a5GgXSz4xTrHziebKzlf8oCB9X9Yt+2Wc=;7:Ik4ESt02Ll3OIVBgg1yiiU8iCnK2EPOe13m7i6Xcr1ZyQ3uPlzRnmZWgnDWpct3VTo2ouzAYHTQd7hjkHpOYfgGKCYWk6bOUFYWPlDHeRQRDqqlRJWahq9bbHap9hOAly/cHEIY+4/qnFZ2MyeEVqnC6RDvHIGnp+RJAB7YBD+kDm6cBF8Et5BG43rwF2ZQ3
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2016 18:10:22.1110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1094
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53350
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
Acked-by: David Daney <ddaney@caviumnetworks.com>
---
v2: Change David to be Acked-by instead of Signed-off-by.


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
 
