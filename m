Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 09:21:46 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:41643 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122961AbSIMHVq>; Fri, 13 Sep 2002 09:21:46 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id JAA21652;
	Fri, 13 Sep 2002 09:22:07 +0200 (MET DST)
Date: Fri, 13 Sep 2002 09:22:06 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Matthew Dharm <mdharm@momenco.com>
cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: When to #ifdef on CPUs?
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIMEPBCIAA.mdharm@momenco.com>
Message-ID: <Pine.GSO.3.96.1020913091043.21164B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 12 Sep 2002, Matthew Dharm wrote:

> So, what's the rule here?  When do I used #ifdef and when do I just
> let the PRID stuff work it's magic?
> 
> I mean, heck... it might be nice to put a check to see if the detected
> CPU matches what the kernel was compiled for...

 Well, we might be able to build generic kernels one day.  So you need to
judge whether some bits of code are needed/useful if run on your processor
in a generic configuration (use PRId then) or are specific to a
configuration dedicated to your processor (use a config option then).

 There are places in the existing code that violate the rule but the
reasons are mostly historical and they will hopefully get cleaned up
sooner or later (I have a few of them on my to-do list, too).  Thus please
don't be much too influenced by old code.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
