Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 03:29:21 +0200 (CEST)
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:48896
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993964AbeGLB2X22ant (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jul 2018 03:28:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miHqHNwtIMLpFGIV9OT1ME9zyR+7bErZ4Fr8KitWFBU=;
 b=Q/+gddyL6RW/yi4hCnvz6b3cOV8YMT2tn89lvhEWHZXi7In3bgKEHjbQNFqLRMVaHQ+O1rqv0ooReAIdb8FMSVfYDPObuiSNnh+R0+l7aW4K6ugv5bK0CU9GgCtXN2TYY6ym1/OUDonlgH7N7c8la2pppoBq34eXYzTWu8Hacl4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from localhost.localdomain (73.162.151.67) by
 CO2PR0801MB2151.namprd08.prod.outlook.com (2603:10b6:102:17::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 01:28:13 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v2 5/6] MIPS: kexec: Relax memory restriction
Date:   Wed, 11 Jul 2018 18:27:47 -0700
Message-Id: <1531358868-10101-6-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531358868-10101-1-git-send-email-dzhu@wavecomp.com>
References: <1531358868-10101-1-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [73.162.151.67]
X-ClientProxiedBy: BYAPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::33) To CO2PR0801MB2151.namprd08.prod.outlook.com
 (2603:10b6:102:17::6)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10d7ae02-17f4-462d-bfd6-08d5e796bcb7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0801MB2151;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;3:1Srz4qdXN0qD8YsFQQqq/gLtIdWr8MoNupj8aj37sEa9B8rKeag2zl8cLYyOdn6OOakHSDEtAmGbha12vH12zJnVRjunDv+pAZcvctVd3uQr51KEHK/9Y37+uC7jfmYB72nYvW8Yul3WNQdsU46F1sxInzfKdftdo/L85zi2kjr1YYsGP7T9WZf7N9m/DzZe766WLPK30V9CTH0v0dGddm6Xn1SNaWjeAaq4gSZJFDul5EHgWL56N1AETvIvkU4N;25:TIqIYzyepn0RCii6dFmzblYOtCtPni6FiEqj//5mWt+7BkvDBpL5qYCOnkXLS2k8qYVQ3qZfG0ygkkCjinygdD/gGXNZklDwd6SdK8/dhXmyGgtybs8GDNkhw4Jl+kzcMGNjMUrno33QO2ErIyfAmSOldiKtMzRxHyRLAZly24C12i3tZpIrrfHs931lmSLC4m5dl/e8e2c9dBOEz+XdUz/djXp38RTejP0zNiiCVCMBuV8nr+qwi9jHaP3dqVOZauVDV+s5gU0BgLGdm0MLXs9duTMciEcO2PXdYBlHh0CdVHMyo2mRPFJT2VSeAn+7SxEeEtE91IpgzZFeziQMBg==;31:Aq/7pzX97YbzHnTK6e6XacS/qhtRRGD2Wopraq18axAp7rYMnD+Ew0tf/xnNt0Jjuh/Pqocz+j82kawkPjjK72V59xwcOuHmziwmDWiQXypFKeDSA+WTd/BLDs2IG9NIv7sGh2usByXlO90ZF8GiUMPFIL/vp6DfbCWB+l4a0wkVmJKWfAitv21MnWDbebBJHX92OI9P1oZrQ5Vs1zNN6TAUOMpJnjNQyPb8OPOEVvQ=
