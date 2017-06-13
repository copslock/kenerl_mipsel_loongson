Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 01:50:20 +0200 (CEST)
Received: from mail-dm3nam03on0048.outbound.protection.outlook.com ([104.47.41.48]:38921
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994626AbdFMXtwZ00mW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 01:49:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=p/Ym04qM2y7CqaygsOPOzqr4IQUewpDRjkYcCzmcZ6g=;
 b=VufGTxw5WqJTV4oGtmKmhdZPzOo+0RJeLFUINPGm7jxmOzs2y2u91ALNJpKwtcSawxtgEQuz9S1TgZMoNvu2QefUddpm0wTEjv8k3Nk7/NfmCj0Ea1mv9gVBe9TTAiW6PadQ5JbEF87ee/ippZ9VsLcpmbqFJKi7xkVSYi8WVT4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Tue, 13 Jun 2017 23:49:44 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 1/4] tools: bpf_jit_disasm:  Handle large images.
Date:   Tue, 13 Jun 2017 16:49:35 -0700
Message-Id: <20170613234938.4823-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170613234938.4823-1-david.daney@cavium.com>
References: <20170613234938.4823-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0024.namprd07.prod.outlook.com (10.166.107.19) To
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR07MB3501:
X-MS-Office365-Filtering-Correlation-Id: a3948b36-119a-4f93-5111-08d4b2b6de16
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;3:E7Oc+sfWibVzlZJcmNQRdp8df8OiApLrdee+pedfkDjTUgAtJ7LKb6H5ope951uDhTx+/Ed63T0DJ5OuyUmjcX3NO9dmQ7Edf/C25JzIHnoynHgrjgsONKGqh2CFirMrfRmZvmKTSW991scbuOJax9nf8vAmiA1Sa8B7RM80Ur3qqyzgGsQH/JAmfKw5oa27DgHhULoV23ECqFceRP0eOwNxDXG0JJ+P7bh01LChcycinbvYI20xpuK1/mfmot9oyHYAh+W9E23xfIO2B3BS80XGs2Fof2SR8bfaAVYsydhjEEO/DjxqSWSOWjVNzmDXFHiIpJT0R8ZGvoJ7wnSOwQ==;25:neF4vdx8ye9bXymX4uQabOBxf+QtCE0XpLBVSt4+ixbPfGDAutlEm7pGay4FOIcHB0yQR5it3nt4VgfJuD6pNob5I4Hh9yVat/Y8MgwoqUWjKdqFGjZC9/UrXiVO12p4LU7rH7/kffY+UciIMcK//+NPNzh2wFbQYlbpJreF5L6caovxr/RTeP28SkbtXqO2fDipagOz7DdtzcKGyse4Wmf4CKQ8pVeZFFNR1t2DQ2cSKffpKt7MavBEeVR5ydKbTt7bv7wRf1SjtYOpiYxdNLuh6FtepEk1WNiuu6iLoTBYTNpW3ohSVcbZXQ4cQVWKBOfAb51eAL9fEBFatBQfQ760XxUP0StsOta2EUyIRdzaMiBcR3oa3eYWbYaL0HyB3CEIjcrLCaGfKgshnhVQU1rItS3k7GtueQUsRPfHZdc39pP8j4iA7GigVahHWjR8IJmAhXBidU2RlbbIVT0XImdExEJ2MD3AiFupQO+edVE=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;31:O3wox2oz0G050gm4TzVVN494Wg4cd5FC7b3UMipvemxNvGD+eyMd4OzsQ+WYwZHnbAT4ov7cuIGDbNAWHoDRUJ2a241Uyk/57tlRIi9PqN2sTHr2MGHpu67ZbRgJp8DAKIZaVpINo7DqY7x4pFkV79k5ViMw2GU4+sYLG0jb0w5JHN3B1jG+2idsFsuRTSnupR5lXPATFJmV68SewaxZwnmLBs4mxInnavMqktHmVK0=;20:36pQr7S6P1U9AErDLxkIaoUqdc4lBdR1Rfi99+kgsF4sprTXO7yZ4tSe2t8DywxVrKii7VSFupipSvmJqVkDoDeQMYFyHZLH1glWDt2uJpGrC+kh6jGcHopTHQ674VN885+qSjUHumBTMeMbvdmIz2haJKNtuXBr+460usQUGCSxUfllk/IGgr91tDZ3xoeWbvS4i816vDKk95BLEVsvN4mzDzbPPeijhI0qwt3JaiMPaeaUBLu2zTrLFf3FA5V+DIQ5OxKl3qKUREAznAA6tXqKcG/L2rNu6JLCbsTgFl9WlxF7QdvniKkq0vLiXm0A68gH0FF3cb9L3tfw9p0UrBhEqC2MMmP5s0uMwZ+vusDXXvE9evoVZ++VK4SaO0UNedt+uUUxcUCTNMxahEVeFO2Dysb3BGWMLTFicqsTAy6rYCKT5FUXAphWo0kkcmn+mSTtg7xnf2r463oqoSbSkOPNm1bgI2Xoq2/R7O4VkKNBx/lkuGWmSmzO4yv0owMy
X-Microsoft-Antispam-PRVS: <MWHPR07MB35017CC91731B3D6A0A1B45897C20@MWHPR07MB3501.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123558100)(20161123560025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3501;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;4:UbNLWpaQJ1TsP87rxWQ1ersI/FvcQUvNgVekxdQ07u?=
 =?us-ascii?Q?LZg+ad3yIzRyBlsVMj7xsQgs0uLMC82HblDEOehSNFjQ98mvXltE3fPIjzUI?=
 =?us-ascii?Q?kwSxKkeJ0imciG4msx0IlHipawipW1Vkwez7H90u3DbNFXsxbOUSpJw3k/d1?=
 =?us-ascii?Q?qyu80uFpu7ZHtqpvCQbAj968mkFMuSopOL0xn2+/L9Kh2jSdYGkrzD/l5xpd?=
 =?us-ascii?Q?kiU4ygO8EegU/SK3FaJS1c8OD0brhLqo8IEd01H/m5QCZUuOIWCM9VZZuQI0?=
 =?us-ascii?Q?V7PLKZjmBigDUHCqQLwxBiUk3LE/OsRvSTJmjZHH13lNbDuU5nYMciSVOhld?=
 =?us-ascii?Q?08/WFrKO+chWxeC8LnFiPEiO6aL2YaeKwla5x/Bu/Q9umwej/8i8efaU9cVe?=
 =?us-ascii?Q?24T7O0uZ6e3ChE0wU+ylucoNNK+nH++wH1kBYzqsoOFJ9rMLYn0hBHht6XvC?=
 =?us-ascii?Q?MEHdR1TRQiCrRrpIXOyyorNqcJSRMuZOzsMMx2Njo0Gpm9/psuSlUesFtdE5?=
 =?us-ascii?Q?OCroextujjIiRGiWuYYcmgRX7qh8R9CGmXL4/joqdo61vpSRxDo2bCezQ5I+?=
 =?us-ascii?Q?eZzCMYFvdA4l8Y67c7NZ8PCt7KP2MKV604JUjNM9sFNbC7NjiGKaClcf9UUB?=
 =?us-ascii?Q?fX4Rc8hYWllp5fkWhvyzjj48ORebBCL4kHFVER6+EjnThQIp0M/XdQcCtDj1?=
 =?us-ascii?Q?P73EFgRl6tuQWGUxcdV9EXX4+R92Dz59/Dqbv7YZuEIbGZSV3wx4yAP0ldfQ?=
 =?us-ascii?Q?BGO3jSqh1XOJxM6bKv78d9ZhFZqruaFibI07B+hZ2YCW13B5rE0r7R+iQydT?=
 =?us-ascii?Q?+I3JHExqLKz/c/Q8DSLnlHVqDzOh/jbqjzukwjtlFDgPHkQvKeDE/Gs51Mts?=
 =?us-ascii?Q?Wo4tMyg2qV23LyMOuV7wnc6nmcFfBqPyPE5WLdmV+1g5UW2MM8njQ9mKc/X4?=
 =?us-ascii?Q?kKhYKH4Kq01wCu9FOA3bEU1jh3FlxSlkRogF/pPr8V1cYqLbbL4DGxVpgFrU?=
 =?us-ascii?Q?I8W1Bk3gCZM6MJAwc24Y7hfDw73xRLJQWlUQqcvNmqN/RttlUUQvBP7fxVV7?=
 =?us-ascii?Q?uNwUWy2fx+Kpdj5MWENmMDgNUYSnwPwsUygNsgdydjx111a88OmQgB1rpjBu?=
 =?us-ascii?Q?JaYPTKdVESsYV/BcnIPfYhjh7mQlEo?=
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39840400002)(39450400003)(39410400002)(39400400002)(39850400002)(189002)(199003)(6512007)(105586002)(53936002)(50226002)(53416004)(2950100002)(106356001)(4326008)(189998001)(6506006)(25786009)(42186005)(6666003)(33646002)(50466002)(69596002)(5003940100001)(6486002)(48376002)(76176999)(47776003)(7736002)(305945005)(1076002)(478600001)(101416001)(2906002)(81156014)(8676002)(81166006)(72206003)(107886003)(36756003)(5660300001)(66066001)(38730400002)(3846002)(68736007)(97736004)(6116002)(86362001)(50986999);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3501;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;23:lompLCigV68H/HBr75TxeQm2I/h9cDU1BaQqCEqjc?=
 =?us-ascii?Q?CsqVPL+Pf27HNNoA6+5/sOgIaJgalPO57H5OPDBKp/UmxTV2KjAkSfBksLhN?=
 =?us-ascii?Q?qG7ajrxIiHlVxGw3uHKCNRuANUqtrgWFqrjwqYgxXt29RvBXBe1Tqv4hq4mF?=
 =?us-ascii?Q?BXFVGGKAj5zZt47A0B9bmtQ0FulDHgH9sSg5v/M3uR8jelKj+2EHKeeDWDRM?=
 =?us-ascii?Q?3v4yFNQXc2nHtz9ECVYxOu2MUC9axhfHvQvZEe/tUHWDa2VHFrrVAmyu8mTg?=
 =?us-ascii?Q?WkOPprrdVAq9kyvgjZMmpI6hq05GdVJwhBaS5SNn5Pjp/7GiiWzTvEUFsX9C?=
 =?us-ascii?Q?hLYyTiTGsFkddYBRGFWvnyUpiwOEfVcMrhorK8j0BA0RxpX/9/LDkOLK0ZsJ?=
 =?us-ascii?Q?9orcrqmMwJdbiO/XyeFsoX5+Bzpu/oBT1of8IZWiwydWjR/Qi2fcZT/2IqoH?=
 =?us-ascii?Q?xDahAUDroKMF+Sa+KYPx6F27N2fRvs4ho3rkthWZaw+bhs0+3pqxAF/dlZd/?=
 =?us-ascii?Q?2MruxStETpXiMua42q10AavQR5BIfDC8KIsmzW7XBjHKj4qrCxB7QVx3mQDI?=
 =?us-ascii?Q?GrFo85/Hky2nXTDUa8ByxtJtYeRnwlD48EbbQgXIHKkDv+zinNqs2zw9PM+1?=
 =?us-ascii?Q?8lC2E11BYpVgfWVutw4ueuA3VT0eCuWBcEXuGAIDv6J7LVExaOvu902Sqt8c?=
 =?us-ascii?Q?x8oy8fanuKFS8Azd7393bgaLwLsr5b8o0RzCMa4vGyOZszOVvVgRYU4oEiq4?=
 =?us-ascii?Q?wZSxg4xb1R0l78vHfLBYe0WaSRwOo0mW9tXwvG5ylCsqaDm5ub+rqi7Nq58C?=
 =?us-ascii?Q?RpADMWoBm7o1y03azlwgu0hisvykCOhz2jmx+TRCPdl602VnH074CgZWuXF6?=
 =?us-ascii?Q?/JO0pUHg6MD5myIxNvnzV/1oV9XEKpOReOUxrpWRjzTQ/iaiyIHB81YcQxQz?=
 =?us-ascii?Q?ybM8RW2h9PvKRuhd3ED6wdw4oqoW0ycNSnbZe7MQhrcr+0owuXSdlGKQNxHz?=
 =?us-ascii?Q?1OOZykvo3adILCMpQ2q/UDe0eSiXp/eY2KrarXKUwrXMW7qx9kg+XMvUzf6U?=
 =?us-ascii?Q?kYNdoC70rdHNo+8Kmn+0QGpDR8sV+9t/LJEDqvtl5S5aCfV4x/KJ/tTrn905?=
 =?us-ascii?Q?EsmS7PasJfi/bH964n24b+0lV4pSBu6ckYVb2l1oZ+HY1rAAGKegsnuIMHed?=
 =?us-ascii?Q?6ov6NnLFzBC85WYXiU3G8XookMwzLv5G4l7y8/uO8tDd0Zr+w9LeYe15LmvC?=
 =?us-ascii?Q?Q2Y/LG4wxj84uzw/Ag=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;6:j6ZfxRoTC6etn8G5KkNMbKYwxsWURSwIZA006tbps2YaxIvKxorzcDo2m9wysWvSn4YQYl85NhSeo1fiXQV50bVm5LDeaggdx81rXGOdpurwZaLuNGmX8a7Wfoh0BdpHEddVdyp2I1SNEes07RWC9b5zRVl/nF7GXZDJR7lxBqTM3uMdiptar/1T9ss6BFj8WxtF1Fp0m4weZlsUpZTt2Wpo3GcIRQH+VjEi5rKrUpOYnmtl8BMG3xOW+RuFq1px7vZXsiGm+GnkvcAuDlY+PraFNrbEJAwECRpUXLbTsoSq1Un8ibDAJxsvpfDNSiQRz4gHqFxfolC9MG2E3Iqg+ekGgAKk0dSV460FgX6T+eAIzn7U3jL0Swq+IVByTkd1/BcCy2Rcud4qnWdBiO0TSiFV6nJCjYwkdY3iQAGn6t3fLeWvwcx8nKldStM2J7pOBWFNxItJbj3DHqsz13Lh6OVy+x5NJHV7I0cZV1bSnpaUV6v+/dGU5K2OfSdyFDhWTPWgcxphxzE30tIPmXwQpA==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;5:5K/8HMZ1sAE2E3HHKfmB4SfBOYpUKR39hwqKTMUBCtIV2m+l148LyvdNHO0mIrpxw1tvmxAxX6t8yQtHhJRQ2e3J27s5zCxFMe8XpacmQF7bL6ci5gOSTK3MZeSWHtYy4YalkH5AIJhRdqlkmOocoH3YQl/349zLQ2b/TodMmJ9Q0TNml7Ecnqfw/H81m6Dov1UM/H0XrE4mfsjJXGQgqQtmts0ftb10XvgGWW1v6NqLtm8wO3LjSstrRC00obzfLyAe1JzNljU+RDyhA7oOt83H2380KJRwB4SfN9tssptQYdtcQezfd/Y9+gXaOvLaUX/z4YzMOOdh7LrQX+K4RMPJy9tab5Kr525Q4tUhGimnPlL/d4Bn6Y5KUkntlntMygCqzdQUyisiCFXAG/hNkDctn19/0oa6nK/vMjooCXXiCL0d8ols4SPBlq4YzyuWLjyzX48xJn2+zYGQ1c3fLRoz1B/6v2vEEkHCAtuo0gvgUTZp6gmxmuOgISh1Am0p;24:eoyeY7eyVS09f2GAQg40yvc2SEQiA6RnbQWqH3Rrc20dSniEuajKtFJVzICAMChE+0VswYav5vAeQUxBYnDDjr6n564KOwU39MiTf+Cacew=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;7:U3KiekeKzT755YFM2lfIDLYCwLGHGBpjWO9OszeJrxPVC26Pv4ciMNn4EQI2re20zAnEE28mFW8PbEj8SFhfqwltBXlE0WmjJtWK8xLElPkDC+ZQwcctpoQtAHIPk2wd1kBrdhWVb305Pp/E/n0tZ1B+nt4zTaWhVEJhySgIIvpiJedzOTcK1P+yphlan7LFvrcMJhBNMLh2TOcpYnwiTOibrIktZLm845TvOyB+4/AKOGT2c+L6vxhapBBCNRkgrRf/M9CSQ5rIeXGVPhAcnoCub7lirB5en9Dfe/niC9NS1fZiDoo/royk0C3d5ZlKZjaz30W1LGAPVWZFNEarXw==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2017 23:49:44.3379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3501
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58433
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

