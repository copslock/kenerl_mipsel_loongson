Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2003 20:42:41 +0100 (BST)
Received: from opengraphics.com ([IPv6:::ffff:216.208.162.194]:45994 "EHLO
	hurricane.opengraphics.com") by linux-mips.org with ESMTP
	id <S8225562AbTJHTmi>; Wed, 8 Oct 2003 20:42:38 +0100
Received: from lsorense by hurricane.opengraphics.com with local (Exim 3.36 #1 (Debian))
	id 1A7KCF-00026u-00; Wed, 08 Oct 2003 15:42:07 -0400
Date: Wed, 8 Oct 2003 15:42:07 -0400
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: Question about use of PMAD-AA ethernet adapter on Decstation
Message-ID: <20031008194207.GA16118@opengraphics.com>
References: <20031008142337.GI12409@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1031008162829.26799D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1031008162829.26799D-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.28i
From: Len Sorensen <lsorense@opengraphics.com>
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.694, required 5,
	AWL, BAYES_00)
Return-Path: <lsorense@opengraphics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lsorense@opengraphics.com
Precedence: bulk
X-list: linux-mips

On Wed, Oct 08, 2003 at 05:31:09PM +0200, Maciej W. Rozycki wrote:
>  The trace dump looks through the kernel stack and uses simple heuristics
> to judge whether a word should be included or not: if it is in the range
> covered by the kernel's text segment, it's printed.  It might be pure
> coincidence a specific value corresponding to a kernel address is present
> at the stack as it may actually be a leftover from past execution, e.g. 
> within a stack frame reserved for local variables that hasn't been
> initialized yet, or are simply unused for a particular execution path. 
> You need to analyze the backtrace, comparing it to actual code involved to
> see which of the addresses are results of real function calls. 
> 
>  Well, most interrupt handlers can be interrupted by other interrupts,
> only the high priority ones cannot.  These are marked with SA_INTERRUPT in
> the flags.  Of course the entry code for IRQ handling cannot be
> interrupted and only a single interrupt source is selected for handling
> based on predefined priorities, but once execution reaches
> handle_IRQ_event() (which calls specific handlers registered by drivers),
> another interrupt can be taken. 
> 
>  The trace doesn't look suspicious at first sight to me.
> 
>  The PMAD-A cannot be handled the same way as the others since it has a
> sane buffer space layout, something that cannot be said of the others. 
> Therefore the stock declance.c driver doesn't handle the PMAD-A properly
> -- that's functionality that needs to be implemented when the driver gets
> restructured (it'll happen for 2.6 and probably a backport to 2.4 will be
> available later as well).  There is a patch that converts the stock driver
> into one working for the PMAD-A (but it doesn't work for the others than)
> and I'm told Debian uses thus modified code as a separate driver.  The
> patch is based on work by Dave Airlie and is available here:
> 'ftp://ftp.ds2.pg.gda.pl/pub/macro/drivers/pmad-a/patch-mips-2.4.20-pre6-20021222-declance-pmad-12.gz' 
> -- it applies cleanly to the current version of declance.c.

Well I am runing declance for the onboard and pmadaa for the add on card
as far as I can tell.

>  Both dev->mem_start and dev->mem_end are initialized incorrectly as they
> should use bus addresses and now they use CPU virtual ones.  For
> MIPS-based TURBOchannel systems, the mapping between the addresses is
> quite straightforward, but it's not necessarily the case for the others.
> The addresses should also be used for I/O resource allocation mamagement
> which is not implemented in the driver.
> 
>  Your point about dev->mem_end is of course valid -- the bug wasn't
> noticed, because the variable isn't used for anything in these cases.
> 
>  Please send me the full oops report and I'll see what I can decipher from
> it.

Here is what I got on the console:

Instruction bus error, epc == 80045ae0, ra == 8005d8a8
Oops in traps.c::do_be, line 491:
$0 : 00000000 80280000 80280000 000f48b0 8027ef94 000f48b0 8027ef94 00000000
$8 : 8023e108 bc040000 00000020 874d227c 86b857e4 86b857e8 86b857e0 00000008
$16: 00000000 00000000 00000000 8027ebc0 80259820 fffffffe 00000000 04102060
$24: 00000000 2b107a90                   8023e000 8023fde0 8043ff80 8005d8a8
Hi : 00000000
Lo : 00000600
epc  : 80045ae0    Not tainted
Status: 1000e400
Cause : 00000018
Process swapper (pid: 0, stackpage=8023e000)
Stack:    00000000 8005da74 00000000 04102060 00000001 8005dd18 8027ebe0
 20000001 8027ebe0 8005de64 8027ebe0 800598e4 00000000 811b2940 8023fea8
 801263bc 800596a0 00000000 80158898 80158888 000000c0 80259848 00000000
 80259838 fffffffe 1000e400 8023fea8 00000000 80059170 30000400 fffffffb
 00000011 8004a6e8 8667c000 802590d0 8026c97c fffffffb 0000000d 8004a728
 8044e2d0 ...
Call Trace:   [<8005da74>] [<8005dd18>] [<8005de64>] [<800598e4>] [<801263bc>]
 [<800596a0>] [<80158898>] [<80158888>] [<80059170>] [<8004a6e8>] [<8004a728>]
 [<80125574>] [<80125574>] [<800432dc>] [<800432c0>] [<8020a37c>] [<8004042c>]
 [<8020959c>]

Code: 03a02021  080115e0  00000000 <401a6000> 00000000  001ad0c0  07400003  03a0d821  3c1b802b
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Through ksymoops it gets to be:

Instruction bus error, epc == 80045ae0, ra == 8005d8a8
Oops in traps.c::do_be, line 491:
$0 : 00000000 80280000 80280000 000f48b0 8027ef94 000f48b0 8027ef94 00000000
$8 : 8023e108 bc040000 00000020 874d227c 86b857e4 86b857e8 86b857e0 00000008
$16: 00000000 00000000 00000000 8027ebc0 80259820 fffffffe 00000000 04102060
$24: 00000000 2b107a90                   8023e000 8023fde0 8043ff80 8005d8a8
Hi : 00000000
Lo : 00000600
epc  : 80045ae0    Not tainted
Using defaults from ksymoops -t elf32-tradlittlemips -a mips:3000
Status: 1000e400
Cause : 00000018
Process swapper (pid: 0, stackpage=8023e000)
Stack:    00000000 8005da74 00000000 04102060 00000001 8005dd18 8027ebe0
 20000001 8027ebe0 8005de64 8027ebe0 800598e4 00000000 811b2940 8023fea8
 801263bc 800596a0 00000000 80158898 80158888 000000c0 80259848 00000000
 80259838 fffffffe 1000e400 8023fea8 00000000 80059170 30000400 fffffffb
 00000011 8004a6e8 8667c000 802590d0 8026c97c fffffffb 0000000d 8004a728
 8044e2d0 ...
Call Trace:   [<8005da74>] [<8005dd18>] [<8005de64>] [<800598e4>] [<801263bc>]
 [<800596a0>] [<80158898>] [<80158888>] [<80059170>] [<8004a6e8>] [<8004a728>]
 [<80125574>] [<80125574>] [<800432dc>] [<800432c0>] [<8020a37c>] [<8004042c>]
 [<8020959c>]
Code: 03a02021  080115e0  00000000 <401a6000> 00000000  001ad0c0  07400003  03a0d821  3c1b802b


>>RA;  8005d8a8 <update_wall_time+18/7c>
>>$1; 80280000 <uidhash_table+2c/40c>
>>$2; 80280000 <uidhash_table+2c/40c>
>>$4; 8027ef94 <xtime+4/8>
>>$6; 8027ef94 <xtime+4/8>
>>$8; 8023e108 <init_task_union+108/2000>
>>$19; 8027ebc0 <irq_stat+0/20>
>>$20; 80259820 <tasklet_hi_vec+0/10>
>>$28; 8023e000 <init_task_union+0/2000>
>>$29; 8023fde0 <init_task_union+1de0/2000>
>>$31; 8005d8a8 <update_wall_time+18/7c>

>>PC;  80045ae0 <handle_ibe+0/cc>   <=====

Trace; 8005da74 <update_process_times+34/11c>
Trace; 8005dd18 <timer_bh+160/168>
Trace; 8005de64 <do_timer+144/14c>
Trace; 800598e4 <bh_action+60/d8>
Trace; 801263bc <timer_interrupt+f8/1cc>
Trace; 800596a0 <tasklet_hi_action+110/1a4>
Trace; 80158898 <lance_interrupt+2b0/2d8>
Trace; 80158888 <lance_interrupt+2a0/2d8>
Trace; 80059170 <do_softirq+1a0/1a8>
Trace; 8004a6e8 <do_IRQ+e4/12c>
Trace; 8004a728 <do_IRQ+124/12c>
Trace; 80125574 <handle_it+8/10>
Trace; 80125574 <handle_it+8/10>
Trace; 800432dc <cpu_idle+6c/74>
Trace; 800432c0 <cpu_idle+50/74>
Trace; 8020a37c <p.1+324/d38>
Trace; 8004042c <init+0/194>
Trace; 8020959c <genexcept_early+dc/9f0>

Code;  80045ad4 <handle_ades_int+28/34>
00000000 <_PC>:
Code;  80045ad4 <handle_ades_int+28/34>
   0:   03a02021  move    a0,sp
Code;  80045ad8 <handle_ades_int+2c/34>
   4:   080115e0  j       45780 <_PC+0x45780>
Code;  80045adc <handle_ades_int+30/34>
   8:   00000000  nop
Code;  80045ae0 <handle_ibe+0/cc>   <=====
   c:   401a6000  mfc0    k0,$12   <=====
Code;  80045ae4 <handle_ibe+4/cc>
  10:   00000000  nop
Code;  80045ae8 <handle_ibe+8/cc>
  14:   001ad0c0  sll     k0,k0,0x3
Code;  80045aec <handle_ibe+c/cc>
  18:   07400003  bltz    k0,28 <_PC+0x28>
Code;  80045af0 <handle_ibe+10/cc>
  1c:   03a0d821  move    k1,sp
Code;  80045af4 <handle_ibe+14/cc>
  20:   3c1b802b  lui     k1,0x802b

Kernel panic: Aiee, killing interrupt handler!

Does that help anything?  If not I may just have to assume it was a
fluke that the machine crashed twice in 15 minutes after putting in the
PMAD-AA card.  I haven't managed to make it crash today.

Len Sorensen
