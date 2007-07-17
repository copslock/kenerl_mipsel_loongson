Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2007 10:16:57 +0100 (BST)
Received: from pasmtpa.tele.dk ([80.160.77.114]:48769 "EHLO pasmtpA.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20021373AbXGQJQz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jul 2007 10:16:55 +0100
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 5F4CA80056C;
	Tue, 17 Jul 2007 11:16:24 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id D0478580D2; Tue, 17 Jul 2007 11:17:38 +0200 (CEST)
Date:	Tue, 17 Jul 2007 11:17:38 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [KBUILD] Whitelist references from __dbe_table to .init
Message-ID: <20070717091738.GB19679@uranus.ravnborg.org>
References: <20070710081632.GA10559@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070710081632.GA10559@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 10, 2007 at 09:16:32AM +0100, Ralf Baechle wrote:
> This is needed on MIPS where the same mechanism as get_user() is used to
> intercept bus error exceptions for some hardware probes.  Without this
> patch modpost will throw spurious warnings:
> 
>   LD      vmlinux
>   SYSMAP  System.map
>   SYSMAP  .tmp_System.map
>   MODPOST vmlinux
> WARNING: arch/mips/sgi-ip22/built-in.o(__dbe_table+0x0): Section mismatch: reference to .init.text:

Applied,

	Sam
