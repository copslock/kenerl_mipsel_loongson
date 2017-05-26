Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2017 02:40:10 +0200 (CEST)
Received: from mail-sn1nam01on0088.outbound.protection.outlook.com ([104.47.32.88]:46656
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994801AbdEZAijQoQbJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 May 2017 02:38:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JXbt9uZgWOjCD9pxtYd4tNRfTK7oadTa5ZpMxMbouIY=;
 b=PdZjeY39npTWh1vJZzWyewpgtkiJuK7beAbV/fjMrK/dvkMqFMBY/unODv+SMVFBfmF6XzinT0fa2/SfrrNlyyNjuwSzT9+IDjtJQB171HZzbqiQUZ0kx9QOHAtKau/oUQeJoasLpnZcbtbAIV02FyTgV5LHYNW9dF/an7Nid8w=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1101.14; Fri, 26 May 2017 00:38:33 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 3/5] MIPS: Add some instructions to uasm.
Date:   Thu, 25 May 2017 17:38:24 -0700
Message-Id: <20170526003826.10834-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170526003826.10834-1-david.daney@cavium.com>
References: <20170526003826.10834-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0034.namprd07.prod.outlook.com (10.162.96.44) To
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR07MB3500:
X-MS-Office365-Filtering-Correlation-Id: 964c8e90-ecdb-428d-d70d-08d4a3cf8a1f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;3:YTPdq4kVSq0kb/8bLzQbnG0nY1lyBXTzhdA36C5ilX73C89cM1rMZ2rmr/698W2V1/9rz9H6NwmcrxkI+KMSIV9CTylU+8uHlilGmH6NlnOb+cNPOywdAhAfSaokS0PCU5VVzWiRk9dJf6oM32PThuwQali+lp55WTsJzQzzGGI1M6ajvr4A5YxlZWdPjHhlkaPn46e8q38KrkyT0TPhLZrUkN0NcUaILBOrTtbacqhAutveqw5v7WNIUDanWEOoRm6sCX2ct6hO82e7Hu4F3QP7juMJyGj+AJRo3AEJx602YvEDfD959GJPUjWr3ZTcg0RTPXwP2tq2G2CgtHjYRA==;25:zgTTdPS+c3eGaneqRmBEnUMLDEl5sB379jjAttf9rRS4T8KwxeYFTJxJqDEB/a4Xy1/bKjVxN9RE/iMVT2hGJbjd1K8KvrkJEE3RIUPiNpVoLPd12EtX1TORAuRk8/muCMgMQ+PERQ+q3NbP9Rcy38QMZrrqQsw7909PHG8RmFTqesjyZ0g4pskP92sopE6ts/QPmjG3awRApe9OHdtPeogBINGxf9V3gZ4Cqp6qsqzcjtkU0S9Uuh5jVwVSzBbvElNsYKWNnshL6EV1tn2sofBvkh7G1UzaP2XAAV1IQSDnmHbQRXzTrpe4Becummbniolav/cF9CCgPwwTM3Pqvs+J65rsp/4hAvAVJtJm6lrm+HFMv+JsXrhSQZEVhwgjaT+uoUPvWZOzf+//y88s2Ifhzj67n8909GTNidje8w+krEiHUtS0KTkLT0tIwIsvfaDje1prHRhgRAnQ0mEn3zE2M3L9XzyS3hW9qpcWB80=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;31:LgcEZToPEI9hP49RP+ofSR2+Gtu1bD4soIwlwVV91+2uAHE5kyZsI2UHzIsuGXC+YeWcCFDs9BbR4+MOZwdVPZRcyB7cXmCWdU/WsdmGljY/Yz1l/Cw9dJkJl6/TJBG80GmHGqRzUbxpLRW+DESKQEq8bfCR68cjLDbM0ziY2qQN2ZnVXAew/YCijS0DbRnAFaVTfYxm9qsuuf+5UlEuFijhtHJqPwwtzZeKek5EN5s=;20:99SRRkiDaWK3WYcYOqcxBcgH/1MU51uaUpBjKuXfUFSNvaqTz33kbqKx4Q+Jxh6IQaAYm800f3yGdD1JJSG5o/yXA3BQLfTIGxGveSkJHpdJzzS/uIPMLS9OHFK3nT+BdRSddF7D5CdUXmWy8FZse81j97ckCnkLiSIeJEzqgAaDsSpGXKDVorzdLWE14pliIaHNSsep3lPWQF25ndB7/6HP4sMBb8/PpkMqbIFBdkj2yPRa4cYV8PwAOeFVKtWDuNLOuZ5P5+jwDzOor61PnVNxU1EK8iLO7Dgi+cEPC+aUgLq8TOZcoERMgN4aBKEZDl9vyLbkcQ7mwdIIzLjFk9/FkQqjJi6NOGJ7LZBm9K24ThxvLWJ+xxf+fqEJZL2WmjXlUdXckYAOB0KMIat58Gfn37CkwoDyQH1RSOo3dfckQW6Mchj1zs/2M0iFRlVp8hNfAs2kTob8/5wjQkxrYW+RYg4+ams5WBVN2TtwkowmUFdPNai3byQWGzc1kzMi
X-Microsoft-Antispam-PRVS: <DM5PR07MB3500979ADD98B99FC90EDFA697FC0@DM5PR07MB3500.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123558100)(20161123560025)(20161123562025)(6072148);SRVR:DM5PR07MB3500;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;4:HbyOaKVlatusGFf1szeyydzTFGMdbPmD09Px9EXL5OdwdIsYA0CQsbu1x0CZtecOZcLb/xsf53EqbrW4oAh2FPHqXrwXQ/NGdIlBOOt5Lgs2qiESGL055/ZW+MDFnWvYXinPPxhCvV48PR6dx5R0tYuuetR84I52K1cyhQGM7v64na+nGD5I3D5gaZBPaL3gY+/cQY6xWHFHmvR3aYkuq69HkANr2k5GCW2cOfNr3DE3WQ3iHPeXs3qeOUu/m+xGpRRK7Nciu+hNpdxFbG+pHhSgGN8DEyIGdhJFLCZ8Ps3kzuJJHOTUuAjQWFWXb9UGvB1yWcsVwVlLwrnYdhL+cBe/XgnAcf7XEvF3aVQ3qQWnjTXWli/b7fR50z3XAoeRwpupk7ADS6KRlLbUd1hP9gQ3eyBcUZG2Pn4CZvfZSkP30gVrz+OYL7efYzTPJOFhUzc6scQb3VE4jmr5XABO7JvvM1PT1KxHnUW1p2x580O2sWQuloJITHLuAwQj5g9Pm1G0RwsT17XxNCGE6bJ/UtupiIiTX9aJszv3FJybRiYzTRdPxZaPPze4DIZOa7ARWjJEryDf2C1omgfMthffKrgoypNfGze9e5j05Lz3LloH8eFu5ETefKrJX1fpVWV49tmr0g2LUxREicl6DBC0S9t7tQ+E2E13efmab+VdgYWTe/i47VnOzj/qsdqbWi1L/jJb98JnCqS9xpudqLj/KbRETgMfF9cUoYQsMLTKkOgcvWJXIttUM1nDPJ9AS4WCm2Lh1e0HijylDw96PIH6N52yqOztKofSdTjvF+cXvLU=
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(39400400002)(39840400002)(39410400002)(39850400002)(305945005)(3846002)(5660300001)(7736002)(2906002)(53936002)(6512007)(25786009)(189998001)(478600001)(1076002)(107886003)(38730400002)(72206003)(81166006)(5003940100001)(6666003)(66066001)(47776003)(50466002)(8676002)(50226002)(42186005)(76176999)(53416004)(50986999)(6506006)(86362001)(33646002)(2950100002)(4326008)(36756003)(6486002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3500;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3500;23:oVys67ly9FZMiVu8jnYPaCdkB+6hChNcMKINfTtXq?=
 =?us-ascii?Q?/71xZuwYlBFADnjMbKw5M4+Bvzy3502hI09VRah6BdGIIaxjJ3ZMeXomLyTr?=
 =?us-ascii?Q?pyIJHjjaTAVs9mqbrIf1uTkGlBLSRDa4qInIwGXPbu3GztS4TnSFMIJCEzya?=
 =?us-ascii?Q?Rcmu2CUQw3ZoxqoRdxnDeKGSCWmJM4405uHP0O3uE61wgbo1cKLe1q5irek1?=
 =?us-ascii?Q?G3c4UpHNQB5015yOlrRXwWtnKdMpP5ro+3du/2iwX0z+oSLaWPzEz2VAxmcL?=
 =?us-ascii?Q?UX/7xe+ePBwZ/HH9ALX0KiOyN9M8Rv/EIcd6wC0FZbjkqvV/D2m4RUykhKWZ?=
 =?us-ascii?Q?1nNE+tQfT+t1aceXqTU5qJz5xisNvqFi77ig93Kh9yPvPrvnADD3Dnz64a2W?=
 =?us-ascii?Q?IAp6auVX4DXOljKnqJM9Q0UOeTcq0lNIzcYw7CYXycRkpfL+fTEkTEREMq0J?=
 =?us-ascii?Q?IzMFurIuDkFnOiXDdfKwisH0P7z4L+xpF8O6gGS7MvOMPGLRo/d4O0PVlLfv?=
 =?us-ascii?Q?b/FqcbCUUGFC1hEJAU0B/B4ulczx+W3vk8ejeZPe4EWlOVzraGtqp9UVx1nH?=
 =?us-ascii?Q?2YDg9sAw3Z7Utoq5s13gLEb+cLkxc6Szb/ZR5rrc73BLlRQxliIvRuccoBpF?=
 =?us-ascii?Q?JOYwfQBe6U8qV3mkA+p5U5hMc7oB5g8M9pjn+n6zYSf7+TGWUJxT/oldqLZ/?=
 =?us-ascii?Q?AUEeXDoPNtOa9hwKzTDoA1K19GxuDvvUmAKwlpVrTdb0W6HmXsjH1A+HyHNU?=
 =?us-ascii?Q?JWXFz2N38OAg6H3UzuFLuXXzivopbRo2h11AX4kOjBujCMfpdSl3frA6BKPW?=
 =?us-ascii?Q?/5zGTqALAZzFNs5i31HX8mFE4470/scTYZyN/0rQdzM5Kk3CPLuGN9fI1Rh/?=
 =?us-ascii?Q?dbKBLD4vlSA+GvCn0Ae+WHuCjSBrVPKdmbMJ9gB5J93+UmlzB0g+t7U51WT4?=
 =?us-ascii?Q?NkPis13pqs83GYItR1oFLToDCsELhqV7U5UrmWFb/b/ZXMUH5pTLZmG/0jZX?=
 =?us-ascii?Q?GnmaTsqBBoL6wd6tmKmUfvXVitZxZ62GZfEgKxbk/flrhWVwpDElqojEbGQi?=
 =?us-ascii?Q?HyB4uk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;6:JQWWA7cJOeH/VlzzIAIQZ0/kxqA/jKEAFRz2CgqjuOwI0OomKNS3vl/RhxDts1Emwkgm2og1RlctJ0GNN7ioHRDgJmVkk56liGqCQkch1dIkRzFa37TDf4DjwbN6fX6XKpXDI7PyFHUclTqE8Oz2psDrpyf/iSPnuDnnMIV9VeUvtS6qafidkBF0zLUXW/IRqRQl0Hv9uwTsB0+JIO8c554RI7z3NiUXfMvfjxRYryQEaBE729T8qdc2pMF/wOgzbE+sKe0xkmRg1pXZExaECF1Jy6UO4BjTTY1ZMDIz9c5NYctd2+R6jBmhn87XZIiThcqGinTi2yAP1NBRqnJXnVI6AmSAvx1eojYQ4Ws9lBxI/jVzPeJKcSkZjxYOi3kkf9wbowqFO2Fn1ApMwee5GsM2+fneaLyc0pjy9rugjKTNohR2YijmVFM76uo12qddrduBB2+Ul/e9eyGNajvXhje03Illgh4GZVaMqiVzDcm16h3l0yXO4AIr/MSRJRzsWmsaSKFzwadOHE91P2VS8Q==;5:vaKzzlCiesmPF/XOsfT7zfXeazhQHMr9JTWU1ZG2lHpR/H1hfVlQJVouZxTcbPFQSz4XNN+eXo82XG6aOxVsGNYlfnD1OoJGARxyvJFMvq1+XB5dKuPSD7IjDD+/RTsM68toaGbh8Pgl4MSlXT3LOFWskPagOASluTGY4dgYYCM=;24:KWH+CIEHBnL9sG2krhzmYf2oNUVpGZmpLiwCwJUBS7oMz/mfaoxcO7cbbRvg6XrTj95sC+IrvqNVPl2zTzd0wUiffO+gJeJmXVQ1tpu0bek=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;7:97IHfA+unu1SUDDST/R4i8OSK435bnrqGb34lBaqqwke4VSlVZLLLzrce2lJ/dt6vfy2p0hIQ05c3qbG38ZzkQ6Z68s6XrZMfI9usINKqCXmjf48O80Na6NamaV+XxZeWe5TYeSqVn8SqFEe6rKTkKx3DgkNCfv29mbhyn7daAAQ0lbHrsAVuhoeFfBx84cWD+tYe4ENoeePCi0GvZFbEuuzxlhSuM0hK3G9x3T2DzIyTldjEjKfpntGQlOeMmS+NyvQiKe3lBESOyGPw+OYIpKw/cZNk72I97hwllQD1grOW1Tmy67gGk+iOzFq5VkyD0LO85EWUbL3DEKlilYHtg==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2017 00:38:33.0438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3500
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58011
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

Follow on patches for eBPF JIT require these additional instructions:

   insn_bgtz, insn_blez, insn_ddivu, insn_dmultu, insn_dsbh,
   insn_dshd, insn_dsllv, insn_dsra32, insn_dsrav, insn_dsrlv,
   insn_lbu, insn_movn, insn_movz, insn_multu, insn_nor, insn_sb,
   insn_sh, insn_slti, insn_dinsu

... so, add them.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/uasm.h | 28 ++++++++++++++++++++++++++++
 arch/mips/mm/uasm-mips.c     | 19 +++++++++++++++++++
 arch/mips/mm/uasm.c          | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 3748f4d..624d14d 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -72,6 +72,8 @@ Ip_u1u2s3(_beq);
 Ip_u1u2s3(_beql);
 Ip_u1s2(_bgez);
 Ip_u1s2(_bgezl);
+Ip_u1s2(_bgtz);
+Ip_u1s2(_blez);
 Ip_u1s2(_bltz);
 Ip_u1s2(_bltzl);
 Ip_u1u2s3(_bne);
@@ -82,19 +84,28 @@ Ip_u1u2(_ctc1);
 Ip_u2u1(_ctcmsa);
 Ip_u2u1s3(_daddiu);
 Ip_u3u1u2(_daddu);
+Ip_u1u2(_ddivu);
 Ip_u1(_di);
 Ip_u2u1msbu3(_dins);
 Ip_u2u1msbu3(_dinsm);
+Ip_u2u1msbu3(_dinsu);
 Ip_u1u2(_divu);
 Ip_u1u2u3(_dmfc0);
 Ip_u1u2u3(_dmtc0);
+Ip_u1u2(_dmultu);
 Ip_u2u1u3(_drotr);
 Ip_u2u1u3(_drotr32);
+Ip_u2u1(_dsbh);
+Ip_u2u1(_dshd);
 Ip_u2u1u3(_dsll);
 Ip_u2u1u3(_dsll32);
+Ip_u3u2u1(_dsllv);
 Ip_u2u1u3(_dsra);
+Ip_u2u1u3(_dsra32);
+Ip_u3u2u1(_dsrav);
 Ip_u2u1u3(_dsrl);
 Ip_u2u1u3(_dsrl32);
+Ip_u3u2u1(_dsrlv);
 Ip_u3u1u2(_dsubu);
 Ip_0(_eret);
 Ip_u2u1msbu3(_ext);
@@ -104,6 +115,7 @@ Ip_u1(_jal);
 Ip_u2u1(_jalr);
 Ip_u1(_jr);
 Ip_u2s3u1(_lb);
+Ip_u2s3u1(_lbu);
 Ip_u2s3u1(_ld);
 Ip_u3u1u2(_ldx);
 Ip_u2s3u1(_lh);
@@ -117,22 +129,29 @@ Ip_u1u2u3(_mfc0);
 Ip_u1u2u3(_mfhc0);
 Ip_u1(_mfhi);
 Ip_u1(_mflo);
+Ip_u3u1u2(_movn);
+Ip_u3u1u2(_movz);
 Ip_u1u2u3(_mtc0);
 Ip_u1u2u3(_mthc0);
 Ip_u1(_mthi);
 Ip_u1(_mtlo);
 Ip_u3u1u2(_mul);
+Ip_u1u2(_multu);
+Ip_u3u1u2(_nor);
 Ip_u3u1u2(_or);
 Ip_u2u1u3(_ori);
 Ip_u2s3u1(_pref);
 Ip_0(_rfe);
 Ip_u2u1u3(_rotr);
+Ip_u2s3u1(_sb);
 Ip_u2s3u1(_sc);
 Ip_u2s3u1(_scd);
 Ip_u2s3u1(_sd);
+Ip_u2s3u1(_sh);
 Ip_u2u1u3(_sll);
 Ip_u3u2u1(_sllv);
 Ip_s3s1s2(_slt);
+Ip_u2u1s3(_slti);
 Ip_u2u1s3(_sltiu);
 Ip_u3u1u2(_sltu);
 Ip_u2u1u3(_sra);
@@ -248,6 +267,15 @@ static inline void uasm_i_dsrl_safe(u32 **p, unsigned int a1,
 		uasm_i_dsrl32(p, a1, a2, a3 - 32);
 }
 
+static inline void uasm_i_dsra_safe(u32 **p, unsigned int a1,
+				    unsigned int a2, unsigned int a3)
+{
+	if (a3 < 32)
+		uasm_i_dsra(p, a1, a2, a3);
+	else
+		uasm_i_dsra32(p, a1, a2, a3 - 32);
+}
+
 /* Handle relocations. */
 struct uasm_reloc {
 	u32 *addr;
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index f3937e3..400012a 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -59,6 +59,8 @@ static const struct insn const insn_table[insn_invalid] = {
 	[insn_beql]	= {M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
 	[insn_bgez]	= {M(bcond_op, 0, bgez_op, 0, 0, 0), RS | BIMM},
 	[insn_bgezl]	= {M(bcond_op, 0, bgezl_op, 0, 0, 0), RS | BIMM},
+	[insn_bgtz]	= {M(bgtz_op, 0, 0, 0, 0, 0), RS | BIMM},
+	[insn_blez]	= {M(blez_op, 0, 0, 0, 0, 0), RS | BIMM},
 	[insn_bltz]	= {M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM},
 	[insn_bltzl]	= {M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM},
 	[insn_bne]	= {M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
@@ -73,19 +75,28 @@ static const struct insn const insn_table[insn_invalid] = {
 	[insn_ctcmsa]	= {M(msa_op, 0, msa_ctc_op, 0, 0, msa_elm_op), RD | RE},
 	[insn_daddiu]	= {M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
 	[insn_daddu]	= {M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD},
+	[insn_ddivu]	= {M(spec_op, 0, 0, 0, 0, ddivu_op), RS | RT},
 	[insn_di]	= {M(cop0_op, mfmc0_op, 0, 12, 0, 0), RT},
 	[insn_dins]	= {M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE},
 	[insn_dinsm]	= {M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE},
+	[insn_dinsu]	= {M(spec3_op, 0, 0, 0, 0, dinsu_op), RS | RT | RD | RE},
 	[insn_divu]	= {M(spec_op, 0, 0, 0, 0, divu_op), RS | RT},
 	[insn_dmfc0]	= {M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
 	[insn_dmtc0]	= {M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
+	[insn_dmultu]	= {M(spec_op, 0, 0, 0, 0, dmultu_op), RS | RT},
 	[insn_drotr]	= {M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE},
 	[insn_drotr32]	= {M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE},
+	[insn_dsbh]	= {M(spec3_op, 0, 0, 0, dsbh_op, dbshfl_op), RT | RD},
+	[insn_dshd]	= {M(spec3_op, 0, 0, 0, dshd_op, dbshfl_op), RT | RD},
 	[insn_dsll]	= {M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE},
 	[insn_dsll32]	= {M(spec_op, 0, 0, 0, 0, dsll32_op), RT | RD | RE},
+	[insn_dsllv]	= {M(spec_op, 0, 0, 0, 0, dsllv_op),  RS | RT | RD},
 	[insn_dsra]	= {M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE},
+	[insn_dsra32]	= {M(spec_op, 0, 0, 0, 0, dsra32_op), RT | RD | RE},
+	[insn_dsrav]	= {M(spec_op, 0, 0, 0, 0, dsrav_op),  RS | RT | RD},
 	[insn_dsrl]	= {M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE},
 	[insn_dsrl32]	= {M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE},
+	[insn_dsrlv]	= {M(spec_op, 0, 0, 0, 0, dsrlv_op),  RS | RT | RD},
 	[insn_dsubu]	= {M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD},
 	[insn_eret]	= {M(cop0_op, cop_op, 0, 0, 0, eret_op),  0},
 	[insn_ext]	= {M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE},
@@ -99,6 +110,7 @@ static const struct insn const insn_table[insn_invalid] = {
 	[insn_jr]	= {M(spec_op, 0, 0, 0, 0, jalr_op),  RS},
 #endif
 	[insn_lb]	= {M(lb_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
+	[insn_lbu]	= {M(lbu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
 	[insn_ld]	= {M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 	[insn_lddir]	= {M(lwc2_op, 0, 0, 0, lddir_op, mult_op), RS | RT | RD},
 	[insn_ldpte]	= {M(lwc2_op, 0, 0, 0, ldpte_op, mult_op), RS | RD},
@@ -119,6 +131,8 @@ static const struct insn const insn_table[insn_invalid] = {
 	[insn_mfhc0]	= {M(cop0_op, mfhc0_op, 0, 0, 0, 0),  RT | RD | SET},
 	[insn_mfhi]	= {M(spec_op, 0, 0, 0, 0, mfhi_op), RD},
 	[insn_mflo]	= {M(spec_op, 0, 0, 0, 0, mflo_op), RD},
+	[insn_movn]	= {M(spec_op, 0, 0, 0, 0, movn_op), RS | RT | RD},
+	[insn_movz]	= {M(spec_op, 0, 0, 0, 0, movz_op), RS | RT | RD},
 	[insn_mtc0]	= {M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
 	[insn_mthc0]	= {M(cop0_op, mthc0_op, 0, 0, 0, 0),  RT | RD | SET},
 	[insn_mthi]	= {M(spec_op, 0, 0, 0, 0, mthi_op), RS},
@@ -128,6 +142,8 @@ static const struct insn const insn_table[insn_invalid] = {
 #else
 	[insn_mul]	= {M(spec_op, 0, 0, 0, mult_mul_op, mult_op), RS | RT | RD},
 #endif
+	[insn_multu]	= {M(spec_op, 0, 0, 0, 0, multu_op), RS | RT},
+	[insn_nor]	= {M(spec_op, 0, 0, 0, 0, nor_op),  RS | RT | RD},
 	[insn_or]	= {M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD},
 	[insn_ori]	= {M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM},
 #ifndef CONFIG_CPU_MIPSR6
@@ -137,6 +153,7 @@ static const struct insn const insn_table[insn_invalid] = {
 #endif
 	[insn_rfe]	= {M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0},
 	[insn_rotr]	= {M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE},
+	[insn_sb]	= {M(sb_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 #ifndef CONFIG_CPU_MIPSR6
 	[insn_sc]	= {M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 	[insn_scd]	= {M(scd_op, 0, 0, 0, 0, 0),	RS | RT | SIMM},
@@ -145,9 +162,11 @@ static const struct insn const insn_table[insn_invalid] = {
 	[insn_scd]	= {M6(spec3_op, 0, 0, 0, scd6_op),  RS | RT | SIMM9},
 #endif
 	[insn_sd]	= {M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_sh]	= {M(sh_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 	[insn_sll]	= {M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE},
 	[insn_sllv]	= {M(spec_op, 0, 0, 0, 0, sllv_op),  RS | RT | RD},
 	[insn_slt]	= {M(spec_op, 0, 0, 0, 0, slt_op),  RS | RT | RD},
+	[insn_slti]	= {M(slti_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
 	[insn_sltiu]	= {M(sltiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
 	[insn_sltu]	= {M(spec_op, 0, 0, 0, 0, sltu_op), RS | RT | RD},
 	[insn_sra]	= {M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE},
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index f23ed85..bae08d4 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -61,6 +61,10 @@ enum opcode {
 	insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall, insn_tlbp,
 	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh, insn_xor,
 	insn_xori, insn_yield, insn_lddir, insn_ldpte, insn_lhu,
+	insn_bgtz, insn_blez, insn_ddivu, insn_dmultu, insn_dsbh, insn_dshd,
+	insn_dsllv, insn_dsra32, insn_dsrav, insn_dsrlv, insn_lbu, insn_movn,
+	insn_movz, insn_multu, insn_nor, insn_sb, insn_sh, insn_slti,
+	insn_dinsu,
 	insn_invalid /* insn_invalid must be last */
 };
 
@@ -214,6 +218,13 @@ Ip_u2u1msbu3(op)					\
 }							\
 UASM_EXPORT_SYMBOL(uasm_i##op);
 
+#define I_u2u1msb32msb3(op)				\
+Ip_u2u1msbu3(op)					\
+{							\
+	build_insn(buf, insn##op, b, a, c+d-33, c-32);	\
+}							\
+UASM_EXPORT_SYMBOL(uasm_i##op);
+
 #define I_u2u1msbdu3(op)				\
 Ip_u2u1msbu3(op)					\
 {							\
@@ -264,6 +275,8 @@ I_u1u2s3(_beq)
 I_u1u2s3(_beql)
 I_u1s2(_bgez)
 I_u1s2(_bgezl)
+I_u1s2(_bgtz)
+I_u1s2(_blez)
 I_u1s2(_bltz)
 I_u1s2(_bltzl)
 I_u1u2s3(_bne)
@@ -272,17 +285,25 @@ I_u1u2(_cfc1)
 I_u2u1(_cfcmsa)
 I_u1u2(_ctc1)
 I_u2u1(_ctcmsa)
+I_u1u2(_ddivu)
 I_u1u2u3(_dmfc0)
 I_u1u2u3(_dmtc0)
+I_u1u2(_dmultu)
 I_u2u1s3(_daddiu)
 I_u3u1u2(_daddu)
 I_u1(_di);
 I_u1u2(_divu)
+I_u2u1(_dsbh);
+I_u2u1(_dshd);
 I_u2u1u3(_dsll)
 I_u2u1u3(_dsll32)
+I_u3u2u1(_dsllv)
 I_u2u1u3(_dsra)
+I_u2u1u3(_dsra32)
+I_u3u2u1(_dsrav)
 I_u2u1u3(_dsrl)
 I_u2u1u3(_dsrl32)
+I_u3u2u1(_dsrlv)
 I_u2u1u3(_drotr)
 I_u2u1u3(_drotr32)
 I_u3u1u2(_dsubu)
@@ -294,6 +315,7 @@ I_u1(_jal)
 I_u2u1(_jalr)
 I_u1(_jr)
 I_u2s3u1(_lb)
+I_u2s3u1(_lbu)
 I_u2s3u1(_ld)
 I_u2s3u1(_lh)
 I_u2s3u1(_lhu)
@@ -303,6 +325,8 @@ I_u1s2(_lui)
 I_u2s3u1(_lw)
 I_u1u2u3(_mfc0)
 I_u1u2u3(_mfhc0)
+I_u3u1u2(_movn)
+I_u3u1u2(_movz)
 I_u1(_mfhi)
 I_u1(_mflo)
 I_u1u2u3(_mtc0)
@@ -310,15 +334,20 @@ I_u1u2u3(_mthc0)
 I_u1(_mthi)
 I_u1(_mtlo)
 I_u3u1u2(_mul)
-I_u2u1u3(_ori)
+I_u1u2(_multu)
+I_u3u1u2(_nor)
 I_u3u1u2(_or)
+I_u2u1u3(_ori)
 I_0(_rfe)
+I_u2s3u1(_sb)
 I_u2s3u1(_sc)
 I_u2s3u1(_scd)
 I_u2s3u1(_sd)
+I_u2s3u1(_sh)
 I_u2u1u3(_sll)
 I_u3u2u1(_sllv)
 I_s3s1s2(_slt)
+I_u2u1s3(_slti)
 I_u2u1s3(_sltiu)
 I_u3u1u2(_sltu)
 I_u2u1u3(_sra)
@@ -339,6 +368,7 @@ I_u2u1u3(_xori)
 I_u2u1(_yield)
 I_u2u1msbu3(_dins);
 I_u2u1msb32u3(_dinsm);
+I_u2u1msb32msb3(_dinsu);
 I_u1(_syscall);
 I_u1u2s3(_bbit0);
 I_u1u2s3(_bbit1);
-- 
2.9.4
