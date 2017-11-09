Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 01:54:54 +0100 (CET)
Received: from mail-by2nam01on0063.outbound.protection.outlook.com ([104.47.34.63]:43773
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990517AbdKIAwZ0ucCQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 01:52:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LGD9GdPpf2VjSZ7bV8DMndj+Yb5/aG/sJF2AwnuoBtY=;
 b=AvVyVMGwABHD4QMEbB/k8uvTv+xBKwtFIXgThec1zgWLM2XEt8yoqq4oUJnPJ9NWttGdlV6mEnx1fdfr+n5Ak4Ac4zcvckznfb0wgOJWwpsRuCm6XVpZFYM6GCprH2UsIUtsev0YrvvoI2qiSMqsxIhEEBaujB+Ev1wBenF4HNw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 00:52:16 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 8/8] MAINTAINERS: Add entry for drivers/net/ethernet/cavium/octeon/octeon3-*
Date:   Wed,  8 Nov 2017 16:51:26 -0800
Message-Id: <20171109005126.21341-9-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109005126.21341-1-david.daney@cavium.com>
References: <20171109005126.21341-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0022.namprd07.prod.outlook.com (10.161.192.160)
 To CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7e1be0a-1b45-400f-c783-08d5270c202e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:Oor+ESke2Sg674dG63HFKNf0oI6h7iuQCii4tWqH4d7E27Ak1B7mzEr1VcZvQvgcq3BJqfN8TfqfyKWivY61vFa6GEx+Rvk/Qz0tv8sjUrBcf8Oh3fx5XMlhrOBfTXyA9Gxuw7wrIPRf+lBtufu/+23xlSDPXVRIOakyQxRXO2DRALoUDEZKaxFM5g26lRJGWs1djcjntQJcpRvAGDrtTZFMiAhjpS/VLp4Qz/BDrBccFO9uaWQJWtipjwgO8XIR;25:2Bw+YBLk1d4B0GvwcLeuHVe1MXMQ2moHChXMiAzxTfiXWvIztUr3Rj6NTfz8gu8qFpF76C/D2S5I+sa3Y1PtLboyeNZY5WFm7LnJyVi1MCi8LpoOhvL5CrhAjZDO9GbqagHxzhyea22lfvFLgN14UtaNIANgdt8Lx4KiuBB/qfGozZ/aBJsRhcIAWOoZ9M6CUWAhV2vM+RBEBSqIeWM4vFvskDe9yj6GJCvHCl98AKsoVWIKZOR4+hCi93KSQEwPDG4pVOSs8hyx9LkWE99ro72hJdOT0o0evqIrDMKt+RbLpD5Qb2CkoXtRedk+ILnVe97Di0YdXSi3tDmu4jxB7Q==;31:gaC06jbQDa5gY+MOFE0hhr1GbpwOCUJq212rZLcCRDkQ7jS7V00ySlYVmtM+Q0HxXjhiZ8CPrw5vDarj9mt0Yodzf2kbQiJ+zQsZP41FAup5sIgXq/EUT6/64ryXF1pECGRf7osHGjXWNmKYbGViqyCCk6BRg1Zf2eqimUB9ib516tq9YIfCRLgr74+4rsYtnYg1wf2xI3Ebl4t+in5IKJqXnZkKlO8XfcP2hEYlK2w=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:Dq4o2yu4YKoUe5cdcSF5HjMSNg55E69XwzaGomjIHSTqNZsEMNabg7eIjnFPZutdIWEqBaD0SLGR9zKFb9KrSD6tQyQf8artDGcwFMq//bpXLT1KcAd7knu5lkkljShV7/+NV0CxlWgD0alwbsjuy/Lk1WCS7vuziLrlOs7eMXX9rWlznIMMP9TTqzyaTMoVWR6uxlm3OyIKojJ8QRxiQAmCG8lTC7DIrKdknIIuWRxan9lfYwA81jR8ha5keyX+G/Nbx2QLuWAAzL0C2xodzfWQ5PxGc8bTkyYdmr8XjIdXHmEWJVW9fkw9R/gZTPrCJgdTjrS97Smgea0C5bmoXCvwXh5dcnmitAOqo78/QlTGi6ibsGf1eCpRBYjRVMGcbRmGAJU9rZkRR1unhMOFZozamL0rRegURksWfLAgtaErDsFPhO20HlT1pUnJ+nJYaUrAvZBDocMTWiwEmPqHUbFg9micfphtj3L5VsuhmK9zXWfN2W6hKC7Z/5y4FJr3;4:/cd66skU12cCQvm4s4+6s1EESjw7cRWS5w2uArYMenBpMDw+FVxoka8DibWL8YA5dVtcZ896Ygp5E1vNQvVkUh2rZ+wEvmYLjYbbiYajkqcfF3dCR2friFKYJOpq1Ak4UJL0+1PF1bbY9N9z0G0UZ4qbhnDEskbzw2kpc0AJ5qdR6iVJqxMSRuWFGF4m9ibmSKuC2zjTfHJEgimCDlIrEXOgC/2DUPBBca+rRCF/YZmO4Ilyc0dkolL3eZdwueU89hOsUoqYzTWRQaa+ZPu6GqJCXp9wnMlYElqhjw7rGYqdb0otMfHCKlUxrgvVo1Ew
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Microsoft-Antispam-PRVS: <CY4PR07MB3495C4134C30B24B75CA5A9B97570@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231021)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(53936002)(6486002)(50466002)(6506006)(110136005)(2950100002)(36756003)(33646002)(7736002)(54906003)(50986999)(106356001)(189998001)(66066001)(2906002)(25786009)(305945005)(7416002)(97736004)(76176999)(1076002)(48376002)(47776003)(105586002)(16526018)(3846002)(81156014)(6512007)(81166006)(6116002)(8936002)(5003940100001)(101416001)(8676002)(478600001)(53416004)(316002)(6666003)(50226002)(72206003)(4326008)(69596002)(5660300001)(6306002)(68736007)(16586007)(39060400002)(86362001)(107886003)(53386004)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:cc9whgEbhxfUWFNqpyHFx4T19VZcYQPbZ01/rFEMy?=
 =?us-ascii?Q?4xQMgm/wdmmM7hXS/VGx0J/48PvQVS9JSN/4JP2dnx2iDjZQKjqPsT+NY+Ib?=
 =?us-ascii?Q?TaB4gR6WQ/l1Q0JwR2XobwOXbdV/SUxaJdGQY2Hv+EvxJ7OX405oaBipMfRR?=
 =?us-ascii?Q?ZtL42mx9ndby1VwnKqvbt98sChJThpK6OjGyE/QH8E5seH2T57aZeIcPBtKd?=
 =?us-ascii?Q?5g9Yd+7As+B/JAkRYkowYZlqfhHNNH6imN8n3fU0aAVg9fLRc44H7MgcKLlo?=
 =?us-ascii?Q?VOjX4IJafOddbnwCsrwfQ61LcR6CG1Qmg5MXZ2L9wWgx8M7kJ7G6X18QjYap?=
 =?us-ascii?Q?v3jEaYlKYEvHeko0mxS6RgUIESCjXXNAQBSn22NNzKukO7qakV4YmdyezehI?=
 =?us-ascii?Q?RxQzsJnDPXXJLAeFlGbStrmiLWCaPzAnBm3lRctZhjU5g5ZdDq0JcZxCUx0C?=
 =?us-ascii?Q?6pLSw2MoNCVgr57vSiLPI1y/zQ2VUzlHs0Y2e+18hxOCL9XTwTKsjqmle8AX?=
 =?us-ascii?Q?2kLMyNDRdHTbNu0tHtohK2w2sYl7p9rZ53hTYu3aZ6Ca59/MRblP5/JGmeY4?=
 =?us-ascii?Q?uThKkNXQD+aCGyom7RYuC8FZvSqaJ5+gJJgBFf13yEGkC007SU9hmsl63J6T?=
 =?us-ascii?Q?Vo7e07O+DUoIVlK+CWgXo95rJ9HvVTSJRDHrhlonBsjYlRRZ0SCkNvI4o6L6?=
 =?us-ascii?Q?q4romCpzwRY8OtcrXhE98Gx7ARRTLMMlaLr9siXbfSYA0N2VdQx/0RufsTDu?=
 =?us-ascii?Q?6C9+mAFxplc37Jwj2EYmhZXsTKlt5tz5NXW1AHrXEW/27/hUwIgC2M+FYV94?=
 =?us-ascii?Q?JYsk4BybH7jiyQlZ+fqIiIm0BAAgbQF+q72E2WZOvpMBZXmHSUWIMdvSLKe5?=
 =?us-ascii?Q?9EfyKjxYveRmvgAHZ1of1zPNT0JkW9SXxFB/gUXl9UdWQmxfiH4lyhwCn+gb?=
 =?us-ascii?Q?yyF7MP/8RaDURIaWhWjNk0rU9BwRkMi3/rBg/KFuHVIxyzckIjNtQLz0SrX7?=
 =?us-ascii?Q?oz05SiF/57/dPpXvSW9/+4h2Zg+esK4X1JvYJYtrJLDp5o/+UXkbzONwOYnp?=
 =?us-ascii?Q?ZAjbVRv2O9F83UkJj10bRA1T8SoPvGCxhMs0sHqLN72VbOEzPVOm/5x/0Pj+?=
 =?us-ascii?Q?InGNyc1ifJhc8N9aGOkfCBsfD2fiEw56XakFkqUxo0uCoq8zD6CpoTfRIY6r?=
 =?us-ascii?Q?Xj25Y0kMmnHEap0CtS3lVCqYGJ8hy2YkExwylEeIRQN0/dcoUAkuIxpErGii?=
 =?us-ascii?Q?buePkdVtf+GDzAo72p4bRPoi7sweyLncIP5SXgxsD8yf98qAAItjwM4PtdCW?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:42ruZIuW2KQiqNr454zGpeK4YSDl/xz3yt3qhwyJR/RIEjFkRK/Oc4LQErMs5RVrenoHpYj/2usMJtCogljYAdJ2Y06tBhP847DAQiB8JUtN+/o74F9lQhyKL+QsApAmkishE24tC2paa4Wlz6+rV/UQfmRrVwnm4xXgI+QuUmGyWn8Ciy63zOQa4tQwqXYuVrIpvOvBC+A/+7oB+Hm2OP94Urb/YkTTUvu8DVRH6gq53a0WGaDH7lgVKgx4EPvtdcqkhjc57dK/gcxpgLTRdv4ERc5yDHosZ8MMX19n+hLcjcSiMU3HI8Epu12noyadsn7kfmezP2it9SIVlbziFR53nh9VKvNZWm8gy2OYn70=;5:gLvQq9dosu1wcHM5OdhSqIrb5nz0LMFX6dmurwTzwkPHtfTA1jLrG5kM5QjRqP3Elmgv8K0tXY9aFKTNtEMWXwa7l/JraPQ1Mp5HuACwabAQs2AKGo+rFRebBl1rC3elYCUI/A9Tf74zE1Azg69EYJeYe2d4IWylKCjAIjbu50w=;24:w7MLliNxmhWvw2mLNHnBwNyMoAb/O806D8pRns1heqF9ZcbAtOWdZ9wF2RB56i3dLI0NXb5naXkWTU07fZA7zcZHG9IepPlSV2M5ktngiSE=;7:xp+GSI84C1zt2UFHCsctPFIWKyyeH2hZ/2naVjOOeY9enLqxtn20x7dF+bCRbB57d2rgwLE7kNxSFNZxT4Iriwdm0x4gSFvV0hsGkcUwIbX0MeN/cuQv1RhUFEO1M1rJXE+RVHTUGMo2hOQG4/bUGyQU/L4mHwW08vDHPqDaacNmX8z1k4Yz5fhUqdlV3sQpy/sl7vshUIvGuk474t8S3yjLBDFTbaV2wzJZvSO/9YwX4GGKzmfBChEeZKpQPRfD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 00:52:16.4482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e1be0a-1b45-400f-c783-08d5270c202e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

Signed-off-by: David Daney <david.daney@cavium.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a24f56e0451..142af33adc35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3212,6 +3212,12 @@ W:	http://www.cavium.com
 S:	Supported
 F:	drivers/mmc/host/cavium*
 
+CAVIUM OCTEON-III NETWORK DRIVER
+M:	David Daney <david.daney@cavium.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ethernet/cavium/octeon/octeon3-*
+
 CAVIUM OCTEON-TX CRYPTO DRIVER
 M:	George Cherian <george.cherian@cavium.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.13.6
