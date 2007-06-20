Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2007 17:58:51 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:54434 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20024742AbXFTQ6t (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Jun 2007 17:58:49 +0100
Received: (qmail 15699 invoked by uid 101); 20 Jun 2007 16:58:41 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 20 Jun 2007 16:58:41 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l5KGweZx006769;
	Wed, 20 Jun 2007 09:58:41 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <LGNW7KLW>; Wed, 20 Jun 2007 09:58:40 -0700
Message-ID: <46795CBA.7090408@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Brian Oostenbrink <Brian_Oostenbrink@pmc-sierra.com>,
	Dan Doucette <Dan_Doucette@pmc-sierra.com>
Subject: Re: [PATCH 1/12] mips: PMC MSP71xx core platform
Date:	Wed, 20 Jun 2007 09:58:34 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 20 Jun 2007 16:58:34.0981 (UTC) FILETIME=[3D478950:01C7B35C]
user-agent: Thunderbird 1.5.0.12 (X11/20070509)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Ralf Baechle wrote:
> On Thu, Jun 14, 2007 at 03:54:47PM -0600, Marc St-Jean wrote:
> 
>  > Re-posting patch as requested by Ralf. Changes since last post:
>  > -Minor cleanups as recommended by checkpatch.pl.
> 
> Be careful with that script.  Some of it's recommendations are harmful,
> for example when it sees an inclusion of <asm/time.h> it will suggest
> to use <linux/time.h>.  That's all fine because generally the file under
> linux/ will include the asm/ version but there are exception.

I discovered that on some patches, a few had to be reverted but no problem.

> But it's great that you discovered it already, it saves me the for both
> sides annoying part of dealing out tons of trivialities, first such as
> formatting trivialities.  One thing checkpatch.pl doesn't yet complain
> about is trailing whitespace such as in the first of the patches you
> sent:
> 
> Warning: trailing whitespace in line 106 of 
> arch/mips/pmc-sierra/msp71xx/msp_usb.c
> Warning: trailing whitespace in line 12 of 
> arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
> Warning: trailing whitespace in lines 43,53,63,79 of 
> arch/mips/pmc-sierra/msp71xx/msp_time.c
> Warning: trailing whitespace in lines 49,59,62,68,78,84 of 
> arch/mips/pmc-sierra/msp71xx/msp_irq.c
> Warning: trailing whitespace in line 84 of 
> arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
> Warning: trailing whitespace in line 157 of 
> arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
> Warning: trailing whitespace in lines 154,307,537,548,558 of 
> arch/mips/pmc-sierra/msp71xx/msp_prom.c
> Warning: trailing whitespace in lines 66,229,238,252 of 
> arch/mips/pmc-sierra/msp71xx/msp_setup.c
> 
> No need to resend the patch, I can strip that of trivially

Hmmm, I see. That's odd since it catches most trailing whitespace. I'll
email the maintainer if you haven't already. I've reported two other
issues to him before and he fixed the script in a day!

Marc
