Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 13:52:56 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:29431 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225456AbTISMwx>; Fri, 19 Sep 2003 13:52:53 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA11097;
	Fri, 19 Sep 2003 14:52:35 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 19 Sep 2003 14:52:35 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Eric Christopher <echristo@redhat.com>
cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
In-Reply-To: <1063949984.2537.0.camel@ghostwheel.sfbay.redhat.com>
Message-ID: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 18 Sep 2003, Eric Christopher wrote:

> > But mips64 kernel assumes that the kernel itself is compiled with
> > "-mabi=64".  For example, some asm routines pass more than 4 arguments
> > via aN registers.
> 
> Yes, but then you aren't abi compliant are you? If you want n64 then say
> n64. If you want o32 extended to 64-bit registers then use o64.

 I think "-mabi=64" is OK (I use it for over a year now) and for those
worried of every byte of precious memory, "-mabi=n32 -mlong64" might be
the right long-term answer (although it might require verifying if tools
handle it right).  Given the experimental state of the 64-bit kernel it
should be OK to be less forgiving on a requirement for recent tools. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
