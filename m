Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 18:13:39 +0100 (CET)
Received: from ams-iport-1.cisco.com ([144.254.224.140]:21933 "EHLO
        ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903673Ab1KHRLt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2011 18:11:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=manesoni@cisco.com; l=4259; q=dns/txt;
  s=iport; t=1320772309; x=1321981909;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=OxhInuSsFEI+vWSGU17lSM+Dedft4KQJy09V5AmlXQo=;
  b=lBN5ehFqzk7ye1TlM9apOCRhxx6rwxSlyCZONJmcIZZuP6S6jg05igxU
   kSUVeHlS9/KBt6gzEyAfrZsHuHjq2IbyUNydFmBY/SVwrwpSZIjvZLzET
   1GprTofQLSZZbkMDNJnog2WsQE/OJ+T14ajxq7/d0zVvmyUmar5CLzvFU
   8=;
X-IronPort-AV: E=Sophos;i="4.69,477,1315180800"; 
   d="scan'208";a="121097004"
Received: from ams-core-2.cisco.com ([144.254.72.75])
  by ams-iport-1.cisco.com with ESMTP; 08 Nov 2011 17:11:40 +0000
Received: from manesoni-ws.cisco.com ([10.65.74.254])
        by ams-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id pA8HBdgA015597;
        Tue, 8 Nov 2011 17:11:39 GMT
Received: by manesoni-ws.cisco.com (Postfix, from userid 1001)
        id 2444B82FC2; Tue,  8 Nov 2011 22:34:54 +0530 (IST)
Date:   Tue, 8 Nov 2011 22:34:54 +0530
From:   Maneesh Soni <manesoni@cisco.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>, ananth@in.ibm.com,
        kamensky@cisco.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 1/4] MIPS Kprobes: Fix OOPS in arch_prepare_kprobe()
Message-ID: <20111108170454.GB16526@cisco.com>
Reply-To: manesoni@cisco.com
References: <20111108170336.GA16526@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111108170336.GA16526@cisco.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 31435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manesoni@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6937


From: Maneesh Soni <manesoni@cisco.com>

Fix OOPS in arch_prepare_kprobe() for MIPS

This patch fixes the arch_prepare_kprobe() on MIPS when it tries to find the
instruction at the previous address to the probed address. The oops happens
when the probed address is the first address in a kernel module and there is
no previous address. The patch uses probe_kernel_read() to safely read the
previous instruction.

CPU 3 Unable to handle kernel paging request at virtual address ffffffffc0211ffc, epc == ffffffff81113204, ra == ffffffff8111511c
Oops[#1]:
Cpu 3
$ 0   : 0000000000000000 0000000000000001 ffffffffc0212000 0000000000000000
$ 4   : ffffffffc0220030 0000000000000000 0000000000000adf ffffffff81a3f898
$ 8   : ffffffffc0220030 ffffffffffffffff 000000000000ffff 0000000000004821
$12   : 000000000000000a ffffffff81105ddc ffffffff812927d0 0000000000000000
$16   : ffffffff81a40000 ffffffffc0220030 ffffffffc0220030 ffffffffc0212660
$20   : 0000000000000000 0000000000000008 efffffffffffffff ffffffffc0220000
$24   : 0000000000000002 ffffffff8139f5b0
$28   : a800000072adc000 a800000072adfca0 ffffffffc0220000 ffffffff8111511c
Hi    : 0000000000000000
Lo    : 0000000000000000
epc   : ffffffff81113204 arch_prepare_kprobe+0x1c/0xe8
    Tainted: P
ra    : ffffffff8111511c register_kprobe+0x33c/0x730
Status: 10008ce3    KX SX UX KERNEL EXL IE
Cause : 00800008
BadVA : ffffffffc0211ffc
PrId  : 000d9008 (Cavium Octeon II)
Modules linked in: bpa_mem crashinfo pds tun cpumem ipv6 exportfs nfsd OOBnd(P) OOBhal(P) cvmx_mdio cvmx_gpio aipcmod(P) mtsmod procfs(P) utaker_mod dplr_pci hello atomicm_foo [last unloaded: sysmgr_hb]
Process stapio (pid: 5603, threadinfo=a800000072adc000, task=a8000000722e0438, tls=000000002b4bcda0)
Stack : ffffffff81a40000 ffffffff81a40000 ffffffffc0220030 ffffffff8111511c
        ffffffffc0218008 0000000000000001 ffffffffc0218008 0000000000000001
        ffffffffc0220000 ffffffffc021efe8 1000000000000000 0000000000000008
        efffffffffffffff ffffffffc0220000 ffffffffc0220000 ffffffffc021d500
        0000000000000022 0000000000000002 1111000072be02b8 0000000000000000
        00000000000015e6 00000000000015e6 00000000007d0f00 a800000072be02b8
        0000000000000000 ffffffff811d16c8 a80000000382e3b0 ffffffff811d5ba0
        ffffffff81b0a270 ffffffff81b0a270 ffffffffc0212000 0000000000000013
        ffffffffc0220030 ffffffffc021ed00 a800000089114c80 000000007f90d590
        a800000072adfe38 a800000089114c80 0000000010020000 0000000010020000
        ...
Call Trace:
[<ffffffff81113204>] arch_prepare_kprobe+0x1c/0xe8
[<ffffffff8111511c>] register_kprobe+0x33c/0x730
[<ffffffffc021d500>] _stp_ctl_write_cmd+0x8e8/0xa88 [atomicm_foo]
[<ffffffff812925cc>] vfs_write+0xb4/0x178
[<ffffffff81292828>] SyS_write+0x58/0x148
[<ffffffff81103844>] handle_sysn32+0x44/0x84

Code: ffb20010  ffb00000  dc820028 <8c44fffc> 8c500000  0c4449e0  0004203c  14400029  3c048199

Signed-off-by: Maneesh Soni <manesoni@cisco.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
---
---
 arch/mips/kernel/kprobes.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index ee28683..9fb1876 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -25,6 +25,7 @@
 
 #include <linux/kprobes.h>
 #include <linux/preempt.h>
+#include <linux/uaccess.h>
 #include <linux/kdebug.h>
 #include <linux/slab.h>
 
@@ -118,11 +119,19 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	union mips_instruction prev_insn;
 	int ret = 0;
 
-	prev_insn = p->addr[-1];
 	insn = p->addr[0];
 
-	if (insn_has_delayslot(insn) || insn_has_delayslot(prev_insn)) {
-		pr_notice("Kprobes for branch and jump instructions are not supported\n");
+	if (insn_has_delayslot(insn)) {
+		pr_notice("Kprobes for branch and jump instructions are not"
+			  "supported\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if ((probe_kernel_read(&prev_insn, p->addr - 1,
+				sizeof(mips_instruction)) == 0) &&
+				insn_has_delayslot(prev_insn)) {
+		pr_notice("Kprobes for branch delayslot are not supported\n");
 		ret = -EINVAL;
 		goto out;
 	}
-- 
1.7.1
