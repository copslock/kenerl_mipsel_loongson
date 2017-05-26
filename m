Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2017 02:39:09 +0200 (CEST)
Received: from mail-sn1nam01on0088.outbound.protection.outlook.com ([104.47.32.88]:46656
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994799AbdEZAiiUcZbJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 May 2017 02:38:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/8YmsJD3N/8Sbv+lN4lvU+HChCoQl/9lQYFJpPH7I3g=;
 b=lCp8PSXHFO7RVObX2Vp7JYcJ70wxO6yRpWv4WFjidw8UpJbd1YXDqO0ja9ylarh7ipgE+sQPesoTrOwJOEZJZBVPem13oPRqLmZoJrafpNNpRP40kQPgxsyrA+L24eiefIqfkToArQuvHMqoNhehVUwzS2JQZTQFJ9ewSUbbQFA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1101.14; Fri, 26 May 2017 00:38:31 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 1/5] MIPS: Optimize uasm insn lookup.
Date:   Thu, 25 May 2017 17:38:22 -0700
Message-Id: <20170526003826.10834-2-david.daney@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: a149f95a-0ecf-44c0-f05d-08d4a3cf88ea
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;3:jPrgDSjJWpHx52pPwn0sj1zmvpeslEOU7gzD2fNwtkeK9qa7/h2JEutZHQrPwQPOXv2Fqm0m8m38lStBujzVujVCJCSuVSC3qtnX3I69D/8ueThoQ0oBR/5gfuA5vWgZHbdPdXt29N9ioAvCztycKUwGVUwgsz/PpLrPX0DiAxuz53v1zhYbaiH9fDgikOnoI8swzFtT1D7wpvI0yLbGK2yePDYUa0kTEJsn9/Cu7pjiwvBfhGxy4YlDqo9+5tlU2lrutfQX/CgLsK/GXSuLMqlqH61j4v4WmNMqOcWuT/Mfm+JhkdEWJFh2FNpc0/dYBn7Hu8tYjpq1JVB34VJ7Ig==;25:fpC4nYLKMxRGNT+/kiX7LEXzB988g/SKzR69Bxt4yJ/b58LQXS9vYOq7m1Jv8JfJ0KHQDw3e1ehLb56e2LsBc7wIQGrlAUX58QS2OU8gyF5orUS/pgdFRGD3vGNeMg1COvjad+vOJSNgaQ4X4KdnmjwdG4rCJdorEHFkGTcGvvnclqzrVDqY+en7EF+V/TIh7VRwc+y8xCAB7L8r5Ah2VyjElBGL9s2plh8WTuhEPUC6+ih4Vumg7zNVqoDerGw9DuBNZWuvm2JtNCwckBdqs2jLvXTflUHSfnd4PqHuQeUcjnmEGKhbU0/rLH7EMNmryUh7tXQC9uJWhphOQsigFQmlmHbtGaoXnKTosIJm/dQBRhopoCyzoSyUehmtmfJ46EfGR9SfnxUsPV1v7Cvl6krzO1QJyr4kNDIBk6xGR2sk12XINKKgtVSkEv+0PLRnb0+bqrdLmmnROvBEFN2+WhTJ8eXEhlcEddBmlIgG//A=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;31:/W1Fg9ymlAIWFig7bWV9VT43atjmiqYaS+m9ql1XF4U9fl1c4AmP0lRPJV3raFm6Cz9r8mnQFX1zMgwrl+RZRCNiaSCb9kTfxHB+RDoTnrxpecYEZPhnG9uj4PkqEKY7KmfdJQBxCuXAVjJx1ky7ODzJKRZuQQzVPkqzTJx3ds0RIJ5Q6n5CyiM/wocVwezDlbD5hWcpBPlIvwe1AKM2f24Wt0dkL468hkCJUNDyMqQ=;20:bQCJdyghuylAvsEBh5MSJcfVpLui0ytNmZILEfZJsjLklKi/1UbBofPN+gsTPTuzH8EDhY+UPTBjVOOzBnhGk/H9NvscTOXYQhXB14Pe/O+fW9zQBo0x7BE37Zu/fR9gnj9EvlI3p72VrMasZ2VaHpFaOzBhC8jM+cngeN5dRmE5WMcBnrk3ke3yfqRM3Mr8FH03hfRA8x8TgOBhE47GpwdkcDTJxsHlJEJMIpGIUNKitQQhottPgTvNRekdwVCDYNkn5G7I0bNAR+05835ZEaKDvUY67wtent5IyAJTu9nsybu39esYEVytAVnr+J/eMyRxXC1cYVBXzwt9xMRIdpJObW89kk8f/K6apd9iFhYvu14FqKJhRnyqGtcXISp4DQBn/pILfhh7y6TxzYDVM0Xa+BYvG905X6iFQ4w1VsgE5lkTuIitVkq1swt6ERLKX9YpL+hDcDD/epqWp9VNV5V2+zhRG+QgMsWbUttNUWJ9wtyDhgYM7k/idZWAxHlc
X-Microsoft-Antispam-PRVS: <DM5PR07MB350077804A017ECC3A1771B097FC0@DM5PR07MB3500.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123558100)(20161123560025)(20161123562025)(6072148);SRVR:DM5PR07MB3500;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;4:2p8ccj+u/LtsrsPISP+IHNrtTwglnbT9J6GSzYZ+F/3md6zOafALYKGhTtq0cdllhNnsR0BS/OrhliJrwlSW3Cg09CNSrTa/WtUhjJcCsmfgVcTHKCazEmsappErZ+UadlpFr+tzDWGeXkIYPzpCOfPC9/GcAc70P7dVSFLBwLdcNI2WmqRj0CUIjFRFVSImg5IbvtOEgit8aAZTGut3bN/rg5dJfFVPx54OZZ/swr2USwbue17+kYaSIz1J5LZAtsrPWOhwU6iLaX6ytYt8asaOxsBRZKr0WkOjulR1CKGudGERHQBt4TOIOEvsmihYJAGyktXRfH9UP3Bsp/OZs3mKC4GI7yHqE4dXWMtqrAOUEgdL/3qCVk374q+kBqEGSGz2DL7mJR0aUH6RO5vlEw4ZL0Cg5n4DdVBk2sykgCN99CQPG0sRIMXrLcIkLh4b1p3LIIQZ7NlYWvNvvfe8oiO6WBq5KBQKulL49S+sWRgcz/NTNs2mAVUjvEXgA38FRMITtMHZTRqY79BpfOnsmrK7ImVI6pLUQX0EDG4sGhTXU6aHQmWlAVlCLZeT3tHBdGdKDfrqsqMeqwuL47iBvYgfny209rWt7inJRDjP8aSUy5ypp0KFqfW90GEGvKPTJKUNgI3hPmIruayYqZxIY7Kt+XKVH/CZIkwbzptEw9ZP9YPVRJ6llg3uG41crAPMUGGGMz11EFsXSlfdH71i4FEiMFHw4ha1YiH8ZjnK51Lizija19BwsdbxYd8fORIYnxu8YjPAjaz3sd9u6tL79bSLVk83G5KsodA7Aj2CFn4=
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(39400400002)(39840400002)(39410400002)(39850400002)(305945005)(3846002)(5660300001)(7736002)(2906002)(53936002)(6512007)(25786009)(189998001)(478600001)(1076002)(107886003)(38730400002)(72206003)(81166006)(5003940100001)(6666003)(66066001)(47776003)(50466002)(8676002)(50226002)(42186005)(76176999)(53416004)(50986999)(6506006)(86362001)(33646002)(2950100002)(4326008)(36756003)(6486002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3500;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3500;23:aFHo/YXnX3KcqNysBD7RUxNByvfls9up2uGClF5EI?=
 =?us-ascii?Q?o0XhDzkzYOvCHP6VxzjMriW6qwhOtBCzzp/IWUdXV7I5YqCrZw/bXzNt/ZYn?=
 =?us-ascii?Q?hcjoanxQqlZ/HD5kyvy1l6W4xQeWenhkXgbAppbPOWker6+9hYk9TQgLwSdn?=
 =?us-ascii?Q?JsxiyVL8n1SCUp72g777CZdkEXkGarsnOnPZ8EHPJr9RtYHMJOL5lwY/Xjzz?=
 =?us-ascii?Q?u4qMbsQA4D1WTU5Upfr+48XHc2TXCpdBVgVgS6iWOrfFqq/+Ek0dggTyXeyo?=
 =?us-ascii?Q?Mw+TgfeHbRotnQ6AYW08rBUKdM3OH0G+yj1dMCu7BxYPfOOk66/I6mx5l56B?=
 =?us-ascii?Q?dbb9XBCIivh2Ik21XAHdPuUA0f5grPv93TZml8Fj8ere8icU3A3QmNyGEBRw?=
 =?us-ascii?Q?oWHHaBFnMTj1DG1Mp/FAWgSGdwTT0GJGgsZvJEQByeAKz5kGC0rEzjhx8gcr?=
 =?us-ascii?Q?BjJrA9GnyTTocZYNHCwmLX2/cBxLuhE9i8qJWL0XnJWlGw9zan6bOjcz3Gum?=
 =?us-ascii?Q?iBGu/7yW9/zRWN7Zp76pmrYoqdTaeTyJhb4gM+2v3++TjIik/JVU0dY4n4wd?=
 =?us-ascii?Q?zZyxtzFLyl16HqoHiOV+TD3c/zSes0iZyQkZVSzxGhRXtgLI1r5F2q7Gcw9w?=
 =?us-ascii?Q?CO6axyzkefpkDE28tGPg1s9W0mxMay0Yx5zhEJjrvfTln3AYsHESfPY27aH0?=
 =?us-ascii?Q?1jlmixylZgzsZc17nHJivteW+ze+Bz4wAQtgEq8LTCbUKTolx+odSIzn8foB?=
 =?us-ascii?Q?IAWaPr7I2oT3YdD1Zx6NgbuUGByRviroKAyadOsmg2WcpkCOzJkDsyjwAYgD?=
 =?us-ascii?Q?UwzKsAdRp4THrIAzSe6n7QnrX3MLpylQfC8J0DGfV5+dGbYtcShDwtjlQhyR?=
 =?us-ascii?Q?9kGjnTRw42OCEjxIUCq/nW1xSAfHhIUvPJbFfAxjCrqpyWD7kO/jKjTfANUt?=
 =?us-ascii?Q?+tMPljUXS3R8FOMLGl4bd2LWMJ73/DlHpn5udAJs54QHOSxJp4oaH43H4IOI?=
 =?us-ascii?Q?Frvdzvvb8QeGGgzhppe3T6L68lKOM2b7a5lapeJcEm9aCze7rLulFReR4bEi?=
 =?us-ascii?Q?H8o3bk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;6:8i04SF8zMHezmHmvJwB+T0ljGKmkG8mCcYKlFis3DTYGhfd83ij6AN/whXgeDkVEXDJwjnZVOTVn2mhsLYPS/uc1VEflqh/orKLIhpy062LbvtIqIAwmIeAL23XMJoY67hj5auPGbojdT1FtclF3BsR7nOPXEiXBnfJNzUvEHrZTVIdGFkLuh6+w+v7fhJKNBNoS0aES8hOw7MdQZET2j5xKfFPRe9vUqAWOiQoV2fK3qHSfdTMNnOZspiu0CaZCMXRI2QhhuzjSVjAo9P2JOeNYd8T0Qh7QYnDg2QgVAuChj0xzwCI1L86+5tRYhy6i2+W7f8QcWiRVMMK4JERMnu1OVJJeSMWJekA9hznVDjX1vbCPdt52o5CY1ye8fcBC0q9eubRxa8opdD/EkvUEa69WtlfMC4FPS3f7y2zcwQ3sa3dU2TxYx34HOs4ZDZfIMYOeEsVGfoRlI24S7NQdSf9uCdaGTy4PbJM5sW09CDtLSJsVL88XWqp8LIGWBTN9/8PlHYZA9HC3Z2S9u53wvQ==;5:It8NLwPxz2pPcAoZZUj7HzuVUS3qhZhpUfTCL+JHUDN5OQSRRFojTO9qno6et4wcDGZkDSTFSKh0Gq6/6PPaZ+xWIAZ7D3Ltz90qUE0LAmfjhrhlGWn2vMQf9VPzIm5N6NPh6k78XFJbw2A85JO7oalOxkp7oMVzvMa3JKlEr7I=;24:cBvTM4oVzVTjFfTmBC7nWfZczlDZMW8yg8MMtquPF4Bssz/Necimj2pfX5LzZn/PdVe+YauEz1P6RhyHES4Tguk2SibqEcz94fpgIzXoSU8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;7:ynp1PLmktplGPV/KJK9yy9UrlroIYLxoIukHRJZ9vEH2o5FcybwdCJrkHxJ4PhWKjkoc4YuZe6vK4fUAiCmmjAWyk7DI7WPjFbCiOyLy58aHb3szoa73ItPOfwzVYh2CtI5s6EZKNoY8ty8bLzJrvlpphqxsv0S8MT6Ns203Cd49WIt1Zk+Sz8C6jNYl2fhQZHGtvVM/dh0Sx0pyJjO5J0CiuIKi9MhB+SPyHJ8FFbmo/R2sxX7jhWTStReRCOEGOBUqmm04plGy1jtOlQ1zMNuxDLM+Yh3veuUaeavNkI64bqvX4qbIYJgD2/FJ0E945sCRDV9+LzTjMqey8WfJJA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2017 00:38:31.0194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3500
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58009
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

Instead of doing a linear search through the insn_table for each
instruction, use the opcode as direct index into the table.  This will
give constant time lookup performance as the number of supported
opcodes increases.  Make the tables const as they are only ever read.
For uasm-mips.c sort the table alphabetically, and remove duplicate
entries, uasm-micromips.c was already sorted and duplicate free.
There is a small savings in object size as struct insn loses a field:

$ size arch/mips/mm/uasm-mips.o arch/mips/mm/uasm-mips.o.save
   text	   data	    bss	    dec	    hex	filename
  10040	      0	      0	  10040	   2738	arch/mips/mm/uasm-mips.o
   9240	   1120	      0	  10360	   2878	arch/mips/mm/uasm-mips.o.save

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/uasm-micromips.c | 188 ++++++++++++++++++------------------
 arch/mips/mm/uasm-mips.c      | 217 +++++++++++++++++++++---------------------
 arch/mips/mm/uasm.c           |   3 +-
 3 files changed, 199 insertions(+), 209 deletions(-)

diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 277cf52..da6de62 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -40,93 +40,92 @@
 
 #include "uasm.c"
 
-static struct insn insn_table_MM[] = {
-	{ insn_addu, M(mm_pool32a_op, 0, 0, 0, 0, mm_addu32_op), RT | RS | RD },
-	{ insn_addiu, M(mm_addiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
-	{ insn_and, M(mm_pool32a_op, 0, 0, 0, 0, mm_and_op), RT | RS | RD },
-	{ insn_andi, M(mm_andi32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
-	{ insn_beq, M(mm_beq32_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_beql, 0, 0 },
-	{ insn_bgez, M(mm_pool32i_op, mm_bgez_op, 0, 0, 0, 0), RS | BIMM },
-	{ insn_bgezl, 0, 0 },
-	{ insn_bltz, M(mm_pool32i_op, mm_bltz_op, 0, 0, 0, 0), RS | BIMM },
-	{ insn_bltzl, 0, 0 },
-	{ insn_bne, M(mm_bne32_op, 0, 0, 0, 0, 0), RT | RS | BIMM },
-	{ insn_cache, M(mm_pool32b_op, 0, 0, mm_cache_func, 0, 0), RT | RS | SIMM },
-	{ insn_cfc1, M(mm_pool32f_op, 0, 0, 0, mm_cfc1_op, mm_32f_73_op), RT | RS },
-	{ insn_cfcmsa, M(mm_pool32s_op, 0, msa_cfc_op, 0, 0, mm_32s_elm_op), RD | RE },
-	{ insn_ctc1, M(mm_pool32f_op, 0, 0, 0, mm_ctc1_op, mm_32f_73_op), RT | RS },
-	{ insn_ctcmsa, M(mm_pool32s_op, 0, msa_ctc_op, 0, 0, mm_32s_elm_op), RD | RE },
-	{ insn_daddu, 0, 0 },
-	{ insn_daddiu, 0, 0 },
-	{ insn_di, M(mm_pool32a_op, 0, 0, 0, mm_di_op, mm_pool32axf_op), RS },
-	{ insn_divu, M(mm_pool32a_op, 0, 0, 0, mm_divu_op, mm_pool32axf_op), RT | RS },
-	{ insn_dmfc0, 0, 0 },
-	{ insn_dmtc0, 0, 0 },
-	{ insn_dsll, 0, 0 },
-	{ insn_dsll32, 0, 0 },
-	{ insn_dsra, 0, 0 },
-	{ insn_dsrl, 0, 0 },
-	{ insn_dsrl32, 0, 0 },
-	{ insn_drotr, 0, 0 },
-	{ insn_drotr32, 0, 0 },
-	{ insn_dsubu, 0, 0 },
-	{ insn_eret, M(mm_pool32a_op, 0, 0, 0, mm_eret_op, mm_pool32axf_op), 0 },
-	{ insn_ins, M(mm_pool32a_op, 0, 0, 0, 0, mm_ins_op), RT | RS | RD | RE },
-	{ insn_ext, M(mm_pool32a_op, 0, 0, 0, 0, mm_ext_op), RT | RS | RD | RE },
-	{ insn_j, M(mm_j32_op, 0, 0, 0, 0, 0), JIMM },
-	{ insn_jal, M(mm_jal32_op, 0, 0, 0, 0, 0), JIMM },
-	{ insn_jalr, M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RT | RS },
-	{ insn_jr, M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RS },
-	{ insn_lb, M(mm_lb32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
-	{ insn_ld, 0, 0 },
-	{ insn_lh, M(mm_lh32_op, 0, 0, 0, 0, 0), RS | RS | SIMM },
-	{ insn_ll, M(mm_pool32c_op, 0, 0, (mm_ll_func << 1), 0, 0), RS | RT | SIMM },
-	{ insn_lld, 0, 0 },
-	{ insn_lui, M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | SIMM },
-	{ insn_lw, M(mm_lw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
-	{ insn_mfc0, M(mm_pool32a_op, 0, 0, 0, mm_mfc0_op, mm_pool32axf_op), RT | RS | RD },
-	{ insn_mfhi, M(mm_pool32a_op, 0, 0, 0, mm_mfhi32_op, mm_pool32axf_op), RS },
-	{ insn_mflo, M(mm_pool32a_op, 0, 0, 0, mm_mflo32_op, mm_pool32axf_op), RS },
-	{ insn_mtc0, M(mm_pool32a_op, 0, 0, 0, mm_mtc0_op, mm_pool32axf_op), RT | RS | RD },
-	{ insn_mthi, M(mm_pool32a_op, 0, 0, 0, mm_mthi32_op, mm_pool32axf_op), RS },
-	{ insn_mtlo, M(mm_pool32a_op, 0, 0, 0, mm_mtlo32_op, mm_pool32axf_op), RS },
-	{ insn_mul, M(mm_pool32a_op, 0, 0, 0, 0, mm_mul_op), RT | RS | RD },
-	{ insn_or, M(mm_pool32a_op, 0, 0, 0, 0, mm_or32_op), RT | RS | RD },
-	{ insn_ori, M(mm_ori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
-	{ insn_pref, M(mm_pool32c_op, 0, 0, (mm_pref_func << 1), 0, 0), RT | RS | SIMM },
-	{ insn_rfe, 0, 0 },
-	{ insn_sc, M(mm_pool32c_op, 0, 0, (mm_sc_func << 1), 0, 0), RT | RS | SIMM },
-	{ insn_scd, 0, 0 },
-	{ insn_sd, 0, 0 },
-	{ insn_sll, M(mm_pool32a_op, 0, 0, 0, 0, mm_sll32_op), RT | RS | RD },
-	{ insn_sllv, M(mm_pool32a_op, 0, 0, 0, 0, mm_sllv32_op), RT | RS | RD },
-	{ insn_slt, M(mm_pool32a_op, 0, 0, 0, 0, mm_slt_op), RT | RS | RD },
-	{ insn_sltiu, M(mm_sltiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
-	{ insn_sltu, M(mm_pool32a_op, 0, 0, 0, 0, mm_sltu_op), RT | RS | RD },
-	{ insn_sra, M(mm_pool32a_op, 0, 0, 0, 0, mm_sra_op), RT | RS | RD },
-	{ insn_srl, M(mm_pool32a_op, 0, 0, 0, 0, mm_srl32_op), RT | RS | RD },
-	{ insn_srlv, M(mm_pool32a_op, 0, 0, 0, 0, mm_srlv32_op), RT | RS | RD },
-	{ insn_rotr, M(mm_pool32a_op, 0, 0, 0, 0, mm_rotr_op), RT | RS | RD },
-	{ insn_subu, M(mm_pool32a_op, 0, 0, 0, 0, mm_subu32_op), RT | RS | RD },
-	{ insn_sw, M(mm_sw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
-	{ insn_sync, M(mm_pool32a_op, 0, 0, 0, mm_sync_op, mm_pool32axf_op), RS },
-	{ insn_tlbp, M(mm_pool32a_op, 0, 0, 0, mm_tlbp_op, mm_pool32axf_op), 0 },
-	{ insn_tlbr, M(mm_pool32a_op, 0, 0, 0, mm_tlbr_op, mm_pool32axf_op), 0 },
-	{ insn_tlbwi, M(mm_pool32a_op, 0, 0, 0, mm_tlbwi_op, mm_pool32axf_op), 0 },
-	{ insn_tlbwr, M(mm_pool32a_op, 0, 0, 0, mm_tlbwr_op, mm_pool32axf_op), 0 },
-	{ insn_wait, M(mm_pool32a_op, 0, 0, 0, mm_wait_op, mm_pool32axf_op), SCIMM },
-	{ insn_wsbh, M(mm_pool32a_op, 0, 0, 0, mm_wsbh_op, mm_pool32axf_op), RT | RS },
-	{ insn_xor, M(mm_pool32a_op, 0, 0, 0, 0, mm_xor32_op), RT | RS | RD },
-	{ insn_xori, M(mm_xori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
-	{ insn_dins, 0, 0 },
-	{ insn_dinsm, 0, 0 },
-	{ insn_syscall, M(mm_pool32a_op, 0, 0, 0, mm_syscall_op, mm_pool32axf_op), SCIMM},
-	{ insn_bbit0, 0, 0 },
-	{ insn_bbit1, 0, 0 },
-	{ insn_lwx, 0, 0 },
-	{ insn_ldx, 0, 0 },
-	{ insn_invalid, 0, 0 }
+static struct insn insn_table_MM[insn_invalid] = {
+	[insn_addu]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_addu32_op), RT | RS | RD},
+	[insn_addiu]	= {M(mm_addiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
+	[insn_and]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_and_op), RT | RS | RD},
+	[insn_andi]	= {M(mm_andi32_op, 0, 0, 0, 0, 0), RT | RS | UIMM},
+	[insn_beq]	= {M(mm_beq32_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
+	[insn_beql]	= {0, 0},
+	[insn_bgez]	= {M(mm_pool32i_op, mm_bgez_op, 0, 0, 0, 0), RS | BIMM},
+	[insn_bgezl]	= {0, 0},
+	[insn_bltz]	= {M(mm_pool32i_op, mm_bltz_op, 0, 0, 0, 0), RS | BIMM},
+	[insn_bltzl]	= {0, 0},
+	[insn_bne]	= {M(mm_bne32_op, 0, 0, 0, 0, 0), RT | RS | BIMM},
+	[insn_cache]	= {M(mm_pool32b_op, 0, 0, mm_cache_func, 0, 0), RT | RS | SIMM},
+	[insn_cfc1]	= {M(mm_pool32f_op, 0, 0, 0, mm_cfc1_op, mm_32f_73_op), RT | RS},
+	[insn_cfcmsa]	= {M(mm_pool32s_op, 0, msa_cfc_op, 0, 0, mm_32s_elm_op), RD | RE},
+	[insn_ctc1]	= {M(mm_pool32f_op, 0, 0, 0, mm_ctc1_op, mm_32f_73_op), RT | RS},
+	[insn_ctcmsa]	= {M(mm_pool32s_op, 0, msa_ctc_op, 0, 0, mm_32s_elm_op), RD | RE},
+	[insn_daddu]	= {0, 0},
+	[insn_daddiu]	= {0, 0},
+	[insn_di]	= {M(mm_pool32a_op, 0, 0, 0, mm_di_op, mm_pool32axf_op), RS},
+	[insn_divu]	= {M(mm_pool32a_op, 0, 0, 0, mm_divu_op, mm_pool32axf_op), RT | RS},
+	[insn_dmfc0]	= {0, 0},
+	[insn_dmtc0]	= {0, 0},
+	[insn_dsll]	= {0, 0},
+	[insn_dsll32]	= {0, 0},
+	[insn_dsra]	= {0, 0},
+	[insn_dsrl]	= {0, 0},
+	[insn_dsrl32]	= {0, 0},
+	[insn_drotr]	= {0, 0},
+	[insn_drotr32]	= {0, 0},
+	[insn_dsubu]	= {0, 0},
+	[insn_eret]	= {M(mm_pool32a_op, 0, 0, 0, mm_eret_op, mm_pool32axf_op), 0},
+	[insn_ins]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_ins_op), RT | RS | RD | RE},
+	[insn_ext]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_ext_op), RT | RS | RD | RE},
+	[insn_j]	= {M(mm_j32_op, 0, 0, 0, 0, 0), JIMM},
+	[insn_jal]	= {M(mm_jal32_op, 0, 0, 0, 0, 0), JIMM},
+	[insn_jalr]	= {M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RT | RS},
+	[insn_jr]	= {M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RS},
+	[insn_lb]	= {M(mm_lb32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
+	[insn_ld]	= {0, 0},
+	[insn_lh]	= {M(mm_lh32_op, 0, 0, 0, 0, 0), RS | RS | SIMM},
+	[insn_ll]	= {M(mm_pool32c_op, 0, 0, (mm_ll_func << 1), 0, 0), RS | RT | SIMM},
+	[insn_lld]	= {0, 0},
+	[insn_lui]	= {M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | SIMM},
+	[insn_lw]	= {M(mm_lw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
+	[insn_mfc0]	= {M(mm_pool32a_op, 0, 0, 0, mm_mfc0_op, mm_pool32axf_op), RT | RS | RD},
+	[insn_mfhi]	= {M(mm_pool32a_op, 0, 0, 0, mm_mfhi32_op, mm_pool32axf_op), RS},
+	[insn_mflo]	= {M(mm_pool32a_op, 0, 0, 0, mm_mflo32_op, mm_pool32axf_op), RS},
+	[insn_mtc0]	= {M(mm_pool32a_op, 0, 0, 0, mm_mtc0_op, mm_pool32axf_op), RT | RS | RD},
+	[insn_mthi]	= {M(mm_pool32a_op, 0, 0, 0, mm_mthi32_op, mm_pool32axf_op), RS},
+	[insn_mtlo]	= {M(mm_pool32a_op, 0, 0, 0, mm_mtlo32_op, mm_pool32axf_op), RS},
+	[insn_mul]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_mul_op), RT | RS | RD},
+	[insn_or]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_or32_op), RT | RS | RD},
+	[insn_ori]	= {M(mm_ori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM},
+	[insn_pref]	= {M(mm_pool32c_op, 0, 0, (mm_pref_func << 1), 0, 0), RT | RS | SIMM},
+	[insn_rfe]	= {0, 0},
+	[insn_sc]	= {M(mm_pool32c_op, 0, 0, (mm_sc_func << 1), 0, 0), RT | RS | SIMM},
+	[insn_scd]	= {0, 0},
+	[insn_sd]	= {0, 0},
+	[insn_sll]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_sll32_op), RT | RS | RD},
+	[insn_sllv]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_sllv32_op), RT | RS | RD},
+	[insn_slt]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_slt_op), RT | RS | RD},
+	[insn_sltiu]	= {M(mm_sltiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
+	[insn_sltu]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_sltu_op), RT | RS | RD},
+	[insn_sra]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_sra_op), RT | RS | RD},
+	[insn_srl]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_srl32_op), RT | RS | RD},
+	[insn_srlv]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_srlv32_op), RT | RS | RD},
+	[insn_rotr]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_rotr_op), RT | RS | RD},
+	[insn_subu]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_subu32_op), RT | RS | RD},
+	[insn_sw]	= {M(mm_sw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
+	[insn_sync]	= {M(mm_pool32a_op, 0, 0, 0, mm_sync_op, mm_pool32axf_op), RS},
+	[insn_tlbp]	= {M(mm_pool32a_op, 0, 0, 0, mm_tlbp_op, mm_pool32axf_op), 0},
+	[insn_tlbr]	= {M(mm_pool32a_op, 0, 0, 0, mm_tlbr_op, mm_pool32axf_op), 0},
+	[insn_tlbwi]	= {M(mm_pool32a_op, 0, 0, 0, mm_tlbwi_op, mm_pool32axf_op), 0},
+	[insn_tlbwr]	= {M(mm_pool32a_op, 0, 0, 0, mm_tlbwr_op, mm_pool32axf_op), 0},
+	[insn_wait]	= {M(mm_pool32a_op, 0, 0, 0, mm_wait_op, mm_pool32axf_op), SCIMM},
+	[insn_wsbh]	= {M(mm_pool32a_op, 0, 0, 0, mm_wsbh_op, mm_pool32axf_op), RT | RS},
+	[insn_xor]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_xor32_op), RT | RS | RD},
+	[insn_xori]	= {M(mm_xori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM},
+	[insn_dins]	= {0, 0},
+	[insn_dinsm]	= {0, 0},
+	[insn_syscall]	= {M(mm_pool32a_op, 0, 0, 0, mm_syscall_op, mm_pool32axf_op), SCIMM},
+	[insn_bbit0]	= {0, 0},
+	[insn_bbit1]	= {0, 0},
+	[insn_lwx]	= {0, 0},
+	[insn_ldx]	= {0, 0},
 };
 
 #undef M
@@ -156,20 +155,17 @@ static inline u32 build_jimm(u32 arg)
  */
 static void build_insn(u32 **buf, enum opcode opc, ...)
 {
-	struct insn *ip = NULL;
-	unsigned int i;
+	const struct insn *ip;
 	va_list ap;
 	u32 op;
 
-	for (i = 0; insn_table_MM[i].opcode != insn_invalid; i++)
-		if (insn_table_MM[i].opcode == opc) {
-			ip = &insn_table_MM[i];
-			break;
-		}
-
-	if (!ip || (opc == insn_daddiu && r4k_daddiu_bug()))
+	if (opc < 0 || opc >= insn_invalid ||
+	    (opc == insn_daddiu && r4k_daddiu_bug()) ||
+	    (insn_table_MM[opc].match == 0 && insn_table_MM[opc].fields == 0))
 		panic("Unsupported Micro-assembler instruction %d", opc);
 
+	ip = &insn_table_MM[opc];
+
 	op = ip->match;
 	va_start(ap, opc);
 	if (ip->fields & RS) {
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 2277499..f3937e3 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -48,126 +48,124 @@
 
 #include "uasm.c"
 
-static struct insn insn_table[] = {
-	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
-	{ insn_andi, M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM },
-	{ insn_and, M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD },
-	{ insn_bbit0, M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_bbit1, M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_beql, M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_beq, M(beq_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_bgezl, M(bcond_op, 0, bgezl_op, 0, 0, 0), RS | BIMM },
-	{ insn_bgez, M(bcond_op, 0, bgez_op, 0, 0, 0), RS | BIMM },
-	{ insn_bltzl, M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM },
-	{ insn_bltz, M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM },
-	{ insn_bne, M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+static const struct insn const insn_table[insn_invalid] = {
+	[insn_addiu]	= {M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
+	[insn_addu]	= {M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD},
+	[insn_and]	= {M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD},
+	[insn_andi]	= {M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM},
+	[insn_bbit0]	= {M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
+	[insn_bbit1]	= {M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
+	[insn_beq]	= {M(beq_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
+	[insn_beql]	= {M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
+	[insn_bgez]	= {M(bcond_op, 0, bgez_op, 0, 0, 0), RS | BIMM},
+	[insn_bgezl]	= {M(bcond_op, 0, bgezl_op, 0, 0, 0), RS | BIMM},
+	[insn_bltz]	= {M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM},
+	[insn_bltzl]	= {M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM},
+	[insn_bne]	= {M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
 #ifndef CONFIG_CPU_MIPSR6
-	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	[insn_cache]	= {M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 #else
-	{ insn_cache,  M6(spec3_op, 0, 0, 0, cache6_op),  RS | RT | SIMM9 },
+	[insn_cache]	= {M6(spec3_op, 0, 0, 0, cache6_op),  RS | RT | SIMM9},
 #endif
-	{ insn_cfc1, M(cop1_op, cfc_op, 0, 0, 0, 0), RT | RD },
-	{ insn_cfcmsa, M(msa_op, 0, msa_cfc_op, 0, 0, msa_elm_op), RD | RE },
-	{ insn_ctc1, M(cop1_op, ctc_op, 0, 0, 0, 0), RT | RD },
-	{ insn_ctcmsa, M(msa_op, 0, msa_ctc_op, 0, 0, msa_elm_op), RD | RE },
-	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
-	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
-	{ insn_di, M(cop0_op, mfmc0_op, 0, 12, 0, 0), RT },
-	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
-	{ insn_divu, M(spec_op, 0, 0, 0, 0, divu_op), RS | RT },
-	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
-	{ insn_dmtc0, M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
-	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
-	{ insn_drotr, M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE },
-	{ insn_dsll32, M(spec_op, 0, 0, 0, 0, dsll32_op), RT | RD | RE },
-	{ insn_dsll, M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE },
-	{ insn_dsra, M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE },
-	{ insn_dsrl32, M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE },
-	{ insn_dsrl, M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE },
-	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
-	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
-	{ insn_ext, M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE },
-	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
-	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
-	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),	JIMM },
-	{ insn_jalr,  M(spec_op, 0, 0, 0, 0, jalr_op), RS | RD },
-	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
+	[insn_cfc1]	= {M(cop1_op, cfc_op, 0, 0, 0, 0), RT | RD},
+	[insn_cfcmsa]	= {M(msa_op, 0, msa_cfc_op, 0, 0, msa_elm_op), RD | RE},
+	[insn_ctc1]	= {M(cop1_op, ctc_op, 0, 0, 0, 0), RT | RD},
+	[insn_ctcmsa]	= {M(msa_op, 0, msa_ctc_op, 0, 0, msa_elm_op), RD | RE},
+	[insn_daddiu]	= {M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
+	[insn_daddu]	= {M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD},
+	[insn_di]	= {M(cop0_op, mfmc0_op, 0, 12, 0, 0), RT},
+	[insn_dins]	= {M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE},
+	[insn_dinsm]	= {M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE},
+	[insn_divu]	= {M(spec_op, 0, 0, 0, 0, divu_op), RS | RT},
+	[insn_dmfc0]	= {M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
+	[insn_dmtc0]	= {M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
+	[insn_drotr]	= {M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE},
+	[insn_drotr32]	= {M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE},
+	[insn_dsll]	= {M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE},
+	[insn_dsll32]	= {M(spec_op, 0, 0, 0, 0, dsll32_op), RT | RD | RE},
+	[insn_dsra]	= {M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE},
+	[insn_dsrl]	= {M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE},
+	[insn_dsrl32]	= {M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE},
+	[insn_dsubu]	= {M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD},
+	[insn_eret]	= {M(cop0_op, cop_op, 0, 0, 0, eret_op),  0},
+	[insn_ext]	= {M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE},
+	[insn_ins]	= {M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE},
+	[insn_j]	= {M(j_op, 0, 0, 0, 0, 0),  JIMM},
+	[insn_jal]	= {M(jal_op, 0, 0, 0, 0, 0),	JIMM},
+	[insn_jalr]	= {M(spec_op, 0, 0, 0, 0, jalr_op), RS | RD},
 #ifndef CONFIG_CPU_MIPSR6
-	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
+	[insn_jr]	= {M(spec_op, 0, 0, 0, 0, jr_op),  RS},
 #else
-	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jalr_op),  RS },
+	[insn_jr]	= {M(spec_op, 0, 0, 0, 0, jalr_op),  RS},
 #endif
-	{ insn_lb, M(lb_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
-	{ insn_lh,  M(lh_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_lhu,  M(lhu_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	[insn_lb]	= {M(lb_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
+	[insn_ld]	= {M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_lddir]	= {M(lwc2_op, 0, 0, 0, lddir_op, mult_op), RS | RT | RD},
+	[insn_ldpte]	= {M(lwc2_op, 0, 0, 0, ldpte_op, mult_op), RS | RD},
+	[insn_ldx]	= {M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD},
+	[insn_lh]	= {M(lh_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_lhu]	= {M(lhu_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 #ifndef CONFIG_CPU_MIPSR6
-	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
-	{ insn_ll,  M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	[insn_ll]	= {M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_lld]	= {M(lld_op, 0, 0, 0, 0, 0),	RS | RT | SIMM},
 #else
-	{ insn_lld,  M6(spec3_op, 0, 0, 0, lld6_op),  RS | RT | SIMM9 },
-	{ insn_ll,  M6(spec3_op, 0, 0, 0, ll6_op),  RS | RT | SIMM9 },
+	[insn_ll]	= {M6(spec3_op, 0, 0, 0, ll6_op),  RS | RT | SIMM9},
+	[insn_lld]	= {M6(spec3_op, 0, 0, 0, lld6_op),  RS | RT | SIMM9},
 #endif
-	{ insn_lui,  M(lui_op, 0, 0, 0, 0, 0),	RT | SIMM },
-	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
-	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_mfhc0,  M(cop0_op, mfhc0_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_mfhi,  M(spec_op, 0, 0, 0, 0, mfhi_op), RD },
-	{ insn_mflo,  M(spec_op, 0, 0, 0, 0, mflo_op), RD },
-	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_mthc0,  M(cop0_op, mthc0_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_mthi,  M(spec_op, 0, 0, 0, 0, mthi_op), RS },
-	{ insn_mtlo,  M(spec_op, 0, 0, 0, 0, mtlo_op), RS },
+	[insn_lui]	= {M(lui_op, 0, 0, 0, 0, 0),	RT | SIMM},
+	[insn_lw]	= {M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_lwx]	= {M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD},
+	[insn_mfc0]	= {M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
+	[insn_mfhc0]	= {M(cop0_op, mfhc0_op, 0, 0, 0, 0),  RT | RD | SET},
+	[insn_mfhi]	= {M(spec_op, 0, 0, 0, 0, mfhi_op), RD},
+	[insn_mflo]	= {M(spec_op, 0, 0, 0, 0, mflo_op), RD},
+	[insn_mtc0]	= {M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
+	[insn_mthc0]	= {M(cop0_op, mthc0_op, 0, 0, 0, 0),  RT | RD | SET},
+	[insn_mthi]	= {M(spec_op, 0, 0, 0, 0, mthi_op), RS},
+	[insn_mtlo]	= {M(spec_op, 0, 0, 0, 0, mtlo_op), RS},
 #ifndef CONFIG_CPU_MIPSR6
-	{ insn_mul, M(spec2_op, 0, 0, 0, 0, mul_op), RS | RT | RD},
+	[insn_mul]	= {M(spec2_op, 0, 0, 0, 0, mul_op), RS | RT | RD},
 #else
-	{ insn_mul, M(spec_op, 0, 0, 0, mult_mul_op, mult_op), RS | RT | RD},
+	[insn_mul]	= {M(spec_op, 0, 0, 0, mult_mul_op, mult_op), RS | RT | RD},
 #endif
-	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM },
-	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
+	[insn_or]	= {M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD},
+	[insn_ori]	= {M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM},
 #ifndef CONFIG_CPU_MIPSR6
-	{ insn_pref,  M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	[insn_pref]	= {M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 #else
-	{ insn_pref,  M6(spec3_op, 0, 0, 0, pref6_op),  RS | RT | SIMM9 },
+	[insn_pref]	= {M6(spec3_op, 0, 0, 0, pref6_op),  RS | RT | SIMM9},
 #endif
-	{ insn_rfe,  M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0 },
-	{ insn_rotr,  M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE },
+	[insn_rfe]	= {M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0},
+	[insn_rotr]	= {M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE},
 #ifndef CONFIG_CPU_MIPSR6
-	{ insn_scd,  M(scd_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
-	{ insn_sc,  M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	[insn_sc]	= {M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_scd]	= {M(scd_op, 0, 0, 0, 0, 0),	RS | RT | SIMM},
 #else
-	{ insn_scd,  M6(spec3_op, 0, 0, 0, scd6_op),  RS | RT | SIMM9 },
-	{ insn_sc,  M6(spec3_op, 0, 0, 0, sc6_op),  RS | RT | SIMM9 },
+	[insn_sc]	= {M6(spec3_op, 0, 0, 0, sc6_op),  RS | RT | SIMM9},
+	[insn_scd]	= {M6(spec3_op, 0, 0, 0, scd6_op),  RS | RT | SIMM9},
 #endif
-	{ insn_sd,  M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
-	{ insn_sllv,  M(spec_op, 0, 0, 0, 0, sllv_op),  RS | RT | RD },
-	{ insn_slt,  M(spec_op, 0, 0, 0, 0, slt_op),  RS | RT | RD },
-	{ insn_sltiu, M(sltiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_sltu, M(spec_op, 0, 0, 0, 0, sltu_op), RS | RT | RD },
-	{ insn_sra,  M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE },
-	{ insn_srl,  M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE },
-	{ insn_srlv,  M(spec_op, 0, 0, 0, 0, srlv_op),  RS | RT | RD },
-	{ insn_subu,  M(spec_op, 0, 0, 0, 0, subu_op),	RS | RT | RD },
-	{ insn_sw,  M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_sync, M(spec_op, 0, 0, 0, 0, sync_op), RE },
-	{ insn_syscall, M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
-	{ insn_tlbp,  M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0 },
-	{ insn_tlbr,  M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0 },
-	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
-	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
-	{ insn_wait, M(cop0_op, cop_op, 0, 0, 0, wait_op), SCIMM },
-	{ insn_wsbh, M(spec3_op, 0, 0, 0, wsbh_op, bshfl_op), RT | RD },
-	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
-	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
-	{ insn_yield, M(spec3_op, 0, 0, 0, 0, yield_op), RS | RD },
-	{ insn_ldpte, M(lwc2_op, 0, 0, 0, ldpte_op, mult_op), RS | RD },
-	{ insn_lddir, M(lwc2_op, 0, 0, 0, lddir_op, mult_op), RS | RT | RD },
-	{ insn_invalid, 0, 0 }
+	[insn_sd]	= {M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_sll]	= {M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE},
+	[insn_sllv]	= {M(spec_op, 0, 0, 0, 0, sllv_op),  RS | RT | RD},
+	[insn_slt]	= {M(spec_op, 0, 0, 0, 0, slt_op),  RS | RT | RD},
+	[insn_sltiu]	= {M(sltiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
+	[insn_sltu]	= {M(spec_op, 0, 0, 0, 0, sltu_op), RS | RT | RD},
+	[insn_sra]	= {M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE},
+	[insn_srl]	= {M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE},
+	[insn_srlv]	= {M(spec_op, 0, 0, 0, 0, srlv_op),  RS | RT | RD},
+	[insn_subu]	= {M(spec_op, 0, 0, 0, 0, subu_op),	RS | RT | RD},
+	[insn_sw]	= {M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_sync]	= {M(spec_op, 0, 0, 0, 0, sync_op), RE},
+	[insn_syscall]	= {M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
+	[insn_tlbp]	= {M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0},
+	[insn_tlbr]	= {M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0},
+	[insn_tlbwi]	= {M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0},
+	[insn_tlbwr]	= {M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0},
+	[insn_wait]	= {M(cop0_op, cop_op, 0, 0, 0, wait_op), SCIMM},
+	[insn_wsbh]	= {M(spec3_op, 0, 0, 0, wsbh_op, bshfl_op), RT | RD},
+	[insn_xor]	= {M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD},
+	[insn_xori]	= {M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM},
+	[insn_yield]	= {M(spec3_op, 0, 0, 0, 0, yield_op), RS | RD},
 };
 
 #undef M
@@ -196,20 +194,17 @@ static inline u32 build_jimm(u32 arg)
  */
 static void build_insn(u32 **buf, enum opcode opc, ...)
 {
-	struct insn *ip = NULL;
-	unsigned int i;
+	const struct insn *ip;
 	va_list ap;
 	u32 op;
 
-	for (i = 0; insn_table[i].opcode != insn_invalid; i++)
-		if (insn_table[i].opcode == opc) {
-			ip = &insn_table[i];
-			break;
-		}
-
-	if (!ip || (opc == insn_daddiu && r4k_daddiu_bug()))
+	if (opc < 0 || opc >= insn_invalid ||
+	    (opc == insn_daddiu && r4k_daddiu_bug()) ||
+	    (insn_table[opc].match == 0 && insn_table[opc].fields == 0))
 		panic("Unsupported Micro-assembler instruction %d", opc);
 
+	ip = &insn_table[opc];
+
 	op = ip->match;
 	va_start(ap, opc);
 	if (ip->fields & RS)
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 730363b..f23ed85 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -46,7 +46,6 @@ enum fields {
 #define SIMM9_MASK	0x1ff
 
 enum opcode {
-	insn_invalid,
 	insn_addiu, insn_addu, insn_and, insn_andi, insn_bbit0, insn_bbit1,
 	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
 	insn_bne, insn_cache, insn_cfc1, insn_cfcmsa, insn_ctc1, insn_ctcmsa,
@@ -62,10 +61,10 @@ enum opcode {
 	insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall, insn_tlbp,
 	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh, insn_xor,
 	insn_xori, insn_yield, insn_lddir, insn_ldpte, insn_lhu,
+	insn_invalid /* insn_invalid must be last */
 };
 
 struct insn {
-	enum opcode opcode;
 	u32 match;
 	enum fields fields;
 };
-- 
2.9.4
