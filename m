Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 18:19:27 +0100 (BST)
Received: from p508B66F0.dip.t-dialin.net ([IPv6:::ffff:80.139.102.240]:28217
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225005AbUHWRTX>; Mon, 23 Aug 2004 18:19:23 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7NHJLKa027502;
	Mon, 23 Aug 2004 19:19:21 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7NHJL1l027501;
	Mon, 23 Aug 2004 19:19:21 +0200
Date: Mon, 23 Aug 2004 19:19:21 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Alec Voropay <a.voropay@vmb-service.ru>
Cc: linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
Message-ID: <20040823171921.GD21884@linux-mips.org>
References: <20040823122843.GB20905@linux-mips.org> <036001c48923$31563350$1701a8c0@alec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <036001c48923$31563350$1701a8c0@alec>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 23, 2004 at 07:09:31PM +0400, Alec Voropay wrote:

>  OK, OK. You are right. However, as it is known, there is at
> least one project "to bridge" Win32/multithread and *NIX :
>  WINE.
> http://winehq.com/site/docs/wine-devel/x3398
> 
>  Yes, the Win32/MIPS API (and ABI) is dead, but MIPS/multithreading
> lives in the WindowsCE/MIPS HPCs.
> 
> 
>  Unfortunately, I can't find any details about Win32/MIPS
> implementation.

That's because for Windows on x86 there are tons of important binary-only
applications available and Linux would have to be bought if they're
available at all.  On MIPS we're not in this dependency situation, so
we hardly care about Win32.

  Ralf
