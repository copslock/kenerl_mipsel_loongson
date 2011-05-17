Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 17:16:54 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40074 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491077Ab1EQPQr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2011 17:16:47 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4HFIAdf008057;
        Tue, 17 May 2011 16:18:11 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4HFI9Ik008056;
        Tue, 17 May 2011 16:18:09 +0100
Date:   Tue, 17 May 2011 16:18:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Jian Peng <jipeng@broadcom.com>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Cleanup arch_get_unmapped_area
Message-ID: <20110517151809.GA7932@linux-mips.org>
References: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DD1BD72.2000408@caviumnetworks.com>
 <BANLkTikq04wuK=bz+Lieavmm3oDtoYWKxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BANLkTikq04wuK=bz+Lieavmm3oDtoYWKxg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 16, 2011 at 06:27:17PM -0700, Kevin Cernekee wrote:

> >> +#ifdef CONFIG_32BIT
> >> +       task_size = TASK_SIZE;
> >> +#else /* Must be CONFIG_64BIT*/
> >> +       task_size = test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 :
> >> TASK_SIZE;
> >> +#endif
> 
> Can the "#else" clause and "task_size" local variable be eliminated?
> TASK_SIZE now performs this check automatically (although that wasn't
> always the case).


As noticed by Kevin Cernekee <cernekee@gmail.com> in
http://www.linux-mips.org/cgi-bin/extract-mesg.cgi?a=linux-mips&m=2011-05&i=BANLkTikq04wuK%3Dbz%2BLieavmm3oDtoYWKxg%40mail.gmail.com

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/kernel/syscall.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

Index: linux-queue/arch/mips/kernel/syscall.c
===================================================================
--- linux-queue.orig/arch/mips/kernel/syscall.c
+++ linux-queue/arch/mips/kernel/syscall.c
@@ -79,20 +79,13 @@ unsigned long arch_get_unmapped_area(str
 {
 	struct vm_area_struct * vmm;
 	int do_color_align;
-	unsigned long task_size;
 
-#ifdef CONFIG_32BIT
-	task_size = TASK_SIZE;
-#else /* Must be CONFIG_64BIT*/
-	task_size = test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE;
-#endif
-
-	if (len > task_size)
+	if (len > TASK_SIZE)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED) {
-		/* Even MAP_FIXED mappings must reside within task_size.  */
-		if (task_size - len < addr)
+		/* Even MAP_FIXED mappings must reside within TASK_SIZE.  */
+		if (TASK_SIZE - len < addr)
 			return -EINVAL;
 
 		/*
@@ -114,7 +107,7 @@ unsigned long arch_get_unmapped_area(str
 		else
 			addr = PAGE_ALIGN(addr);
 		vmm = find_vma(current->mm, addr);
-		if (task_size - len >= addr &&
+		if (TASK_SIZE - len >= addr &&
 		    (!vmm || addr + len <= vmm->vm_start))
 			return addr;
 	}
@@ -126,7 +119,7 @@ unsigned long arch_get_unmapped_area(str
 
 	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (task_size - len < addr)
+		if (TASK_SIZE - len < addr)
 			return -ENOMEM;
 		if (!vmm || addr + len <= vmm->vm_start)
 			return addr;
