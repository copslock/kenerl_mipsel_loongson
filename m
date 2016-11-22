Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 20:44:27 +0100 (CET)
Received: from mail-bl2nam02on0059.outbound.protection.outlook.com ([104.47.38.59]:61880
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993150AbcKVToFb-2Ev (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2016 20:44:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4b8a0W6+jRp+FXzO33E+oQbsT4iyqjZ0mfLE6vn8Yro=;
 b=PNhS8eY8tsQ0wb0I8KJloN0gsloNv/4wuX92RegbxxOQ+ty84SWaZkR7K1TmqFPvy3zV1ePLp5RNn+HgLbY93UtHtm4eFAdnhTlW509mKs9XcSL+lkXtGBsXGr+HEmrhfey/O+pdcNORCIWhRiPY8eGVj/USQxfh6xwq2tlBV8c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 CY4PR07MB3208.namprd07.prod.outlook.com (10.172.115.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.734.8; Tue, 22 Nov 2016 19:43:58 +0000
Subject: [PATCH 1/5] MIPS: FW: Make fw_init_cmdline() to be __weak.
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <b14ef49d-f39c-4e13-2da8-ab94804395a2@cavium.com>
Date:   Tue, 22 Nov 2016 13:43:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: MWHPR13CA0025.namprd13.prod.outlook.com (10.173.117.139) To
 CY4PR07MB3208.namprd07.prod.outlook.com (10.172.115.150)
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;2:9cG1xmgVV9Ib3A2okm2MYlDUAsuH2qzva6OaUfIhuWMx/IqL+n+9g411d0Gb1eUA2Y+aqqo0ZDwpWQLuEKYtgR4YXhLDB0S65XR+Qzxh0fSjOiLxooid+wGIqbwG6sok5lwraJKjXGhhGRMNehFcrrSxxXlXgOLbJKpSKpiN2A0=;3:JyacJrA4RZ23uBGgN/aRgh7XWYbCIGkoCTueACx+O5LuFXVvT6SsUyH1otKhK8on5tbfRlA0xqcOQF0/O9AuklyBrVlZRGkKg7a1e1nO8s2vV2bquXOcwUdQTkMRAzYuZUL/MQSjR7CJRq5kpMH83a3Katd6TG6DlKt7A+Bvhkc=;25:LUEqjvkWLqat5UNwrw3mW2x28HEQDsX/JQM+ZtoKO0sb3yO3tspsEJX1BoxoAFNAaeXosW+OyExAIDhJxV9grxyoKU/8mif7J1Xsl2GO0gjDlv3l9oqwTkjBvyTV9Ap0pbYx9CWntnCiftxcZ+dWdrLsx+J8zAWJMONz6uPl70G3v8CD4rUqsHk/cisVnZVDuGv7K8rmt2xfWI1uQqc1mmX9F//KlsNk+dwMYVy9S9Jn2IRxVz5VOLSEbaJkRTwyA2U+eJZgh8y0+RoSMj58wzMeWeeAIhyrrK0h9LxaC9DK0xB0BhmVhgbkO9qcnbDbCgXpwR8ewlo9a8w7aMjm2nF7keSVbw9gW40YayIz8rNoJl6/DpKWBxy6q9PbpH4ZdvrzaTvdLzvqdN0+rsW6whbf4kirmxSvkJw9xV2sgVlmLncU2brPedoXNLy3ObowCIF3R0JwlUvxLZzR4xaYLQ==
X-MS-Office365-Filtering-Correlation-Id: 6fa1551f-b93c-49ca-4005-08d4130fe6dc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY4PR07MB3208;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;31:F9KK0Ts/Z54xu65Yv/LsNyyrR28oSqPyvrIXQggeqoETElK3fhHpv58Z9I8f2PI5CySwnfg7/CfWFWLewU6uIxnCdzB2UbhMLVB/jClTpei8yIRwV4HhWudMDyLfQdwM5QRPgAOkohJihnV64189CFmyLp1MJyn4cV82ujP/0AsGANJTjxpbUZbn5V+xK+NTo9VNNnLXJ9w9dF0nRzBSlc8WwvTdJpHnGql5luqwUmzVfHUUGXlWlTjkZObC7uMkqCgvEV8FCCWk3hqiMNiqPw==;20:XIxelViDi46zg0fgKGdWMsYCylfVeB7RxHcEJ+X7QmZ1NeUKEiM6A57qnmScr4Oiy9dpfFQ66+drbDBLuQHKFZXCTA+SA5BYrCVGAt1Z7AygdTvNSfjMESQZQraF1Nk9tO8BENDF3YDFw2K73ffTWtpJ30cuSRFGls+hX+RJNXkuBDGwsfBENteBimBW8WPkZtQ3pCpplSEyn+Ixv7GdASetp6236BXbvWA7Fj+4sPxgcuB1BDu/Iob6xP9KrIGGq9WwhLS4etRFhuA2XKinvAdH1giAe9am8CfSCmSWCTds3742duKOQlDd+Lk6vBcVqlvXcTLUeNQkhF57WAzPFznPsR36OpOtRQxKq5tS0oizHjYY4S3KzQn/K9c6OoVQMhXVAJdjRDLlgb+8EyWvSmFcvklOWFE82S5S70yTow3Q4QBlAymKgcb6bfUt3TVSpaYWTzspvKTM2hoWl1u6TjXxBQuC+875AtEe/a/rP5wobJKSFM8HNPpGlcIqyP84
X-Microsoft-Antispam-PRVS: <CY4PR07MB3208C4D28A21AB867FBAB17080B40@CY4PR07MB3208.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6060326)(6040307)(6045199)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(6061324)(6072148)(6042181);SRVR:CY4PR07MB3208;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3208;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;4:1wQc81Zo/csAOWrDO+kv21xrG/pT+1yN0Z9Gl6fgo8PilGljChV3ZAyM+9olEl9Q+hLmGrp53PIyN5KLe1T35SlXsYz60XnxD53Qp+34NKFiqB/EoPuJaLa3Ms0MHN6cyiS3K8tQz7OLA87uPagoCuEN8VK1uxWOrnnALuIslnJ21mToR32QKanpKuBH9aj/0gb7wheAF0JXhIAyjr/PRF9zno/E+7y0x6G34aN5UtvWt/ieMaIpDKy6IumX9/zz7j74+IA2MBBWOTGivKZmVb6C87vtx1H1b5yWEIRwKPlQElW89BjAkMyLApMNSXLR9wI0x2TOZLWu7EZ3lciuIjMmzzlhl7ygWttZDzFOq2jsHTsv1IDqeiLAHWDjPot0KR6igrjg8qQvluBDHO+RdOTzfLz4CVoyiHo8Q9uQhS7loyrvNAbolfN+HQycs9Cpl5tFTz7a7TCnuWgjW21fB/n+w69L1PkC8jAfen+j2k87Yj+CtYfAqVSGqwdWGdbdLDKavIOlNMsCTVY6RGadkQ==
X-Forefront-PRVS: 0134AD334F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(199003)(189002)(77096005)(106356001)(31686004)(68736007)(2351001)(31696002)(42186005)(105586002)(3846002)(33646002)(4001350100001)(50986999)(54356999)(101416001)(189998001)(92566002)(97736004)(6116002)(2906002)(230700001)(7846002)(36756003)(8676002)(64126003)(4326007)(450100001)(66066001)(65826007)(5660300001)(38730400001)(50466002)(6666003)(7736002)(110136003)(305945005)(23676002)(83506001)(6916009)(81156014)(81166006)(65806001)(575784001)(86362001)(65956001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3208;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzMjA4OzIzOlQ1VEpsRm9ULzhvV2ljb21kdTdhM0FhMTli?=
 =?utf-8?B?a1haaVJsYWxvS09scy94UkpxQ3dzM05aSEhCUFk3UkI5czlVOHpRSzVMbXBT?=
 =?utf-8?B?ZnJmMm81bzdlMGU5dmVROWhIWXM5WXk2SERGSitGdFZCQzNuNkwzQ0I3czVL?=
 =?utf-8?B?ZDJBNWFEbEY0Qm1HcW1PejZzaUFKVEVaUUdzL3JNNHlXU1BMUlVSbGQ3WVNH?=
 =?utf-8?B?YmsxN0o0V3VldEVkeWlhMFhicm16YlRoeDRqZE8ySTFjcVo2NCtXZEtQSzVP?=
 =?utf-8?B?aVRXNG1VY2lESGNXU3FNTlRDNG5oc2NhTjRkUnd4eldaaURqbHlnRFkwczBZ?=
 =?utf-8?B?S2ZIWWZjRVBzbTB2aStsVWlSUHJDVDlob1RoVjJOM292YnROUjFRWWhGZm9P?=
 =?utf-8?B?cHRDWVVmT1BvTnNOSkEwQ0tQM2lzWDVnYlVVTTV3TEZ3SDcrcDdrcm85K3FR?=
 =?utf-8?B?MVo1UjlBbGp0NnhaQ21GanN6NFI2STg4V0kweGppZHdsTkZra1laZ2d1T3hC?=
 =?utf-8?B?YS9kT0RPTUtlWU11QTUwb3hETHlrWkh6cWZJeHlsVE9DZHR4S25LTm9MclA3?=
 =?utf-8?B?V0tRRUdVc2RNZFY4cE9DdGlNQUxkckM5QlAxWGZUYS9pSnA0ZitEdG1yK0pq?=
 =?utf-8?B?TDlod2pqKzFxZ05sQ1R3cGIrUXZoZUZOM0grY1ltcmFRYjczS2ZKaGNnQm1T?=
 =?utf-8?B?L0s0ZnVKbkZnUENVQjJSSWYyUHNlMmRyOXBnRlJsdmNjMUlwVUI0YjlBblFy?=
 =?utf-8?B?OG5rV3BvQ0NJUndsMUJyeTZHdXpvY0Z1WU8xUDVLb1BPK2RZN0FEcUdONitq?=
 =?utf-8?B?VGNMa3A2aVAxRSttdGw2Uk1IamxTa21na2xHQ0FYUTJBY1J2WkFRN2hpbEpK?=
 =?utf-8?B?RjFNRktaZGxWekRSaUYxMmYxall0NUk5aHZvYklQa2VDWi8zemhheEh3TDNx?=
 =?utf-8?B?NTlINTZ5U2cvSEMvaVpuWnF4SGlnYzE4OHV2Wm1NN3V5b0l4R240QlBMRDY2?=
 =?utf-8?B?YUY5RTBvY3VoQ1dnQ2FXNFQ0YWFWNW9ZN3I1UDhYUVQ5Zm5SZ080d016Q0V1?=
 =?utf-8?B?YkpBY0U0dlY2NnhJc056S3RxbzJtN3VBck5pdHVBN3R1MjhLVytWZGdTVThI?=
 =?utf-8?B?ek05Y1N3ZkpPdGhDdFFmZ0N5ZWQyTE92TFpmbnhjMWVMYlRQVW5JWmtSdllk?=
 =?utf-8?B?eUozRGFQZXZHbWY5eE5SVk4vbDRPUmdYTGNGZ01DSkdCeUpsVndQYXNrMTZ0?=
 =?utf-8?B?dkVwRlhjdCtDajhmekZPVGNqSktna3ZCMmFMaGh5Z2FKTFlwaGhkcERtMUl4?=
 =?utf-8?B?NXBQcFd4YVVMT094bFhvMGRsMVB3dFFKL1V0TFNIWXQxbjlQQm13UDREb1du?=
 =?utf-8?B?NkN3SUNkVTArMGFnaVZWMGU2U0owN1o3NjZpRXU3azNwZkJLRkkwVFZCSHJ6?=
 =?utf-8?B?WGx1VndzUytLc2xYOGtKTVhpTkJyelRtWWthQUQxQmtGNDBGS1d1dGNIM3da?=
 =?utf-8?B?Mk1yMkZSeXFoNkl6MVh5ZGp3TlRmdzgxTmxpb1VYS3UyTUxIWFFWTjJuelJI?=
 =?utf-8?B?cDRraWtmc2lmYTRpSkhBM1FwZ0kyaVlHdVB5WEF6WmlwZ3BQQkJDMEpOMy91?=
 =?utf-8?B?REpGNUpsazFoWnE3RmRLaU5iMFcxMEp4YnU4ZXRCUThXc2lhb1AwY04vdHRx?=
 =?utf-8?Q?agAeHiZA+TZ3SPPGFO5DjwE6cl+2MJb7yqi49fL?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;6:eXJb12AQ6KQPZmGZZ38okTu6ZxAxr3ku46kbg8ZgBiwFVMZKT7f9sWwOCiLFCNhTkH0tDpi5/sKtMLDovjwrV4B+OLAQuohcFmZIE2HSoyUKUC5bntklTbXMtHHPWB9QzYndG1sRlBb8kXsBuqXKR5Zpv6idzl51H5y6DnZZjTzG2Cqk2yGo+YrS0lrgx4yWVuTn4uu/WV/QtKekhOGafje2GRekTj4YWgOBcEqb1zxQodG1VdXxLdX008dVq+j8YwdAex+gimNSm0upJjZIV66M0uIo+bj2FXLGxkrXlrGzHjB8vUsgHJilBGFyLr1dGR4V3Jtg0W0jK1i4jEIOP9IsKrfXCqsOf7oXuoqNvnI=;5:hfaMkyyN/Cf+ELR8cdMUUceEZ9BKZX3/xG3ZJbGe59dHIKldxKTBhtfFzy/Po5j9NamHRzIZJQ9q7+RdppPPo7RCXLnb6Ciu8O9tsWjQs7p3+z6HdSxagcm/erBSqjyRk/n/hXg6wW9znqUXxLrMDA==;24:QLdLWu9BiivrDN65p62sSGVf/HzR5sJ6zZLrWh83FptzjEzOydPrcZtjtd7N69d/GwHcLtZrwQAGFCKrluNcvTxEpoXunysUxLYBQZMyOls=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;7:Ck9OtU3Jzehpxu331GfoIW0ahKnMjCGPu4ISwqmSPj6jwWGNaILK/sY8k4neXTOGiogTiriDhaQBZcB7XUhlHM1PelcS/RbvQhHZ5ehzI8UxT9YldeC7nIURVoFFP7UW92FpIGoI/fbHLdqMBFmFbL9j6o0KbjD7gcKhG0czV1DC/rwg/295AOe+su+fr1N9ze4FCMtvb0PRGdGZ1L2Y8fVT/c9B2j9IkEptW1OpcCaDZGlccNMnuvTLYRUOaJAuP7akz930rj6KPzLFwItvdL9glYCl7y/sr9SGpVf4rAe0d8gs2RNWhkeQk0KwnunlSN8q4Jx+1qLJvqQtbTPskj+p1cwfiKGKZBCnmdNfWrY=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2016 19:43:58.0149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3208
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55855
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

Some bootloaders pass the kernel parameters in different registers.
Allow for platform-specific initialization of the command line.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/include/asm/fw/fw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/fw/fw.h b/arch/mips/include/asm/fw/fw.h
index d0ef8b4..0fcd63e 100644
--- a/arch/mips/include/asm/fw/fw.h
+++ b/arch/mips/include/asm/fw/fw.h
@@ -21,7 +21,7 @@
 #define fw_argv(index)		((char *)(long)_fw_argv[(index)])
 #define fw_envp(index)		((char *)(long)_fw_envp[(index)])

-extern void fw_init_cmdline(void);
+extern void __weak fw_init_cmdline(void);
 extern char *fw_getcmdline(void);
 extern void fw_meminit(void);
 extern char *fw_getenv(char *name);
-- 
1.9.1
