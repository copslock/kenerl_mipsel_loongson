Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2004 18:31:10 +0100 (BST)
Received: from h-213.61.96.13.host.de.colt.net ([IPv6:::ffff:213.61.96.13]:20713
	"EHLO aurora.factorlocal.de") by linux-mips.org with ESMTP
	id <S8225967AbUEMRbJ>; Thu, 13 May 2004 18:31:09 +0100
Received: from dev7.factorlocal.de ([192.168.168.7] helo=[192.168.168.221])
	by aurora.factorlocal.de with asmtp (Exim 4.20)
	id 1BOK31-0008Pp-68
	for linux-mips@linux-mips.org; Thu, 13 May 2004 19:31:07 +0200
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <5055A94A-A503-11D8-B16C-000A956A056E@aurora.factorlocal.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-mips@linux-mips.org
From: Joerg Rossdeutscher <joerg@factorlocal.de>
Subject: RaQ2: Installation stops at "loading debian installer"
Date: Thu, 13 May 2004 19:31:05 +0200
X-Mailer: Apple Mail (2.613)
Return-Path: <joerg@factorlocal.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joerg@factorlocal.de
Precedence: bulk
X-list: linux-mips

Hi,
step by step... :-)

The RaQ2 boots the debian-installer-b4 via tftp and nfs until the 
display shows "Loading debian installer". Then it stops.
I now have found an old Laptop that still has a serial port.


The last lines say:

 >execute initrd={initrd-size}@{initrd-start} 
console=ttyS0,{console-speed}
elf: 80080000 <-- 00001000 1916928t+176112t
elf: entry 801fc040
net: interface down

(I type this by hand, so excuse possibly errors)

That's it. Ethereal shows no more net traffic and no remarkable errors 
before the installation stops. Nothings happens. And nothing at google 
for this message. Hm.

Any ideas someone?

Bye, Ratti

-- 
_____________________________
Joerg Rossdeutscher

Factor Design AG
Schulterblatt 58
20357 Hamburg
Germany

T +49.40.432 571-43
F +49.40.432 571-99
E-mail: joerg@factordesign.com

http://www.factordesign.com
