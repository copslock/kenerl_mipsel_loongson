Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 19:08:48 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:15101 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122961AbSIMRIr>;
	Fri, 13 Sep 2002 19:08:47 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g8DH8WUD023841;
	Fri, 13 Sep 2002 10:08:32 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id KAA04242;
	Fri, 13 Sep 2002 10:08:33 -0700 (PDT)
Message-ID: <009201c25b48$7da2cf30$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Gareth" <g.c.bransby-99@student.lboro.ac.uk>,
	<linux-mips@linux-mips.org>
References: <20020913172824.5c7ed0a4.g.c.bransby-99@student.lboro.ac.uk>
Subject: Re: Cycle counter
Date: Fri, 13 Sep 2002 19:10:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

A few comments, a couple of which are in common with
Nick's response.

1) With anything except the absolutely latest MIPS CPU
     design (the M4K), you cannot access the Count register
     unless you have full system coprocessor access, which
     is to say, unless you are in the kernel.  If you're doing
     this in user mode, I would expect you to get a SIGILL
     on your mtc0/mfc0.  If you're embedding your code
     in the kernel and triggering it via a system call, and if
     you disable interrupts during the sample interval, you
     should get a more-or-less accurate result.

2)  As Nick points out, you should absolutely never
     *write* to the count register.  Sample it and compute
     deltas, but do not change it, as system timing depends
     on it in many (most?) kernels.

3)  Make sure you check the users manual for your CPU
      to determine whether the count register is incremented
      every cycle or every two cycles.

4)  Personally, when I want to know how long a loop takes
     to execute under Linux, I generally use the good old-fashioned
     gettomeofday() system call to time a very large number of
     iterations of the loop, enough to run for 10 seconds or
     so, and divide by the number of iterations.  That won't
     give you the worst-case, caches-cold execution time,
     but it will give you a very close approximation of the
     Nth iteration time, without having to embed the code
     in the kernel.

            Regards,

            Kevin K.
 
----- Original Message ----- 
From: "Gareth" <g.c.bransby-99@student.lboro.ac.uk>
To: <linux-mips@linux-mips.org>
Sent: Friday, September 13, 2002 6:28 PM
Subject: Cycle counter


> Hi,
> 
> Another question reagarding the mips malta board. I am wanting to be able to
> find out how many cycles a certain loop takes to execute. I understand there is
> a cycle counter built into the processor that I want to use for this. I have a
> bit of inline assembly to do the job but the results I am getting are not
> consistent so i think there is probably something wrong with my attempt at the
> inline assembly. Here is the code : 
> 
>   void al_signal_start(void);
>   size_t al_signal_finished(void);
>   unsigned int GetcpuCycles(void);
> 
>   char str[8];
> 
>   int main (void)
>   {
>       double x;
>       al_signal_start();
>     
>       x = al_signal_finished();
>       printf("GetcpuCycles says : %f \n",x);
> 
>       return 0;
>   }
> 
>   size_t al_signal_finished(void)
>   {
>       return GetcpuCycles(); 
>   }
> 
>   void al_signal_start(void)
>   {
>   int zero,temp;
>   __asm__("move $2, $zero");
>   __asm__("nop");
>           __asm__("mtc0 $2, $9" :  : "r" (temp));
>           __asm__("nop");
>           __asm__("nop");
>           __asm__("nop");
>   }
> 
>   unsigned int GetcpuCycles(void)
>   {
>           int temp;
>           __asm__(".set reorder");
>           __asm__("mfc0 $2, $9" : : "r" (temp));
>           __asm__("nop");
>           __asm__("nop");
>           __asm__("nop");
>           /*__asm__("jr $31" );*/
>   }
> 
> 
> As you can see, main just starts and stops the counter with no instructions in
> between. I expexcted the cycle count to be zero or close to it because of the
> instructions required to get the count but this is not the case. I am getting
> numbers like 8499. Is there just something wrong with my assembly or is there
> something else I am missing?
> 
> Thanks for any help
> Gareth
> 
> 
> 
