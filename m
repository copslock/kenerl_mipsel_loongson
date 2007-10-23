Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 18:24:19 +0100 (BST)
Received: from pasmtpb.tele.dk ([80.160.77.98]:55231 "EHLO pasmtpB.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20031477AbXJWRX6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2007 18:23:58 +0100
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id CFC24E30ADF;
	Tue, 23 Oct 2007 19:23:54 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 8B9C3580D2; Tue, 23 Oct 2007 19:25:30 +0200 (CEST)
Date:	Tue, 23 Oct 2007 19:25:30 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Discardable strings for init and exit sections
Message-ID: <20071023172530.GA26345@uranus.ravnborg.org>
References: <Pine.LNX.4.64N.0710121711120.21684@blysk.ds.pg.gda.pl> <20071012171938.GB6476@stusta.de> <20071012175209.GA1110@linux-mips.org> <20071012181544.GC6476@stusta.de> <Pine.LNX.4.64N.0710231753250.8693@blysk.ds.pg.gda.pl> <20071023171201.GW30533@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071023171201.GW30533@stusta.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

> 
> As long as the modpost warnings are just warnings they will often be 
> missed at compile time.

The plans for the modpost warnings are more or less:
- Let all __init, __cpuinit, __meminit etc use dedicated sections
no matter the actual configuration.
Use ifdeffery in the .lds files to place stuff in the correct final
section.
Teach modpost about the illegal dependencies.

When we then are back to almost warning free with allmodconfig for
the most important platfroms (read: or in reality the ones I have a
tool-chain for and which care to make allmodconfig buildable in mainline)
then modpost will generate errors instead of warnings to force people
to fix all the NEW errors they introuduce.

A variable will convert the errors to warnings for use in certain situations.

But I am not familiar enough with ELF format to extend the current checking
as suggested by people a few times. Maybe someone else can assist here.

Comments?

	Sam
