Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 16:17:48 +0100 (BST)
Received: from pfepb.post.tele.dk ([IPv6:::ffff:195.41.46.236]:56932 "EHLO
	pfepb.post.tele.dk") by linux-mips.org with ESMTP
	id <S8225776AbUERPRr>; Tue, 18 May 2004 16:17:47 +0100
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepb.post.tele.dk (Postfix) with ESMTP id C26B15EE096;
	Tue, 18 May 2004 17:17:39 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 500)
	id D6A5FDF4A8; Tue, 18 May 2004 17:28:34 +0200 (CEST)
Date: Tue, 18 May 2004 17:28:34 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mathieu Chouquet-Stringer <mchouque@online.fr>,
	linux-kernel@vger.kernel.org, rth@twiddle.net,
	linux-alpha@vger.kernel.org, ralf@gnu.org,
	linux-mips@linux-mips.org, akpm@osdl.org, bjornw@axis.com,
	dev-etrax@axis.com, mikael.starvik@axis.com, sam@ravnborg.org
Subject: Re: [PATCH] Fix for 2.6.6 Makefiles to get KBUILD_OUTPUT working
Message-ID: <20040518152834.GA2635@mars.ravnborg.org>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@online.fr>,
	linux-kernel@vger.kernel.org, rth@twiddle.net,
	linux-alpha@vger.kernel.org, ralf@gnu.org, linux-mips@linux-mips.org,
	akpm@osdl.org, bjornw@axis.com, dev-etrax@axis.com,
	mikael.starvik@axis.com, sam@ravnborg.org
References: <20040516012245.GA11733@localhost> <20040516203322.GA4784@mars.ravnborg.org> <20040517152311.GA29999@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517152311.GA29999@localhost>
User-Agent: Mutt/1.4.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

> > Hereby the '+' sign is no longer needed (used today where makeboot is used.
> 
> Ok, I applied the changes you requested, please check the diff for mips as
> I had to modify some other lines too.

Looks goood, but the cris part is missing?
Please pass on current patch to Andrew with a nice changelog entry.
The cris part we can take later if Mikael does not surface.

	Sam
