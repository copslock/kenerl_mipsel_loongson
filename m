Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2392FG11202
	for linux-mips-outgoing; Sun, 3 Mar 2002 01:02:15 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g23922911198
	for <linux-mips@oss.sgi.com>; Sun, 3 Mar 2002 01:02:03 -0800
Message-Id: <200203030902.g23922911198@oss.sgi.com>
Received: (qmail 11729 invoked from network); 3 Mar 2002 08:06:50 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 3 Mar 2002 08:06:50 -0000
Date: Sun, 3 Mar 2002 15:58:50 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: [PATCH] Re: Re: Re: Re: used_math not cleared for new processes?
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g23924911200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

ÔÚ 2002-03-01 11:11:00 you wrote£º
>hi,
> sorry,it seems this patch bring other problem,please don't use.
>i am investigating it.
With this patch, there may be more than one processes having CP0_CU1 enabled,
thus fp context may be corrupted silently.

The fix is to deprive fpu from last_task_used_math(if not null) in init_fpu
See the modified patch below.

BTW,when debugging for this problem,i found that every process will use fpu
at least once. in a statically linked executable of this program:
         main() {}
there are two cfc1, one in __setfpucw,the other in __sigsetjmp_aux
and many fpu ops in __mktime_internal.

the first fpu usage is caused by __setfpucw.

>>>
>>>I think it make sense to clear used_math in do_exec().  It also improvies the
>>> performance slightly by not loading the parent's FPU context when it uses the
>>>FPU for the first time.
it will need init_fpu then,but anyway register access is faster than memory access.
>>>
>>>Do you have a patch for this?
>>Yes. Here it is.
>>
>>--- processor.h.ori     Thu Feb 28 15:02:20 2002
>>+++ processor.h Thu Feb 28 15:00:10 2002
>>@@ -215,6 +215,7 @@
>>        regs->cp0_epc = new_pc;                                         \
>>        regs->regs[29] = new_sp;                                        \
>>        current->thread.current_ds = USER_DS;                           \
>>+       current->used_math = 0;                                         \
>> } while (0)
>> 
>> unsigned long get_wchan(struct task_struct *p);
>>
>>
>>--- traps.c.ori Thu Feb 28 15:04:48 2002
>>+++ traps.c     Thu Feb 28 15:05:23 2002
>>@@ -668,8 +668,12 @@
>>        if (current->used_math) {               /* Using the FPU again.  */
>>                lazy_fpu_switch(last_task_used_math);
>>        } else {                                /* First time FPU user.  */
>>-               if (last_task_used_math != NULL)
>>+               if (last_task_used_math != NULL) {
>>+                       int status = read_32bit_cp0_register(CP0_STATUS);
>>+                       write_32bit_cp0_register(CP0_STATUS,status|ST0_CU1);
>>+
>>                        save_fp(last_task_used_math);
>>+               }
This should be changed to:
+               if (last_task_used_math != NULL) {
+                       __enable_fpu();
                        save_fp(last_task_used_math);
+						/* last_task_used_math loose fpu */
+                      ((struct pt_regs *)(__KSTK_TOS(last_task_used_math) -
                         sizeof(struct pt_regs)))->cp0_status &= ~ST0_CU1;
+               }

>>                init_fpu();
>>                current->used_math = 1;
>>        }
>>
>>
>>>
>>>Jun
>>
>>Regards
>>            Zhang Fuxin
>>            fxzhang@ict.ac.cn
>
>Regards
>            Zhang Fuxin
>            fxzhang@ict.ac.cn

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
