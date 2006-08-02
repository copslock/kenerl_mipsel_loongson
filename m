Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2006 14:09:25 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.188]:17078 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133453AbWHBNJP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Aug 2006 14:09:15 +0100
Received: by nf-out-0910.google.com with SMTP id q29so648439nfc
        for <linux-mips@linux-mips.org>; Wed, 02 Aug 2006 06:08:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=KFNItiNCC85KpgX/cQJGIMMBNSlIk9VSU5sE1T2+nAItbeG2aiDlkwVkIdHCzFY/OaBBFPjFMX2+ME1ALZMOAr0mvzXs1VDBtf4CgF9mogEj59NtnERk2b6anhOBKLE9D0o8f1olPporLkxf65jWNcT/ZnOO2MLCKzlDTwNxPPs=
Received: by 10.49.21.8 with SMTP id y8mr2119831nfi;
        Wed, 02 Aug 2006 06:08:52 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id n23sm1471470nfc.2006.08.02.06.08.51;
        Wed, 02 Aug 2006 06:08:52 -0700 (PDT)
Message-ID: <44D0A3B0.40601@innova-card.com>
Date:	Wed, 02 Aug 2006 15:08:00 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 7/7] Allow unwind_stack() to return ra for leaf function
References: <cda58cb80608011238q5b0e0eacje28f921d6e1c7700@mail.gmail.com>	<20060802.105126.88700874.nemoto@toshiba-tops.co.jp>	<44D07C97.2040008@innova-card.com> <20060802.202540.10544424.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060802.202540.10544424.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 02 Aug 2006 12:21:11 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> does something like this on top of this patch make you feel better ?
>>
>> -- >8 --
>>
>> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
>> index 4ceddfa..8a9db45 100644
>> --- a/arch/mips/kernel/process.c
>> +++ b/arch/mips/kernel/process.c
>> @@ -480,7 +480,13 @@ unsigned long unwind_stack(struct task_s
>>  		return 0;
>>  
>>  	if (leaf)
>> -		pc = regs->regs[31];
>> +		/*
>> +		 * For some extreme cases, get_frame_info() can
>> +		 * consider wrongly a nested function as a leaf
>> +		 * one. In that cases avoid to return always the
>> +		 * same value.
>> +		 */
>> +		pc = pc != regs->regs[31] ? regs->regs[31] : 0;
> 
> Yes, it should be safe.  But still I'm not sure unwind_stack() should
> take "regs" as its argument...
> 

does this updated patch make you really happy ? If so I'll resend the whole
updated patchset.

-- >8 --
Subject: Improve unwind_stack()

This patch allows unwind_stack() to return ra for leaf function.
But it tries to detects cases where get_frame_info() wrongly
consider nested function as a leaf one.

It also pass 'unsinged long *sp' instead of 'unsigned long **sp'
as second parameter. The code looks cleaner.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/process.c |   35 ++++++++++++++++++++++-------------
 arch/mips/kernel/traps.c   |   24 ++++++++++++------------
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 309bfa4..951bf9c 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -448,15 +448,16 @@ #endif
 }
 
 #ifdef CONFIG_KALLSYMS
-/* used by show_frametrace() */
-unsigned long unwind_stack(struct task_struct *task,
-			   unsigned long **sp, unsigned long pc)
+/* used by show_backtrace() */
+unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
+			   unsigned long pc, unsigned long ra)
 {
 	unsigned long stack_page;
 	struct mips_frame_info info;
 	char *modname;
 	char namebuf[KSYM_NAME_LEN + 1];
 	unsigned long size, ofs;
+	int leaf;
 
 	stack_page = (unsigned long)task_stack_page(task);
 	if (!stack_page)
@@ -469,18 +470,26 @@ unsigned long unwind_stack(struct task_s
 
 	info.func = (void *)(pc - ofs);
 	info.func_size = ofs;	/* analyze from start to ofs */
-	if (get_frame_info(&info)) {
-		/* leaf or unknown */
-		*sp += info.frame_size / sizeof(long);
+	leaf = get_frame_info(&info);
+	if (leaf < 0)
 		return 0;
-	}
-	if ((unsigned long)*sp < stack_page ||
-	    (unsigned long)*sp + info.frame_size / sizeof(long) >
-	    stack_page + THREAD_SIZE - 32)
+
+	if (*sp < stack_page ||
+	    *sp + info.frame_size > stack_page + THREAD_SIZE - 32)
 		return 0;
 
-	pc = (*sp)[info.pc_offset];
-	*sp += info.frame_size / sizeof(long);
-	return pc;
+	if (leaf)
+		/*
+		 * For some extreme cases, get_frame_info() can
+		 * consider wrongly a nested function as a leaf
+		 * one. In that cases avoid to return always the
+		 * same value.
+		 */
+		pc = pc != ra ? ra : 0;
+	else
+		pc = ((unsigned long *)(*sp))[info.pc_offset];
+
+	*sp += info.frame_size;
+	return __kernel_text_address(pc) ? pc : 0;
 }
 #endif
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 303f008..ab77034 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -74,8 +74,9 @@ void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
 
 
-static void show_raw_backtrace(unsigned long *sp)
+static void show_raw_backtrace(unsigned long reg29)
 {
+	unsigned long *sp = (unsigned long *)reg29;
 	unsigned long addr;
 
 	printk("Call Trace:");
@@ -99,30 +100,29 @@ static int __init set_raw_show_trace(cha
 }
 __setup("raw_show_trace", set_raw_show_trace);
 
-extern unsigned long unwind_stack(struct task_struct *task,
-				  unsigned long **sp, unsigned long pc);
+extern unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
+				  unsigned long pc, unsigned long ra);
+
 static void show_backtrace(struct task_struct *task, struct pt_regs *regs)
 {
-	unsigned long *sp = (long *)regs->regs[29];
+	unsigned long sp = regs->regs[29];
+	unsigned long ra = regs->regs[31];
 	unsigned long pc = regs->cp0_epc;
-	int top = 1;
 
 	if (raw_show_trace || !__kernel_text_address(pc)) {
 		show_raw_backtrace(sp);
 		return;
 	}
 	printk("Call Trace:\n");
-	while (__kernel_text_address(pc)) {
+	do {
 		print_ip_sym(pc);
-		pc = unwind_stack(task, &sp, pc);
-		if (top && pc == 0)
-			pc = regs->regs[31];	/* leaf? */
-		top = 0;
-	}
+		pc = unwind_stack(task, &sp, pc, ra);
+		ra = 0;
+	} while (pc);
 	printk("\n");
 }
 #else
-#define show_backtrace(task, r) show_raw_backtrace((long *)(r)->regs[29]);
+#define show_backtrace(task, r) show_raw_backtrace((r)->regs[29]);
 #endif
 
 /*
-- 
1.4.2.rc2
