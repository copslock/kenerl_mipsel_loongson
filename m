Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 09:42:51 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:24195
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224939AbTBYJmu>; Tue, 25 Feb 2003 09:42:50 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18nbbl-001TS1-00; Tue, 25 Feb 2003 10:42:41 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18nbbl-0001FN-00; Tue, 25 Feb 2003 10:42:41 +0100
Date: Tue, 25 Feb 2003 10:42:41 +0100
To: jeff <jeff_lee@coventive.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.20
Message-ID: <20030225094241.GF25303@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030225083321.GD25303@rembrandt.csv.ica.uni-stuttgart.de> <LPECIADMAHLPOFOIEEFNCEMBCNAA.jeff_lee@coventive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LPECIADMAHLPOFOIEEFNCEMBCNAA.jeff_lee@coventive.com>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

jeff wrote:
> Dear Thiemo,
>     We modified the head.S and the kernel_entry change to 0x80000798
> (check from System.map) and we download this kernel to RAM address
> 0x80000000 and jump to 0x8000798 to execute.

By adding a pre_kernel_entry() there, I guess.

> It show EXCEPTION...
> And our bootloader will not handle ELF file format. But after build the kernel
> image, we got two image, vmlinux and vmlinux.binary. vmlinux is FLE file
> format and vmlinux.binary is only data (check by file). We download 
> vmlinux.binary to test.

One more guess: The conversion to binary lost some important section.


Thiemo
