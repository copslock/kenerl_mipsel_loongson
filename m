Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 17:35:26 +0100 (BST)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@3ffe:8260:2028:fffe::1)) by linux-mips.org
	id <S8225240AbTDNQfK>; Mon, 14 Apr 2003 17:35:10 +0100
Date: Mon, 14 Apr 2003 17:35:10 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Oddities with CVS Kernels, Memory on Indigo2
Message-ID: <20030414173510.A2133@ftp.linux-mips.org>
References: <3E98F206.5050206@gentoo.org> <20030414140717.GA805@simek> <3E9AD98B.90808@gentoo.org> <wrpbrz9vzkl.fsf@hina.wild-wind.fr.eu.org> <3E9AE0D6.5060401@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E9AE0D6.5060401@gentoo.org>; from kumba@gentoo.org on Mon, Apr 14, 2003 at 12:24:54PM -0400
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 14, 2003 at 12:24:54PM -0400, Kumba wrote:
> 
> 	Also, forgot to mention on this topic, but while messing with ISA/EISA 
> cards in the I2, I've run across some strange "hack" regarding Local IRQ 
> 3 on the machine.  There's a construct inside 
> arch/mips/sgi-ip22/ip22-int.c in the enable_local3_irq() function that 
> purposely panics the kernel if LIRQ3 is probed or used.  Any one got any 
> idea why this is?  There aren't any comments in the code to explain this 
> odd little construct, and removing it generates some amusing messages at 
> bootup, long the lines of "Whee: Got an LIO3 irq, winging it...".  Quite 
> odd if you ask me.

Several chips used in Indy (and Indigo2) are used in much complicated machines
(not supported by linux) and SGI always designed its machines with modularity
in mind. local3_irq is another cascade where nothing is hooked on Indy, so you
can't get this irq. and if it happens there is sometning strange with our
system. there are no comments because you need to understand it before coding
and once you read documentation comments are useless ;-)

	ladis

ps. there is driver for built-in parport now by Vincent Stehle
http://vincent.stehle.free.fr/sgi/parport.php3
