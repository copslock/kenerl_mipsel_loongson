Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Feb 2005 20:34:07 +0000 (GMT)
Received: from mailout06.sul.t-online.com ([IPv6:::ffff:194.25.134.19]:17849
	"EHLO mailout06.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225244AbVBEUdv>; Sat, 5 Feb 2005 20:33:51 +0000
Received: from fwd06.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1CxWco-0000o3-00; Sat, 05 Feb 2005 21:33:50 +0100
Received: from denx.de (XRxHPiZXQeVbs0ia1-DSctoPgyZY1OMRzfBfhTeIrBl42VWI1iQa0L@[62.158.200.222]) by fmrl06.sul.t-online.com
	with esmtp id 1CxWcZ-0zYkpk0; Sat, 5 Feb 2005 21:33:35 +0100
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 463B942F9E; Sat,  5 Feb 2005 21:33:34 +0100 (MET)
Received: by atlas.denx.de (Postfix, from userid 15)
	id CD4DBC108D; Sat,  5 Feb 2005 21:33:33 +0100 (MET)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id CAC2A13D6DB; Sat,  5 Feb 2005 21:33:33 +0100 (MET)
To:	Robert Michel <news@robertmichel.de>
Cc:	linux-mips <linux-mips@linux-mips.org>
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: patch like kexec for MIPS possible? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Sat, 05 Feb 2005 20:11:10 +0100."
             <20050205191110.GD3071@mail.robertmichel.de> 
Date:	Sat, 05 Feb 2005 21:33:28 +0100
Message-Id: <20050205203333.CD4DBC108D@atlas.denx.de>
X-ID:	XRxHPiZXQeVbs0ia1-DSctoPgyZY1OMRzfBfhTeIrBl42VWI1iQa0L@t-dialin.net
X-TOI-MSGID: 50e230f1-10c5-4941-b350-ca80a19c5b8d
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20050205191110.GD3071@mail.robertmichel.de> you wrote:
> 
> Kexec is written for x86 (yet) - but the (my) question is if
> this would be possible with MIPS, too.

Other, smilar solutions exist for other  architectures,  like  Magnus
Damm's  "relf"  tool for PowerPC and x86 (relf - reload elf: a driver
to load and start a new elf file from within  Linux).  Adaptions  for
other processors are more or less trivial.

> Does GRUB run on MIPS? Does GRUB support SSH2? Does most MIPS
> bootlaoders support USB-sticks or booting via VPNs?

Use U-Boot :-)

> LinuxBios is a "nice" project, but for most boards/boxes Linuxer
> could be happy to be able to boot it - to develop a nice boadloader
> is depended from the hard/firmware of the systems.

Use U-Boot :-)

> A kernel with a kexec like patch could be used into the bootchain
> for several reasons:
...
> - booting from original not supported devices (usb, network)
...
> - for upgrades lower downtimes (Router, Firewalls....)

These are IMHO the only valid reasons for such an approach.

> IMHO would be the most powerfull and flexible way 
> to boot a linux kernel,
> to boot it just from an other linux kernel.

We've been using "relf" in some projects (x86 - where we  were  stuck
with  really  dumb  BIOSes),  but  I cannot see many situations where
kexec is actually better or more powerful than  a  decent  bootloader
line U-Boot. OK, I'm obviously biased.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
In an organization, each person rises to the level of his own  incom-
petency                                         - The Peter Principle
