Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 May 2013 18:11:54 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:49527 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822674Ab3EIQLwBHTxy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 May 2013 18:11:52 +0200
Received: by mail-pa0-f42.google.com with SMTP id bj3so2228785pad.1
        for <multiple recipients>; Thu, 09 May 2013 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=jw4MfX8uNnmxXPtuCvWM8Bizy3Z0wicC5LvldMqEDf0=;
        b=NjHvaPKSl06K5M0DajNeWN0TjYAL5wIfIvyPF3jDxSXGQNuOHFnlhUz/Dfg2Yq3C4P
         cZI1ypB2ymfGjnSkiqx3X5WbJj56V99vAjJjiX+IaV6XaK8GZTTSH8uKmVg4kEu/kdJ8
         yTcdEQBBDDB+YGKjECiDUEq47r50isWsZ5aoXuKsH9R3AebBLNuur1pew4CRx3fwVzO2
         ep5QhasoDL607ze1Bx7LYgUx7eppE2Vga4ouncbHpVmUDVa7UcvgMoXgOyvpu/YjCbbq
         7XRa4MoN3T1x78XIQg/mW+1YHP13RjxOWdNLVWY1HwNxs3IcsSVLLLJM05An5of1hAgE
         MOdQ==
X-Received: by 10.66.219.231 with SMTP id pr7mr13730664pac.47.1368115905044;
        Thu, 09 May 2013 09:11:45 -0700 (PDT)
Received: from localhost.localdomain ([114.250.80.3])
        by mx.google.com with ESMTPSA id qi1sm4181522pac.21.2013.05.09.09.11.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 May 2013 09:11:44 -0700 (PDT)
From:   Jiang Liu <liuj97@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jiang Liu <jiang.liu@huawei.com>,
        EUNBONG SONG <eunb.song@samsung.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm, MIPS: fix a bug caused by free_initmem_default()
Date:   Fri, 10 May 2013 00:10:04 +0800
Message-Id: <1368115804-22220-1-git-send-email-jiang.liu@huawei.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <liuj97@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liuj97@gmail.com
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

EUNBONG SONG <eunb.song@samsung.com> reported a bug on MIPS64 platforms
caused by free_initmem() as below:
[  132.134719] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.9.0+ #29
[  132.141678] Stack : 0000000000000004 000000000000003f ffffffff80fa0000 ffffffff802924a8
          0000000000000000 ffffffff80fa0000 00000000000000ff ffffffff80293760
          0000000000000000 0000000000000000 ffffffff81080000 ffffffff81080000
          ffffffff80e2baf0 ffffffff80f93977 a80000004146cbb8 0000000000000020
          0000000000000003 0000000000000020 a800000041473da8 ffffffff810f0000
          a800000041473a10 ffffffff806ef910 a800000041473828 ffffffff80290920
          0000000000000000 ffffffff80293b90 000000000000000a ffffffff80e2baf0
          0000000000000000 a800000041473750 000000004146cef8 ffffffff805e7794
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          0000000000000000 ffffffff80272498 0000000000000000 0000000000000000
          ...
[  132.207201] Call Trace:
[  132.209655] [<ffffffff80272498>] show_stack+0x68/0x80
[  132.225943] [<ffffffff802bd4ac>] notifier_call_chain+0x5c/0xa8
[  132.231776] [<ffffffff802bdb84>] __atomic_notifier_call_chain+0x3c/0x58
[  132.238391] [<ffffffff802bdbe8>] notify_die+0x38/0x48
[  132.243442] [<ffffffff802716cc>] die+0x4c/0x148
[  132.247974] [<ffffffff8027f998>] do_page_fault+0x4b8/0x500
[  132.253461] [<ffffffff8026c764>] resume_userspace_check+0x0/0x10
[  132.259469] [<ffffffff80324a54>] free_reserved_area+0x8c/0x178
[  132.265304] [<ffffffff806e0dc8>] kernel_init+0x20/0x100
[  132.270529] [<ffffffff8026c7e0>] ret_from_kernel_thread+0x10/0x18

The root cause is that virt_to_page()/virt_to_phys() can't be used to
handle virtual address from compatible segments on MIPS64 because
virt_to_phys() is defined as:
static inline unsigned long virt_to_phys(volatile const void *address)
{
        return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
}

x86_64 platforms have a similar situation, but __pa() has been enhanced
to handle virtual address space used for kernel code and data segments.
static inline unsigned long __phys_addr_nodebug(unsigned long x)
{
        unsigned long y = x - __START_KERNEL_map;

        /* use the carry flag to determine if x was < __START_KERNEL_map */
        x = y + ((x > y) ? phys_base : (__START_KERNEL_map - PAGE_OFFSET));

        return x;
}

So we have two possible solutions here. The quick solution is to revert
to the original implementation by using __pa_symbal(). The long term
solution is to enhance virt_to_phys() to correctly handle virtual
address from compatible segments.

This patch adopts the quick solution to fix the bug for v3.10, and we
need guidance from MIPS64 experts on whether we should go with the long
term solution.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Signed-off-by: EUNBONG SONG <eunb.song@samsung.com>
Cc: David Daney <ddaney.cavm@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/mm/init.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 3d0346d..3648768 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -446,7 +446,9 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 void __init_refok free_initmem(void)
 {
 	prom_free_prom_memory();
-	free_initmem_default(POISON_FREE_INITMEM);
+	free_init_pages("unused kernel memory",
+			__pa_symbol(&__init_begin),
+			__pa_symbol(&__init_end));
 }
 
 #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
-- 
1.7.9.5
