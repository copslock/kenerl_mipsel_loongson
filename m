Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2003 22:44:37 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:44276 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225289AbTFMVof>;
	Fri, 13 Jun 2003 22:44:35 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h5DLiPQ14847;
	Fri, 13 Jun 2003 14:44:25 -0700
Date: Fri, 13 Jun 2003 14:44:25 -0700
From: Jun Sun <jsun@mvista.com>
To: Dan Malek <dan@embeddededge.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	jsun@mvista.com
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030613144425.E14458@mvista.com>
References: <Pine.GSO.3.96.1030613221736.20506C-100000@delta.ds2.pg.gda.pl> <3EEA3B5C.2000201@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3EEA3B5C.2000201@embeddededge.com>; from dan@embeddededge.com on Fri, Jun 13, 2003 at 05:00:12PM -0400
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Jun 13, 2003 at 05:00:12PM -0400, Dan Malek wrote:
> Maciej W. Rozycki wrote:
> 
> >  It looks as a good idea, although possibly an intermediate directory
> > would be desireable not to clutter arch/mips too much.  E.g:
> > 
> >   arch/mips/platforms/platform1/...
> >                      /platform2/...
> 
>  From my experience with other architectures, fewer intermediate
> directories are often useful, for example:
> 
> 	arch/mips/platforms/board_and_chip_files
> 
> allows a maximum amount of code sharing and minimal duplication.
> When you have lots of lower level directories, you often have
> many identical files in them that should be shared, but are not,
> causing support/update challenges.  For example:
> 
> 	arch/mips/platforms/mfg_board_common.[ch]
> 	arch/mips/platforms/mfg_board_type1.[ch]
> 	arch/mips/platforms/mfg_board_type2.[ch]
>

Congradualtions!  You will have roughly about 950 files under that
directory.

Even with good effort to combine files and promote sharing, I think
you will still have quite some.

I think having another directory layer under arch/mips/platforms
shouldn't be too bad, (although I like arch/mips/machines better).  

We can use some scheme like Geert was proposing, i.e., named after
boards and chipsets.  Hack, I think even naming after board vendor
is acceptable.


> It would be nice to see the defconfig files in their own directory,
> that would be the single most useful way to eliminate some clutter :-)
>

I second on this.

Jun
