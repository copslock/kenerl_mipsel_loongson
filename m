Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1S8EMN32386
	for linux-mips-outgoing; Thu, 28 Feb 2002 00:14:22 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1S8EF932382
	for <linux-mips@oss.sgi.com>; Thu, 28 Feb 2002 00:14:15 -0800
Message-Id: <200202280814.g1S8EF932382@oss.sgi.com>
Received: (qmail 6828 invoked from network); 28 Feb 2002 07:18:33 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 28 Feb 2002 07:18:33 -0000
Date: Thu, 28 Feb 2002 15:10:57 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Jun Sun <jsun@mvista.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: used_math not cleared for new processes?
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g1S8EG932383
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

ÔÚ 2002-02-27 14:53:00 you wrote£º
>Zhang Fuxin wrote:
>
>> hi,linux-mips,
>>    I find that current->used_math isn't cleared when we start a new process.Is it
>> intended? I mean 'start_thread' in do_exec but not 'copy_thread' in do_fork when
>> speaking 'start a new process'. We can/should? keep used_math for the latter,but for
>> the former?
>> 
>
>
>I think it make sense to clear used_math in do_exec().  It also improvies the
> performance slightly by not loading the parent's FPU context when it uses the
>FPU for the first time.
>
>Do you have a patch for this?
Yes. Here it is.

--- processor.h.ori     Thu Feb 28 15:02:20 2002
+++ processor.h Thu Feb 28 15:00:10 2002
@@ -215,6 +215,7 @@
        regs->cp0_epc = new_pc;                                         \
        regs->regs[29] = new_sp;                                        \
        current->thread.current_ds = USER_DS;                           \
+       current->used_math = 0;                                         \
 } while (0)
 
 unsigned long get_wchan(struct task_struct *p);


--- traps.c.ori Thu Feb 28 15:04:48 2002
+++ traps.c     Thu Feb 28 15:05:23 2002
@@ -668,8 +668,12 @@
        if (current->used_math) {               /* Using the FPU again.  */
                lazy_fpu_switch(last_task_used_math);
        } else {                                /* First time FPU user.  */
-               if (last_task_used_math != NULL)
+               if (last_task_used_math != NULL) {
+                       int status = read_32bit_cp0_register(CP0_STATUS);
+                       write_32bit_cp0_register(CP0_STATUS,status|ST0_CU1);
+
                        save_fp(last_task_used_math);
+               }
                init_fpu();
                current->used_math = 1;
        }


>
>Jun

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
