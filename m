Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 21:02:28 +0200 (CEST)
Received: from mail-cys01nam02on0047.outbound.protection.outlook.com ([104.47.37.47]:32616
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992509AbcHZTCThKSwY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Aug 2016 21:02:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ngdlSEbuSHm4avIjR+lon0jKEqGXKP/Apklzwyd2WPc=;
 b=emkIJRCJgMPLthBy3C8xeFZcJ2l9Hk3ArpN35W1iDXc9SusvBGUyCih5uHkZ7W1fK0ZBAM+154eA4PWgnsJ494e4ay7RSbIWgsIkxjfszkuCHIgZ2LbGt7z94Kk70n/tZwPrS+UQpry0xKT8LzZNHVBVmOFAKPS5snhtrRPnjEQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 DM2PR0701MB1104.namprd07.prod.outlook.com (10.160.246.147) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384)
 id 15.1.587.9; Fri, 26 Aug 2016 19:02:11 +0000
Subject: [PATCH v2] MIPS: Octeon: mark GPIO controller node not populated
 after IRQ init.
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <57C0922C.40907@cavium.com>
Date:   Fri, 26 Aug 2016 14:02:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: DM3PR18CA0008.namprd18.prod.outlook.com (10.164.243.18) To
 DM2PR0701MB1104.namprd07.prod.outlook.com (10.160.246.147)
