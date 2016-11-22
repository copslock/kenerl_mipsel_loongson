Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 20:45:37 +0100 (CET)
Received: from mail-cys01nam02on0046.outbound.protection.outlook.com ([104.47.37.46]:54530
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993188AbcKVToea0hnv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2016 20:44:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ifJouailkbME+vgGAZOW5HDr9GaiMbhv689uiTMXNc4=;
 b=kzuw61Ldk33BvwCbq34jGmTCL7xUd4vPgiQP0/5ij8QIZ4YC50ipiacIwSYv83j5wBGQSb04+2upgXbXzqWzCn6Yww2DSAnbOmeaeOAmbAfgUKW9fwj/bprVbWqkZIOYCBeUUHArY1X++N/Ko2lcHqGY3PtFr+UHJkqzURNAXaM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 MWHPR07MB3214.namprd07.prod.outlook.com (10.172.96.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.734.8; Tue, 22 Nov 2016 19:44:25 +0000
Subject: [PATCH 4/5] MIPS: OCTEON: Add plat_get_fdt() function for Cavium
 platforms.
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <d6661543-da93-b164-8cd3-480b33165bac@cavium.com>
Date:   Tue, 22 Nov 2016 13:44:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: MWHPR13CA0041.namprd13.prod.outlook.com (10.173.117.155) To
 MWHPR07MB3214.namprd07.prod.outlook.com (10.172.96.148)
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3214;2:fs4izxRSRItByq1d1BWcTPcUi/elGdmhz1jpATi/tIoIa6vWsdekWLxYzcXvS5GrZEwgaIMBSHtp4Ygo+uqOVNIMceo+zXOAMyscslVqL5fwkZeH176vGaUgQI0vyxPlggSouVC65QpCD+qb0s8BdW1KcE8MjBIvNxNd598ZjGc=;3:t6IsdiaM+4/xCSzgk/2HZe3VbdlIS+rCf2hvDGTLYy/+D8n9RRYMcAWh0ENdHHJJbj4oiRHG4t7XJdLcRP3ul6fCFDMFSRBjuiTDMGMwXcpZloHyJQonwuhbhHNuxCNLzoWlOhlbXVsWb71Cdy5Zvc63qHv2vjHHTykh/t9lskY=
X-MS-Office365-Filtering-Correlation-Id: bb748442-f8c0-443f-47c1-08d4130ff74a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:MWHPR07MB3214;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3214;25:VvRaCRsyiwXjuoZwL3Q2aNOKswf8deOtt0CoR2fkkdSp2a4JAONh49XTKA+0aMoOyVpxZLZS3TntfSZg/LphTFbyH1cFYqtF++gnupYH+ysiKvDizwxRdN0bXDQUYp/14LLgqGBpWEv5/0oYAXB6Wkol9xyAegwl4zK21pxJB0xJ823eAKcVKDJv1FWHWNNRC7R2C/4aOyMdQ2zRhJ6R76/Fi/Om3rQQiH19neAHZf6Xpwhlh48LF2fzLcBVjfkDz1H1Yn00fIe1Yv33OZhvF8tBk1tKUob9qnBQPTTMtlXWnKfwqZcUryO6vMocWbR9NPAI8K5aZEik6oilWVyOljDVypkMIAKJxouVjEmZfwN/zc+pi8MPu8gtmKRB1TOsenlqKGT6jTmU540lT/DcGPoMK6gZAZC7UQuaXzz59npRPE8+oz3ModuKf8P3e8oiEznDzWGMXOkDC/fUlgb2K6lYkYXR3F7zqhY9xLjUT6X+sRBWc2Qk0HTRzfS1PTlhWJlHZlSgCkdk2ZR5nFLejsB28+9JQZWO/Gz+X/1eThKMPZrAqdeSX6TuKmuN4oiigaXaazOvJoHGF7t3YxdziAIihN1CRpFX1KGRe4cKvhAv232PAqkoIOCtZ0mwDx3iqI321fvuEf14N+FIq7s/6lKXx6sHiZATFQaGn65SZ20/o9sFYIYWGA8lMkTg8gLrQvLlc799sEE2GDUqvpH3KaO8zj83Sdzu9ZemZG4tvl2xWVuMokMD/nu952akuwBMHpais1n2tkcskl516bsb4w==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3214;31:O5DfeUedqIoj8NlX2XV4N7v5fvmSJUUNq4m7/wqr5Rlx05QbNlmj/if5HMgdal/sTnP94Akagms/AvzmLu6pW+IRqQIdPMKdLz0+jmt/IRb3qO9C3g6dA5poy7znXHVmRPsNaAQQGynvYZF2fltNSxxL9gqpjNOAjNb7wx6tM4uXpzJwybzJOlYOO3W2Cai4p6axjyFp/riXZb/t5gx6u6kMbEv8wBz9knZPHO4f4vDZb7/imSy0cCSHIfd9dEzgj7/TRetXFBI41oYQHsKqQ7N/tRVEfq3G6rUrv8Z+O9s=;20:mKooxJT2vT3yHwI/XqRZXw1JyXy5EQX6Rp6YbtDA+Z1Ak6s9xlmCOk/iirIuDWEUWh/DJZepr09hgR3lEK6rbBGhQxungGdIxJXEX8wgV5K6BLQQFzj96gItF5yKhkKNq4QW1+NykvVAFLokPzMtNJI1jL06PPhpIsAmIcBiM30qXKkLYAN51rXYyDYUuXE2LFE2dJOCsaQUi5q8X6xspdOGHtTFF0wWkc4KuMKdHiUpsJ20J8m2OCi4R4YNX8WZk4XzmG2ozjMlBU0EgTcWbgfs3xnPRUcLuI7drFxlguOafEfwp24SWxPwMgCg7P9DfKV9hi/M6oHMfwaHKR8kB00Z+Xpx9Rxv6N3VPQd/9Z5Ne6+kAJGRm9iX8+En2+Z4cZw+jXVvr1ijeqCJS+kfjk0zIocglJmrrafHwcYMk2y5fKFl/dDRWVPECi65QMpKflmYk/ogjF084jXBbFQcX1wFIEUlz15IKM41Cko89NJaBmjhwtOcCeOlc1EiOggv
X-Microsoft-Antispam-PRVS: <MWHPR07MB3214D2870E3D2637ADC5BC5280B40@MWHPR07MB3214.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040307)(6060326)(6045199)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6061324)(6041248)(6042181)(6072148);SRVR:MWHPR07MB3214;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3214;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3214;4:bGNJniCvhU8J8oBxu5j1ZqpcUH0e+n2Un/us8XBIVcYe1Ksu2gh4QNUinEoqGDLRXPq6ksug7TaKNKp1XH9EdZVO9AW/AloGDPY8OBreOjH+uB6NS0zjjXt7f6Xq7faE7Uc2yU6OChXRgWRKGroH0ccpp0niwT2IJN+DyjCCulLRxL4GtGuNu9+rR4RHwY4mRrkTdTJcw5ajw79qXMLEN5GHmQ55DxwB3y4KADdcWP74sMHU5BoWyNedVun9Mitj+JeaZ2w2WC1kxbsmNWh+N+FduNBIoNTt/V8URcy9h0WoR0LBDBbJLa7e16FTZcUqhv/FPbfqro0qjl8uuA/mdVVeJMOynR4JN5wpa6g6Wfa6PRyAUkrP8+T7hnWyLZR0fJeeLxjuz1Vrr/TC0p/deRpCq1ksfkxW7KmBaPJbOMZUQkLTbmyMrtdNRtNpKL5f+tyooh254Wu1stha1xDBOuWDDNwkE2OYJIbuOIuaVMnvqRa+rsCuMUKfhHekfJZPm4xBAPNTbxlFrSPGhLST6g==
X-Forefront-PRVS: 0134AD334F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(199003)(189002)(305945005)(2351001)(50466002)(64126003)(7846002)(7736002)(42186005)(31686004)(31696002)(110136003)(106356001)(2906002)(65956001)(66066001)(47776003)(92566002)(83506001)(189998001)(65806001)(4326007)(81166006)(23676002)(97736004)(77096005)(8676002)(86362001)(105586002)(101416001)(4001350100001)(54356999)(65826007)(230700001)(50986999)(6116002)(33646002)(5660300001)(6666003)(68736007)(3846002)(36756003)(450100001)(81156014)(38730400001)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3214;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzMjE0OzIzOnByZ1JEUmtLTTlxSGtmajdBNmZjdEtGeUN1?=
 =?utf-8?B?WnZmNWM2c1AxMUVJSWszRVpOc0c2WHRadzlFRHFML0dvQjNvM01mckVOQXZK?=
 =?utf-8?B?Q0Vsb1BYdDhENXV1Q0xYZHd5L3poU0FqU1l6NUZsTjRhNks3NnFtNEY5TGMx?=
 =?utf-8?B?Wk5GdTM5Vm1KR3lOR2FQa2Nvd3VpMS9sb25PR25DTEZ5Q0JxVW9rVjhVQ2px?=
 =?utf-8?B?VkhoUy9IRjQwSHRiLy9zU0RYR0MvQXYwdzk0ZXBFV2wwZEczaEhhUjdZNXBR?=
 =?utf-8?B?NXVuTHNkOGZKNG45Y0o5M1Q4UjF4VFUvbU9rQ09xNUZ1bDNrbU1nQStRMmpk?=
 =?utf-8?B?TUhCQjFoUU1JUmp4Q0Y2TFNleXV2eVRTSWVNRm1TTTlkRXVRbVMvdEZHcytK?=
 =?utf-8?B?YjhadmlIamtGWVhSL21XNW44aW9MZG45dm1mWkZ4SkhldkZvRkwrbldldHBo?=
 =?utf-8?B?S25ESmdrZTNZRmg2dWs4RkYrNW5TT01wNnZxVXZ2NStTaWljVVY3UzdkWjBJ?=
 =?utf-8?B?ZGZxTlRzMkIrSFBlZlAyQkdCOFVhMXl6MmZIT1FvejFDYlZ5QW1rcWEzYmFV?=
 =?utf-8?B?aGt5aDZ1dVFiaXluL0JRNXlpZGJqSUF4M3hiQkF1d0JNa3hWQzIyU1JDQm8v?=
 =?utf-8?B?SEVBTUh4MkptZnlob3YyZEJNTDM4UnBHanBsRWE1VGlkV1k1RWVPdW5PY2Fj?=
 =?utf-8?B?a25WZmdYeWJPMWc2MDAzeDcySFViSXdTTGtUWksvd2dCUnFxaGZUeWw4ZWhn?=
 =?utf-8?B?VmRMWklCWmk1aWh1WkdNdXhTOHFBNmlzZUp1UldXM0t6UlJKTlI4N3Ayamps?=
 =?utf-8?B?NkxSRUlpOEhYQk1MbUF6eEpVeklZN0k5TFJxWklqTUx3T3RxZnQ3aVJYQ2Ju?=
 =?utf-8?B?TGRDRHg2Q1VoM0xtcHdUUzZMbHVJRVp0dWhJR1ZEWTRwT0Z4QVhreVRWb3NV?=
 =?utf-8?B?MzR4WUw5cXVxZUlUSDNXMFNjUW82NDMzTFFGV20wOFRLRncxbUloY2tXZGg5?=
 =?utf-8?B?UTNVVHdrTGI1RDNBYUliOG53a044ZjlHRVY5K1pkdHdzVkcrWDNVQ24wbzFJ?=
 =?utf-8?B?TXRiK01WV3luM3JoVVV3RFdWbWhNc2ljVGYraU9KSmM0dm91ZlVDRTFQUkRN?=
 =?utf-8?B?OEdjOVFtaklhUXpyWW52N3ZsYm1iOG9GbnJSOEZvZWh0ZldPeEo0dUE0Y2gz?=
 =?utf-8?B?aFNiMnM5Yk5tY3BYL0hFZXBaTStvalJDbjFocWhUSEs0VmtNRlNvNXFXZHJP?=
 =?utf-8?B?cHVnUStRNS9PNW5od1dvWVVXRFNKMHUraG13Qk42b1NOTmpNSE9sbldtZlNH?=
 =?utf-8?B?Y3U0OTBHU2M2YTRKSnBuVXpFZjFUZGFYVWNMUmxtYjQyTlpzbGlaSHFLWmdT?=
 =?utf-8?B?ekZhazc2c2kzK09VOFBFbWFNbmVXUXZnWVFyd3FGTmkwMVpGRk4xOXE3WnJD?=
 =?utf-8?B?MGE0WU1UdHJ5YkRLRVRjYzB0NUhDdWhxeFlsRER3ZXRYVDRhMEdkQTZiY0l4?=
 =?utf-8?B?bmtxcXFEWFpUaGh4d1h5M0kzcm4vU1lpZjZGdXhvdE4rS25PMGd0cm5ERjl0?=
 =?utf-8?B?bVhCdTlwTUhMb3NKMldwK0YyTzFvVUs4dUVXeFNzeXRUWHNmZi9NaUxJVVNm?=
 =?utf-8?B?dk5lMGJhT0JJY1o2YkZDRy8zREJ5V2NVc21yWUxrWVpmdjFCdTV2cVhBPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3214;6:CxZU2i2KA1iQ6TbSU96vht1Mn+ToLoewGxMOdloUgtx7m+Ezo1lBIWqbR1XkCnYcOH5VicqrUftgejKWujT5wgQP4R4zgwUssJR7eTGMC80kU0hv18tQn/W2NBoFSLGbM25Ss/Y8wKdQVsx/sCpf3QOZFLyxKuMQ35kags+sQrSrgwiw24i3837EJtZ+YArb2S38Lvtulej8pNTbh7gorLDp6VjFVWfkbcFqYPe9EkTFNbqkp5ZzWWjXNUnw+jaUAp+EDhkp4wSgWX6Fx0fz8g7BPLzaDi/H0jL8wzx3f8xHiFJukJyNQRVqGEWvoHJUtVw7DrYsQoTLMBQT64OiCjLM+jC5eUQ0dL5WSJcd/cM=;5:nkLgUftTR08MFe+PZEKoL1TAJV8KSTGHnrtWaG4svwN8bn7UupNASdrKMUV7UYfhNJDysfdeMaVCZakGTis8V/qJcy4Wi+R4GcM1s3fG/lLSfKcG12uMJPnSSY5FWL6y8hNqf09eqOPeSVDJoRBo2A==;24:lVjW/2jQ8/2wXxfRA8NZTns6vjRkQSiR9cLqCssXVajWpZpvodTpIbR4VAziWlS0R2E+o15AQdOuXmwHMJ7i2MbSeWbnPaMYG6w8xt9iDCo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3214;7:D3bM8OIXIGdSpDHYXVrulCJiNVu/CWFM9WH/P7/9hYtAvQN3o0XGOXyqySod5toHUfN8Ny3iJfJxyBTcyWI5NTOJiStPhfUKnHmVPNSmfBdUB7nDJKkGaobFVNR08io89jp8+atsQmxXTOv0ukZFrEJDGPk64yKTSr8//EiV0JRjxaO2qg3lNq6ri81dBLNMLRAZ4km6J+tDYKcYB0qWZAPmkYHjwlrwqGtf3Xxb79Msu+IEH1faHlyc/XaCInQco+DH4vFy/WF4k1pQg29CAk5HcbU3HHGnjtWIjIdxF6ZP/7pYAwK7jQ+oQyKmaHdpQvGbhC+f5f6O50aXrgF2yCajLM+PQy3OgitXJdLVLrU=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2016 19:44:25.6927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3214
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55858
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

Add in the function needed for OCTEON platforms to support KASLR.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/cavium-octeon/setup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 4809ce4..d9dbeb0 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -965,6 +965,13 @@ void __init fw_init_cmdline(void)
 	}
 }

+void __init *plat_get_fdt(void)
+{
+	octeon_bootinfo =
+		cvmx_phys_to_ptr(octeon_boot_desc_ptr->cvmx_desc_vaddr);
+	return phys_to_virt(octeon_bootinfo->fdt_addr);
+}
+
 void __init plat_mem_setup(void)
 {
 	uint64_t mem_alloc_size;
-- 
1.9.1
