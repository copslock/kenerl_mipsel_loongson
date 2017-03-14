Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 22:22:25 +0100 (CET)
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:38383
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992111AbdCNVV5vhKyP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Mar 2017 22:21:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jERgHMNeo5Z9Eb05xyXzSiprJY+YuNkJ7EtIzkl0S3A=;
 b=DdKcQ/ZQBcn3C9k655aQytU5oTU+KKyM2KJeX9YX3HOMFudptKGNTwEBPrzUz9OPPwjaSlzjh7tVN22d2LOcGJUGk2IZEGCtBv1TzGM49pU5wx37Xz0unMUx+xEMO77KY3elLojz73w2dWf3l64lW7YFHPt+cRU+XwtWnrG8FAY=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Tue, 14 Mar 2017 21:21:50 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 1/5] MIPS: uasm:  Add support for LHU.
Date:   Tue, 14 Mar 2017 14:21:40 -0700
Message-Id: <20170314212144.29988-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170314212144.29988-1-david.daney@cavium.com>
References: <20170314212144.29988-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0003.namprd07.prod.outlook.com (10.162.96.13) To
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144)
X-MS-Office365-Filtering-Correlation-Id: 66ca49a8-a76a-4cba-0dc4-08d46b20214e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;3:Twfb1WW4vOnejWEVbpxBlUaJi51duft8/KGYPm9U2Licfqq2tuanjW5AAlnGWrp29aQ/yUzQ2SJqJRXfgu/FrFgNUu3/oDlk1uEg15k+GYfAunUeDX80RZdevicfMOHzZQTPC59WBYZZXTzVilflL7EFCbynS1IzDRqE7GASykm3EkSn3DTSiFBOEKwRN1I8FKOgSkSd4Us7FRF8dhXF+Zfhcfv148nBR3cUzScRL3PoY2K2I3mI+9FLFxM3QFubFKhIidvGMd6MZeG1Pd9K8g==;25:UnE49Jqp1I+WgT25aiHls8bkRupx+QeDmg2D5cmUz49U6ucR1ZDV1cs3usPA7yEhmCzxz1tk8bHpwpZ2p/2pRFWjV6efMy7t5uylLRyeGDLwBjGNDNGmf+7S76mA1vH0w2c1LRqD0TR4AQefXmfVKdtydnffclS9tTleALm/n35bc8Y8/IA5Ga7SvHgukX2zMiYlWQHftzaJBG4y51KnOaCBdNdp7/wBEmtfH7Zr5hXOZLq9IWQMEnQR11O8gCnByFJx/S3ZeMSr6dgIS4BfutMBrT+wNJth8L/8iPDf52y0mbw7rfhFX/G0KOByor40w4w4dBgQWjL5mM75dkOqtXfd6+0rT4XWkcDV5omQBEAPHwf9efslGtOSiaER4mIj6r3tVHXeWnmEmgmHiJbxNlmrNAfrL4qVxVlEiBGghFL3RFOWL+thPdTjRGqoCHPSMfxJ2nEl/RElqDWEuEnjbQ==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;31:SSGwPFrjG9Uke/0oxGeU7kag/fOx+OR0UyKare3Qocc5ZU7Mgy6siR+VPB8JUoWzo70rSzcqYNlEkwVHEmJdveIYropd8lNzzgSoJTVdyDwJN4IN5j20l8fomBVPsRQkWOhqpLA6LS2G5g7X5SwYNfQ9isuQdO5U2OrkDPFMeW9KO/URXQotsRAN7lhpE3vyjqGLDjvq0bMVqnFYapiTZmnifMFGsCAduSCuJQQE3g0=;20:jKWW4y6vzNsx0mOpQ6Skm1UVnSD/W+9sXx91dQGaIyc+/3cO2Rg9rv833QKtM0gkgx4bbC0a242bsgEAz+6vGTayCkOysga9B5hPlQXkQR8K5XgOywJtLnaIMwJQIFF12CXamk0nlbG6e+EKSoxV5+e7iuc+R/yZdKtRizXmcu85/J7DHtSsN2MpO3qRAQUmvRm+Kix/dGZjjicPS/fFOWnvU2ZU9WEp2ZrccOvSQtWIPQ1UcX3IdS2ya8yzUMc310DeyDi2dSGrMyNOLwAqT24okE/35BBR1FxcsUclM5pqnANttL1qpqHUfsszS5VchLvYmC6JUGxBtfwLoOxkPXOp2FiFQayQkB2hiTMj3933lnDwGDG5ij58teu+QeTfj+qomi4t/6yYa19rfV57sbXmAqRS8f6kwtGGhPhWQoL2fGavEzXFSdl1A5q2aw6bUnU2pqrcvRArdEL9/gGl/dbF4SGGfHwcSzNw7F6w+q/8vKBfQ90ivsC4kxoYntZx
X-Microsoft-Antispam-PRVS: <BL2PR07MB24207BC357A95C5C69C3456A97240@BL2PR07MB2420.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(20161123558025)(20161123562025)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:BL2PR07MB2420;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;4:S9UqwJB8L2FqS/YqZymeq5k3piGwJychyu9wAiMBIz0qoNh3A8bOj4mNLHhvpYteRtscQkfzuC0wuzWXlKNOf+pZ/IInBWyJu9tLlWpYnQLBa9B0PRXyhly0bA5mXRLFYeYPVQB5ysEdjlmVzbfbr3tXpvoEd1v2GUXjrbXBDc94Z6ttMdMK83RSUtAxyEAmgsULRrkm+7gXUMRtxfIwSOM02QQtx8UjWfodtT6SZnnzkGths3RXC0eRoeHnflVrG7j1KXFJj5s7I/FkcWGptfJ5gpr5PhcGGyJSeHs5BI8/GpOAqh8Nd+xp0hDkoyiTPfRTxJq3hRnmEEeqWzQlu8PZCgGf6Olmd6V+yOx3hpdBF1BEeoptdarHaiRH4G5EcBi2Gxc8AtxK/6PZ/wX1qQ/bYpuYooxuiNfuY6pasaZ7lj0/3ZvLI/t8owFgOlWW3gIvdAOc30Z9ssB0LLta+/cCbee94Aq8o9S4mMVife43ZSRLVpTfFEU+xooVd7Y5U6ELYVXlZJw9l1tUt7t6HAcnh3oKgpGciPqvKgbr0uS72vRIx7WrM3S4c1dvia+ytCeLKG9RTgx0fLf574USP4J5/kocU09nz5r8Vrhv9vg=
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(305945005)(50986999)(4326008)(36756003)(7736002)(6116002)(50226002)(3846002)(8676002)(50466002)(81166006)(5003940100001)(48376002)(54906002)(76176999)(6506006)(42186005)(107886003)(38730400002)(1076002)(86362001)(25786008)(53416004)(6512007)(6486002)(33646002)(47776003)(66066001)(53936002)(2906002)(5660300001)(189998001)(6666003)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2420;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;23:3UsiwFbscRlr2EuPBG2rPB1UEYqkmr6mnK3SAxtwxGlS1l9kDem/oNWPcW6E1nvVEjQjsEdVg400IQdjzTak7olq5HpHPQoHxl+W2FZgHObbbzklz2JSxZvan5APUQif0hSAVqAcu0OIgrNE5xLKIiPlpci0VzthFcdWPSPM4oaPbzQQ4/zbLiKGiQ9qQXGlXz9ACkN1/q1by4Uf/I1UfIEyKJB4CsNLtkKFcuLxmoTbUlJxVbj2EC7YwrZVczgYafcWvQB9BCV9mxEKsRTYdX10RmyLxuhnYzt5Cuj9+1asOYEZsg440/tlJAkyg/6A6Z2z8VeFVq63eHePHjL/jUzfKJZqwByspLhAIIxzb4dOmccIaXT2jQKBBE8rws7UuwjQ8ESBTkdy5YUN5Dp4BZBRSRZo6fJ8GHFrvYo5DDENvv1cwtG3jZbLoIyqaUtkd5tWVHRCL9/P1LsijAgXON3K+QujCClZTaB0Wup+D/Wkm6wrkVF8lXoww7rNv7yK0bYBHCut7sRETvobdcJslVAJG93GUl9m4tvom1kcDiC0ttkcG/8c3t1aRutXdtEp3Z///G9GKAa5KgC0CCHHZJa8qvHnVBjV1luFINvs/NneKOQ8SGJ06Kgae1OBKIYReFVQmeaZhLPgZZodDlHu6nUItS63nPm0JE6C1yoWXYc05rKGcKhS+aT66hh0IjF+Mt89bAJMvzStnd5qzapjt259v0J59VvtuisRpukfbHcoX/YOAtnqwhlx36jkhhH1/wgehLBd9on5NlPaFmu8G32dNT6epzsrBIki3SwwChWFa0wn4qguAiQWUXGip9LNh9PIm1ipU5f1wB1dA3FJE75VSKQ6CE31+MD58W0TndT/23n2PYz3GXoxa4Mrt1PYV+6NIcawpI+P4baw5+z6UQjFRb/8+MLjZ/8MTQ7LmoJLAjVBs8AqjSdLf9B5gNGo
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;6:Q2tfyF04zfwQKstTmoJXoj5oMABZox/hn1myp0U/9ldSkHCu0jyjcBPQVAEbPAZcW01VTSMSvRExT6cVK5O1RtN3qEf+shETcex/IZzTj2p4xb2xA/YLhRlq/CPlXqi1qEJfV5Z42yO7sOwvly2xQsz/hiVbFyzZY9JoiOvfUbe+c8lpvWoBFG3EuP4J2YBnSXXCrAd3U8EuTd3eGIy+V8WXIm/67IaEBXM+Vbmw19aw9iAmkZXybAfHQLgAMhTzCfm4EH0OLJOD8oGANmoBY/BvF6+8YeKZgoRq60k/6AO1IubPnko2EvH500jGWKWWJ5eSzCfkDPuVnbfWcaf6579TZ6kUGiioPpbkPZvKkdbJDb47eitkuDy7jRIjBhlNis/kOPolQ1LoY/gGu/ys3g==;5:A4ZplZCd4+jInuNV7sEwe7Wm3rpEwUUhk86GNWKzNJqYUn8T00ordf902YGsfCNoEKDgBabLNaocRvPAWH6C+wvuWQh+zvi0C4hjORf7uMpRPz4zTf7xCY0PBZpiCaWOtYJ0jxrW5/jA1j8Phzpy8A==;24:caXse7TyJIg/E1MnprY29thd6V1BTHl/88Aa5ce0pCSai+Cp3H+IU7+vSYWvyEOKTQdI+rN4x4C9SWjspJhfdVW8mslCRRxUBJKo44AaRLA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;7:3oS2YekIEsN3iirrbC3bEGKohtPXXH9aZmbNbNc11t9A8DiTAjrTPQm+6S576t8ogsNQy2q6V8Omzvk6LU7N7UqL2Q1wVgOeHV0yF6NVRXcDZ0v/g12ojSp2wbDiVS4w7U5ynsU7JR8aZ7AI1y80ciwU3hCRxTFikRqvwCeDqDSVTrIRfomyBNs7fSxYayHTQ5ccE+yczcPigD89WwqWUNiJb0Fg7O/ySBco+QZZF9Bq82hX8zkCUvuPDDMdMKy7MErxT6qn1dJ7EgOZ9YtCBKyatZsoIpAmF5UE/pxQGxBFIMMNnR+mOA/Ya+6o+s4+8MqJyaGsSiITR4cih0BNVg==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2017 21:21:50.0783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2420
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57263
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

