Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 15:25:51 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:56130
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224908AbUJSOZn>; Tue, 19 Oct 2004 15:25:43 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CJuvi-0002bt-00; Tue, 19 Oct 2004 16:25:38 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CJuvh-00028F-00; Tue, 19 Oct 2004 16:25:37 +0200
Date: Tue, 19 Oct 2004 16:25:37 +0200
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	Manish Lachwani <mlachwani@mvista.com>
Subject: Re: jump instruction in delay slot
Message-ID: <20041019142537.GB21691@rembrandt.csv.ica.uni-stuttgart.de>
References: <200410191605.47543.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410191605.47543.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Thomas Koeller wrote:
> Hi,
> 
> the following code snippet is from
> arch/mips/pmc-sierra/yosemite/irq-handler.S:
> 
> ll_duart_irq:
> 		li	a0, 4
> 		move	a1, sp
> 		jal	do_IRQ
> 		j	ret_from_irq
> 
> I wonder if this is correct. AFAIK, a jump instruction
> must not occupy the delay slot of another branch or
> jump instruction. Since the 'jal' returns to the first
> instruction after the delay slot, I would expect the
> effect of the 'j' instruction to be cancelled. Or
> is this some kind of trick I do not understand?

I guess this code has no preceeding ".set noreorder" directive.
By default, your friendly assembler handles delay slots for you. :-)


Thiemo
