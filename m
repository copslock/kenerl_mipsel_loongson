Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2005 12:53:46 +0100 (BST)
Received: from h155.mvista.com ([IPv6:::ffff:12.44.186.155]:49950 "EHLO
	imap.sh.mvista.com") by linux-mips.org with ESMTP
	id <S8225479AbVGYLxa>; Mon, 25 Jul 2005 12:53:30 +0100
Received: from ch.mvista.com (unknown [10.180.0.16])
	by imap.sh.mvista.com (Postfix) with SMTP
	id 360F43ECA; Mon, 25 Jul 2005 04:55:49 -0700 (PDT)
Received: by ch.mvista.com (nbSMTP-0.99) for uid 1000
	hzhang@ch.mvista.com; Tue, 26 Jul 2005 03:55:07 +0800 (CST)
Date:	Tue, 26 Jul 2005 03:55:05 +0800
From:	Haitao Zhang <hzhang@ch.mvista.com>
To:	"Steven J. Hill" <sjhill@realitydiluted.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Register definition file for the Broadcom 91250
Message-ID: <20050725195505.GA3376@mvistapanda.ch.mvista.com>
References: <42E19522.2030106@mvista.com> <42E19C2E.8010808@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E19C2E.8010808@realitydiluted.com>
User-Agent: Mutt/1.5.8i
Return-Path: <hzhang@ch.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hzhang@ch.mvista.com
Precedence: bulk
X-list: linux-mips

On 20:23 Fri 22 Jul     , Steven J. Hill wrote:
> Joanne Woo wrote:
> >
> >I'm looking for a register definition file for the Broadcom 91250 for 
> >debugging the kernel using the Abatron BDI2000.    If you know where I 
> >can find it, please let me know.   Thanks.
> >
> There is a site devoted to the BCM1250 chips with regard to Linux and
> NetBSD. It is:
> 
>    http://sibyte.broadcom.com/
> 
> The User's manual is what you probably want:
> 
>    http://sibyte.broadcom.com/public/resources/index.html#um
> 
> As far as the BDI2000, I believe you are out of luck. The only hardware
> debugger I know of that works with the SiByte boards is from Coreolis
> [sp?].
yeah, that's Corelis Debugger: 
     http://sibyte.broadcom.com/public/partners/corelis/
and also 'Green Hills MultiProbe' may work(?)
>I heard rumors of other people who reverse-engineered the
> protocol for more open debugging, but I do not know more than that.
> Maybe others on the list will comment.
well, except commercial products provided by Corelis,
'broadcom' also provide a group of excellent jtag debug toolset, 
working under Redhat9 userland so that 
you can use corelis device directly to trace into kernel by GDB 
or use those jtag probes for re-flash your modified CFE.
> 
> -Steve

Thanks,

Haitao
