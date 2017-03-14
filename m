Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 22:23:48 +0100 (CET)
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:38383
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992227AbdCNVV7Dp97P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Mar 2017 22:21:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vele+4qzo1X4g+xFLjYCnM0YU2AmeLDJ4TTuqYWWiJU=;
 b=MnJ8cgzMgskUcuLeNceRPc5IOjtyyfdbzFP8fpl830ELHCHWEi3BCUzI/cfe69baffEXnnRu9cBS7Dsj1Vd7CrHne7etGE4Bp8YgM3YsrixVf1avPcjF8jtXWrEQ0KGPThOSTJWtxtLfI88fs+qF38p632OMXil4FMWZE1c7LM0=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Tue, 14 Mar 2017 21:21:52 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 3/5] MIPS: BPF: Use unsigned access for unsigned SKB fields.
Date:   Tue, 14 Mar 2017 14:21:42 -0700
Message-Id: <20170314212144.29988-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170314212144.29988-1-david.daney@cavium.com>
References: <20170314212144.29988-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0003.namprd07.prod.outlook.com (10.162.96.13) To
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144)
X-MS-Office365-Filtering-Correlation-Id: 311be081-d4be-4bb1-018e-08d46b202284
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;3:LibuxwJ5Ra3ub43GVjhfBSPunsWj1S7wZ9uEOv7Nqe5HEKcqgSAa5klyIiH/BkNENky9UiluhOqN6TptmEJw8HwOFwmY20RW2eVGIFELgMaJCg9kdtMXIMDYFPz2fswpwCmdM5W7HbsVaoepH5t4nt1fw/UGFgRCeKBLuuEed0o2GVdYwQLTyO9yUF78zAQ4QyQHaxLr6xAr5kPotjYj9bIkXjzlfsU50liav2E8Xx/mK8pGuFXYFadQcjMWS2Ii0OtkUcXSLnhBNEXn4nwOKg==;25:6Z8IgC41wyCm0lfP6tUgAHKEzpfr94wMbeLqOY35tuyD2y6Pc8XUxx5+dXQ/j+OG7QCHKtQPZh23TEn/w+ezdWs1ypZ/KgngMfNEhgJ12XrSVTOWcejv35uORhggC4Svoh6HE6Xy2BVXJGwwkIoMcoo8vP+tAaXjedF2d3logXp5CJEVlUKh+Krnvco/5SgKLmHgV2Rv75q8eXd878z8JJoy3V7ek3o2eqJa0TZkV7ciN1Sl3QXstUJ0uDTKc2CdoPWX3E2LZESYtnwbdggO9eQJ9rHuKaV+Dreeku2EqbI1cYawiJUU4DWM+EAtrvwfuVqf7Vf/B0fP6J1ipmP11WGgEz430IAmxwOWh3gt458uaHwsq+qlPDvXO5Iw6C2lyKhvZRwkYVTkc5SBD5z9rHV/KJPWKfkaW3xUTDFNixNWmUN/09B821KjJVzz+jMZGUcgMhHo+tXifSgWmeJzFQ==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;31:FfuW49rF+XgK4+rmkUxOIy+jxYtNcdn3wGCT4aCQFS13cU/7K9f6EL0a9skFqGE1V5oMNhqiV3odgm+qfJmIefsHHwV9AeeZ+HYUzwwVslZvLBdnCv4LcpnlFOUvIPoDSK8A46/vCpYZygWQ/s2cwDGCSML1P0iPJUig2KuDd1KUCj0ZNXF8TTprGgm5+/zsp2NiGHnPRxg2HVaGrhNWN5IW5gV3gilkrjkRM6xNyB8Zj7Bfk3Iok43+jx9XXd7T;20:vi/JbxVhphGrgp+gHGGtmsBVkovs/Ur2BI3q4YUGlTrewmPNIN77Cbk9azD0BA9iXQuuLUgxhFaIL4M3l0wMmOWlte1lOWB2MgzES4Gp9rg3mT44jgoBJ0bNO4JmbWvDe8U/CZKg5vjt6Ifh1QlqNz9ovBqL1m5oVNRwg7fnKSnCv8vo+IWUffIAEkozlqGuxS1LZe9QqYgZAPlPDzOKLPQUJizngSlNsrVLh1Y/2uZEG/ZP7rOQSnLAhLOuAi3q3a9ggexSrFmyBNtWmEEydVzMpb3zNMByRUbsbdrvbpc5zVdlD0vPBbBWPeBUi4/22WtAcHMLS1fPRZ5s0s0NfmfWHBYT+VvOKylpkGENDRX8+qVPYtuXDdD9YTCjvHpcbA93byQ2+3UNsoI+FxhfMeXeRlmVzjW58VdWp/6J+beh+iZgFrlywbspe9Xid8FRAEh+d6VUO8C+JtmSdwOoOzZPNyiBZkuVD1FeuQk6tbf1m28MYpRWXno2Y5d/qhFB
X-Microsoft-Antispam-PRVS: <BL2PR07MB242021D3F9AB0CD272FE058C97240@BL2PR07MB2420.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(20161123558025)(20161123562025)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:BL2PR07MB2420;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;4:eVVswZ126Kq7n37mR6GyRd2Do7ZCo8l3Oi3lL1WEgJc8QGP3T9mvGcUXzJ+F9WYiCbyzbsJleUpHsO8q/to+S/nMSvxBRo2r6pDhuQSo+S2vZq+GQz1jrb79xAGtWdlbk3VJZCyWtKbf/Zzq45hT7jUfA4M+w/8k+TPG9WeJLLfx3/4f7+o5MsQdaC/HadRWpG0MxvcJrew4kD3p8j0LwK/vIkn3UcxTrm0bNIsyns0Jeuo4qgxDkJd0oN9q/yoBFXGQw1U2r86d1AS9eTHs0LnXOa7ZD6AQLO87OEM2NSUWGaX5zyKftsowbUhdmCTJZipqQNuzrMdJeqjPKikZylU1cz7aL8UT/PfuNG0fb6p5PGBgcxV0owHEop2d+3aiMrK5dUj0PWHoAJX0f2haHYsqx05c0QRZ3xARwKNNVW/MiymoRjo5oKZmv6LJH9hQbl1EuyFNaWoYl8ZIbictv1qxXaJd8ttREq6s82kaPRv5mNDApBCVf9pfAWfiNOEvUwyadDxKQUw9K+yj/yyDbFWGaGvjE8tc0pe0hcFlcZm/1lTfbuyh7XmboSJ6GRTgf5SS0A9aM8GRA5Yiz7uwESqgjlio/cma2bF8KlvecEk=
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(305945005)(50986999)(4326008)(36756003)(7736002)(6116002)(50226002)(3846002)(8676002)(50466002)(81166006)(5003940100001)(48376002)(54906002)(76176999)(6506006)(42186005)(107886003)(38730400002)(1076002)(86362001)(25786008)(53416004)(6512007)(6486002)(33646002)(47776003)(66066001)(53936002)(2906002)(5660300001)(189998001)(6666003)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2420;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;23:SlB7h94mwJiKX2Y5zJ8RmXrmyZAqrHN2C6/7xzTQkXv7svJhAdHoiBFrc0suLv4BdinK8TtjzA2mbScYeJ5HFwbUAoEjWbZrPTkWQPjFV18N/mzGMjo554gj6nx4DIpUuggeZal6MFmPMfSdLUiuZZuNfWRN9bAnTNTp0qUhYTNKcE6odSU8RC2IvCeWuhVKEAtZze5O2j+qdtwqyrAT99ty8Lezt+eHRAbOl4q8u6rEl2cesbdk7uFStCQgL57IyZcEXL8oOdZ7YJ8BB0q3uauPcAju7wkKCA+TF1C1byT2Dj5va/4LDCE8uau5+WKv7rlB8hDmEyIUTTojbEQLB2KZ/JaXSk5qcBVT4jrujBECfYNl+O8NpOo3jtCDJg5oSZMfXMHTiXGMSzX6BIqhgtaNtBQYXZK4CugyJzCuF7KtfsSHuA6TY3oW691Ot4oTdRVLn0GfkgoPhcWNj+a81WHhgBY3+T2y2bW6ZepF6TtnzXvTfO8vyxwVOMcKhoBNiKWPT4V2gN3tPRHBM7wXXitBwCfVyApdir8osD9wQzgSMLMsj0eIQ7MsEz2jXYa/UU55f/AZF9Q/FXHHMH1qlbtu91gA+ZFkqKJF/ngxXm1tK5hHw7J4Hm7lsBLTjyXYw273WN/jIfzA9plSt6fKi/JoLVx9lV+eCMaYQYxpNLucRihVtB1FouDp0O6WL26GZIu3RVAjoyRBSBxG64FKYS0IjOV3GN7EBm9BiZVOSWMsmJt+XU1SWhvzLY6Hmvc0O6N1vnI1ptmMlbzBnqpWDS8kQ9UusOHZUxEhU30/gIWPNnzjJ9vMZlCQ/p62TG6xB8KW073s8eUh8uD9M485npbPQr0nrPfqCv+M2L9SE4iF5wjGT2JYK0YTq7XWKsg1SgRs0XQlqlXZ5YbtEhJ1J4DJmWMOYdml5KjLleUAsNYm7Xidgz6gQHaCRyR970gT
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;6:IsOdpHrpx+YIuoRoNKSY+8kQoFvd45KNDwhQMQpKalISNeww5jtIMna9dgiR55MaknEDDniTs3hDnlIAMWowOfG3Jo2zyl8F8w/gUzrMtSrT5hWPY4xI/PlfHFGZcc7Qke95p/MvDAJNqP/z5dTbnbCaRXJRfOvItYwRI+MnILjhto/SJItLPW1TKsENx1Dyh20V2hFdXTMZNwrJ70XvFtZaHJquIcTP7afNBMk1bVZ4MymPtknJRKN1esTZmX84XeMaaTKdoRoLL34kRbKyBdsysGDJsIXzsOUOOuth3LSz6tQff7FcsqfM0MaKyQYPk4SVNdDs6DsmlCKwidXiG69qw6CUHpa7oCaiAwQ1hZctJdeiL3e/ZGhd/ZKBMI3u/bSm41YZ0wdZALs3/5d1Sg==;5:3L87PgswgbsX6PEqAr107mbrXnOvXaaqqIoShf27XlNlzPEv5zdif3t6idh7riTh67Qy3jGlRSGucMN8hEn/jtOaEwA8BrTHFn6m/88q1NGcUPKR3a1KE62rIxk1fg4fi+msiIFUCvS+Oc2d/jArlg==;24:8UbggkTnBkJNfJAozoXQCaCwfU2uazpcB3IU0ZCX0qKn8ch1R191MMvH4/ZefrpsfE03Lvp1lhO9z7WXQiBRWBD1FEY1dZcKVo6SwMePZvM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;7:xjr2u1FHG+AFXZVtW+RhDHPIlspBdvHwFGJSE/9SCNM8XxZ4QER0u80w2wRPM4nkybBfezGXxHjEyRpKFY05q/JRAWGE2Bb8UTIXeSjffRVUxPGsadX88NtsseTv/+ItWVvEapmA3HQVigJ/WF+BfwigUPeWgEbbBQk46inm/BNoOiBrQU5CYu/v07qZMFZ7MZYfBqA3jjJPD6D7ggfUUhylPOPww7Na+aShrb+gxXgB4XXcun4NN8Qjex0yVR06AuGecqldwD/UxoIGSJ2yuLiaMoNTQEOPKgXqhT+xfheBdl5A0cCDs4z9LTxdZmbhUCG0JZuDNUkU4OtFLISS9g==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2017 21:21:52.1096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2420
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57266
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

