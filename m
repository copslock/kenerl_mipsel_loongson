Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 21:55:03 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:16601 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225218AbVBGVyr>; Mon, 7 Feb 2005 21:54:47 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j17LnnxQ015143;
	Mon, 7 Feb 2005 21:49:49 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j17Lnn4p015142;
	Mon, 7 Feb 2005 21:49:49 GMT
Date:	Mon, 7 Feb 2005 21:49:49 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dominic Sweetman <dom@mips.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, nigel@mips.com,
	linux-mips@linux-mips.org
Subject: Re: c-r4k.c cleanup
Message-ID: <20050207214949.GD6703@linux-mips.org>
References: <20050204.231254.74753794.anemo@mba.ocn.ne.jp> <4203890B.5030305@mips.com> <20050204145803.GA5618@linux-mips.org> <20050207.192450.55145246.nemoto@toshiba-tops.co.jp> <16903.24802.504192.330272@arsenal.mips.com> <16903.29369.622451.447313@arsenal.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16903.29369.622451.447313@arsenal.mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 07, 2005 at 01:52:57PM +0000, Dominic Sweetman wrote:

> o The 25KF D-cache is physically indexed (and of course
>   physically tagged). 
> 
> o The 25KF I-cache is virtually indexed and virtually tagged - the tag
>   includes the ASID to reduce the number of occasions on which you
>   have to invalidate all the lines from a particular process.
> 
> o A 25KF secondary cache, if provided, is physically indexed and
>   tagged. 

Ok, so I've added it also, thanks.

  Ralf
