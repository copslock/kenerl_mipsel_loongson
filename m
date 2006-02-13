Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 04:13:05 +0000 (GMT)
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:38821 "EHLO
	rwcrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133354AbWBMEMx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 04:12:53 +0000
Received: from [192.168.1.4] (unknown[69.140.185.48])
          by comcast.net (rwcrmhc12) with ESMTP
          id <20060213041900m1200d7cste>; Mon, 13 Feb 2006 04:19:00 +0000
Message-ID: <43F008B1.7070103@gentoo.org>
Date:	Sun, 12 Feb 2006 23:18:57 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.X] Early console for Cobalt
References: <20060212171025.GB1562@colonel-panic.org> <20060213.114359.07641583.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060213.114359.07641583.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
>>>>>> On Sun, 12 Feb 2006 17:10:25 +0000, Peter Horton <pdh@colonel-panic.org> said:
> pdh> Adds early console support for Cobalts.
> 
> We already have EARLY_PRINTK.  How about using it?  (like dec does)

I already tried getting early printk to work....Either it wasn't initializing 
early enough for my needs, I was enabling it incorrectly, or it just doesn't 
work on Cobalt.  This does work, however, and already pointed out one obvious 
flaw I have in a patch I've been using on Cobalt (setting cpu_scache_line_size 
to > 0 when cobalt lacks an scache).

For systems where the serial device can be difficult to use until initialized 
late in the boot cycle (Octane comes to mind), early_printk won't function either.

Maybe some kind of framework is needed for defining the kinds of early console 
various systems can support?


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
