Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Feb 2003 22:58:38 +0000 (GMT)
Received: from rj.sgi.com ([IPv6:::ffff:192.82.208.96]:62146 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225230AbTBLW6h>;
	Wed, 12 Feb 2003 22:58:37 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h1CKwgG8014881;
	Wed, 12 Feb 2003 12:58:42 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id JAA19901; Thu, 13 Feb 2003 09:58:29 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h1CMwQ8G000308;
	Thu, 13 Feb 2003 09:58:26 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h1CMwNd1000306;
	Thu, 13 Feb 2003 09:58:23 +1100
Date: Thu, 13 Feb 2003 09:58:23 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: porting arcboot
Message-ID: <20030212225823.GJ8408@pureza.melbourne.sgi.com>
References: <20030210034549.GA8408@pureza.melbourne.sgi.com> <20030210100319.GA30624@merry> <20030210223955.GF8408@pureza.melbourne.sgi.com> <20030211224622.GC1186@paradigm.rfc822.org> <20030212050341.GI8408@pureza.melbourne.sgi.com> <20030212152620.GB7934@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212152620.GB7934@paradigm.rfc822.org>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Wed, Feb 12, 2003 at 04:26:20PM +0100, Florian Lohoff wrote:
> > Am I missing something?
> 
> Yes - That you dont need all those objects in that archive. 

But how does that help?  It's painful to merely build the set
of objects we need.  (That would involve e2fsprogs makefile hacking...
i.e. not just reusing it out-of-the-box)  But it's absolutely necessary,
because it's impossible to build all the other objects for mips64 today.

So, are you doing the Makefile hacking, or what?

Cheers,
Andrew
