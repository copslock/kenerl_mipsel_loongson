Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Feb 2008 18:01:50 +0000 (GMT)
Received: from pasmtpb.tele.dk ([80.160.77.98]:28623 "EHLO pasmtpB.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20029889AbYBBSBm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 2 Feb 2008 18:01:42 +0000
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 622FCE3148A;
	Sat,  2 Feb 2008 19:01:40 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id E53FF580D2; Sat,  2 Feb 2008 19:01:44 +0100 (CET)
Date:	Sat, 2 Feb 2008 19:01:44 +0100
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove __INIT_REFOK and __INITDATA_REFOK
Message-ID: <20080202180144.GA25399@uranus.ravnborg.org>
References: <20080130141408.GA6116@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080130141408.GA6116@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 30, 2008 at 02:14:08PM +0000, Ralf Baechle wrote:
> Commit 312b1485fb509c9bc32eda28ad29537896658cb8 made __INIT_REFOK expand
> into .section .section ".ref.text", "ax".  Since the assembler doesn't
> tolerate stuttering in the source that broke all MIPS builds.
> 
> Since with this change Sam downgraded __INIT_REFOK to just a backward
> compat thing and there being only a single use in the MIPS arch code the
> best solution is to delete both of __INIT_REFOK and __INITDATA_REFOK (which
> was equally broken) being unused anyway these can be deleted.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Thanks Ralf - applied.
And sorry for the MIPS breakage.

	Sam
