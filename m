Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2003 22:29:40 +0000 (GMT)
Received: from zok.SGI.COM ([IPv6:::ffff:204.94.215.101]:15254 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225208AbTBRW3W>;
	Tue, 18 Feb 2003 22:29:22 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h1IMTIKp026436;
	Tue, 18 Feb 2003 14:29:18 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id JAA15619; Wed, 19 Feb 2003 09:29:17 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h1IMTDuP007849;
	Wed, 19 Feb 2003 09:29:13 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h1IMTDSP007847;
	Wed, 19 Feb 2003 09:29:13 +1100
Date: Wed, 19 Feb 2003 09:29:13 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: weirdness in bootmem_init(), arch/mips64/kernel/setup.c
Message-ID: <20030218222913.GB915@pureza.melbourne.sgi.com>
References: <20030218065427.GA915@pureza.melbourne.sgi.com> <20030218114244.B25047@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218114244.B25047@linux-mips.org>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 18, 2003 at 11:42:44AM +0100, Ralf Baechle wrote:
> Read again.  PFN_PHYS is shifting left, the others shift right.

Ooops, sorry for the noise...

Cheers,
Andrew