X-MS-Office365-Filtering-Correlation-Id: a5246f00-f2a9-40b2-4077-08d3cde37c6c
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1104;2:1lCVuWD5fDf9SatxMLn49uRHu3t3jya2vFEFeQzqZJ0IcJ2ImpN4UOUi/mGhEEB5kyKmZWJa1OPkzclVQsXM+r7ztk3dKGKpV0E237i1GWhiake4rRVkaVUBf1LJNECOyQb7NXTePpgcvpTV7ks8DG4HMnHsyLT3akqGL9dJ0jnybOE7xz/BGQoaZgTZFjLj;3:hJgysv6PW8ytq+VHqBFfJy7XOrVEfMjb2IobWwtCdUBFdgrPzDOjQsfB4KoQXv4nTBYQFezmrqIhslwDeNlpyBFOADytMRkrkrlY7GHDqjALrIMxEnzSeVr3L8DkNAWv;25:3R+tq6VR36hOEVmnwK2a/pBfgkOQN/e5a2mWQqPvgqbAazbPp2dapmPX281NZ3SQJt6VSLaM5iGZMBw6vPBylk9XBe6rYH4vf5BXYgrZg+Tif1FwzMLVHgT8Tajz7vOomz6kyxUAddMwM8NnmnUrRMdk5rSsK1j76dEa626A47Ix5RALAH8JbOiknzamR4ESG/bOSZBbHfVaXrXQYT5M8Igm9C+REUtg2kIM14PDiEx2ZGjmltbTRxlBdTZI8TzJuFQQB352yVEGkE7mDHNyjc9TaobFRoeh+R80AnNrmezAU/I3EsJJqbczo6pAqZbshWrwPoQgcbxVnF87DKSBKpGsBBz4qWvQN0X05UA5g/29LlSzQ9lxRWDdrxDpBisrppkWEX7SfOA2lEeDs+oZ/dDLAnHGGQmKFOXkt0Qoy3U=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0701MB1104;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1104;31:BOtGph87FqEPqiVVzJXkrxqaJaIFY7DuWV4Lbphk/fnpzo60NrYy606qRoIiPk4jBvhUir2GTw+skjjW7Gojw0EEfwB3d2bGjawUQXszISXEkn7KQgMspGRTLjw8A4YzJEqz5xZN/GS1rapdp/e9Lf0M478+c0IEqmTZ/MMuzvHwH/lq86oUQObOMiLekw1LAXcUG6NudMCwNQsvR/XhrADu6b3Lgok9OhSksALk28c=;20:RLWEv12Jibp7KikSs0tEb1KdSE4k93AoUfkJDg+dscwJrFfbXF1+E8rREaZsBIjw45PMmpVlu4WkdWjolIcXPlsJre6jHHHXDQhIeKu8G/UuDoDVSMmy3jLD8PNcuVqyOw9bMuJ5KylQAKtIoi4hywaD1HKpvmH4Lzg3L8D+dGQrb4cQoU2T2a5ApBzgV8S7AJlFnOgdADqqOrKdXHyPwkqq8Q5M1O0dDEwUja9Rj2DlIPokWXzl5Wpg+M+u21XqRYMM7E0wHbiNVsB4mR+9jyRjjMgiluAyTLI9ky0n9QHOOaI0MRsVCSQiQzvIEejeFl3zHxHCnEmW1arSp8lXNRlTxlmAfm1wMTtRm1cQQnwzli9Jy/+Y1dgPJXutThSMCxGf8SaIk6ZpgOp9snjcmrfHILf4d706tpyzFDBStiWfu7gxG/XT8Jo2krFlanGn25cEA3j2wdaFJA7vk/Vj915WDsKFPh6PAx0774V3wYEudB5WIb5C1DMR2FvvSXaj
X-Microsoft-Antispam-PRVS: <DM2PR0701MB11044B057A95C0AB2AB25AEC80EC0@DM2PR0701MB1104.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:DM2PR0701MB1104;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0701MB1104;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1104;4:ZqSV7jdG6ZBdIGXGjo8/+jeZAAU0MPEDwuHvFbQKgakgnU4whXMzhhOJwYUnlMrsxPPAo7CLiwZAV2lyc46ROfW7l+yKGvoWpV9FuLJG/2nVwqhDulFDXxzqnf1ni24P2qX8bsAX1ivulVmShieRXauRaGii93a6jJ8uPT+NjqqpPVBuKim0LMVm8+43jqDOqfADTjK3SFl0Vjqnl7Zf9gNBFv2NQ0oG/5b7eCQr7ISrlvHkJwH4CvvzkrbLEDjubzZ4iruZYblKl0+YLIJTEovtEmEadx6Qq0FZhYDgOUbpY3NxKHB3N7E7HdB6tCOHBEG2+AA5yYEMvHx7tH9qIFoAlR9b+nWNU3ru/gmg918Pd0H/4/dV+fW1NSfsu30YE34nlOEyEGpjRsWOMCIcPw==
X-Forefront-PRVS: 00462943DE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(189002)(199003)(54356999)(81156014)(81166006)(50986999)(19580395003)(19580405001)(8676002)(2906002)(4326007)(23676002)(47776003)(6116002)(66066001)(101416001)(586003)(68736007)(77096005)(3846002)(86362001)(65806001)(36756003)(65956001)(105586002)(106356001)(5660300001)(97736004)(65816999)(5001770100001)(33656002)(4001350100001)(229853001)(50466002)(189998001)(64126003)(92566002)(7736002)(230700001)(83506001)(42186005)(7846002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0701MB1104;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjA3MDFNQjExMDQ7MjM6a1BXMjRpWURwZHhoaTFMMSswRXNpR0tS?=
 =?utf-8?B?aHJCcytiSEpZQkdPaXZVOFRkOFVadmkzcGVxQzRCMm5EYk94WXZNM1hQOCtq?=
 =?utf-8?B?WEJIYkhlVS9nSUdXQVYrMkN6eVRoQ09GM0pmS0h4NW9HNXBVNUVSZkhlbTlm?=
 =?utf-8?B?QlFEN2NsQmh0L2Znb1AvNUsxMGRobHo4aHNDRnFweGF1VVlWS2tFQWZPZWly?=
 =?utf-8?B?NjVLckNYSXFjU0oyOXVMVU1ndlQ5emY3Nm8wOXlhODdPdUhKemRBbGJtQk1m?=
 =?utf-8?B?YUQxLzQvQXUwQ3RGaGp2eXhmTC9VKzNMQzl6aGpTeVdwdzcxRzJtbjNrb3VB?=
 =?utf-8?B?WGxER1JwWVpFQ1l5UHFiVm96TU9pVVFLamRBN3Q0NXBQTCtTK1U5bXZTRHJP?=
 =?utf-8?B?bkJzRTBmQWxUOUlTUTcyUXYrUldQSE9WZHNrby9BRTQ2V21YMTAzTmt4eSt5?=
 =?utf-8?B?V1NnTVlVRlZaR1hUYUpKbmMya3JiYUpDam1jWmNqVnJLS1EzMU1lZ1BzZlpj?=
 =?utf-8?B?SDdFT1BYU0lObkpEVHVYbW4rNzFGWVdHNzYweHR3amlxOE9NV25wSUVneDQ3?=
 =?utf-8?B?ejdRUEZxU2ozOUxLNTJoWGdxcDE2WHRWTHg3ZGVYcEhrbS9aSDFZd3BkbDhL?=
 =?utf-8?B?Wm82dW5oRG9BSnlMemwyOWlpWjR6aHhDdUU3cVJ2OHNBby9mUzVWa3J5K2t1?=
 =?utf-8?B?MTVLcHlIV3drU2tEbldjMDRMRk9ONWtRaTJyS3g0MW1BRFhPOXUzdVdsZUVQ?=
 =?utf-8?B?RWZObTBTTk1FaEhjMzJzaXUyZHU5eW9CaG80RWNMSG5hUmZqeFJjTXg1cEUr?=
 =?utf-8?B?eFhDVndmNG1WOXVxNUVGbzBCcDFLWWJuR1NHeENSQ2hPY29mVXlzSWNlV3Rv?=
 =?utf-8?B?T0ZnUWZFbXUzRlkxbGdub01sTTlIcDlPbjJxalVKUDl1anl6UmJhUkNCcjg5?=
 =?utf-8?B?WGUyNTV6QW5DaFRHWUV6cFl0VDFNWDBVYjRCcEJ4amJrZ1BLSEl6MVpNMzdE?=
 =?utf-8?B?Y0F1dG9CZWJZUjNZenVIK3BmNTZNNjZCSHdBeFd2MXhZbnY4Q0t6azhNV1ZW?=
 =?utf-8?B?SU8yT0VVaUNyclIzVDFuR0Z0Z2N2WnJVUXNpZWlDWGpJcnNock1VbDRlTU4y?=
 =?utf-8?B?cDdtU1ZQM1IvbHVMbkNRb2VNRW51TElXT0NDSGp1aGNaemptQXBZS0dWTW5m?=
 =?utf-8?B?TktvamtMMDhLK2RYY3JDUzJ1cEtaQU0vNFBWc3pzVnNLSlk1YVllc1dlcUg1?=
 =?utf-8?B?NW1hRHd4clo2NWJGL2c5MVlvczI5dXM4OWF3cmd4ZHNwcmZhckZwSTNOS0RP?=
 =?utf-8?B?NjlVZlI1Yi9QZ1crdlpuZjBKcFI4eGZRNTNlNTFPdXhMYWtoNXYvdFNTd1Bi?=
 =?utf-8?B?OFdXQ0picms3aCt3MUErV0hJTFJrdE5nck4zaXo1YTFPMFYxTmdIZzBxS3R6?=
 =?utf-8?B?RUdsdjkzWk1lcTBWSFNDWjhKOUxIek1QNHRNMjZhUDNudFBNMDcydHViak04?=
 =?utf-8?B?bEtGcWNqMWRnSmc5TFFURGRCTnBaLzdYN0h4K1lJRDFJdHZZc3k1Nnc5b1JD?=
 =?utf-8?B?US9VL1oxWWNxV3VMN3d4UFBnWE9iU25TNUNqNXJwVUpqdUlGZUNybzU4dGV1?=
 =?utf-8?Q?Y=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1104;6:KfZGIUgJNZrqVkbwD0wckiD0Ilvu3eUqD7X0wJpyVi+3Eq+6jCSebSsEJ9XfP2pb/7RpOsH+U+bvF9ss2JJBYTpR8iYeCQtic+U5u9liKZGVGENofSfAeGNUDip2SR61BHCBlfXtZQkjhGP7vfcIZnG6wvndmi402KbniVEK53UmwvvBE8VMSSqsFtUEgnog4k8Is05NWsmyJbJHKP8+6rxr3ZJFsEfIDJJJUXnW83iXJCVDE0F7F+shk0vRheylWkoNIk5naKAPyuZeYZAA13Zm+1Elcot9t/kKJR4YLBQ=;5:279oOzu2+DGeyEVVYbV9HbgxnWl2ZlTUUhwSSWaz2tNY2pnlhpGD7x+kuvo1scFtQjSda+2THKthAVNDaLJP/pOkVn/HPJnS6xhkZZg1ac4WwlNK7Ky6yJljEsO7TUldYVD3xriVTeaX8cSLts4cqA==;24:NaThVkOw2rKQLlWcUEdirVVk6+c8oImIMxFdgJifGMSbdgtJxVRbSX+815IluzVip1dBX2TSmwEzXsQMOgfs/NeLndHSDrX5Q9KAKK0imkQ=;7:5Ivi1CHkBZE+mxB3fQLKM+nFZCwtECCocddN6R+oRbsNIpl81weqnie2BYjHvZBzO0jAg890Rs8CBv4l3OswK6oIFKlxKDMchUuHFRcpE5bF7J+2MhHSn4FYeZuleeQtIxBd+sdRXrtLr49STzqS6Qbd+nABknI4qJvQOImaW3poeMG5bK7c49xQRXCsM22wMNGIS36ZFRZ9pCo8wZMX4PG8TM5qWYcMLRHxcxjIB98CASKqXaaxXxTTqNPxn61n
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2016 19:02:11.4388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0701MB1104
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54815
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

We clear the OF_POPULATED flag for the GPIO controller node on Octeon
processors. Otherwise, none of the devices hanging on the GPIO lines
are probed. The 'gpio-leds' driver on OCTEON failed to probe in addition
to other devices on Cavium 71xx and 78xx development boards.

Fixes: 15cc2ed6dcf9 ("of/irq: Mark initialised interrupt controllers as populated")
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/octeon-irq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 5a9b87b..c1eb1ff 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1619,6 +1619,12 @@ static int __init octeon_irq_init_gpio(
 		return -ENOMEM;
 	}

+	/*
+	 * Clear the OF_POPULATED flag that was set by of_irq_init()
+	 * so that all GPIO devices will be probed.
+	 */
+	of_node_clear_flag(gpio_node, OF_POPULATED);
+
 	return 0;
 }
 /*
-- 
1.9.1
