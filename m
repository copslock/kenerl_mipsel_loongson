Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 19:24:33 +0200 (CEST)
Received: from real.realitydiluted.com ([208.242.241.164]:45546 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S1122987AbSIQRYc>; Tue, 17 Sep 2002 19:24:32 +0200
Received: from localhost.localdomain ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 17rHOp-00040I-00; Tue, 17 Sep 2002 07:24:15 -0500
Message-ID: <3D87653E.9030702@realitydiluted.com>
Date: Tue, 17 Sep 2002 12:24:14 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Stuart Hughes <seh@zee2.com>
CC: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: cannot debug multi-threaded programs with gdb/gdbserver
References: <3D876053.C2CD1D8C@zee2.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Stuart Hughes wrote:
> 
> Does anyone know whether there is some special setup needed on
> gdb/gdbserver to use the multi-threaded gdbserver ??
> 
Wow, there are so many things to tell you...where to start...

> My environment is as follows:
> 
> CPU:		NEC VR5432
> kernel: 	linux-2.4.18 + patches
> glibc:		2.2.3 + patches
> gdb:		5.2/3 from CVS
 >
Has to be the gdb-5.3 branch...go look at http://sources.redhat.com/gdb

> gcc:		3.1
> binutils:	Version 2.11.90.0.25
> 
Don't use H.J. Lu's binutils, use the released one. Use gcc-3.2 and
binutils-2.13 as they have fixes for the MIPS debugging symbols with
regards to DWARF.

> cross-gdb configured using: 
> 
> configure --prefix=/usr --target=mipsel-linux --disable-sim
> --disable-tcl --enable-threads --enable-shared
> 
Use '--target=mips-linux' and you'll be better off. Don't worry, it
will support both endians.

> gdbserver configured using:
> 
> configure --prefix=/usr --host=mipsel-linux --target=mipsel-linux
> --enable-threads --enable-shared
> 
I would also try 'CC=mipsel-linux-gcc configure <...>'.

-Steve
