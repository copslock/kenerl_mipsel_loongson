Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g127N7130451
	for linux-mips-outgoing; Fri, 1 Feb 2002 23:23:07 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g127N4d30447
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 23:23:04 -0800
Message-Id: <200202020723.g127N4d30447@oss.sgi.com>
Received: (qmail 5953 invoked from network); 2 Feb 2002 06:22:56 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 2 Feb 2002 06:22:56 -0000
Date: Sat, 2 Feb 2002 14:20:6 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: used_math not cleared for new processes?
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,linux-mips,
   I find that current->used_math isn't cleared when we start a new process.Is it
intended? I mean 'start_thread' in do_exec but not 'copy_thread' in do_fork when
speaking 'start a new process'. We can/should? keep used_math for the latter,but for
the former?

   It leads to a failure in libm-test(the fpu control register doesn't equal to default)
I think the reason is that init_fpu fail to be called with used_math set.
    
  BTW: besides this failure,i see a lot of more related to extra "Invalid operation" exception.
e.g.:
   exp(NaN) == NaN: Exception "Invalid operation" set
   fmax (0, NaN) == 0: Exception "Invalid operation" set
..
 
  My cpu is IDT RC64474,which is basically a r4600.

  I think the cause probably is mips's special SNaN and QNaN handling.

  Could somebody explain?

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
