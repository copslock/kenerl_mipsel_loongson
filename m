Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 11:39:54 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:14570 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225424AbSLSLjx>; Thu, 19 Dec 2002 11:39:53 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA00165;
	Thu, 19 Dec 2002 12:40:05 +0100 (MET)
Date: Thu, 19 Dec 2002 12:40:04 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: make prototype of printk available
In-Reply-To: <m2of7imhkw.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021219122246.27339F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 19 Dec 2002, Juan Quintela wrote:

> maciej> Why is the default log level incorrect here?
> 
> The problem (not here in general), is that if printk's use the default
> log level, then you as a user has no way to raise/lower the default
> log level (i.e. the messages that you want to printk or not).

 Well, the default level is KERN_WARNING and can be changed using sysctl. 
Otherwise it's handled identically to explicitly tagged messages -- you
may control direct console output with the same sysctl. 

 Obviously there are printks that beg for an explicit tag.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
