Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2003 22:00:13 +0100 (BST)
Received: from 157-84-51-66.reonbroadband.com ([IPv6:::ffff:66.51.84.157]:38653
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225262AbTFMVAL>; Fri, 13 Jun 2003 22:00:11 +0100
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h5DL0Ei00739;
	Fri, 13 Jun 2003 17:00:14 -0400
Message-ID: <3EEA3B5C.2000201@embeddededge.com>
Date: Fri, 13 Jun 2003 17:00:12 -0400
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
References: <Pine.GSO.3.96.1030613221736.20506C-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>  It looks as a good idea, although possibly an intermediate directory
> would be desireable not to clutter arch/mips too much.  E.g:
> 
>   arch/mips/platforms/platform1/...
>                      /platform2/...

 From my experience with other architectures, fewer intermediate
directories are often useful, for example:

	arch/mips/platforms/board_and_chip_files

allows a maximum amount of code sharing and minimal duplication.
When you have lots of lower level directories, you often have
many identical files in them that should be shared, but are not,
causing support/update challenges.  For example:

	arch/mips/platforms/mfg_board_common.[ch]
	arch/mips/platforms/mfg_board_type1.[ch]
	arch/mips/platforms/mfg_board_type2.[ch]

keeps all manufacturer shared code in one place, and the board
files could be quite small.  I have the specific case right now
with a board vendor that has about six similar boards, all in
separate directories like this:

	arch/mips/au1000/board1/file.c
	arch/mips/au1000/board2/file.c
	arch/mips/au1000/board3/file.c

where the code is all identical in those files.  My first move is
going to be consolidation of all of the "board" directories into a
single "manufacturer" directory just to eliminate the overhead of
keeping all of these files consistent on updates.  Then, I'm just
going to prefix the board type to the unique file names.  I find
this much easier to maintain and to share code.  Common sense
file names using a standard manufacturer/board name prefix makes
the files just as easy to identify as separate directories.

It would be nice to see the defconfig files in their own directory,
that would be the single most useful way to eliminate some clutter :-)

Thanks.


	-- Dan