X-MS-TrafficTypeDiagnostic: CO2PR0801MB2151:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;20:7+GY3brxxKdMuNxo4s+yEu73vlCbyDvH7KH2WyiHCjeRmfCdFM53gHIHbsBd0xxLuUIWJ+zsH5hQO1LKHAde11a0fYdGVhuvdk9j1kWpMd7tcHMd02+HQO+row+mFPutxkSp6eNmaqyKu67Q+uktLoFp1CLPf779GbcJR+A3288uEEXoT7RpWoxXXyumeauxxMJz7SEuZS/o5FTRtbfH4OezgiBpCi07dFf73yBr0aoA6rMHaJZ+IktNZ40W/Ecz;4:X6Ms4i79vx0xO9NvNBfImu5RiarfIi8IApokzzUjoqxYLdNYWI9VInItPYO+35D34GerUadZVQXxkguddiNEu8Lv7XzCgcDxnHTHsgAaMnEXODG57JAiDeKC6O+/X3n/qjM8sjQaYk0dx6EkSY1oxq2o/XwBtBm+hQ/H71dmtkyCtrNQCbVb3FodidYZB19Xy8NsWLjUNBm2yWsjTBs5KRDJ9xsp8k2hRr85YLRi+eIBoB2hGdfrpUA6U+I/zAaNIs+QhJ9kjQkOTdVteaTktQ==
X-Microsoft-Antispam-PRVS: <CO2PR0801MB21514FC41C1EF48B4DBAFC03A2590@CO2PR0801MB2151.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CO2PR0801MB2151;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB2151;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(386003)(6506007)(26005)(16526019)(86362001)(446003)(486006)(11346002)(476003)(2616005)(956004)(36756003)(106356001)(6666003)(2906002)(6116002)(3846002)(305945005)(5660300001)(68736007)(7736002)(478600001)(6512007)(14444005)(97736004)(50466002)(8936002)(8676002)(25786009)(4326008)(6486002)(107886003)(450100002)(81166006)(48376002)(81156014)(16586007)(105586002)(76176011)(51416003)(52116002)(66066001)(316002)(50226002)(53936002)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR0801MB2151;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0801MB2151;23:MmRbOBqkKUSr8+3kKP4HH22LXVrfX2SaS7sHfDK?=
 =?us-ascii?Q?bdTeJ0lEG8E3lggRFOnDENzShx5AU1uoYKVynYeMb4f+hHthZ3Bv3Csuy12r?=
 =?us-ascii?Q?7rtDAw7OxFzTtRQ30g1r9ySkw95APhKWBHcHMTXrZmbf0yndRXzMwZ6M3bZ1?=
 =?us-ascii?Q?RIl8g0kfFIQUxaIP4JxW6rp8qOGmU60tjHXareF6kIdqPHQEsf21PsQLGwM2?=
 =?us-ascii?Q?2PuP0Fs3U5qNxb2I7NeVwcZ7Nwy67s0TFCyK8nIC8ff/3+vuulTIPXy0h/bR?=
 =?us-ascii?Q?W1Y//VkcT8LW9vLOctpj+fq7gHjYeByfOPeS815Xzvq5DpmYDIwoT4S/KlS5?=
 =?us-ascii?Q?2OE4GZKYu1Sc6vuzZsU5QHIx2WK0pDyXoABHwdZ+sTI1+enOg/7fpfg8TRku?=
 =?us-ascii?Q?1wwaXJ4HVFkcqmwZYGVfqb1nYyjMTFsWKmbLlp8fajT26DJXJzQdmzh9TPuu?=
 =?us-ascii?Q?OdYTW1djXec2w2dgfru1NA6tgWwBlDihVNcvkJKf7LFILhSjoM9MIqBZG2PD?=
 =?us-ascii?Q?RMd1VslnJ+DvQdMq0cE5/GFJDNxbjhFDG5WaaguTezo2K37BEMrqPIcqRLbR?=
 =?us-ascii?Q?MthNIofPdtrxagyJf27oyWMT1UIMhjnWi/8aSuEXGR+lBUkI2suwdBfacTaE?=
 =?us-ascii?Q?8kX1QVSticcRVLtyEY7LHlmwuEHWuSrVGQmzCOuEgmAhJdE2IB2lF2VnzhCo?=
 =?us-ascii?Q?6uwAKrKV3TpveMj5rfvFyg16Ypuq+BNKo7UTP0qdL1DiDXnkPSLCTjBgSxBa?=
 =?us-ascii?Q?uhPLu0MA5NY4KYDvFgw7vL3KqT7hkz9nu5P4pVvVFkCyKkpCUfaqZQxWH4Q5?=
 =?us-ascii?Q?zHLFZ53PxwKzuWRJi3/+YBrXLxX334oABsr746sldO1R5c9Q4N4zPKjp7WVT?=
 =?us-ascii?Q?cLrwNhYe9t9ybx2w3u4BITFud1LL5qh/wU7hEV1LCdICFcctt7n140KghI4o?=
 =?us-ascii?Q?6eb3j7oU0X+E/75bU+GU9oFoOLjuGMshnPVSGB2fTEuAdoLaVIleDaQ/aI23?=
 =?us-ascii?Q?e6stSrKxeWzeQHzprBfbnkIV9DT0wrFxoTj9PPR7Z5Cao82StcH336TG0nZb?=
 =?us-ascii?Q?BXjJS5zeeg3sxGCalrnh4hKTEZ6Uy8qKu2nMR5AlRRQQGozx8sHH3fmAVpxv?=
 =?us-ascii?Q?LcVtBAwCXaQ5/EOsqVMj/9D8LH9txvJSo7ZBG1okRsr2Ye0K5sV74c+Ac15t?=
 =?us-ascii?Q?fqu2d7DweuLkRNBe1FTiEHCBnPEjRcr4zMfH8?=
