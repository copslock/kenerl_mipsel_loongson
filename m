Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g214E4701980
	for linux-mips-outgoing; Thu, 28 Feb 2002 20:14:04 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g214Dv901970
	for <linux-mips@oss.sgi.com>; Thu, 28 Feb 2002 20:13:57 -0800
Message-Id: <200203010413.g214Dv901970@oss.sgi.com>
Received: (qmail 6579 invoked from network); 1 Mar 2002 03:18:26 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 1 Mar 2002 03:18:26 -0000
Date: Fri, 1 Mar 2002 11:11:22 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
CC: "jsun@mvista.com" <jsun@mvista.com>
Subject: Re: Re: Re: used_math not cleared for new processes?
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,
 sorry,it seems this patch bring other problem,please don't use.
i am investigating it.

>>
>>I think it make sense to clear used_math in do_exec().  It also improvies the
>> performance slightly by not loading the parent's FPU context when it uses the
>>FPU for the first time.
>>
>>Do you have a patch for this?
>Yes. Here it is.
>
>--- processor.h.ori     Thu Feb 28 15:02:20 2002
>+++ processor.h Thu Feb 28 15:00:10 2002
>@@ -215,6 +215,7 @@
>        regs->cp0_epc = new_pc;                                         \
>        regs->regs[29] = new_sp;                                        \
>        current->thread.current_ds = USER_DS;                           \
>+       current->used_math = 0;                                         \
> } while (0)
> 
> unsigned long get_wchan(struct task_struct *p);
>
>
>--- traps.c.ori Thu Feb 28 15:04:48 2002
>+++ traps.c     Thu Feb 28 15:05:23 2002
>@@ -668,8 +668,12 @@
>        if (current->used_math) {               /* Using the FPU again.  */
>                lazy_fpu_switch(last_task_used_math);
>        } else {                                /* First time FPU user.  */
>-               if (last_task_used_math != NULL)
>+               if (last_task_used_math != NULL) {
>+                       int status = read_32bit_cp0_register(CP0_STATUS);
>+                       write_32bit_cp0_register(CP0_STATUS,status|ST0_CU1);
>+
>                        save_fp(last_task_used_math);
>+               }
>                init_fpu();
>                current->used_math = 1;
>        }
>
>
>>
>>Jun
>
>Regards
>            Zhang Fuxin
>            fxzhang@ict.ac.cn

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
