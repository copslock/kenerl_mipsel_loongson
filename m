Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2004 05:37:14 +0000 (GMT)
Received: from web52805.mail.yahoo.com ([IPv6:::ffff:206.190.39.169]:17060
	"HELO web52805.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224802AbULVFhI>; Wed, 22 Dec 2004 05:37:08 +0000
Received: (qmail 1248 invoked by uid 60001); 22 Dec 2004 05:36:51 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=YB76wbq2/HW9oAQEUZVDGzMslgAU80fTJjl99rMMXTUxADhFSIGaIlps+DDL4YuGes6DulJ1xlRcp2vkscTq5nj3VogEcKVOiDjSwdmbS6n9SnYrr6bYhP58mUkay7VHAlWSWnfj3GA255UUkaeR64PS2RyYDLB2IrL7pQhHcQI=  ;
Message-ID: <20041222053651.1246.qmail@web52805.mail.yahoo.com>
Received: from [61.95.246.135] by web52805.mail.yahoo.com via HTTP; Tue, 21 Dec 2004 21:36:51 PST
Date: Tue, 21 Dec 2004 21:36:51 -0800 (PST)
From: Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: port on exotic board.
To: Jun Sun <jsun@junsun.net>,
	moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20041222012715.GA13782@gw.junsun.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <m_lachwani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m_lachwani@yahoo.com
Precedence: bulk
X-list: linux-mips

Hello !
> > In "tlb_init" function, cp0 WIRED register is set
> to
> > zero, therefore the call to "local_flush_tlb_all" 
> > flush all TLB entries which were mapping my kernel
> > in the 3 first entries. Why is this necessary ?  
> 
> Setting WIRED to zero is just part of kernel
> start-up initialization.
> 
> In 2.4 it is done before board setup routine, which
> allows board
> to setup certain wired mapping.
> 
> In 2.6 it is done after board setup routine.  You
> are screwed. :) I think
> this needs to be fixed.  A couple of boards should
> be broken because of this.
> 

Well, you can again setup the wired tlb entries later.
For example, in case of Ocelot3 board (setup.c code),
the wired tlb entries are again created in the
time_init function.


void momenco_time_init(void)
{
	setup_wired_tlb_entries();

....

And it is set for the first time in the board setup
function:

static int __init momenco_ocelot_3_setup(void)
{
	unsigned int tmpword;

	board_time_init = momenco_time_init;

	_machine_restart = momenco_ocelot_restart;
	_machine_halt = momenco_ocelot_halt;
	_machine_power_off = momenco_ocelot_power_off;

	/* Wired TLB entries */
	setup_wired_tlb_entries();

....

Maybe you can do the same for this board as well

Thanks
Manish Lachwani



=====
http://www.koffee-break.com
