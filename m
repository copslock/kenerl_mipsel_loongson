Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 00:44:21 +0000 (GMT)
Received: from zok.sgi.com ([IPv6:::ffff:204.94.215.101]:56198 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225240AbTBEAoU>;
	Wed, 5 Feb 2003 00:44:20 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h14NpDKp010535;
	Tue, 4 Feb 2003 15:51:14 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA28800; Wed, 5 Feb 2003 11:44:14 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h150hlMd029011;
	Wed, 5 Feb 2003 11:43:48 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h150hjcU029009;
	Wed, 5 Feb 2003 11:43:45 +1100
Date: Wed, 5 Feb 2003 11:43:45 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Jason Ormes <jormes@wideopenwest.com>
Cc: linux-mips@linux-mips.org
Subject: Re: kernel boot error.
Message-ID: <20030205004345.GI27302@pureza.melbourne.sgi.com>
References: <200302041841.10507.jormes@wideopenwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302041841.10507.jormes@wideopenwest.com>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 04, 2003 at 06:41:10PM -0600, Jason Ormes wrote:
> hello,
> 
> can someone help me with this error?  Is this because the network failed?

I'm getting exactly the same problem.  What machine are you using?
I'm using an ip27 (origin 200), and an acenic network card.

It seems that there all kinds of PCI hacks in the ip27 support,
and I'm currently trying to figure out how to get this card working...

Cheers,
Andrew
