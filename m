Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 20:35:56 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:3824 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225223AbTCMUfz>;
	Thu, 13 Mar 2003 20:35:55 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA21062;
	Thu, 13 Mar 2003 12:35:51 -0800
Subject: Re: IRQ warnings during boot on Au1500/DB1500
From: Pete Popov <ppopov@mvista.com>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <3E70EACF.8F6629E4@ekner.info>
References: <3E70EACF.8F6629E4@ekner.info>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1047587761.819.63.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 12:36:01 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


> Once the IDE probing is done, these messages don't seem to appear any more, and the kernel runs ok. 
> Anybody seeing similar messages?

Yes. I just mentioned that to Ralf but he wasn't sure where they are
coming from. I took a quick look and the cause is the irq probing being
done by the ide code. I don't know if that's "normal" but it feels like
there's something not quite right.  

On the bright side, the new ide patches Ralf checked in fix the ide-cs
pcmcia driver and with the new pcmcia pb1500 patch I checked in (and
with new CPU silicon), you can now use the pcmcia slot on the Pb1500.

Pete
