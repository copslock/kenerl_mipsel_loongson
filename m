Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2006 22:39:42 +0000 (GMT)
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:57065 "EHLO
	fr.zoreil.com") by ftp.linux-mips.org with ESMTP id S8133941AbWCIWjc
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Mar 2006 22:39:32 +0000
Received: from electric-eye.fr.zoreil.com (localhost.localdomain [127.0.0.1])
	by fr.zoreil.com (8.13.4/8.12.1) with ESMTP id k29MivC4014174;
	Thu, 9 Mar 2006 23:44:57 +0100
Received: (from romieu@localhost)
	by electric-eye.fr.zoreil.com (8.13.4/8.12.1) id k29MiuEk014173;
	Thu, 9 Mar 2006 23:44:56 +0100
Date:	Thu, 9 Mar 2006 23:44:56 +0100
From:	Francois Romieu <romieu@fr.zoreil.com>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>, netdev@vger.kernel.org,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	"P. Horton" <pdh@colonel-panic.org>
Subject: Re: [PATCH, RESEND] Add MWI workaround for Tulip DC21143
Message-ID: <20060309224456.GB9103@electric-eye.fr.zoreil.com>
References: <20060129230816.GD4094@colonel-panic.org> <20060218220851.GA1601@colonel-panic.org> <20060306225131.GA23327@unjust.cyrius.com> <20060306231530.GB16082@electric-eye.fr.zoreil.com> <20060307035824.GA24018@linux-mips.org> <Pine.LNX.4.62.0603071031520.5292@pademelon.sonytel.be> <20060308224139.GA7536@electric-eye.fr.zoreil.com> <Pine.LNX.4.62.0603091032490.9741@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0603091032490.9741@pademelon.sonytel.be>
User-Agent: Mutt/1.4.2.1i
X-Organisation:	Land of Sunshine Inc.
Return-Path: <romieu@fr.zoreil.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: romieu@fr.zoreil.com
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven <geert@linux-m68k.org> :
[...]
> So when compiling for Cobalt, we work around the hardware bug, while for other
> platforms, we just disable MWI?
> 
> Wouldn't it be possible to always (I mean, when a rev 65 chip is detected)
> work around the bug?

Of course it is possible but it is not the same semantic as the initial
patch (not that I know if it is right or not).

So:
- does the issue exist beyond Cobalt hosts ?
- is the fix Cobalt-only ?

-- 
Ueimor
