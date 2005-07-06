Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2005 14:40:02 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:7637 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8226327AbVGFNjr>;
	Wed, 6 Jul 2005 14:39:47 +0100
Received: from port-195-158-170-192.dynamic.qsc.de ([195.158.170.192] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1DqA8D-0002dR-00
	for linux-mips@linux-mips.org; Wed, 06 Jul 2005 15:40:05 +0200
Received: from ths by hattusa.textio with local (Exim 4.51)
	id 1DqA8C-0004UE-RN
	for linux-mips@linux-mips.org; Wed, 06 Jul 2005 15:40:04 +0200
Date:	Wed, 6 Jul 2005 15:40:04 +0200
To:	linux-mips@linux-mips.org
Subject: Re: 2.6.12 DOES read MAC address
Message-ID: <20050706134004.GS1645@hattusa.textio>
References: <200507061448.02561.arianna@dsi.unimi.it> <20050706130921.GJ3226@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706130921.GJ3226@linux-mips.org>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Jul 06, 2005 at 02:48:02PM +0200, Arianna Arona wrote:
> 
> > I've compiled the kernel myself and now it reads MAC address at boot time.
> > Problem solved? NO. Ethernet card does not trasmit any packets on the net.
> > 
> > I have a question: how is your ethernet card? Mine is a card with network, 2 
> > consoles and a SCSI port in it. Could be this the problem?
> 
> Same IOC3 card as every Origin.  We're looking into the issue.  Part of
> the problems seems to be the hardware isn't behaving exactly the way I
> thought it is meant to ...

JFTR, CVS HEAD works here, with one strangeness: The kernel fails to find
any autoconfiguration from dhcp. Specifying the parameters on the command
line works, and the interface seems to work fine once the machine is up.


Thiemo
