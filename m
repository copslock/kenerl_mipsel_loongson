Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Mar 2003 07:25:45 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:12303
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224861AbTC2HZo>; Sat, 29 Mar 2003 07:25:44 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18zAik-0004o9-00; Sat, 29 Mar 2003 08:25:42 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18zAij-00052r-00; Sat, 29 Mar 2003 08:25:41 +0100
Date: Sat, 29 Mar 2003 08:25:41 +0100
To: "Avinash S." <avinash.s@inspiretech.com>
Cc: linux <linux-mips@linux-mips.org>
Subject: Re: your mail
Message-ID: <20030329072541.GD14490@rembrandt.csv.ica.uni-stuttgart.de>
References: <200303290723.h2T7NYq6006229@smtp.inspirtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303290723.h2T7NYq6006229@smtp.inspirtek.com>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Avinash S. wrote:
> Hello,
> 
> Im trying to build a kernel config for a big endian IDT79S334 board. I 
> have sucessfully mangaged to get a vmlinux image using Embedix tools for 
> little endian but am having problems with big endian configs. I am using 
> binutils version 2.8. I get an error when i reaches irq.c saying:
                   ^^^
That's _very_ old.

> Unknown ISA level 
> Unknown opcode 'clz'
> 
> im using a mips-linux-gcc from egcs pacakge(1.1.2-4). Does anyone know 
> how to solve this problem or where can i get a mips-linux-gcc that 
> supports the opcode.

It's the assembler, not the compiler. Upgrade binutils.


Thiemo
