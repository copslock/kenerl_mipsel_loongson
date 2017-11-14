Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 05:39:32 +0100 (CET)
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:25938
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991965AbdKNEjCQ09T3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 05:39:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Hbszoh5613mBBY5EP060zadfXNXBzfMh2w27kfHsBsM=;
 b=oIS+TyphVkXNg/8PlPr6jo7uAz5utYiwbvAUjTk66YsHBOIH+0EmSmZhaby1TnP/I8rIXuVg+NVOsbuDMFK9gBaf04wgy9IPmHJdqgYUKeE6drJEk1/9SJP/Sr8Q661ZTewapY5Gtbj7JzgR5Cgo/dscXRli0o0NV/+fe3htCC4=
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3806.namprd07.prod.outlook.com (2603:10b6:803:4e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.218.12; Tue, 14
 Nov 2017 04:38:52 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     Chad Reese <kreese@caviumnetworks.com>, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v3 01/11] MIPS: Add nudges to writes for bit unlocks.
Date:   Mon, 13 Nov 2017 22:30:17 -0600
Message-Id: <1510633827-23548-2-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0019.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::14) To SN4PR0701MB3806.namprd07.prod.outlook.com
 (2603:10b6:803:4e::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46a33c28-f8b7-4fdf-2911-08d52b199bc7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:SN4PR0701MB3806;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;3:GlrsyW6HEtzTHC6eFlmIfp0e32FlSkkmam80VSTnU4Kpx4fHIbnNiI7oDWkP7e33H9NKWMrApAXfO4i9GAifdtkmhq6+gYMIRzRtYLk/1CTpkmGXDXijbmpk9khB2S6oVDu4IKzvWp1aLi/7hOiWYOgyYiZZdW3nf8dwClEDeyAilEG7mnAEQfVDyXhyk8I9x1ILtIPbA/8E1OUhAWONI4b4Q3Igp4OgSkq4/EbueLkIndnqgGa3gE3JN+tiUI+H;25:36IK3QLA2HdvKK02i/gNmup1TJZB3pAWRnDlkwwbe7u4w2/EPH73nBHXnDC0GdNRezbueuigAt4A5QN62xS8w6eW9dxodimGdrhjYtPTjwNKKxC7MNnQrZTkCgKjZ4cbkGwMDGXIx7XmPZpSOyRK+mZg3iRijAWJAlVPp9fi5PVJKXnRhDrP0SBYY+Rew1qzngv8U27jH+tJufTQusO5e+s2QOd3uJvIjMkMCI5HVeiXRh1wxiAfKTIa2p5AHc/hmLKzyGjxTEenhlcNHwm7kWsnX/409zdoN8SQdnV5b+ywDazADD9vkxRsEv+Qitx1qslRdixDNd7eVTUMq5h28g==;31:pIFRE7Uddk2tm8OjMKevdGbcRdzt3AfhobWgI95/cxePth/RypHk0DmZs0b9CkEXuIQXxk9Q5E3/GFq3O0pJHmDhsV20XkASqA5q0GZ+hvAKTuSJYMqeHUeNJeEtM8VnFsQZH3BkISi1a8DG9TZf0uYz8VLAVi6fPstt7nNTp9p6Wu85kZxvvGErlm6IYq8mv96qh9OFkjZWDHawj34BcNtpMB56YQx6wjrPBEG+ZWk=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3806:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;20:rugjT3Rf2XEJdYfIKBzhJs5Vf5qskZT9rDknguh6cKFfI98VY9tlkkA/r8HdtVM87eBwUjJLZ4rLNEGVEiINnjL7xjBw7Di+FAFqCkn+ns7QhfF38eLGzNg5L4jcWyMqgACOpuixxcixyfvakE/Nm/EanzzNGazM8b7UTNHDxzzdXJcJ+Kg9cnduUHNGqDqenXK6+jFc1f3Gy+dYGagr8HfCefL4me/XWfAsOYHkFq+Dfp0xOHTbuJh2J5u0W1R4LGzd0L3ouSA8oPfnDdkNHb7+uGL1dDvd8PG+tEIeGEWjnz4F127GTii9HGEI/rYx8YEDhHetCLUg0TB/dNXNUCVnTSTxxQeb4ulLAZhvnjlHNq66kKyK2kDOAr7t9yeZ8aF+zj4nYTyl/nTcIkxxpoRJeA39EXiJKhnTAA2yh91h3Hlg9/UFIE7ki5yzNNWfPtdzXhea4Io9vg5gi+x5HADwrJNDiKkj8ri/2LpoAeaVbA1pkgly7tDbSZ0yYkRp;4:6/rGbHQpQvqZ2Xjg4CVwynDdCd7XYhVINytjvvF/IL5oXoIWVHO7HLopqzBZi81PkdAHSZXtv54hoU0+JnYTp8cJNwsI7BiZkSrROsRLs183X+Q90BOHb6gbnRhQTVcVdi62xZjOooFhih09vyFn578ZgkRpwMF1Ydb0qiiXiZAbeYZdnxhCEdVicx1HIQX0dQNVpOCbCstuHmbP3BV4p+redtl+TT82CSqhnYR06FUN912wQ0yK01y9kzRamfC4q/9aaDju8cgQpQs3qef8Kg==
X-Microsoft-Antispam-PRVS: <SN4PR0701MB380691CBE8BDDB68B645400E80280@SN4PR0701MB3806.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3231022)(3002001)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3806;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3806;
X-Forefront-PRVS: 04916EA04C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(72206003)(76176999)(54906003)(53936002)(5660300001)(7736002)(50466002)(36756003)(478600001)(305945005)(69596002)(101416001)(16526018)(53416004)(6486002)(6506006)(50986999)(4326008)(48376002)(25786009)(450100002)(5003940100001)(107886003)(97736004)(316002)(47776003)(16586007)(8936002)(86362001)(189998001)(66066001)(3846002)(6116002)(50226002)(2361001)(2906002)(106356001)(68736007)(2950100002)(6916009)(6666003)(81156014)(81166006)(2351001)(6512007)(8676002)(33646002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3806;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3806;23:U6RSdEJ21mm4OACPFAofveoqGeZVewYoB/X3iij?=
 =?us-ascii?Q?LoYdyEHLA54YDdqawMZq4gp3JKzKlp+Z6XKLKaXdRrkmCzyLmeP2Etus3p37?=
 =?us-ascii?Q?xMDvZhEH3F8klBO/UbxTMg/JW4jHzL/SvxOtKhortp092U6ZNwiNDpkonE8A?=
 =?us-ascii?Q?QcHG/MUrkm4jriRJ82nZvzj46lEg5+pY8Ip5MgTtD1vKD3NpNwsrLa941/Fp?=
 =?us-ascii?Q?q2GCnOHPBsx3Y60+YobL7I5XJ+BdSIBXDnjgp6ch2VcBJ+/ZstZjeLwKYn7M?=
 =?us-ascii?Q?RdozA8JfcNB/M88ndvi2y/41nW2uaD60bsEZr1eOsJdvrpFTFdwa180iGDvZ?=
 =?us-ascii?Q?J9tv0wM/yq18as4i1fM4CJP5fwXNtLdlbDSbJbOJYrtWINaP0+wVOCA05wND?=
 =?us-ascii?Q?bzzeVrenaEYDGcZLR+yQaRcULok1zQ+L0asKZh2OXkkqtlyje5KJtxKfqB3k?=
 =?us-ascii?Q?eGOjEthwPR+vE8KhNOX4DlaG86za+j9cPiHAKnM1F5x4liWS+V7/UgO04vCP?=
 =?us-ascii?Q?RsSMrpoiVPQbSEz3RjSDsgBC696ydbQ5H3hFdk+XUs1iEBngCvPwmBZKbgLl?=
 =?us-ascii?Q?Hmaobvr6UpaEMhJct9cN4JamV88qGMgCKc2RAldJhJtKJa9sO/w8/gEmbl1V?=
 =?us-ascii?Q?Wx0cV+5PAaEjwAYohs84l6oqLocy+xYlHJXs+OYTndqwKCOr1a4wYs/JCwrM?=
 =?us-ascii?Q?vEMY0g1JE41Mf6FduOhG9invxGrOy6OUzg3pXrrerFm6nFxtl99KzbIXqpOR?=
 =?us-ascii?Q?gnSlxtOBkM86e2a7vz20J5oRGdeEvM7iNphDkMblDlyOI2uVRPEHXbLa+Erw?=
 =?us-ascii?Q?4FscSl0sjE49WH6y9t3kxix3SJJifTuuwr1E1Wy5uXaRT0vdwMCsGT11t8sU?=
 =?us-ascii?Q?NimKapvhOAf43hJng40pCjxvunoT6capCqGqMuZpNrjupS5o0VF0/nXhGFHD?=
 =?us-ascii?Q?F82oo7tOdrLnLVlybjASMdNq7QouLdgCyjeRUniG7ggkz+ld6gFPLSDkXXZW?=
 =?us-ascii?Q?Rh3OMMLOKjAn5JWPqP5tCavJX9LdLFVeyFMT+N47FJQTt2ZIZZxkxlJnIZYo?=
 =?us-ascii?Q?Dy26ay1QVKXuP4pGEmMWM4ygmoeO2t2EcZ2ixsmNfoaJdM7zQHxwdgnsyvhX?=
 =?us-ascii?Q?74XyNGYp7AzV2anH4Yu+IC8MQJm7pZ120wUAVxvfwAmvIR0Ozb+aBG7C1dnd?=
 =?us-ascii?Q?HK3H3QZl/k9Xj7vwIFQhX46ArkwV3YZeM9MSMlUEt7BG91NmGBQFY8POh8w?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;6:yMbUa/DELNXo+cL6/lXf+73/hjSn9wPH4/oTHj1VeS73hbomslAQFXjM9oWgYroy8xXhRR4ST53fvdHGQ2OS/IXUk6j1/6XwiykHRopi5MJr6RGaBFrJ18Y9RYScPi/dNcoKgcvY2f07rLI7LP77xlJ1Jkkc1z9a3lpL9LuoQ5o2OXJwFBB4aA6V7giFDVb/FUmgl9HKya2V+p22YoI9uFD/e7KzwP0WnS3vWcywKUZxfhLtXcASOJ6QiPU7uQr2GW9qoJh0VhFq7BU7S/4Oh6nR0vix/evrpN1Onv1CGnKuCCJmVqr/4hWthcACfXoOKfq80sbJQTdbvz2uKFGfamTCZBRpqGBD/Vjxkr8KBQc=;5:hfdcAdQZ3s496MAlPKiolTcRkXBJxiEo31JUG6t6ZCq/Z72plA7a4br9uJn22XQIDNNTnFtkpdlNkYYCwNAZKnVPJWiIhkz/oqa/4IQXBjZFVAf/X8HTn7PzdYcVQrAWoAkBN0XGnTGk8CUWSN3GfM5uFi7qyA3rQmF7Q7AaSAo=;24:vb0Xo94SJillBA8aiWEmNBvAeiJeEWib2WxYf4Wlk++bBFKVVaKI6/Bw5inm7szS1bT+xaiJaAg68bOkgTsXTfzYCJJw6jNc3y8rE5lj+Os=;7:2V84/umuwGBQb/Dc0pVC7TOiYJzdCWprXi1chnCoHLVnuj13wcqxBX1PmbMDRKxo4oV2SXRxMlpLpIUkkns8JvJm0y5TFS3hVxkJuJLE4eDyVlZMPXbE5RmSdbkxg+i9y+8Otf8h+4vvrmYV92NDjZXb+rHx5zipoLFVPVCchz7hcXAm7quFPm1qpWZOFqpIPQpTZ8dTfjZI+l4P+PHR83MI0yW/Z9rMhkWIQ+DE5oaT48063SDtGgKRTthbVKFs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2017 04:38:52.3146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a33c28-f8b7-4fdf-2911-08d52b199bc7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3806
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

From: Chad Reese <kreese@caviumnetworks.com>

Flushing the writes lets other CPUs waiting for the lock to get it
sooner.

Signed-off-by: Chad Reese <kreese@caviumnetworks.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/include/asm/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index fa57cef..da1b871 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -456,6 +456,7 @@ static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *
 {
 	smp_mb__before_llsc();
 	__clear_bit(nr, addr);
+	nudge_writes();
 }
 
 /*
-- 
2.1.4
