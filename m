Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 05:52:17 +0100 (CET)
Received: from p508B6D85.dip.t-dialin.net ([80.139.109.133]:40345 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122118AbSKNEwR>; Thu, 14 Nov 2002 05:52:17 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAE4puF27101;
	Thu, 14 Nov 2002 05:51:56 +0100
Date: Thu, 14 Nov 2002 05:51:56 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: george anzinger <george@mvista.com>
Cc: Bradley Bozarth <bbozarth@cisco.com>, linux-mips@linux-mips.org
Subject: Re: SEGEV defines
Message-ID: <20021114055156.C24744@linux-mips.org>
References: <Pine.LNX.4.44.0211131742480.11387-100000@bbozarth-lnx.cisco.com> <3DD3252E.8DB61CE6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DD3252E.8DB61CE6@mvista.com>; from george@mvista.com on Wed, Nov 13, 2002 at 08:23:10PM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 13, 2002 at 08:23:10PM -0800, george anzinger wrote:

> I MUCH prefer a change to the kernel if one or the other
> needs to change.  The issue is, of course, IRIX
> compatability and what that means.  This comes up because I
> want to use the definitions in combination and the common
> bit makes a mess of things.  Still, it would be NICE if it
> matched the rest of the platforms.

The IRIX compatibility code seems unused and the constants aren't even
part of the ABI at all.  So in this case it indeed seems preferable to
change the kernel side.

Anybody disagrees?

  Ralf
