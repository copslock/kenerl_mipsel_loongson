Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA09751
	for <pstadt@stud.fh-heilbronn.de>; Mon, 9 Aug 1999 23:01:52 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA05152; Mon, 9 Aug 1999 13:55:09 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA59028
	for linux-list;
	Mon, 9 Aug 1999 13:45:08 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA60477
	for <linux@engr.sgi.com>;
	Mon, 9 Aug 1999 13:45:04 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA04625
	for <linux@engr.sgi.com>; Mon, 9 Aug 1999 13:45:01 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-29.uni-koblenz.de [141.26.131.29])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id WAA16935
	for <linux@engr.sgi.com>; Mon, 9 Aug 1999 22:44:52 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id OAA17414;
	Mon, 9 Aug 1999 14:40:51 +0200
Date: Mon, 9 Aug 1999 14:40:50 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Cc: thockin@cobaltnet.com
Subject: binutils: Heads up!
Message-ID: <19990809144050.A17349@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Over the last couple of days I've been working on bashing all bugs out of
current CVS binutils from Cygnus.  The result is that as of yesterday
my working version is probably better then ever.

The downside: one of the bugs, misstreating R_MIPS_32 relocations was
present in all previous versions of binutils.  Here the details for those
who care:

Assume two source file, the first one:

	.data
	.globl	var
var:	.word	external_reference

Using binutils 2.8.1 the assembler outputs the following relocation record:

RELOCATION RECORDS FOR [.data]:
OFFSET           TYPE              VALUE 
0000000000000000 R_MIPS_32         external_reference

That's the correct behaviour.  So, now make that a reference to a
global variable defined in the same source:

	.data
	.globl	var
var:	.word	other

	.globl	other
other:	.word	42

This time the assembler will emit:

RELOCATION RECORDS FOR [.data]:
OFFSET           TYPE              VALUE 
0000000000000000 R_MIPS_32         .data

This relocation should be against other.  Why is this a problem?  Assume
both files would be referencing the same global variable.  They get
linked together as part of a final program / library.  Then at runtime
the linker will resolve the one reference to the local instance of the
variable and possibly to another instance for the other reference.

This problem may sound rather theoretical.  Well, it isn't.  Lots of
software out there does nasties like ``int errno = 0;''.  So once we're
finished with fixing binutils every single binary should be recompiled
and eventually exchanged in order to finally get rid of it's effect.
It's probably only causing actual problems in a very small number of
binaries but I though I should mention it.

  Ralf
