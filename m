Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2005 17:49:34 +0100 (BST)
Received: from host157-65.pool8257.interbusiness.it ([IPv6:::ffff:82.57.65.157]:43249
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8226265AbVGEQtH>; Tue, 5 Jul 2005 17:49:07 +0100
Received: by localhost.localdomain (Postfix, from userid 501)
	id AAE1D110F1C; Tue,  5 Jul 2005 20:48:56 +0200 (CEST)
Subject: Re: 2.6.12 does not read MAC address
From:	Michele Carla` <goldfinger@member.fsf.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <42CA9FF3.8060504@total-knowledge.com>
References: <200507051643.09070.arianna@dsi.unimi.it>
	 <42CA9FF3.8060504@total-knowledge.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Tue, 05 Jul 2005 20:48:56 +0200
Message-Id: <1120589336.3117.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Return-Path: <goldfinger@member.fsf.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: goldfinger@member.fsf.org
Precedence: bulk
X-list: linux-mips

On Tue, 2005-07-05 at 07:57 -0700, Ilya A. Volynets-Evenbakh wrote:
> Yes, kerenl doesn't read mac address correctly on O2K. Some timeing
> issue in the driver
> as far as I can tell. None of my kernels ever could read it on O2K, even
> though it works
> just fine on O200.
> 
> No you are wrong. Forcing MAC address works just fine. At least it does
> so here.

it doesn't works also for me... I have not tried last kernel, but as
soon as possible I'm going to do it !

(some times it recognise menet MAC addresses, but it doesn't works)

> You just have to force it to correct value (i.e. the one origin was
> using when it
> was sending bootp/tftp packets.
> 
> Look at the logs at your boot server.
> 
> --
> Ilya A. Volynets-Evenbakh
> Total Knowledge, CTO
> http://www.total-knowledge.com/
> 
> Arianna Arona wrote:
> 
> >Hi everybody,
> >
> >my network problem are now due to MAC address.
> >Kernel does not read it and forcing the value via ifconfig does not solve the 
> >problem.
> >
> >I need to merge the old driver, which detects MAC addr but eth0 link is down,
> >with the new one that does the contraty..... opsss.... I could have a not 
> >working at all driver.... :((
> >
> >A.
> >
> >  
> >
> 
> 
> 
