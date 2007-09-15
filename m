Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2007 22:43:12 +0100 (BST)
Received: from pasmtpb.tele.dk ([80.160.77.98]:23434 "EHLO pasmtpB.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20022327AbXIOVnD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2007 22:43:03 +0100
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 4836FE3254A;
	Sat, 15 Sep 2007 23:43:01 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id 08606580D2; Sat, 15 Sep 2007 23:44:27 +0200 (CEST)
Date:	Sat, 15 Sep 2007 23:44:27 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: beautify vmlinux.lds
Message-ID: <20070915214427.GA15536@uranus.ravnborg.org>
References: <20070915213553.GA15463@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070915213553.GA15463@uranus.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 15, 2007 at 11:35:53PM +0200, Sam Ravnborg wrote:
> Introduce a consistent style for vmlinux.lds.
> This style will be consitent with all other arch's - soon.
> 
> In addition:
> - Moved a few labels inside brackets for the sections they specify
>   to prevent that linker alignmnet made them point before the section start
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> Patch is not even buildtested due to lack of a toolchain :-(

After a second look I actually had the toolchain anyway.
Build tested now.

	Sam
