Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 18:05:30 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:34803 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225463AbUBESF3>;
	Thu, 5 Feb 2004 18:05:29 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i15I5Qc10073;
	Thu, 5 Feb 2004 10:05:26 -0800
Date: Thu, 5 Feb 2004 10:05:25 -0800
From: Jun Sun <jsun@mvista.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>, jsun@mvista.com
Subject: Re: [ANNOUNCE] "cvs explorer" for linux-mips CVS tree
Message-ID: <20040205100525.B9885@mvista.com>
References: <20040204150820.H26726@mvista.com> <Pine.GSO.4.58.0402051218590.11549@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.58.0402051218590.11549@waterleaf.sonytel.be>; from geert@linux-m68k.org on Thu, Feb 05, 2004 at 12:19:34PM +0100
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Feb 05, 2004 at 12:19:34PM +0100, Geert Uytterhoeven wrote:
> On Wed, 4 Feb 2004, Jun Sun wrote:
> > I wrote a CVS tracking tool that tracks CVS changes in patch format
> > and present them with a web interface.  It is now set up to track
> > linux-mips.org tree at the following place.  Enjoy.
> >
> > http://www.linux-mips.org/xcvs/linux-mips
> 
> http://www.linux-mips.org/xcvs/html/select.php
> | Warning: Assertion failed in /var/www/www.linux-mips.org/xcvs/html/db.inc.php on line 36
> | Warning: readfile("/LAST_UPDATE") - No such file or directory in /var/www/www.linux-mips.org/xcvs/html/select.inc.php on line 47
> 

It appears session somehow does not work on your web viewer.  What is 
your web browser anyway?

Immediately after you hit above link, please redirect URL to

http://www.linux-mips.org/xcvs/test.php

If you don't see following, that means sessions do not work.

------------------------------------------------
dbname : xcvs_linux_mips
patchdir : ../linux-mips/patches
branch : MAIN
author : all authors
starting-date :
ending-date :
-----------------------------------------------

Anybody else has similar problems?

Jun