The SKB vlan_tci and queue_mapping fields are unsigned, don't sign
extend these in the BPF JIT.  In the vlan_tci case, the value gets
masked so the change is not needed for correctness, but do it anyway
for agreement with the types defined in struct sk_buff.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/net/bpf_jit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 880e329..a68cd36 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1156,7 +1156,7 @@ static int build_body(struct jit_ctx *ctx)
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
 						  vlan_tci) != 2);
 			off = offsetof(struct sk_buff, vlan_tci);
-			emit_half_load(r_s0, r_skb, off, ctx);
+			emit_half_load_unsigned(r_s0, r_skb, off, ctx);
 			if (code == (BPF_ANC | SKF_AD_VLAN_TAG)) {
 				emit_andi(r_A, r_s0, (u16)~VLAN_TAG_PRESENT, ctx);
 			} else {
@@ -1183,7 +1183,7 @@ static int build_body(struct jit_ctx *ctx)
 			BUILD_BUG_ON(offsetof(struct sk_buff,
 					      queue_mapping) > 0xff);
 			off = offsetof(struct sk_buff, queue_mapping);
-			emit_half_load(r_A, r_skb, off, ctx);
+			emit_half_load_unsigned(r_A, r_skb, off, ctx);
 			break;
 		default:
 			pr_debug("%s: Unhandled opcode: 0x%02x\n", __FILE__,
-- 
2.9.3