The follow-on BPF JIT patches use the LHU instruction, so add it.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/uasm.h | 1 +
 arch/mips/mm/uasm-mips.c     | 1 +
 arch/mips/mm/uasm.c          | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index f7929f6..d7e84f1 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -135,6 +135,7 @@ Ip_u2s3u1(_lb);
 Ip_u2s3u1(_ld);
 Ip_u3u1u2(_ldx);
 Ip_u2s3u1(_lh);
+Ip_u2s3u1(_lhu);
 Ip_u2s3u1(_ll);
 Ip_u2s3u1(_lld);
 Ip_u1s2(_lui);
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 763d3f1..2277499 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -103,6 +103,7 @@ static struct insn insn_table[] = {
 	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
 	{ insn_lh,  M(lh_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_lhu,  M(lhu_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 #ifndef CONFIG_CPU_MIPSR6
 	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
 	{ insn_ll,  M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index a829704..7f400c8 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -61,7 +61,7 @@ enum opcode {
 	insn_sllv, insn_slt, insn_sltiu, insn_sltu, insn_sra, insn_srl,
 	insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall, insn_tlbp,
 	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh, insn_xor,
-	insn_xori, insn_yield, insn_lddir, insn_ldpte,
+	insn_xori, insn_yield, insn_lddir, insn_ldpte, insn_lhu,
 };
 
 struct insn {
@@ -297,6 +297,7 @@ I_u1(_jr)
 I_u2s3u1(_lb)
 I_u2s3u1(_ld)
 I_u2s3u1(_lh)
+I_u2s3u1(_lhu)
 I_u2s3u1(_ll)
 I_u2s3u1(_lld)
 I_u1s2(_lui)
-- 
2.9.3
