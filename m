Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 20:11:56 +0000 (GMT)
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([IPv6:::ffff:213.105.254.86]:6533
	"EHLO irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S8225261AbTBTULz>; Thu, 20 Feb 2003 20:11:55 +0000
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.7/8.12.7) with ESMTP id h1KLCP7l004798;
	Thu, 20 Feb 2003 21:12:26 GMT
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.7/8.12.7/Submit) id h1KLCMeV004796;
	Thu, 20 Feb 2003 21:12:22 GMT
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Ramdisk image on flash.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tibor Polgar <tpolgar@freehandsystems.com>
Cc: Mark Salter <msalter@redhat.com>, krishnakumar@naturesoft.net,
	linux-mips@linux-mips.org
In-Reply-To: <3E55342D.6E1D36FF@freehandsystems.com>
References: <200302201135.09154.krishnakumar@naturesoft.net>
	 <1045765647.30379.262.camel@zeus.mvista.com>
	 <3E552CDF.ECD08EEF@freehandsystems.com>
	 <20030220194115.2A21378A6D@deneb.localdomain>
	 <3E55342D.6E1D36FF@freehandsystems.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045775541.3790.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 20 Feb 2003 21:12:21 +0000
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Thu, 2003-02-20 at 20:01, Tibor Polgar wrote:
> The original poster wanted a setup where the initrd was NOT part of the
> kernel, which begs the question of how/where it would be put into flash so
> something could load/uncompress it.   I'd love to have a way to decouple the
> two so i wouldn't have to recompile the kernel when i change the root image,
> but still not waste any space in flash.   I guess they could be written one
> after the other and the loader is just given a "load map" of where each one
> resides.   Would this satisfy Krishnakumar's requirements?

You probably also want them aligned to 256Kbyte after or similar so that you
can drop the initrd into a seperate erase block on the flash. There are
people doing this. Its actually not hard to hardwire an address into the
initrd code.

Red Boot knows how to do this nicely and it may be a good approach. It does
all the work for this on the ipaq for example.

You can also run some kernels out of flash, I've helped someone get the x86
kernels running from flash for example.
