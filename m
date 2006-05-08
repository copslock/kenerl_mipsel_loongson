Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 May 2006 21:02:49 +0100 (BST)
Received: from pasmtp.tele.dk ([193.162.159.95]:32778 "HELO pasmtp.tele.dk")
	by ftp.linux-mips.org with SMTP id S8133519AbWEHUB7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 8 May 2006 21:01:59 +0100
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id 064311EC334;
	Mon,  8 May 2006 22:01:47 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 606D443C069; Mon,  8 May 2006 22:01:53 +0200 (CEST)
Date:	Mon, 8 May 2006 22:01:53 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Linus Torvalds <torvalds@osdl.org>
Cc:	LKML <linux-kernel@vger.kernel.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Chris Wright <chrisw@sous-sol.org>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [git patches] kbuild fixes for -rc
Message-ID: <20060508200153.GA3762@mars.ravnborg.org>
References: <20060508050809.GA2247@mars.ravnborg.org> <20060508190312.GB2697@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508190312.GB2697@moss.sous-sol.org>
User-Agent: Mutt/1.5.11
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

Hi Linus.

Please revert this bogus commit:
> > commit c8d8b837ebe4b4f11e1b0c4a2bdc358c697692ed

I was discussed on mips list but apparently the fix was bogus.
I will not have time to look into it so mips can carry this local
fix until we get a proper fix in mainline.

[And I now have i386 toolchain in place so I can bo a better check next
time].

	Sam
