Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2005 15:41:56 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:33349
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224948AbVANPlv>; Fri, 14 Jan 2005 15:41:51 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CpTa9-00087I-00; Fri, 14 Jan 2005 16:41:49 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CpTa7-000690-00; Fri, 14 Jan 2005 16:41:47 +0100
Date: Fri, 14 Jan 2005 16:41:47 +0100
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-mips@linux-mips.org
Subject: Re: initrd support.
Message-ID: <20050114154147.GM31149@rembrandt.csv.ica.uni-stuttgart.de>
References: <20050114091715.47318.qmail@web25107.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114091715.47318.qmail@web25107.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

moreau francis wrote:
> Hi,
> 
> I'm going to use initrd to mount my root fs, but I was
> wondering what its status...
> I have noticed in boot directory addinitrd program
> that seems to add an initrd image right after the
> kernel.
> But there's also a section in kernel/vmlinux.lds.S
> called
> .initrd that includes initrd image during kernel 
> compilation.
> 
> Why are there two different ways of using initrd ?

Actually, there are three:
- the generic initramfs method for compiled in initrds
- the addinitrd method to attach a initrd to a precompiled kernel
  image (which is old, and essentially unmaintained)
- the rd_start/rd_size method, which allows a bootloader to load both
  kernel and initrd images into memory and then tells the kernel via
  the rd_start/rd_size parameters where the initrd is located

> Which one I should use ?

Depends on your machine/bootloader and how much flexibility you want.


Thiemo
