Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2003 16:52:14 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:23018 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225200AbTCZQwO>; Wed, 26 Mar 2003 16:52:14 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA23672;
	Wed, 26 Mar 2003 17:52:40 +0100 (MET)
Date: Wed, 26 Mar 2003 17:52:40 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: kwalker@linux-mips.org
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20030306011121Z8225204-1272+770@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030326175117.20767L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 6 Mar 2003 kwalker@linux-mips.org wrote:

> Modified files:
> 	include/asm-mips: Tag: linux_2_4 war.h 
> 	include/asm-mips64: Tag: linux_2_4 war.h 
> 	drivers/char   : Tag: linux_2_4 Config.in Makefile 
> 	                 sb1250_duart.c 
> Added files:
> 	drivers/char   : Tag: linux_2_4 mips_rtc.c 
> 
> Log message:
> 	many uart fixes, add workaround

 Hmm, how does mips_rtc.c relate to the rest of the commit?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
