Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2003 07:30:58 +0000 (GMT)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:492 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225229AbTAVHa5>;
	Wed, 22 Jan 2003 07:30:57 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h0M5V3G8006400
	for <@external-mail-relay.sgi.com:linux-mips@linux-mips.org>; Tue, 21 Jan 2003 21:31:04 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id SAA21283; Wed, 22 Jan 2003 18:30:53 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h0M7U6HJ008281;
	Wed, 22 Jan 2003 18:30:06 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h0M7U682008279;
	Wed, 22 Jan 2003 18:30:06 +1100
Date: Wed, 22 Jan 2003 18:30:06 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: linux-mips@linux-mips.org
Cc: gnb@melbourne.sgi.com
Subject: debian's mips userland on mips64
Message-ID: <20030122073006.GF6262@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

Hi all,

I'm playing with Debian on an Origin 200 (aka ip27 - 64-bit mips).
The current setup in the mips64-linux world is 64bit kernel +
32bit userland.  So, a mips64-linux kernel can be mostly run a
mips32-linux userland out of the box.

Unfortunately, this doesn't apply to strace, as this play with
the 64bit kernel's stack (eg: struct pt_regs), which is different in
mips32 and mips64.

So, I guess the solution is to hack (it's ugly as hell already...)
strace to detect and understand the 64 bit stack from a 32 bit
userland?

Cheers,
Andrew
