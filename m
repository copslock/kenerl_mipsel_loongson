Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 04:16:06 +0100 (CET)
Received: from mail1.windriver.com ([147.11.146.13]:61087 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006516AbbLIDPp2f6cu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 04:15:45 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id tB93FY0L027004
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 8 Dec 2015 19:15:34 -0800 (PST)
Received: from pek-lpgbuild1.wrs.com (128.224.153.21) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Tue, 8 Dec 2015 19:15:34 -0800
From:   <yanjiang.jin@windriver.com>
To:     <rric@kernel.org>, <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <oprofile-list@lists.sf.net>,
        <yanjiang.jin@windriver.com>, <linux-kernel@vger.kernel.org>,
        <jinyanjiang@gmail.com>
Subject: [PATCH] MIPS: oprofile: Fix a preemption issue
Date:   Wed, 9 Dec 2015 11:15:27 +0800
Message-ID: <1449630927-14355-2-git-send-email-yanjiang.jin@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1449630927-14355-1-git-send-email-yanjiang.jin@windriver.com>
References: <1449630927-14355-1-git-send-email-yanjiang.jin@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Yanjiang.Jin@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanjiang.jin@windriver.com
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

From: Yanjiang Jin <yanjiang.jin@windriver.com>

Use boot_cpu_type() instead of current_cpu_type() in oprofile_arch_init()
to avoid the below warning, cpu_type is consistent in a MIPS SMP system.

BUG: using smp_processor_id() in preemptible [00000000] code: insmod/952
caller is oprofile_arch_init+0x30/0x194 [oprofile]
CPU: 5 PID: 952 Comm: insmod Not tainted 4.1.13-WR8.0.0.0_standard #1
Stack : ffffffff80c10000 0000000000000001 8000000025bf0790 ffffffff80e10000
	  ffffffff80e50000 ffffffff80254e2c ffffffff80b64428 ffffffff80e10790
	  0000000000000000 ffffffff801caeb8 0000000000000045 0000000000000005
	  ffffffff80c10000 ffffffff801cb798 0000000000000000 ffffffff80e30000
	  0000000000000000 ffffffff801ff1c0 ffffffff80e2d2f8 000000000000000b
	  ffffffff801cbba0 ffffffff80e107b0 ffffffff80a77828 0000000000000005
	  00000000000003b8 ffffffff80e2d2f8 800000040ad39960 ffffffff801f9950
	  0000000000000124 80000004093b7990 80000004093b7ab8 ffffffff80925108
	  ffffffff80b69a07 ffffffff80a6f0d0 8000000407240e00 ffffffff801cc934
	  000000000000005d ffffffff80159080 0000000000000005 00000000000003b8
	  ...
Call Trace:
[<ffffffff80159080>] show_stack+0xe8/0x108
[<ffffffff80925108>] dump_stack+0x8c/0xd8
[<ffffffff80606570>] check_preemption_disabled+0x110/0x118
[<ffffffffc0086104>] oprofile_arch_init+0x30/0x194 [oprofile]
[<ffffffffc008602c>] oprofile_init+0x2c/0xc0 [oprofile]
[<ffffffff80100550>] do_one_initcall+0xa0/0x1c0
[<ffffffff80921e04>] do_init_module+0x80/0x1d8
[<ffffffff801fd0d4>] load_module+0x1b74/0x2278
[<ffffffff801fdab4>] SyS_finit_module+0xcc/0xf0
[<ffffffff80165884>] handle_sysn32+0x44/0x70

Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
---
 arch/mips/oprofile/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index 3c9ec3d..2f33992 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -77,7 +77,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	struct op_mips_model *lmodel = NULL;
 	int res;
 
-	switch (current_cpu_type()) {
+	switch (boot_cpu_type()) {
 	case CPU_5KC:
 	case CPU_M14KC:
 	case CPU_M14KEC:
-- 
1.9.1
