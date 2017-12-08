Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 01:12:52 +0100 (CET)
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:62912
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991770AbdLHAKOyaecA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Dec 2017 01:10:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zwGj2oW+zP4LXnqMFGqKMSOXzySO64TFlWZ9gb72zgg=;
 b=alH2xpnvE7ieWYw4gYYPZDYryQZncVMFQ4AA2nhGsb5hNeIFWDpFhyPFZM22PxWyQ0kSi7iZzNo2K6SBiSelTHgxPNV++qTFqQyjNEdLnRwr3OThaYO5omWMebN5L659H9oDNCJJ6i1NQ6Sn/Pv1VEUsbb7Hqm1+Hi5Wg+DwtIs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.302.9; Fri, 8 Dec 2017 00:10:10 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v6 net-next,mips 7/7] MAINTAINERS: Add entry for drivers/net/ethernet/cavium/octeon/octeon3-*
Date:   Thu,  7 Dec 2017 16:09:34 -0800
Message-Id: <20171208000934.6554-8-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171208000934.6554-1-david.daney@cavium.com>
References: <20171208000934.6554-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0068.namprd07.prod.outlook.com (10.174.192.36) To
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eef02137-40cc-4cae-5bc4-08d53dd00c0f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603307);SRVR:MWHPR07MB3504;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;3:QfLRnWJ0wTSQfNBTSJVCF+/XlNNlni/p+ElkZvyCaCpGJIn1Z7LF9bMQMGaWtI4nMS8VRaoDvQXjvCD+9btl26JngoS8FmLuZrIrHz9MARZUG7y9+nYO2v1tKpknlLa16dusqFEtE1nOeMuvjlqvsW6WAJB8fHHFDkoNzVoSvHZEXWlwYoyx6sv9aht3GMLCRKYAKb/cQfzWn6s6nnmlhmoix9BsHN1R0oIzn4Vo8dEWXqjHyRtwYf2F+Fe8kjki;25:DaW5bLN/3ZyEqx7r+hyP+ZxgCdjSggX3sa1/w9FzjdRyMJ38GMjQk6WYESj1Wz+GRHY8bwoKChQWVQuRIja3TMeSEZ1pBM1CsIAXUPIeKsNa3L9Cm9mZp8Zxmm3dqnkQp808enfUxcBlQgfMLbhQrPSWnACp2+bMwKjxP6ky/jkPwDo9DBw1/BfokGjz/pvt2qo25zb3rA6lEWYABgjcsJEcVvzBP5TLAjIuWs0tWektzx5nywSG1iU66pzplsVUS0VdoDY5VY3/6WEKbEtv/PZC7h/cgKivjgOs8MsxKzVxSx1c7y1eQK3s64PuUz2Avqrk8JdYOvDQdNl1x8qK0Q==;31:hcPJnuMZKmFTJuJHbEaqVU8MQZXqKXSyaujgaH6ooLD/7G0oOZwEGeIKSPoB6Di3PTapLFZSA44Ls0zvGzBNGFeNMa6xyPTAMXhCIRVwX0M3KqEb9SCercKX9i23Kgxo/kY1R1SBv8DT7Y2CCbpWKPdTfotmOf0GqZI/cDa0SpereS9laqU+YwTbkwTqzJz0hPgAEBuexm5xY70wjVJWQmlcmJGgP4zJc6yc8jxe7es=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3504:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;20:xCAW26f7/ghjxYIj6tWtZPO6paGZL6zD4V23LhVeZ40Ivud26VoXc4QWRvjDv9iWBLmh+488VNA3B99dpdPalIMBGGUZl0/b6VY4HK1L1aXmHCxkNeORC7Rb7ggcV0XUKYarWxOaEGiPE7s23qPTtrdgYGp2XBMUkA6iQgYOg3oMdazqqx32yOvOzOI6Ev1LEy6mEeGaWqRZ4YyhXWEaVH3YAxsesj8hn1BjuPGslIMLo80RgKL49C3VpUerNIvVDN9Q1aES4N8bWpDXx8l7MCz5Vte7XbpAkujwHnmBnMdIm5+sf9DEQ/lHy6vs0bmEKGSZpdpqIS4WlGsSbl5dHHFValgnKzufCDGzBOqK+aUzi/9JrPJN3YTrd9wTcknjGwDAf0Arg6UjbOPLM1McWxo1b5DH0qNymaJ4nxdebFH9ujlDYmYT7vklx4xYOtCsKANRVn7rGt3an2aDzDSOvOtNBFU/XbOQIY/X0rUM3gWqa9alwswpuFnLc2vA9in9;4:G9s+iiK0ZKvkj72zFZn0cQmSlod3KGz2msn3AjhYtbl3BeoQjOimrCnEYoyQTrRGNaQEOnMWPPB9YZvVoMm2eIbqDDXtx4XSYkQpdVIKyzTmnF+rnWxGjlZLY0AQC3uWHs7sg882EOqX226hi5ApeP4RRwCu1z3SDwqI4C3QBysGCaUNiWmsboYepKz8KwY8/dzFAfR+ixRvuX+QAaqQWwNGxsLpEz44d3+I1LPpxuJFwz1ELPbRg55RGEgFvLZLzMqF8Y1+UIDD7mKBc8PwWze8hXAE+SXO7ltgQebycj3tBrSa4JgqJDIvqmDk51Jl
X-Microsoft-Antispam-PRVS: <MWHPR07MB35049E902360B58321BE6EBB97300@MWHPR07MB3504.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231022)(93006095)(93001095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(20161123555025)(20161123562025)(20161123560025)(6072148)(201708071742011);SRVR:MWHPR07MB3504;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR07MB3504;
X-Forefront-PRVS: 0515208626
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(199004)(189003)(86362001)(105586002)(106356001)(81166006)(81156014)(8676002)(6306002)(69596002)(53386004)(6512007)(47776003)(107886003)(66066001)(48376002)(4326008)(39060400002)(7736002)(50466002)(305945005)(53416004)(53936002)(51416003)(52116002)(68736007)(36756003)(76176011)(6486002)(6506006)(8936002)(50226002)(478600001)(33646002)(966005)(72206003)(16526018)(25786009)(3846002)(6116002)(97736004)(16586007)(316002)(2906002)(7416002)(1076002)(54906003)(110136005)(6666003)(5660300001)(2950100002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3504;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3504;23:h7ZOnVr+DosUWeUmJhOtxYf0p3kCo/WiwQHlgFvAx?=
 =?us-ascii?Q?DY73Nzj2W/ORbgiimFJJv/Yn7TZhUJjmcy2W/VlEQ9+lFxv2whnou48fTYaG?=
 =?us-ascii?Q?981+IKHK/yM3YflQLBb0OrCp0imxYJIIz0/GV5Mma2550eb1jr2iRVBdBllw?=
 =?us-ascii?Q?kNxo1eB4lEgY4Lj2C8IfI0dTvNDskFy3SgwDqXteW4LLwPR1IrG4Hzw2+YLJ?=
 =?us-ascii?Q?DOyYqmR/ejPyn56daBpjfNAdSXVnYiUWF3WsB55nei5thHt2sYvbKD4Hf3iV?=
 =?us-ascii?Q?SBd0vHpkcxKIxyOP8OjMnOVQKOjTe+5zhBQyBAn3xKbrFgVZBSmUawpBksHu?=
 =?us-ascii?Q?IWCSpHVLXKDw3BwQKhWeYDYUaHTOLVDNxt7KbbVtKgzwagnbxpTFVa3Lb3Kb?=
 =?us-ascii?Q?teP7dq8tP/XT8c1ha7wTZ1tjwwG4bjupGTETqwEhRhcU6+3GvfElqLMlhSgb?=
 =?us-ascii?Q?Lz2dOysCCe+xWfs+5+DvacXfxUIsY9pmhxUg6SobrnKoWrRV6/khew2G3aJM?=
 =?us-ascii?Q?SvvUTKo4BQhdhHX/sNJnKs1WYGfs8sFCZmsL85o92fzQtoH3z2RVAEpSr6Cp?=
 =?us-ascii?Q?28OShboGGqd419p4A4thijgr8b8FMKIoNjS4PPq0uXiRH0kzKG+P/7yagZF/?=
 =?us-ascii?Q?qJE2S2cPlBcAr6mzal7d3p9OKwvMa0a88SZt3YfpcXVzkX38GQnYmdnwKWGm?=
 =?us-ascii?Q?J0ALbApk/YHCm2dosOoK66gPLFCexbcuZUNZoB1tcmEy+ByIwSUhjLcsbwLO?=
 =?us-ascii?Q?iDuY6e0IJE+3K2jXktNEWelA6UxhxZY6q1m3D7L+PvDyWWwVayGHERBpq9VQ?=
 =?us-ascii?Q?8/SzDkkToYXJ4t9nSTchw4KdPe5VWwViP935liBsmkvW/MnXi2wyxJ6So5Ul?=
 =?us-ascii?Q?8DzmHfptqXypkXIxRPxjhV8ZrJg6swqlLDtff8OQN9Fy/k9jd0qOsPDE2jjJ?=
 =?us-ascii?Q?9MJVfS257PaNH5zITKbJx5/nmzvpOxCfaULZgMX4tqjq6LQZZOyINUy/pZVz?=
 =?us-ascii?Q?k3YSWvdFfuyeZRjhk5GWabNHB8PSA5JYbkePixJ2gWBTiwKSa7un2QgbReH7?=
 =?us-ascii?Q?f+MkEPdlTTbtlR9YfMduetSSXqMb15lXBsMy7zDMELcPpOjXo+25ABmQhtg7?=
 =?us-ascii?Q?0VeMcrNxEfihqR9BK8FZOouXnqKlOdB4ZeBh+lHyx3mjl6NHusYapj/f5BDo?=
 =?us-ascii?Q?sU2xpFXS8KfKYg8QnHacoG6dpA9Jidi+ntGlDuwBVPy6hWDCOx/CD0SGdt5g?=
 =?us-ascii?Q?7nQojmKyTtwdz7ciw4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;6:3WbqTeF4P0/itfcy2qyTGwokx1wlaO+u3tuy/ciMV8vTWYcYT36Z2aakImQ5YxoUg2cDShHMrWRQtXKeZ0jnwRb8/g+4N6KXomYRJs9OMWYBjt0o47NH/eaqMTjoPV01e5jxBhnFTZgQGqnoqjtNfW1LrdaJLyjFTGCcjlFO/ETuA/oMINyBWkSNFGGiUOgGV4a66/rhY48kc8C7ge+mgqslgWB//ZDY91vUMYE3S6TkKpCbdS7HiwvzVfbdkxo9dQ7zvdU6xqYVabIbsLHD4tHSeJVbzReQ7N6LR6h/YnKcmKFFcBaWwqPUORfOeIjZFdRPkHYwasxpnbpLlEQQgJi47AqYUwhlger7Q0VI1AY=;5:vwzQOZvXFSeJdI2PKXle3O7/VrrRTRqnZjSHDpXChjJxDU7OtYz7ZKaz7q6JRbHQCwVMehiU91RYjkRVDqr3rBD36uc3/L8L/FJDagr7cxwYyxrbXC5IRrXmwXfF597zj4BbfybKt4uhP4c4Ydxj1Mz/eOQKDzNu9wm3S8luGvM=;24:z91xOkvv2V7FygQkyTIRCLppcPTfneRZuYk/ZHFmBYiSoegAg9kad8YribqW2dV1Qoft8e/abR0SBnyZxG9PKhWqFhkiPdo6vBQ9795SutA=;7:+jJzluwD2MCvMXO1h3qq1wAA0CTZMJW5VTI0O0CM9HRjhnY/mbntfcrWwVVu8czxy2P4YtC3PPPZgAZsK0Tj3xraL3XGrrdkCv3Aaq1h80BsAf48DXLZjkr9H0h4KDPWMx2hfkAwCM0aBzk4f3zyr0VLAo9dAW+FuFcaTQh8jsnqUnrH7zADAJlbRTCBMnuXH9/iGj+pR06JZKLPqBYLcmCvIY8IvqtLyT0O+dg9zX0SOf7hqWVk8W5K1f8rVYR6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2017 00:10:10.3399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef02137-40cc-4cae-5bc4-08d53dd00c0f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3504
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61348
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
index 4007fa2e193e..b4bf5b205380 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3249,6 +3249,12 @@ W:	http://www.cavium.com
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
2.14.3
