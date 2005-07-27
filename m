Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2005 19:00:48 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:31496 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225806AbVG0SAb>; Wed, 27 Jul 2005 19:00:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DE295E1C67; Wed, 27 Jul 2005 20:03:00 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03868-07; Wed, 27 Jul 2005 20:03:00 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A7C0BE1C65; Wed, 27 Jul 2005 20:03:00 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6RI345N001721;
	Wed, 27 Jul 2005 20:03:04 +0200
Date:	Wed, 27 Jul 2005 19:03:16 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Niels Sterrenburg <pulsar@kpsws.com>, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050727172427.GB3626@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0507271858050.13819@blysk.ds.pg.gda.pl>
References: <20050725213607Z8225534-3678+4335@linux-mips.org>
 <57480.194.171.252.100.1122478386.squirrel@mail.kpsws.com>
 <20050727172427.GB3626@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/994/Wed Jul 27 10:28:09 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 27 Jul 2005, Ralf Baechle wrote:

> Well, here's my nuke-trailing-whitespace skript.  Pretty small - 80% of it
> is the legalese and a brief comment.  In case you're using quilt you
> can do something like
> 
>   nuke-trailing-whitespace `quilt files`
>   quilt refresh --diffstat
> 
> to clean a particular patch

 It doesn't wipe other rubbish like spaces followed by tabs, though -- 
e.g. ones that would match "^ \t".  Perhaps `indent' could help with them, 
but I trust my fingers and eyes instead. ;-)

  Maciej
