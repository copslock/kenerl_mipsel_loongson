Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2004 11:27:44 +0100 (BST)
Received: from h-213.61.96.13.host.de.colt.net ([IPv6:::ffff:213.61.96.13]:42646
	"EHLO aurora.factorlocal.de") by linux-mips.org with ESMTP
	id <S8225474AbUEQK1k>; Mon, 17 May 2004 11:27:40 +0100
Received: from dev7.factorlocal.de ([192.168.168.7] helo=[192.168.168.221])
	by aurora.factorlocal.de with asmtp (Exim 4.20)
	id 1BPfLO-0007ev-Vw
	for linux-mips@linux-mips.org; Mon, 17 May 2004 12:27:38 +0200
Mime-Version: 1.0 (Apple Message framework v613)
In-Reply-To: <5055A94A-A503-11D8-B16C-000A956A056E@aurora.factorlocal.de>
References: <5055A94A-A503-11D8-B16C-000A956A056E@aurora.factorlocal.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D2350ECC-A7EC-11D8-8632-000A956A056E@aurora.factorlocal.de>
Content-Transfer-Encoding: 7bit
From: Joerg Rossdeutscher <joerg@factorlocal.de>
Subject: Re: RaQ2: Installation stops at "loading debian installer" [SOLVED]
Date: Mon, 17 May 2004 12:27:38 +0200
To: linux-mips@linux-mips.org
X-Mailer: Apple Mail (2.613)
Return-Path: <joerg@factorlocal.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joerg@factorlocal.de
Precedence: bulk
X-list: linux-mips

Hi,

Am 13. Mai 2004 um 19:31 Uhr schrieb Joerg Rossdeutscher:
> The RaQ2 boots the debian-installer-b4 via tftp and nfs until the 
> display shows "Loading debian installer". Then it stops.
> I now have found an old Laptop that still has a serial port.
>
>
> The last lines say:
>
> >execute initrd={initrd-size}@{initrd-start} 
> console=ttyS0,{console-speed}
> elf: 80080000 <-- 00001000 1916928t+176112t
> elf: entry 801fc040
> net: interface down
>
> (I type this by hand, so excuse possibly errors)
>
> That's it. Ethereal shows no more net traffic and no remarkable errors 
> before the installation stops. Nothings happens. And nothing at google 
> for this message. Hm.

Thanks to everyone who tried to help. Peter Horton guided me to the
solution. The kernel was broken, the md5sum did not match. I quote
his PM how to find out:

 >It's possible the kernel is not booting because of a problem with the
 >initrd code. What happens if you type the following at the boot shell
 >prompt :-
 >
 >	net
 >	tftp {dhcp-next-server} vmlinux-2.4.25-r5k-cobalt
 >	md5sum
 >	execute console=ttyS0,{console-speed}
 >
 >You can also check that the MD5 sum displayed matches that of the 
kernel
 >file on the TFTP server.

That md5 differed fronm the one on the debian server.
Re-downloaded, now installing. :-)

Yipiiie!

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
