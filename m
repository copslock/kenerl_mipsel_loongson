Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2017 02:40:36 +0200 (CEST)
Received: from mail-sn1nam01on0088.outbound.protection.outlook.com ([104.47.32.88]:46656
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994802AbdEZAijmn3vJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 May 2017 02:38:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tSK+j7pR0KHM1q8LnJuTTV2fq1rbhOe24R6jmWx++dU=;
 b=EFdaU4QTjnK5BKnV3QwYpfvdDn+CguXMyxBAE1JqueMyHEm17MyrzjTuOPU8xGAI+e5gANwbU/QfDVT7/vB74mPvkQQLY+eJmD5s0FlJmg/9bUNTM6htnXniDh608M82ASW3MQ3jAM9gJ18XOcOd0Vp7pfnLHcVOU6vcOrkMElk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1101.14; Fri, 26 May 2017 00:38:34 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 4/5] MIPS: Sort uasm enum opcode elements.
Date:   Thu, 25 May 2017 17:38:25 -0700
Message-Id: <20170526003826.10834-5-david.daney@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d89c795-d84b-4045-bdbe-08d4a3cf8abb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;3:eazHwHFiU46T+SyyRrw57O0O523u/MA8djCee5GCJ5qLA54u125QU11sSv75njMvSMxYBHO2vJfrPLv0EBXmvL5jtqcggq9xAwAt7IEBE7uy4Ij2S06l7HdgnYFu1p2yJ08LH4nTi7G94d3sj6TKLI4G/6swgG/WP+dNApQE2mZnPMY+ir/FSIRwLLxj2vopAJrOU8plff2hckGkm9hOmgfUxpqz9ipab52JjDLlsGMD/Mz90Vnhhdy7CktIXuSerm61rv8ScxXznvnHwNkmpaT5mJnY90yBxsAytvylFBCeO3dpbcYKrGpPmXL7O//itcsyFivDo9muxaWZJSKtYg==;25:wPaySCTumgjhylKDk4AV5DLxGRif+scGJ7Y5MngcbVs7a7m0GQeHRuhxT7OmupoVdcJcgeMIduHI9068OUoewG0O7eZL0HbmlUkzPV/uEMLBtfNtCpKv11XMdZS5QieD8croEYr5bhkL9WNpQttCGAzHjH+zoq3CVhySotRcYysskWKg35WyuH+NoWanMZlRngh64uSTRBHDQ7bAg4COY30oVj061/rmn7SoMt5aTDou7ad9NzCkClMt/+Zu4OJw0cjOVw0PhiOGjDRX1U0Yay4heC7obDTOJT1qYUIujyyWkmHOOJEygA8DT+nbmsTSlxJygneojIEgsgpidGvgATplwODUG7IO3lAdT6ZAM+B70KG/UePlpMx50bLIURUdtvVqoPrOdE4TRQk+Zw9JbaPeUrf9p7QPkBB4qQaG0IcTZjs/W2B6SFZWuymjn1fLuRtKkrA99HiRInvN6hQP3TCNa+NjNyPqNfEvylXvjLc=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;31:sT4vV7c3eNym0FGsL8yFWg/6JjtDHKPlCmwtdnMZUP4tZh5sl4TLZH/3NbZy7VFPldAsFI1QkFy/9o7WFubIdJ7B6HrIbakkbm4dD6NetYC6eF3ARe0+4tjEWyLNVzY3WVkYqeu54sD2XNx/5KCOiBTe+HzH4UWTBHyNPnf6tHwQZbXILAf8mHrXL+vpvYU0Odl9Yn52qeMLreYOIv6gw90EHWqqzmtRpTWMvHzvRAI=;20:4Efpqo1cIwUlZ+6nRkvjSP2WAQC1hIeda4zEOf9s/0OuK7No+Xt+LmN4wewNUGRZ5Aat/OyV7wVGiAB+jk8eXOQGQNWlyb9QSEtHY0DVqtackJQTTog3T2GDdLhRj7/8QhcH+hDXCvomnEhlS0q/d0OQCrwgkI5nRO2O4uXj1fJ3O2wS4dFxQAPY5ZTXEZDWCYHv1Kzvr0CqBgVcGglC3yI2QEIiO6AJ/CbvOdgZo9WpmY+oLvBNXbffJtLW3bdu5qo3BlUlBhmoyN5njsqrnz4CTrUiDvz+HODFnhcmIzg1RkKoKP/DX0tsxJ48ceWnwODzSTilp7EP7cqs3hHDpwiOk9lgLLJLwBQszARv58lFagdIIHjuvzsf1MuaUvJNjt9ut9oZZdH6CCno0iRXFtks5oO6zYPQQls0HrmZLBL0auFVBocmrXBYFvJaYc5fxnI+JL7oxPFt9GF8ORYKT3usm9HYMALDvOcOq1smnkbeTv7NYGFBLt+4DSVUQ6zQ
X-Microsoft-Antispam-PRVS: <DM5PR07MB3500746E8635C9CF8839587597FC0@DM5PR07MB3500.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123558100)(20161123560025)(20161123562025)(6072148);SRVR:DM5PR07MB3500;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;4:iTeuYcvn67Sj/yE07CE9LVRR133+XxfbiV3NsgLfkONyjaIZUkMXCbOisz7P/gBvNgCi8KgYlhwAXLPY4e67HZzhUvHP1Kzov5lj8aBhOGouuomE4f+I7DIugHIVZKl6IAjKzQ2WFs6RKPZydnlZ5VaS04CrTmzjlG+pQ6q/Vb6JP7W4fGvMGJ/akhFT36DOB6x9bh6YEoBoQEhv5AvZSw75EaTlZUQ1kYMoJT5V1vsqHYjhSh94FBg03JB45mQhdki5VPUcq6F6OT3xcr9ha+VYp86wVgoESkBoV91A02yiUCi/kLKG4rmrv1AyAqOwgC11vsuFnoYiK+pp3dHQP+4dFknoXL4RWhFpUT8v4u8V2zaPfsL7McgqHYICSm4Z/9hqYcvlTXCeo8FgkoVftJyfU97UBeqZPj4i1W5q3UVaO2l/r7hjwDio3ZRWzy3HKIrPbGFqpFI35oR3vY2bHaywALZe0W05o/ACCvNqkR83F9ixBe+2d1Voq6FF+iwsN0h5oewV/DBUE6vOfiOmnzeXqvxirwWhw0v30zZ1jIjHWUHK6hCukrZOc0TW1I+1JE8pRbJKibvyZzYEOpiQ6B294QXapNeDuC0t/6a/Fjmli3E4ZBAzHWJ1GczvaOZ+cINvNDcCPxIa/1ZkWc3yEgk4otQP4vGUtzu/qaiYR5NuAH9tg9BMBYlqkGVmnFCx4bHTOWweahHj+esDNC0dK93TUgZTa7wQ7tQ6nVs8N4fZoAR70tCifcWJDGwtewCEvwHHWbvbL9JNvMqNi7i+TTQTMn5oZN6OpqE4jowVffzbG632VRDivrCDWVyrtyP3/VoykOnA8mjfT2x5mDs1Bw==
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(39400400002)(39840400002)(39410400002)(39850400002)(305945005)(3846002)(5660300001)(7736002)(2906002)(53936002)(6512007)(25786009)(189998001)(478600001)(1076002)(107886003)(38730400002)(72206003)(81166006)(5003940100001)(6666003)(66066001)(47776003)(50466002)(8676002)(50226002)(42186005)(76176999)(53416004)(50986999)(6506006)(86362001)(33646002)(2950100002)(4326008)(36756003)(6486002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3500;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:ms;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3500;23:EQ2eASbbp6DO/G/qodtkblu/qVnmyB2OhgZ1XKFcA?=
 =?us-ascii?Q?z1lgQdBW6cUVH4//vMx8uAw7h7voJVUGbcWMjb2YG8fah6k6URA+N4RZWIs6?=
 =?us-ascii?Q?HoT96rpsnaapBIwxcPjs1LiH15mL3Mgx/1WLv8EUPmQtcOldl4UauSRQwQBg?=
 =?us-ascii?Q?y2tj8Y6lky/QrW6oZC8O/VcfMENeymR8iT4C7PQ8Sa2NgbGjsa1/EEduEJg+?=
 =?us-ascii?Q?tYyxchvurlm9zGyYzzvG8x2ccEmYhWmBZYeXREhVBTz1h7KAMcZD4X/VIARt?=
 =?us-ascii?Q?gddCZ6f9JLER/Fc4boSV+PcV84zcYAEhNnP2CWIBTAF/2sjTbGpJByfP0CHe?=
 =?us-ascii?Q?ZiFknEtGyM+ac6d77UE/pRFuz6TbuzRtGfYgsWcuvHy1WiFSGjgwiAhIKKB2?=
 =?us-ascii?Q?EcRp8qZuKPNZzoe//VTV48itq1pgKJ8aglDMKnUxBzZ4NG2uRS92fex4nF1t?=
 =?us-ascii?Q?WASeEUTnD0iNAxKIEt83k4NvdIPkHUFZVidPSk7os8Xs0mcqQrvZaWTXX4eo?=
 =?us-ascii?Q?HvEGe1Mti/t/H9UKxPJ/89wjGlH2zCc4KF9MCQswPfVRp+iQPWIgRcW4M8Ll?=
 =?us-ascii?Q?o5JwizQNkdJem4ZzUQOgbtHbiZ9/BzodI1cIbJK/QqGuuBP8XkFmMaBopy48?=
 =?us-ascii?Q?+xdgm1Fv66/Mw+kIrwn/DkdZyByDPepvkuwTSxA9D7hnzVuzFyJ0kQdsIgwZ?=
 =?us-ascii?Q?OAaPZHVoWVz4NfcsZqxrcz0+qCj/fAFMu+CvsMkOTxSUmIarrkEnNhRPvuEm?=
 =?us-ascii?Q?lp/yw65vMQ6ecY6A+h+IbGRh38mYwTxlQop7nKQn2dZJe9FyNYFTJ2cTonwG?=
 =?us-ascii?Q?U93lPqmn3D05e52eKLJrYQBapnHpaepjXQOlbE9ssGeH196rfUGhkdvqnhgm?=
 =?us-ascii?Q?zrF6tRUulCndHcikHtfAiaOtaMbFSEkwu1nk3+ce/Aa/2hd9hSF4SxUx+vzw?=
 =?us-ascii?Q?owQ7v01TuAw5Tmbnr496XXmFidwb0LDd5s4tmQiddAAlvIrhu7OUzJyvC5Bx?=
 =?us-ascii?Q?c8c5lNrxZY58yOhAmMeRD4AxweKt7vjgILVZu6/bGdhD4j9AN695KnxjZNnz?=
 =?us-ascii?Q?5K6ow4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;6:/NyrqgZYGkLown71gpc7m7YZYUPXCgObiDOvhY5xiWOwunqqYQ6gl7yAFJifiltOKH5HahPhuJ7dmWHBJ7k0QEBYbhyVvhtDmXFMnwde64CUphRDo/UqmiwOcmzC8FFW1WggEtFZ7H9pFaApZk0gRcgGYcJdzgRcqaNzi0EMphSZOVZiJt39JRJRMmpJXyzW8Av5vLQrvpGi2i9FZjjS0dZlP7x4RNfcNoeHkuPL7Rww1J4N/vlNcEs0COmN67Y/I7FkI4kwm6VqzPhS7HdyMXn/eJlI9dmjVmnTwWDWISv69pM5drvqzBXsMtgVaNI+2QomNlG11+N27/8e8r1zS2lR1Y+UzU3CLnlhLBEtLi6aK7jx6oRr7yUDS0kSVeuQ+AUk2ojQd3fQOJixa0+ucG5M9lb4kLb9d4hC9z5Mdy+ZOpZwJd/O8ecDF4U0wQeTnXeEwR/fPBvit0u8U8kgal1Ajr8up/T7dNj01SXTqzuNGii8jJZWH1mUboAhLOruGkO6eGuXPeUjO03Oa6jaRw==;5:OcldaKb8/SZp2x4fCoBqvNm6giYwya3CfBGr807i19hmFN02wDxtbIDkSvPnF3Qel4NQ04FBfRiR1eFTOzv2O1D0FhBubk1gqwgScilRrPM6rQug5kbHgWBw4hGO6OEjxWgKoi3hepIgQ0+iqYP/thdB++GoSRErJ4MtZumXQ18=;24:AtvbS8MDJrXtI+4VIIiGo876t1gz5l+H/GDL6VY9cIHxpMX5BR+x2jO0IzNO1Vizcc7iV2LR4BOSGJD/WLLIytOMWFXIs3fHRKR4STnJN0Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;7:JtgG9P6umnvOMUny9gY/i/xTMswgXlnuscjTw3A5+qBXeYvXA4Dd9uyWkgtXX973ndB3l5mAZrm77BLp3hE5jT//G2fzCjTPmbVxPU1dsjybXjY7wZETcUvvVHz/zGrbXbKG58vAhxRf311MUgCYIpBIXsTR/nEdvslQikb+Kxjm1y2lRu6Tn013Deg+GQHY01LDdDvNa9whFEVebW3XgomxZiXhVf3YNM4kGqX9fBx9KED2xP3xIVGsrDFEtIiiNIOtQ2TqoJHfBrzMw2VMBd+UaMb4j3k8w8/TKkduRXKzTE+5OdzjsgxFLukRssJ4702gjYrCByRHSwIRlprG0Q==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2017 00:38:34.0645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3500
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58012
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

The enum opcode list started out sorted, but many elements have since
been added.  Resort it.

No functional change.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/uasm.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index bae08d4..3ae22bd 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -47,24 +47,24 @@ enum fields {
 
 enum opcode {
 	insn_addiu, insn_addu, insn_and, insn_andi, insn_bbit0, insn_bbit1,
-	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
-	insn_bne, insn_cache, insn_cfc1, insn_cfcmsa, insn_ctc1, insn_ctcmsa,
-	insn_daddiu, insn_daddu, insn_di, insn_dins, insn_dinsm, insn_divu,
-	insn_dmfc0, insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll,
-	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
-	insn_ext, insn_ins, insn_j, insn_jal, insn_jalr, insn_jr, insn_lb,
-	insn_ld, insn_ldx, insn_lh, insn_ll, insn_lld, insn_lui, insn_lw,
-	insn_lwx, insn_mfc0, insn_mfhc0, insn_mfhi, insn_mflo, insn_mtc0,
-	insn_mthc0, insn_mthi, insn_mtlo, insn_mul, insn_or, insn_ori,
-	insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd, insn_sd, insn_sll,
-	insn_sllv, insn_slt, insn_sltiu, insn_sltu, insn_sra, insn_srl,
+	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bgtz, insn_blez,
+	insn_bltz, insn_bltzl, insn_bne, insn_cache, insn_cfc1, insn_cfcmsa,
+	insn_ctc1, insn_ctcmsa, insn_daddiu, insn_daddu, insn_ddivu, insn_di,
+	insn_dins, insn_dinsm, insn_dinsu, insn_divu, insn_dmfc0, insn_dmtc0,
+	insn_dmultu, insn_drotr, insn_drotr32, insn_dsbh, insn_dshd, insn_dsll,
+	insn_dsll32, insn_dsllv, insn_dsra, insn_dsra32, insn_dsrav, insn_dsrl,
+	insn_dsrl32, insn_dsrlv, insn_dsubu, insn_eret, insn_ext, insn_ins,
+	insn_j, insn_jal, insn_jalr, insn_jr, insn_lb, insn_lbu,
+	insn_ld, insn_lddir, insn_ldpte, insn_ldx, insn_lh, insn_lhu,
+	insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0,
+	insn_mfhc0, insn_mfhi, insn_mflo, insn_movn, insn_movz, insn_mtc0,
+	insn_mthc0, insn_mthi, insn_mtlo, insn_mul, insn_multu, insn_nor,
+	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sb,
+	insn_sc, insn_scd, insn_sd, insn_sh, insn_sll, insn_sllv,
+	insn_slt, insn_slti, insn_sltiu, insn_sltu, insn_sra, insn_srl,
 	insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall, insn_tlbp,
 	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh, insn_xor,
-	insn_xori, insn_yield, insn_lddir, insn_ldpte, insn_lhu,
-	insn_bgtz, insn_blez, insn_ddivu, insn_dmultu, insn_dsbh, insn_dshd,
-	insn_dsllv, insn_dsra32, insn_dsrav, insn_dsrlv, insn_lbu, insn_movn,
-	insn_movz, insn_multu, insn_nor, insn_sb, insn_sh, insn_slti,
-	insn_dinsu,
+	insn_xori, insn_yield,
 	insn_invalid /* insn_invalid must be last */
 };
 
-- 
2.9.4
