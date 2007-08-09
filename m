Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2007 16:18:25 +0100 (BST)
Received: from NaN.false.org ([208.75.86.248]:9348 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S20023865AbXHIPSR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2007 16:18:17 +0100
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 34FA2982CE;
	Thu,  9 Aug 2007 15:18:15 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id DC0F6982C5;
	Thu,  9 Aug 2007 15:18:14 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.67)
	(envelope-from <drow@caradoc.them.org>)
	id 1IJ9m8-00029E-Is; Thu, 09 Aug 2007 11:18:12 -0400
Date:	Thu, 9 Aug 2007 11:18:12 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] Remove '-mno-explicit-relocs' option when
	CONFIG_BUILD_ELF64
Message-ID: <20070809151812.GA28142@caradoc.them.org>
References: <11715446603241-git-send-email-fbuihuu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11715446603241-git-send-email-fbuihuu@gmail.com>
User-Agent: Mutt/1.5.15 (2007-04-09)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 15, 2007 at 02:04:18PM +0100, Franck Bui-Huu wrote:
> From: Franck Bui-Huu <fbuihuu@gmail.com>
> 
> This patch removes '-mno-explicit-relocs' usage when
> CONFIG_BUILD_ELF64 is set since this option was only required
> with the old hack to truncate addresses at the assembly level
> where "-mabi=64 -Wa,-mabi=32" was used.
> 
> This should yield a small code size improvement for inline
> assembly, where the R constraint is used.
> 
> The idea is coming from Maciej <macro@linux-mips.org>.

It looks like nothing ever came of these patches?  I tried to boot my
Sentosa again today, and needed a slightly updated version of them.

I'm not positive I did the update correctly, though, since the board
panics in swapper after jumping to a bogus pointer.

-- 
Daniel Jacobowitz
CodeSourcery
