Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 13:53:31 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:37639 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225283AbVBGNxP>;
	Mon, 7 Feb 2005 13:53:15 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1Cy9PI-0006bH-00; Mon, 07 Feb 2005 13:58:28 +0000
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Cy9Jy-0006FY-00; Mon, 07 Feb 2005 13:52:58 +0000
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 1Cy9Jy-0008Fl-00; Mon, 07 Feb 2005 13:52:58 +0000
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16903.29369.622451.447313@arsenal.mips.com>
Date:	Mon, 7 Feb 2005 13:52:57 +0000
To:	Dominic Sweetman <dom@mips.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	nigel@mips.com, linux-mips@linux-mips.org
Subject: Re: c-r4k.c cleanup
In-Reply-To: <16903.24802.504192.330272@arsenal.mips.com>
References: <20050204.231254.74753794.anemo@mba.ocn.ne.jp>
	<4203890B.5030305@mips.com>
	<20050204145803.GA5618@linux-mips.org>
	<20050207.192450.55145246.nemoto@toshiba-tops.co.jp>
	<16903.24802.504192.330272@arsenal.mips.com>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.897,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Interesting,

> Atsushi Nemoto (anemo@mba.ocn.ne.jp) writes:
> 
> > 20KC Users Manual says it has physically indexed data cache.
> 
> That's correct.
> 
> > For other MIPS64 core, 5Kc has virtually indexed cache.
> 
> Yes.
> 
> > How about 25KF?
> 
> Physically indexed, it's a descendent of the 20Kc core.

When Yoichi said 

> 25Kf also has virtually indexed cache

I assume s/he meant the I-cache.

Here is the official MIPS Technologies line (and we kind of ought to know):

o The 25KF D-cache is physically indexed (and of course
  physically tagged). 

o The 25KF I-cache is virtually indexed and virtually tagged - the tag
  includes the ASID to reduce the number of occasions on which you
  have to invalidate all the lines from a particular process.

o A 25KF secondary cache, if provided, is physically indexed and
  tagged. 

-- 
Dominic Sweetman, 
MIPS Technologies (UK)
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706205 / fax: +44 1223 706250 / swbrd: +44 1223 706200
http://www.mips.com
