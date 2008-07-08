Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2008 21:45:07 +0100 (BST)
Received: from pasmtpb.tele.dk ([80.160.77.98]:41156 "EHLO pasmtpB.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20052894AbYGHUpA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Jul 2008 21:45:00 +0100
Received: from ravnborg.org (0x535d98d8.vgnxx8.dynamic.dsl.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 0B7EDE3039B;
	Tue,  8 Jul 2008 22:44:57 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 295C6580D9; Tue,  8 Jul 2008 22:45:47 +0200 (CEST)
Date:	Tue, 8 Jul 2008 22:45:47 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-sparse@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] sparse: Increase pre_buffer[] and check overflow
Message-ID: <20080708204547.GA16742@uranus.ravnborg.org>
References: <20080709.002805.128619748.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080709.002805.128619748.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 09, 2008 at 12:28:05AM +0900, Atsushi Nemoto wrote:
> I got this error when running sparse on mips kernel with gcc 4.3:
> 
> builtin:272:1: warning: Newline in string or character constant
> 
> The linus-mips kernel uses '$(CC) -dM -E' to generates arguments for
> sparse.  With gcc 4.3, it generates lot of '-D' options and causes
> pre_buffer overflow.

Why does mips have this need when all other archs does not?
We should fix sparse so it is dynamically allocated - but
that is not an excuse for mips to use odd stuff like this.

So please someone from mips land explain why this is needed.

	Sam
