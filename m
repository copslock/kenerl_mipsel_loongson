Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 14:42:50 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:25988 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225541AbSLTOmt>;
	Fri, 20 Dec 2002 14:42:49 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 42005D657; Fri, 20 Dec 2002 15:48:56 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: for poor sools with old I2 & 64 bits kernel
References: <m2el8dixmr.fsf@demo.mitica>
	<20021220034450.A21950@linux-mips.org>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20021220034450.A21950@linux-mips.org>
Date: 20 Dec 2002 15:48:56 +0100
Message-ID: <m2ptrwg2zr.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "ralf" == Ralf Baechle <ralf@linux-mips.org> writes:

ralf> On Thu, Dec 19, 2002 at 09:04:12PM +0100, Juan Quintela wrote:
>> this small patch made possible to compile a 64bit kernel for
>> people that have old proms that only accept ecoff.  As usual
>> stolen from the 32 bits version.
>> 
>> The easiest way is creating the file in arch/mips/boot,
>> otherwise we need to copy elf2ecoff.c to mips64.

ralf> Applied slightly modified.  I removed two other unused targets.

Please, add that back, and things will indeed compile :)

Later, Juan.

Index: arch/mips64/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips64/Makefile,v
retrieving revision 1.22.2.21
diff -u -r1.22.2.21 Makefile
--- arch/mips64/Makefile	20 Dec 2002 02:42:26 -0000	1.22.2.21
+++ arch/mips64/Makefile	20 Dec 2002 14:37:18 -0000
@@ -235,7 +235,7 @@
 CORE_FILES := arch/mips64/kernel/kernel.o arch/mips64/mm/mm.o $(CORE_FILES)
 LIBS := arch/mips64/lib/lib.a $(LIBS)
 
-MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
+MAKEBOOT = $(MAKE) -C arch/mips/boot
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 64bit-bfd = elf64-tradlittlemips



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
