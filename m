Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 18:33:23 +0100 (BST)
Received: from waste.org ([66.93.16.53]:60879 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023836AbZEaRdQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 31 May 2009 18:33:16 +0100
Received: from [192.168.1.100] ([10.0.0.101])
	(authenticated bits=0)
	by waste.org (8.13.8/8.13.8/Debian-3) with ESMTP id n4VHWt9M027238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 31 May 2009 12:32:55 -0500
Subject: Re: [PATCH] TXx9: Add TX4939 RNG support
From:	Matt Mackall <mpm@selenic.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
In-Reply-To: <20090601.022335.200392387.anemo@mba.ocn.ne.jp>
References: <1243350141-883-2-git-send-email-anemo@mba.ocn.ne.jp>
	 <20090601.015755.21367568.anemo@mba.ocn.ne.jp>
	 <1243789289.22069.25.camel@calx>
	 <20090601.022335.200392387.anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Date:	Sun, 31 May 2009 12:32:50 -0500
Message-Id: <1243791170.22069.28.camel@calx>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new
Return-Path: <mpm@selenic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpm@selenic.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-06-01 at 02:23 +0900, Atsushi Nemoto wrote:
> On Sun, 31 May 2009 12:01:29 -0500, Matt Mackall <mpm@selenic.com> wrote:
> > > > Not clear to me how this works when this is a module?
> > > 
> > > This patch add a registration of a platform device for RNG to vmlinux.
> > > And the other patch add a driver module for the RNG.  This strategy is
> > > fairly common for SoCs or embedded platforms.
> > 
> > If your driver is built as a module (which your patch allows), the above
> > won't work, right?
> 
> No, the rng driver can be used regardless of module or built-in, as
> like as other platform drivers.  Any special issue for hw_rng?

I found the source of my confusion: you've given the init function in
both files exactly the same name. So when I saw .._init at the bottom of
the second patch, I assumed it was referring to the possibly not loaded
driver's init code.

-- 
http://selenic.com : development and support for Mercurial and Linux
