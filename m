Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2005 16:33:56 +0000 (GMT)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.207]:134 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225291AbVBUQdi>;
	Mon, 21 Feb 2005 16:33:38 +0000
Received: by wproxy.gmail.com with SMTP id 57so768361wri
        for <linux-mips@linux-mips.org>; Mon, 21 Feb 2005 08:33:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=rosvcAe8PtDB2n9I9TZI+yEH6TmhCnvjvYwgW2V8vUpnoJ/nTPdWcFamhjdDNB5kd21hy9zdTi1aLG5jWbuqL/aaWIw/Y2qJOEVIzHNUhR3e2vgstPzvwHFGNRjKlMNF3i+7eN5EsqGWrF9i1mA6tM/5p27Wtw6Nf5Yp1ZyIhJo=
Received: by 10.54.35.68 with SMTP id i68mr40435wri;
        Mon, 21 Feb 2005 08:33:29 -0800 (PST)
Received: by 10.54.41.3 with HTTP; Mon, 21 Feb 2005 08:33:29 -0800 (PST)
Message-ID: <ecb4efd1050221083348d1f90b@mail.gmail.com>
Date:	Mon, 21 Feb 2005 11:33:29 -0500
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: compiling yamon for Au1550 with a recent toolchain?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

This isn't completely on topic, but it is a step on the way. I'm
getting ready for my Au1550 based hardware that will be back from
assembly soon. I'm trying to get the AMD provided yamon source to
compile. I'm using gcc 3.4.3 and bintools 2.15.94.0.2. After a few
tweeks to the makefile, yamon compiles but fails to link:

mips-ld -G 0 -T ./../link/link_el.xn -o ./yamon-02.23DB1550_el.elf -Map ...
mips-ld: section .data [000000009fc3d650 -> 000000009fc40faf] overlaps
section .rodata.str1.4 [000000009fc3d650 -> 000000009fc47197]
mips-ld: ./yamon-02.23DB1550_el.elf: section .rodata.str1.4 lma
0x9fc3d650 overlaps previous sections
mips-ld: ./yamon-02.23DB1550_el.elf: section .rodata.cst4 lma
0x9fc47198 overlaps previous sections

The linker command file (bin/link/link_el.xn) puts .data and .rodata
in _etext. I changed the *(.rodata) to *(.rodata*) in the link_el.xn,
but that didn't help.

Any ideas what might be going on? Has anyone tried compiling this
yamon with a recent gcc/bintools?

                                  Thanks,
                                  Clem
