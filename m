Received:  by oss.sgi.com id <S42211AbQF3Ple>;
	Fri, 30 Jun 2000 08:41:34 -0700
Received: from Cantor.suse.de ([194.112.123.193]:27919 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S42194AbQF3PlX>;
	Fri, 30 Jun 2000 08:41:23 -0700
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 8AD481E20D; Fri, 30 Jun 2000 17:41:31 +0200 (MEST)
Received: from arthur.inka.de (Galois.suse.de [10.0.0.1])
	by Hermes.suse.de (Postfix) with ESMTP
	id 92E8910A026; Fri, 30 Jun 2000 17:41:30 +0200 (MEST)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 1382Py-0008Lk-00; Fri, 30 Jun 2000 17:09:22 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 8B2C81821; Fri, 30 Jun 2000 17:09:20 +0200 (CEST)
To:     libc-alpha Mailinglist <libc-alpha@sourceware.cygnus.com>
Cc:     linux-mips@oss.sgi.com
Subject: origtest failure with MIPS-Linux glibc
From:   Andreas Jaeger <aj@suse.de>
Date:   30 Jun 2000 17:09:20 +0200
Message-ID: <u8og4j6w9r.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


The current glibc testsuite contains in the elf subdirectory a test
called origtest which loads dynamically (via dlopen) the shared file
testobj1.so.

This test fails on MIPS-Linux since testobj1.so contains an undefined
reference to foo which can't be fulfilled.  

In elf_machine_runtime_setup (sysdeps/mips/dl-machine.h)
elf_machine_got_rel is called to relocate the GOT table.  The ABI
defines that "if an entry correspondends to an undefined symbol and
the global offset table entry contains a zero, the entry must be
resolved by the dynamic linker".  foo has a value of 0 and therefore we
need to relocate it (even if it is not called at all) - but there's no
reference at all:

Symbol table '.dynsym' contains 50 entries:
   Num:    Value  Size Type    Bind   Vis      Ndx Name
[...]
    48: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND foo

Who's to blame here?  Is this a restriction of the MIPS ELF ABI (I do
think that glibc's dynamic linker does the right think in this case)?
Or is there a bug in binutils/gcc which should produce a wrong symbol
entry?

Is there anything I can do to fix this failure?

Any comments are very welcome.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
