Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 10:37:24 +0000 (GMT)
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:56498 "EHLO
	gw03.mail.saunalahti.fi") by ftp.linux-mips.org with ESMTP
	id S8133383AbWAYKhF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 10:37:05 +0000
Received: from tori.tal.org (tori.tal.org [195.16.220.82])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id DD9B3E8ED6;
	Wed, 25 Jan 2006 12:41:24 +0200 (EET)
Date:	Wed, 25 Jan 2006 12:42:59 +0200 (EET)
From:	Kaj-Michael Lang <milang@tal.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
In-Reply-To: <Pine.LNX.4.64N.0601241058390.11021@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.61.0601251233020.4271@tori.tal.org>
References: <20060123225040.GA23576@deprecation.cyrius.com>
 <Pine.LNX.4.61.0601241147170.19397@tori.tal.org>
 <Pine.LNX.4.64N.0601241058390.11021@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

On Tue, 24 Jan 2006, Maciej W. Rozycki wrote:

> On Tue, 24 Jan 2006, Kaj-Michael Lang wrote:
>
> The /133 (as all 3MINs) may have an older revision of the I/O ASIC that
> may not have the free-running counter indeed.  It's handled correctly
> regardless, except from missing timestamp precision, obviously.

Sorry, my bad. This problem is under 2.4, not 2.6. 2.6 has other problems.
And yes, the 3MIN does not have a free-running counter in the ASIC.
(http://mail-index.netbsd.org/port-pmax/1995/01/28/0006.html)

> What kind of a patch do you need anyway and why isn't it yet in my mail?

Do still you take patches for 2.4 ? I'll try to find it.

-- 
Kaj-Michael Lang
