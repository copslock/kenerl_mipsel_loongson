Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 07:05:50 +0100 (BST)
Received: from wsip-70-184-212-2.om.om.cox.net ([70.184.212.2]:14820 "EHLO
	hachi.dashjr.org") by ftp.linux-mips.org with ESMTP
	id S20029853AbYFIGFs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jun 2008 07:05:48 +0100
Received: from yokochan.lan (yokochan.lan [IPv6:2002:440d:6de2:0:20d:60ff:fe77:7d85])
	(Authenticated sender: luke-jr)
	by hachi.dashjr.org (Postfix) with ESMTP id F120D961B98;
	Mon,  9 Jun 2008 06:05:45 +0000 (UTC)
From:	Luke -Jr <luke@dashjr.org>
Organization: -Jr Family
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: bcm33xx port
Date:	Mon, 9 Jun 2008 01:05:28 -0500
User-Agent: KMail/1.9.9
Cc:	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
References: <200806072113.26433.luke@dashjr.org> <200806081527.31221.luke@dashjr.org> <Pine.LNX.4.55.0806082249330.15673@cliff.in.clinika.pl>
In-Reply-To: <Pine.LNX.4.55.0806082249330.15673@cliff.in.clinika.pl>
PGP-Key-Fingerprint: CE5A D56A 36CC 69FA E7D2 3558 665F C11D D53E 9583
Jabber-ID: luke@dashjr.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806090105.37978.luke@dashjr.org>
Return-Path: <luke@dashjr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luke@dashjr.org
Precedence: bulk
X-list: linux-mips

On Sunday 08 June 2008, Maciej W. Rozycki wrote:
> On Sun, 8 Jun 2008, Luke -Jr wrote:
> > >  I have seen that already and wrote these stores in __bzero are
> > > protected. Perhaps the fixup fails for some reason, but you need to
> > > investigate it and this is why I suggested to see how the RI handler is
> > > reached.  Since this is a known point the failure leads to, you should
> > > be able to work backwards from there quite easily.
> >
> > Ah, so what you're saying is that perhaps the 'sw' is triggering a TLB
> > exception, and the handler for *that* is causing the RI problem?
>
>  This is almost certain what happens here.  The pointer involved is a
> valid (user) address and is correctly aligned, so you cannot get an
> address error exception.  A TLB exception is next on the list to check.

I added some code to do_ri:
	if (unlikely(!user_mode(regs)))
	{
		long real_epc;
		asm("move %0, $sp" : "=r"(real_epc));
		printk("----- LJR -------\n");
		show_raw_backtrace(real_epc);
		printk("----- LJRx-------\n");
	}

Which gave me some potentially useful info:
	----- LJR -------
	Call Trace:
	[<80011460>] ret_from_exception+0x0/0x24
	[<80069de4>] vma_link+0x48/0x114
	[<8001b1f0>] blast_icache16+0x0/0xec
	[<800aa27c>] padzero+0x5c/0x74
	[<800c6774>] __bzero+0x38/0x164
	[<800ab04c>] load_elf_binary+0x948/0x145c
	[<800aac6c>] load_elf_binary+0x568/0x145c
	[<80083b80>] __path_lookup_intent_open+0x60/0xe4
	[<80083b50>] __path_lookup_intent_open+0x30/0xe4
	[<80080044>] permission+0x10c/0x148
	[<8007bfd4>] search_binary_handler+0x78/0x18c
	[<800aa15c>] load_script+0x25c/0x270
	[<800aa148>] load_script+0x248/0x270
	[<800aa7b4>] load_elf_binary+0xb0/0x145c
	[<8007c204>] get_arg_page+0x4c/0xc4
	[<8001cab4>] r4k_flush_cache_page+0x1c/0x28
	[<8007bfd4>] search_binary_handler+0x78/0x18c
	[<8007e004>] do_execve+0x18c/0x258
	[<8007dfe4>] do_execve+0x16c/0x258
	[<80081074>] getname+0x24/0x118
	[<8001570c>] sys_execve+0x4c/0x78
	[<80030610>] release_console_sem+0x114/0x358
	[<80018410>] stack_done+0x20/0x3c
	[<80031038>] vprintk+0x368/0x448
	[<8007554c>] get_unused_fd_flags+0x60/0x184
	[<80081074>] getname+0x24/0x118
	[<80010478>] init_post+0x60/0xe8
	[<80015584>] kernel_execve+0x8/0x20
	[<800136cc>] kernel_thread_helper+0x10/0x18
	[<800136bc>] kernel_thread_helper+0x0/0x18
	
	----- LJRx-------

Too tired to debug further tonight, but hopefully this stack will stand out to 
someone :)

Luke
