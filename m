Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2003 21:27:22 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:43421 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225287AbTFMU1U>; Fri, 13 Jun 2003 21:27:20 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA21706;
	Fri, 13 Jun 2003 22:28:04 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 13 Jun 2003 22:28:03 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <Pine.GSO.4.21.0306132052290.14094-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1030613221736.20506C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 13 Jun 2003, Geert Uytterhoeven wrote:

> So in the future we may see something like this:
> 
>   arch/mips/chipset1/...
>            /chipset2/...
> 	   /...
> 	   /board1/...
> 	   /board2/...
> 
> where the board* directories contain the glue code for the specific boards?

 It looks as a good idea, although possibly an intermediate directory
would be desireable not to clutter arch/mips too much.  E.g:

  arch/mips/platforms/platform1/...
                     /platform2/...
            ...
  arch/mips/chipset/chipset1/...
                   /chipset2/...

I assume by "chipset" you mean the lone system controller or host bridge. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
