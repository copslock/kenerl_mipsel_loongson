Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.3/8.9.3) with ESMTP id XAA18770
	for <pstadt@stud.fh-heilbronn.de>; Wed, 13 Oct 1999 23:14:40 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA03821; Wed, 13 Oct 1999 14:09:13 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA26582
	for linux-list;
	Wed, 13 Oct 1999 13:59:00 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA31874
	for <linux@engr.sgi.com>;
	Wed, 13 Oct 1999 13:58:32 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA414318
	for <linux@engr.sgi.com>; Wed, 13 Oct 1999 13:58:25 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-7.uni-koblenz.de [141.26.131.7])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id WAA19043
	for <linux@engr.sgi.com>; Wed, 13 Oct 1999 22:58:18 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id VAA01389;
	Wed, 13 Oct 1999 21:39:26 +0200
Date: Wed, 13 Oct 1999 21:39:26 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: binutils@sourceware.cygnus.com, Mark Mitchell <mark@codesourcery.com>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: R_MIPS_64 broken in relocateable links
Message-ID: <19991013213926.A1383@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

The shell archive below is a testcase demonstrating a bug in handling
R_MIPS_64 relocations in 32-bit ELF broken for relocateable links.
The output objectfile will contain bad relocations like:

0000000000000014 l       .text  0000000000000000 xxx

This seems to be caused by BFD temporarily adding 4 to the relocation's
address.  It seem the fix is to undo this when copying R_MIPS_64
relocations to the output file?

  Ralf

#!/bin/sh
# This is a shell archive (produced by GNU sharutils 4.2).
# To extract the files from this archive, save it to some FILE, remove
# everything before the `!/bin/sh' line above, then type `sh FILE'.
#
# Made on 1999-10-13 12:24 PDT by <ralf@cashcow>.
# Source directory was `/usr/people/ralf'.
#
# Existing files will *not* be overwritten unless `-c' is specified.
# This format requires very little intelligence at unshar time.
# "if test", "echo", "mkdir", and "sed" may be needed.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#     14 -rw-r--r-- nuke-ld-23/s1.s
#     48 -rw-r--r-- nuke-ld-23/s2.s
#    328 -rw-r--r-- nuke-ld-23/Makefile
#
echo=echo
if mkdir _sh92525; then
  $echo 'x -' 'creating lock directory'
else
  $echo 'failed to create lock directory'
  exit 1
fi
# ============= nuke-ld-23/s1.s ==============
if test ! -d 'nuke-ld-23'; then
  $echo 'x -' 'creating directory' 'nuke-ld-23'
  mkdir 'nuke-ld-23'
fi
if test -f 'nuke-ld-23/s1.s' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'nuke-ld-23/s1.s' '(file already exists)'
else
  $echo 'x -' extracting 'nuke-ld-23/s1.s' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'nuke-ld-23/s1.s' &&
X	.word	0x1234
SHAR_EOF
  : || $echo 'restore of' 'nuke-ld-23/s1.s' 'failed'
fi
# ============= nuke-ld-23/s2.s ==============
if test -f 'nuke-ld-23/s2.s' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'nuke-ld-23/s2.s' '(file already exists)'
else
  $echo 'x -' extracting 'nuke-ld-23/s2.s' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'nuke-ld-23/s2.s' &&
Xxxx:	.dword	something
Xsomething:
X	.dword	0x789a
SHAR_EOF
  : || $echo 'restore of' 'nuke-ld-23/s2.s' 'failed'
fi
# ============= nuke-ld-23/Makefile ==============
if test -f 'nuke-ld-23/Makefile' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'nuke-ld-23/Makefile' '(file already exists)'
else
  $echo 'x -' extracting 'nuke-ld-23/Makefile' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'nuke-ld-23/Makefile' &&
Xtarget=mips-linux-
XAS = $(target)as
XLD = $(target)ld
XOBJDUMP = $(target)objdump
X
Xall: broken.o
X
X.PHONY: broken.o
Xbroken.o:	s1.o s2.o
X	$(LD) -r -o $@ $^
X	$(OBJDUMP) --full-content --section=.text $@
X	$(OBJDUMP) --syms $@ | grep xxx
X	$(OBJDUMP) --reloc $@
X
X.PHONY: clean distclean
Xclean distclean:
X	-rm -f s1.o s2.o broken.o core
SHAR_EOF
  : || $echo 'restore of' 'nuke-ld-23/Makefile' 'failed'
fi
rm -fr _sh92525
exit 0
