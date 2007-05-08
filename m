Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2007 16:03:25 +0100 (BST)
Received: from mail.cybits.de ([213.139.144.204]:34861 "EHLO mail.cybits.de")
	by ftp.linux-mips.org with ESMTP id S20022229AbXEHPDX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 May 2007 16:03:23 +0100
Received: from localhost (unknown [127.0.0.1])
	by mail.cybits.de (Postfix) with ESMTP id 482A12D6BB3
	for <linux-mips@linux-mips.org>; Tue,  8 May 2007 15:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cybits.de
Received: from mail.cybits.de ([127.0.0.1])
	by localhost (mail.cybits.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3OGHEAE9tB5q for <linux-mips@linux-mips.org>;
	Tue,  8 May 2007 17:04:51 +0200 (CEST)
Received: from [192.168.1.177] (unknown [192.168.1.177])
	by mail.cybits.de (Postfix) with ESMTP id 535942D6BB0
	for <linux-mips@linux-mips.org>; Tue,  8 May 2007 17:04:51 +0200 (CEST)
Message-ID: <4640911A.4080801@cybits.de>
Date:	Tue, 08 May 2007 17:02:50 +0200
From:	Claus Herrmann <claus.herrmann@cybits.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Building a cross kernel for the IP27/Origin System
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <claus.herrmann@cybits.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: claus.herrmann@cybits.de
Precedence: bulk
X-list: linux-mips

Hi,

ich have a question regarding the crosscompiling for an Origin 2000. 
First of all i get this warning:

include/linux/mmzone.h:553:1: warning: "NODE_DATA" redefined
In file included from include/asm/mmzone.h:9,
                 from include/asm-mips/mach-ip27/topology.h:5,
                 from include/asm/topology.h:1,
                 from include/linux/topology.h:34,
                 from include/linux/mmzone.h:544,
                 from include/linux/gfp.h:4,
                 from include/linux/slab.h:14,
                 from include/linux/percpu.h:5,
                 from include/linux/rcupdate.h:41,
                 from include/linux/pid.h:4,
                 from include/linux/sched.h:72,
                 from arch/mips/kernel/asm-offsets.c:13:
include/asm-mips/mach-ip27/mmzone.h:33:1: warning: this is the location of the previous definition

I fixed it by doing a #define and a #ifndef around the golbal NODE_DATA.
Now it compiles smoothly, but in the end I get this:

mips-linux-ld: Dwarf Error: found dwarf version '0', this reader only handles version 2 information.
mips-linux-ld: Dwarf Error: found dwarf version '0', this reader only handles version 2 information.
mips-linux-ld: Dwarf Error: found dwarf version '365', this reader only handles version 2 information.
mips-linux-ld: Dwarf Error: found dwarf version '22528', this reader only handles version 2 information.
arch/mips/mm/built-in.o: In function `mem_init':
: multiple definition of `mem_init'
mips-linux-ld: Dwarf Error: found dwarf version '0', this reader only handles version 2 information.
mips-linux-ld: Dwarf Error: found dwarf version '8704', this reader only handles version 2 information.
arch/mips/sgi-ip27/built-in.o:: first defined here
arch/mips/mm/built-in.o: In function `paging_init':
: multiple definition of `paging_init'
arch/mips/sgi-ip27/built-in.o:: first defined here
make: *** [.tmp_vmlinux1] Fehler 1

Any suggestions what i am doing wrong?
The toolchan i use is the one from MIPS SDE UK. I tried to build my own 
Toolchain, but the same error occur.

Brgds

Claus