X-Microsoft-Antispam-Message-Info: D6G3wVs5PtsIh2p2Zxdw7Ms3XRWf4qfx843Juk8pEFfUPO0qw7XOOBAaYZ2zYeXcmZLZ4N8tTzNpF1cletgwV8b8dG8XIsa1e+osC+AbwVHkTNLSVInNxncIf8rhus0IDJMRgf+osLOhmi2XbIVI7hOFrm1fLl2yqyGhbCRutgZ4JIH9JBWGuUBS+G09beCrUtyf7GXK3xSK4iaHmF3Xrpfi61o47Yisk5wWcAXz2mXu8KkxJclf7GKWVncVH6h3Q78tpd3shdl8T+9Xayj78jpqrpFOVo+LwEWJb7B6niMl16P3RffCqIGXtvLtvmcCe7GBG+C6We6Qyo3EXZo0yhNfpIOrY9mnRMGTONlwNVE=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;6:ESL4V7jVxJtGDwhll3OfuhyzN2utFaAFU5P04PMghcPVgSNHO0Dk1rIvqLG+UFPUibHyVH1OuMLDgh74SO+oEzEbR6NMrgKXpfSqX/8aqMAh/dc1Vy/W0d9ETdNAW1HgfgX+O6U6LcD+Wnx8GuTGmA8nY1dxyRU/75SR4xFfBzW2xf26EhIWF1Fr/FqDbyYHycBAPNKYPwMTx9sLtLbjD5FF5JLXFLtevWM3Tm1jRE1nHZ9WuRIHU7k4LD9aiBy9owL1uJP4kZ825Jxd4FbcHFM1q9f8CUPlQXG9Q1dBlh4qtaioqjAt8HS9XPPCVBIFFRmcO53NS9veWTNHoHvhLoL27woxa5qqXvClwoOghkk2pogk4GTlCMoOwItp+bxx/mBMCF5twtYzsgGCp4LyUpGexKLp10tK0m6IhDd/toPU/OMhg1m6IFGgPnmnLSzbM3q8yPSn4JJanbpGqkoalA==;5:+Lp8IykkpSUxaUWvXcjoOzQjkbKYNQ9xfRQ40QMNwNCdeZ7rFlJu5sVNJgMrdJP/DBaVgAiEaeRuOZmy1mDrLX0q0xXwrDTbCcGXpZfDNnVLF/5ZqY2DWg17+wTWVJ/AwU/UVZEtHUXaHxb2OYkLLl+bRaXYLn9qY/vh1GnnBRQ=;24:BEMWGIQFyyJsPln3zggNwzPmBzevXtoIh4YplGhU0pQqyq+n7jkiAMHR4avAKotp9Mv9WlNeDFxQjyghHkc+a8jlgL/8cxx5ml9G9DU74so=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;7:HidNEIIwJnzTQEmC1bDpbmJwQ7eMJIBODIIW7Qh64b3Uib8unIN5zJ1iny2/1TMgybfWC2rfiTUs3+tBEvGIFzjLMzjuY2xRygyDA0bzoVv3ntpQHHI/U3db/p6kzGWJh36O13KDH8vkmhDkTSHVIZfTc+co1TUCjbTs84tk4P1zaDYcqXiwKCzPV7mC3YyzNobB2YITN/HqbwrHV7nTdhdNExhcoAliMn5UaqiANSdaavEeRYbNViSdTM3cFMVa
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 01:28:13.7680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d7ae02-17f4-462d-bfd6-08d5e796bcb7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB2151
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

We can rely on the system kernel and the dump capture kernel themselves in
memory usage.

Being restrictive with 512MB limit may cause kexec tool failure on some
platforms.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/include/asm/kexec.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 9618e2e..97c548c 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -12,11 +12,11 @@
 #include <asm/stacktrace.h>
 
 /* Maximum physical address we can use pages from */
-#define KEXEC_SOURCE_MEMORY_LIMIT (0x20000000)
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
 /* Maximum address we can reach in physical address mode */
-#define KEXEC_DESTINATION_MEMORY_LIMIT (0x20000000)
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
  /* Maximum address we can use for the control code buffer */
-#define KEXEC_CONTROL_MEMORY_LIMIT (0x20000000)
+#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
 /* Reserve 3*4096 bytes for board-specific info */
 #define KEXEC_CONTROL_PAGE_SIZE (4096 + 3*4096)
 
-- 
2.7.4
