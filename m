Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jan 2004 12:40:34 +0000 (GMT)
Received: from gateway.heeltoe.com ([IPv6:::ffff:66.134.219.32]:8251 "HELO
	gateway.heeltoe.com") by linux-mips.org with SMTP
	id <S8225235AbUAJMkd>; Sat, 10 Jan 2004 12:40:33 +0000
Received: (qmail 17053 invoked from network); 10 Jan 2004 12:40:26 -0000
Received: from mwave.heeltoe.com (192.245.4.20)
  by clunker.heeltoe.com with SMTP; 10 Jan 2004 12:40:26 -0000
Received: from mwave (brad@localhost)
	by mwave.heeltoe.com (8.11.6/8.11.6) with ESMTP id i0ACePX01584;
	Sat, 10 Jan 2004 07:40:25 -0500
Message-Id: <200401101240.i0ACePX01584@mwave.heeltoe.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Adam Nielsen <a.nielsen@optushome.com.au>
cc: linux-mips@linux-mips.org
Subject: Re: Running Linux on an NCD HMX X-Terminal 
In-Reply-To: Message from Adam Nielsen <a.nielsen@optushome.com.au> 
   of "Sat, 10 Jan 2004 15:05:04 +1000." <200401101505.04453@korath> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 10 Jan 2004 07:40:25 -0500
From: Brad Parker <brad@heeltoe.com>
Return-Path: <brad@heeltoe.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@heeltoe.com
Precedence: bulk
X-list: linux-mips


Adam Nielsen wrote:
...
>Does anyone know what my chances would be of getting a Linux kernel on it?  I 
>found a couple of precompiled MIPS kernel images (one was ELF32 but the other 
>was ELF64), however when I tried to boot them the terminal simply said "Load 
>address out of range" and aborted.  I was using the precompiled images 
>because I really want to know whether it'll work before I go to the trouble 
>of installing all the cross-compilation tools.

I brought up linux on the PPC403 version of an NCD x-terminal.  As I recall I
had to write program to hack the elf header to get kernels to load.

The project is at http://sourceforge.net/projects/explora-linux/

And the program to hack the kernel elf file is 

http://cvs.sourceforge.net/viewcvs.py/explora-linux/ncdhack/ncdhack.c

You may get lucky and find they used the same format for MIPS...

-brad
