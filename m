Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 22:40:49 +0000 (GMT)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:975 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225240AbTBDWkt>;
	Tue, 4 Feb 2003 22:40:49 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h14KeAG8024224;
	Tue, 4 Feb 2003 12:40:13 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id JAA26579; Wed, 5 Feb 2003 09:39:58 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h14MdWMd028868;
	Wed, 5 Feb 2003 09:39:32 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h14MdU1A028866;
	Wed, 5 Feb 2003 09:39:30 +1100
Date: Wed, 5 Feb 2003 09:39:30 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Guido Guenther <agx@sigxcpu.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [patch] cmdline.c rewrite
Message-ID: <20030204223930.GD27302@pureza.melbourne.sgi.com>
References: <20030204061323.GA27302@pureza.melbourne.sgi.com> <20030204092417.GR16674@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204092417.GR16674@bogon.ms20.nix>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 04, 2003 at 10:24:17AM +0100, Guido Guenther wrote:
> On Tue, Feb 04, 2003 at 05:13:23PM +1100, Andrew Clausen wrote:
> > Some kernel parameters are auto-generated.   eg: root= (always has been
> > broken).  Anyway, the old version of cmdline.c added these auto-generated
> Can you explain in what way root= was broken?

It was blindly copying from the environment variable a string
looking like dksc(0,1,2).  This should be translated (somehow)
to something looking like /dev/sdb1.  This would have to be
done after the hard disk probes.

Does Linux have some other notation for addressing devices by
their location on the bus?  (I recall a flamewar on the topic...)

Cheers,
Andrew
