Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 18:26:22 +0100 (BST)
Received: from pasmtpb.tele.dk ([80.160.77.98]:48065 "EHLO pasmtpB.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20031442AbXJWR0N (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2007 18:26:13 +0100
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 1D4EDE3101A;
	Tue, 23 Oct 2007 19:26:12 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id CAC8A580D2; Tue, 23 Oct 2007 19:27:47 +0200 (CEST)
Date:	Tue, 23 Oct 2007 19:27:47 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org,
	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Discardable strings for init and exit sections
Message-ID: <20071023172747.GB26345@uranus.ravnborg.org>
References: <Pine.LNX.4.64N.0710121711120.21684@blysk.ds.pg.gda.pl> <20071012174507.GA21193@uranus.ravnborg.org> <Pine.LNX.4.64N.0710231758070.8693@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710231758070.8693@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

> 
>  Arguably all the existing linker scripts should be made more consistent I 
> suppose.  Currently all the {init,exit} annotations are handled separately 
> by each architecture, so this would be no exception.  If you have a 
> proposal as to how to do it cleanly, people will certainly appreciate it.

Patches appreciated. I have made many of the linekr scripts use same
format now - so it is easier to see what is equal and can be consolidated.

	Sam
