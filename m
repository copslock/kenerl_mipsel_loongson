Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2004 11:10:22 +0100 (BST)
Received: from skl1.ukl.uni-freiburg.de ([IPv6:::ffff:193.196.199.1]:58843
	"EHLO relay1.uniklinik-freiburg.de") by linux-mips.org with ESMTP
	id <S8225785AbUE1KKG>; Fri, 28 May 2004 11:10:06 +0100
Received: from wh85.ukl.uni-freiburg.de (ktl77.ukl.uni-freiburg.de [193.196.226.77])
	by relay1.uniklinik-freiburg.de (Email) with ESMTP id 5D1FF2F395
	for <linux-mips@linux-mips.org>; Fri, 28 May 2004 12:10:02 +0200 (CEST)
From: Max Zaitsev <maksik@gmx.co.uk>
Organization: Mutella Dev co.
To: linux-mips@linux-mips.org
Subject: Re: help needed : cannot install linux on SGI O2 R5000
Date: Fri, 28 May 2004 12:10:05 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405281210.05259.maksik@gmx.co.uk>
Return-Path: <maksik@gmx.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksik@gmx.co.uk
Precedence: bulk
X-list: linux-mips

Hi!

thanks for the prompt answer. actually I've messed things up slightly. The 
kernel that I could boot with relative success was a frame buffer enabled one 
from Ilia (http://www.total-knowledge.com/progs/mips/kernels/
vmlinux.64-20040315).

> The IP32 Netboot I have requires you to setup an NFS-exportable root for it
> to work properly ... There should be an initrd link in the ip32 directory --
> use that for NFS root, and pass at minimum 'root=/dev/nfs
>
this I've tried already, but the thing is that the netboot kernel does not go 
beyond telling me what the entry point was. I've also tried to use the kernel 
from Ilya with the same root. There, everything would hang after starting the 
initrd script.

> and it's advised you run off of serial console (if you 
> aren't already). 
>
actually, I don't. I don't have a serial console/cable in my possetion and was 
intending to actually use the display/keyboard combination to perform the 
installation. Would it be possible? Can you advise me where to get a suitable 
netboot kernel?

Regards,
Max 
