Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Jun 2003 19:47:51 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:40066 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225209AbTFNSrt>; Sat, 14 Jun 2003 19:47:49 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA06138;
	Sat, 14 Jun 2003 20:48:22 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Sat, 14 Jun 2003 20:48:22 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dan Malek <dan@embeddededge.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <3EEA3B5C.2000201@embeddededge.com>
Message-ID: <Pine.GSO.3.96.1030614203554.1934E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 13 Jun 2003, Dan Malek wrote:

> >   arch/mips/platforms/platform1/...
> >                      /platform2/...
> 
>  From my experience with other architectures, fewer intermediate
> directories are often useful, for example:
> 
> 	arch/mips/platforms/board_and_chip_files
> 
> allows a maximum amount of code sharing and minimal duplication.

 What prevents one from sharing code from different directories?

> When you have lots of lower level directories, you often have
> many identical files in them that should be shared, but are not,
> causing support/update challenges.  For example:
> 
> 	arch/mips/platforms/mfg_board_common.[ch]
> 	arch/mips/platforms/mfg_board_type1.[ch]
> 	arch/mips/platforms/mfg_board_type2.[ch]
> 
> keeps all manufacturer shared code in one place, and the board
> files could be quite small.  I have the specific case right now
> with a board vendor that has about six similar boards, all in
> separate directories like this:
> 
> 	arch/mips/au1000/board1/file.c
> 	arch/mips/au1000/board2/file.c
> 	arch/mips/au1000/board3/file.c
> 
> where the code is all identical in those files.  My first move is

 IMO file.c should me moved up one level or to arch/mips/au1000/lib.

> going to be consolidation of all of the "board" directories into a
> single "manufacturer" directory just to eliminate the overhead of
> keeping all of these files consistent on updates.  Then, I'm just
> going to prefix the board type to the unique file names.  I find
> this much easier to maintain and to share code.  Common sense
> file names using a standard manufacturer/board name prefix makes
> the files just as easy to identify as separate directories.

 Identification is not a problem.  Logical separation is.  Directories
were invented for a reason.

> It would be nice to see the defconfig files in their own directory,
> that would be the single most useful way to eliminate some clutter :-)

 It sounds reasonable.  The generic defconfig of course has to be left
where it is now.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