Dynamically allocate memory so that JIT images larger than the size of
the statically allocated array can be handled.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 tools/net/bpf_jit_disasm.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/tools/net/bpf_jit_disasm.c b/tools/net/bpf_jit_disasm.c
index ad572e6..422d9abd 100644
--- a/tools/net/bpf_jit_disasm.c
+++ b/tools/net/bpf_jit_disasm.c
@@ -159,8 +159,8 @@ static void put_log_buff(char *buff)
 	free(buff);
 }
 
-static unsigned int get_last_jit_image(char *haystack, size_t hlen,
-				       uint8_t *image, size_t ilen)
+static uint8_t *get_last_jit_image(char *haystack, size_t hlen,
+				   unsigned int *ilen)
 {
 	char *ptr, *pptr, *tmp;
 	off_t off = 0;
@@ -168,9 +168,10 @@ static unsigned int get_last_jit_image(char *haystack, size_t hlen,
 	regmatch_t pmatch[1];
 	unsigned long base;
 	regex_t regex;
+	uint8_t *image;
 
 	if (hlen == 0)
-		return 0;
+		return NULL;
 
 	ret = regcomp(&regex, "flen=[[:alnum:]]+ proglen=[[:digit:]]+ "
 		      "pass=[[:digit:]]+ image=[[:xdigit:]]+", REG_EXTENDED);
@@ -194,11 +195,22 @@ static unsigned int get_last_jit_image(char *haystack, size_t hlen,
 		     &flen, &proglen, &pass, &base);
 	if (ret != 4) {
 		regfree(&regex);
-		return 0;
+		return NULL;
+	}
+	if (proglen > 1000000) {
+		printf("proglen of %d too big, stopping\n", proglen);
+		return NULL;
 	}
 
+	image = malloc(proglen);
+	if (!image) {
+		printf("Out of memory\n");
+		return NULL;
+	}
+	memset(image, 0, proglen);
+
 	tmp = ptr = haystack + off;
-	while ((ptr = strtok(tmp, "\n")) != NULL && ulen < ilen) {
+	while ((ptr = strtok(tmp, "\n")) != NULL && ulen < proglen) {
 		tmp = NULL;
 		if (!strstr(ptr, "JIT code"))
 			continue;
@@ -208,10 +220,12 @@ static unsigned int get_last_jit_image(char *haystack, size_t hlen,
 		ptr = pptr;
 		do {
 			image[ulen++] = (uint8_t) strtoul(pptr, &pptr, 16);
-			if (ptr == pptr || ulen >= ilen) {
+			if (ptr == pptr) {
 				ulen--;
 				break;
 			}
+			if (ulen >= proglen)
+				break;
 			ptr = pptr;
 		} while (1);
 	}
@@ -222,7 +236,8 @@ static unsigned int get_last_jit_image(char *haystack, size_t hlen,
 	printf("%lx + <x>:\n", base);
 
 	regfree(&regex);
-	return ulen;
+	*ilen = ulen;
+	return image;
 }
 
 static void usage(void)
@@ -237,12 +252,12 @@ static void usage(void)
 int main(int argc, char **argv)
 {
 	unsigned int len, klen, opt, opcodes = 0;
-	static uint8_t image[32768];
 	char *kbuff, *file = NULL;
 	char *ofile = NULL;
 	int ofd;
 	ssize_t nr;
 	uint8_t *pos;
+	uint8_t *image = NULL;
 
 	while ((opt = getopt(argc, argv, "of:O:")) != -1) {
 		switch (opt) {
@@ -262,7 +277,6 @@ int main(int argc, char **argv)
 	}
 
 	bfd_init();
-	memset(image, 0, sizeof(image));
 
 	kbuff = get_log_buff(file, &klen);
 	if (!kbuff) {
@@ -270,8 +284,8 @@ int main(int argc, char **argv)
 		return -1;
 	}
 
-	len = get_last_jit_image(kbuff, klen, image, sizeof(image));
-	if (len <= 0) {
+	image = get_last_jit_image(kbuff, klen, &len);
+	if (!image) {
 		fprintf(stderr, "No JIT image found!\n");
 		goto done;
 	}
@@ -301,5 +315,6 @@ int main(int argc, char **argv)
 
 done:
 	put_log_buff(kbuff);
+	free(image);
 	return 0;
 }
-- 
2.9.4
