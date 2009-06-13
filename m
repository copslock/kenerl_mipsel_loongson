Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Jun 2009 18:26:35 +0200 (CEST)
Received: from gateway03.websitewelcome.com ([69.93.52.26]:59285 "HELO
	gateway03.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1492373AbZFMQ03 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 13 Jun 2009 18:26:29 +0200
Received: (qmail 2057 invoked from network); 13 Jun 2009 16:30:46 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway03.websitewelcome.com with SMTP; 13 Jun 2009 16:30:46 -0000
Received: from [12.233.205.2] (port=26792 helo=odysseus.paralogos.com)
	by gator750.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1MFW3T-00036S-7g; Sat, 13 Jun 2009 11:26:07 -0500
Message-ID: <4A33D2EA.801@paralogos.com>
Date:	Sat, 13 Jun 2009 18:25:14 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	wuzhangjin@gmail.com
CC:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Error: symbol `__pastwait' is already defined
References: <1244879922.24479.30.camel@falcon>
In-Reply-To: <1244879922.24479.30.camel@falcon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Calling a function does not cause replication of its symbols.  That 
would happen if it were a macro, or an inline function, but not a simple 
global function, which r4k_wait_irqoff is supposed to be, since (at 
least the last time I worked with it), it is only called indirectly by 
having its address stored in the cpu_wait function pointer.  Either your 
compiler is doing something insane and replicating the function each 
time its address is taken (!), or someone has added another __pastwait 
symbol somewhere.

And you are correct that moving the symbol to another function risks 
breaking the functionality. Even if the compiler didn't reorder things - 
which you are correct to note that it might do - you would create a 
window during which the kernel would mistakenly believe that the CPU was 
in the interrupt-disabled wait state when in fact it had just fallen out 
of the loop and serviced an interrupt.  I don't think that would 
necessarily be fatal, but it would at least be inefficient.

          Regards,

          Kevin K.

Wu Zhangjin wrote:
> Hi, 
>
> there is a guy reported a compiling problem in linux-2.6.29:
>
> [...]
>   CC      arch/mips/kernel/cpu-probe.o
> {standard input}: Assembler messages:
> {standard input}:3939: Error: symbol `__pastwait' is already defined
> make[1]: *** [arch/mips/kernel/cpu-probe.o] Error 1
> make: *** [arch/mips/kernel] Error 2
>
> Seems I met this problem before, perhaps here is the reason:
>
> arch/mips/kernel/cpu-probe.c:
>
> void r4k_wait_irqoff(void)
> {
>     local_irq_disable();
>     if (!need_resched())
>         __asm__("   .set    push        \n"
>             "   .set    mips3       \n"
>             "   wait            \n"
>             "   .set    pop     \n");
>     local_irq_enable();
>     __asm__("   .globl __pastwait   \n"
>         "__pastwait:            \n");
>     return;
> }
>
> there is a global symbol __pastwait defined at the end of
> r4k_wait_irqoff, if r4k_wait_irqoff is called more than one time, the
> __pastwait will be multi-defined. so, need to be fixed. does this fix
> it?
>
> arch/mips/kernel/cpu-probe.c:
>
> void r4k_wait_irqoff(void)
> {
>     local_irq_disable();
>     if (!need_resched())
>         __asm__("   .set    push        \n"
>             "   .set    mips3       \n"
>             "   wait            \n"
>             "   .set    pop     \n");
>     local_irq_enable();
>     return;
> }
> /* a dumy funciton for marking the end of r4k_wait_irqoff */
> void __pastwait(void)
> {
> 	;
> }
>
> but I am not sure the gcc compiler will tune the position of the
> r4k_wait_irqoff and __pastwait or not, so seems not safe. perhaps we
> should change something else instead.
>
> perhaps we should tune the __pastwait solution directly, just spark it,
> not look into it yet, seems __pastwait is only used here:
>
> arch/mips/kernel/smtc.c:
> smtc_send_ipi:
>
>             if (cpu_wait == r4k_wait_irqoff) {
>                 tcrestart = read_tc_c0_tcrestart();
>                 if (tcrestart >= (unsigned long)r4k_wait_irqoff
>                     && tcrestart < (unsigned long)__pastwait) {
>                     write_tc_c0_tcrestart(__pastwait);
>                     tcstatus &= ~TCSTATUS_IXMT;
>                     write_tc_c0_tcstatus(tcstatus);
>                     goto postdirect;
>                 }    
>             } 
>
> best wishes,
> Wu Zhangjin 
>
>
>   
