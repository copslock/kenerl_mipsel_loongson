Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2017 23:05:16 +0100 (CET)
Received: from mail-bn3nam01on0086.outbound.protection.outlook.com ([104.47.33.86]:3904
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992214AbdCAWFJhzJxZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Mar 2017 23:05:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rL/1a+k+ldDMUTTp5+myDGCsKT4dVhUu6zf1I9UzMts=;
 b=B/P/U5sWmwy+s04tWphlJkChth85A2oawbBtOiPI87hmr1xUj33lALi4Fl7ZFnZ0wtXxBHa+u7aulMYFInIFcRMZOI8ns7Q0cev5cAwsxdV74qv+dKMzk6II88VCCSnaCygBibYuaSP/HgfY1664VzZEEyAbT8yUD2DHyG7CJkw=
Authentication-Results: akamai.com; dkim=none (message not signed)
 header.d=none;akamai.com; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BY2PR07MB2421.namprd07.prod.outlook.com (10.166.115.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Wed, 1 Mar 2017 22:05:00 +0000
From:   David Daney <david.daney@cavium.com>
To:     Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        Ingo Molnar <mingo@kernel.org>, Zhigang Lu <zlu@ezchip.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] module: set __jump_table alignment to 8
Date:   Wed,  1 Mar 2017 14:04:53 -0800
Message-Id: <20170301220453.4756-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BLUPR07CA0032.namprd07.prod.outlook.com (10.255.223.145) To
 BY2PR07MB2421.namprd07.prod.outlook.com (10.166.115.13)
X-MS-Office365-Filtering-Correlation-Id: d0be0ac6-2e3f-4b10-d360-08d460ef02cb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BY2PR07MB2421;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;3:fMWuxb2953kskW50QALRYxNU0oqg46SXVvhCvzC+WFDXBklMUtRxuPlD8DQGNk8DKauU9aOYbPSrK3Fu/p0wDq0+B3WFANGREMO3l2T4Xy1qhBhUDVyZ9GR3xGckL2aney56bePOxIg4aCd51eONBW6WJ+UHNZAQhAiPssOf+meVcNQGQtUlDAiF1UCJzbiVNsl6JT/bXAqBFPcSbFm74aKcz+d6eXCopZ66BSnxvYjAi6GjbhsJohTBSSUL2tl0q/DyI+T5G9b/Tj64fbwifA==;25:JsO9SD61f942W9KODjr8lMapbenZFuQYi0YrHx9Ul5s6zSwJQrFSyQlIowiZDZ+4tvnMwwF6fn0dJotQRGzzUp0tsqAkinhF8MZgPMUBUQlL4ZVGuKTGKYca6yL3SfO0yew54M2TZXVR4CrU4EVzbJLbHlkaH3XU4A1sbitv1Os/95lgp3Ku7KuiKWdOfXNJTToTO9iNg6LszPkHJszbVIZOQbsq9FEruKO0n+IF3Yoh/nNvqYn0qknk6cuL6R1uFbYOzikm3oDW3BYXtAtDGMg6DocaKSq6MgBhDave8dKNtxLLRbpyABaoIVD2T++U3QVt1KAyA5HPU/jAMECrNo2z98QKl2QHo+QAYF4zOKYFP+rUkXxW63gquYEDztyDs5LQ4ZZpVh+PkvbnEpaC6SdV95Zx8RAQBkppk8TySXnPn5TWuAZ1HB2a4rujW3WC5vQ4GtIn6iuMXt4nqkdJzA==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;31:am64sW2DkLJ6gKs6Mr5WSgiQQ3cNujna4FV3OzkzekOkfnkdb8HyStXm1sP+taVXsAFFu1bvFhFsneEJ3D8+TWF4PTM2YgiZy6xSWoCVFfOaALKG8Y21OKk7rf3Eod/RDyYzJZqI08a+wEXDtkzVETdSD+0PSFEAf+ZcWfj2WLaokOXDnEBn2UeVG2yTaWwmX4x4AZ6qP/FsylUQhQB3xy/pSdnka1VNejC0llf+hsA=;20:AZOlWddaOt8RBVyRqU5+ukvdNK3GfWYXoYsgftU7GFfjs/Y23N1DxGqOZxqi6vBfKImL++Nb+8VPPXedhpEs7DLSr6qcVjdUyP+ipqO+iVhdhrkNPOnNrEeBlm0ircJD6WGDz+ON3hblqwWVrXVGm2cPcVkCTxWOVgPNi7/4F7n+Vi3a3TNHMi9hEb8GO2bjgsM6f5ySN0+S9VrCEJo4DpwQDg6N0ZovvH+frQqJXNnBvSlgfSmhX80pO3ABvW1Ye0mlqG03bwOKy+dSBs/Cg/wgcfiTDmM9zsG0E6HwCTHhXn690ayoYgj4C2fVlXB+dEP3/kANtFqklErySCHntEMqfgoIg9xS2FbZ9JKhQrn8PyOjgqqR2UqQB9iNIa4BoFzaBmj7kxMmTIN58SJ4D/2uVJnLif352/gjPDi3KseSZouECDyaAeeFCzYuJOZwEAem8CanTwGZIQVd7StUilA3N3NWfAlF12CuPxIVWKMtmXG40b8BrqFPbrPmI9yH
X-Microsoft-Antispam-PRVS: <BY2PR07MB2421B24F1F15825AF61A547097290@BY2PR07MB2421.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123555025)(20161123560025)(20161123562025)(20161123564025)(20161123558025)(6072148);SRVR:BY2PR07MB2421;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2421;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;4:KpxEsRPHxgdIleFeg8w2qMgbEzIh2n3XU5hPnk22LyJ3oOP4FrY3BfdP06+zCK+6Z32+5MQ2ZhnDKbF5ftH0FATpdu7KO4z2XnE9XhpmErxo857NuuQPnPfYE2UWHjmzSV7CCoCqrJfN0ImmPSl427pYraUa6lfQkba+LEsmDwdB2DeldTztQZFecNkaR/vD69DS92LcU9NohxwGrKmtmKjkHcK4lx+v49r2HJg/VA8l7kPs9/xyvGhffDF3MIM4G6MeMNwTuTlkRxbSMgG5WC7vwkeIzN/mlrcALshNFR82T84W7Xn/c43lh8t6Dh3u2Td21NRr9kRb9ApM+O4e+HYhJrP86jGr6R4RqLsxVNIeRJbPAG2tN7ySmYo0uZW9L0is05E57PY750db++uJFAhUSYcIJmGX+NNPuBb0rxd7vNAEScjDhExPjGkYOiUPKPVXfGz8QtJOYFNuQza4xQ942GL22PWmAMooxsr6ETxW1lDtDbC7OTeWmtkYwDVtl4mGAYeH5BFhKzo8Hv2OWKQ6uyQDHpkhHrkLr7THyqx3gnwQtUXHlPZuESOKcZxaYxjeS5Hm3ZWyao9uJzaN4x3o18wahafTgVbP/3B+rvDcDHvN+XWoj+UfjZnkQeDX6VvwNrnJlKpAOZmgAj5ceQ==
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(81166006)(189998001)(6666003)(54906002)(47776003)(50986999)(92566002)(25786008)(2906002)(8676002)(53936002)(66066001)(6512007)(50226002)(6506006)(86362001)(50466002)(1076002)(5003940100001)(48376002)(38730400002)(3846002)(7416002)(36756003)(6486002)(107886003)(6116002)(42186005)(33646002)(7736002)(5660300001)(305945005)(53416004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2421;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;23:PTZhOUMs6T4osGbceb5Lt5mcEDSc2BnlJcw5nB73NPKbbkkcO7sz9d9Sfy86ZgsrPT9kuZ5MiZxFANTEbCtSA0Mddpsac7jjzvhfnOcHiRBgVovpK08UwAkSuIxGJgQZNe4asUTfZsfZBaYvnadrNXjsO58JWEZL0Z1Rgc7slDBh7ziyBLPM+v+OYguuNNnkuEmXU8pTwvuwp3ZNf4vhj44yy3XnLLCxqquU2WVVSA2yzGLkfDY+IIYdVkijJjTKMAhxMGFatbLcvWuJrsDbdcXCFuYWfkugW+rObEI9ghjur+3ujkJQ/cqSzcN+kYIl4BvRG/DjUpVGLZOTlViA+7wP5nTaHBJxaaSsTNlK8NP7IF8ZpNXp8hVl1O3KF6l+evL7oaH8hXJPk0QqIKdblNXtxQWPPFAn+D7V04+nrMZVApU+mtlq02cV3T2c8wNtjnP5XOcz3utUXS0uumewWmbuzH6fHqh0BhIwFhk7G8QAT3odsmcEB3VeS5Rta0birx8w+BUPdDTvMbHtCt8DzvsrUzBcFRnZVqjSCZr1kOlvylazP1ZlMx+k11cunBtMpbHnxNfJdlNFM34Sbl6sYOjfj3UqBQtQvSA6f7vjw93//7FDIh+CE9mk3Au+DPoWH5PyWi8er47S2OVPhvk2kW2LELgFxwsss5FPVxzEdAmaW4wD7NmN33D6KqzxvQ7+i/IpKM9Jxi96IEwtKxri9diziuFmeGXqDy09INXgLSb4sHNsyqD3jpxjVA82Pk5ZppFZNBoI5PiZgNa72Ov5JjzFDcBzFbxc3Twz9+OW7KzdXcfvfIzXl6KEwArASW94gZ+vDSzn/4zY8MTwCu51e4tqyqX1//8qJvorJQbhzdFKM9Sq/h7YrUXjQq9m74urFet6dG9PLNOWgyymlgS1zB6wM+W/wAJ8NsGMHZhze1o5V9q3FnWU+A8iXGpaOgbl
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;6:tlaTEmp1DbWB+wpHLZHPLiKa4gDRJOh+lc4giPQ0lJv4LnMYX04GGYAJvjVwBS9EqoRgJwLQ8uA6T3wh7fCyXQL0/+p7S05RjDa8XDLgIb7BMssY/6FP2c1GaQj/SPgaTyGky+cJdwWrypF7Mn9z9Xx3W8GOcn6nboiAmZw0/QGrjMU01mo+Fpy2hri5SbQVFh0HSwloP8am+iiX1/31S+qtXxXogqmFrXA5h291rjof529bpFQgHeJa7yRUhF/8/6eGAwrqFneM4tbr6/DAAYxQ1/pGb2GRn1WHl3a/TKG6ImyR9qbOqZe5vsmcVUpKQgUxTrHjbQLJCAZL3v04BnwP9C/cXRh6eYeyfNITjWgVP6XBkIl0qTVwF9Q//4tNOsDdYC5qHKtFNI2eTpD2cA==;5:XL0sFeqYjU2gb7x0f7DAQ2IioLda5SAkRsbaWslrF2fCUXqzZISfBK1EHnwWhqzcGvwZ0+dwPRldlPDzePtEYOPBqUKsi3UjuS9ovqTaLNFlyXjwpVZN5qx9AXT6kj8AW/8yHjJpfyzAcBhg0llL5QJzwZlIX8fPbpeQ2eL1k4A=;24:dzgVaSwvFYDHpSR/sDOaSbyfu9JTyV9/pMXN6uDCaVTSsw7Y7RRWiFXLD0jQO8AubeAMFiBiwPnFHnMTfE84ShGIE3IwyG1S6/b8XA1I0uY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;7:RFqiEIxyoWhQGE66EvBiabJ7lzzR/lkHMu2x7w5hoYbiOaexqtzvaz0lYOjmoS6hetop+rHAP93YHELpZr6sHNybHnBL453mpcAnoSbLH/xCxYNJ7gphdUDEGB4k5ftEDTW1VCMXjbQx3I1KYNsXxvY4zZQNqsWnvqfk+EHXpxaIxkkm5gCdFN0DPf3WuWRTYPtia6kCRqvm6eMFZJdiCnb/pVhNAZdUEDbYOujCcv8HCNyou9wLzMrivY6O+6nPai/lH/iNW1SHSluGjJrVYUpp+1GegD9gCLg4yhPzx+hbQNYaZwj0Tk3fFZ85TPzbT9dfLKpD/M+hOq/EkaloHA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2017 22:05:00.0663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2421
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56953
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

For powerpc the __jump_table section in modules is not aligned, this
causes a WARN_ON() splat when loading a module containing a __jump_table.

Strict alignment became necessary with commit 3821fd35b58d
("jump_label: Reduce the size of struct static_key"), currently in
linux-next, which uses the two least significant bits of pointers to
__jump_table elements.

Fix by forcing __jump_table to 8, which is the same alignment used for
this section in the kernel proper.

Signed-off-by: David Daney <david.daney@cavium.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
---
 scripts/module-common.lds | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/module-common.lds b/scripts/module-common.lds
index 73a2c7d..53234e8 100644
--- a/scripts/module-common.lds
+++ b/scripts/module-common.lds
@@ -19,4 +19,6 @@ SECTIONS {
 
 	. = ALIGN(8);
 	.init_array		0 : { *(SORT(.init_array.*)) *(.init_array) }
+
+	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
 }
-- 
2.9.3
