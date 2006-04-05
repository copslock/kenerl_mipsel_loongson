Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2006 14:19:40 +0100 (BST)
Received: from pqueuea.post.tele.dk ([193.162.153.9]:5913 "HELO
	pqueuea.post.tele.dk") by ftp.linux-mips.org with SMTP
	id S8133357AbWDENTa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Apr 2006 14:19:30 +0100
Received: from pasmtp.tele.dk (pasmtp.tele.dk [193.162.159.95])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id 993583758F9;
	Wed,  5 Apr 2006 13:00:10 +0200 (CEST)
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id A2D351EC342;
	Wed,  5 Apr 2006 13:00:04 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id E913243C21C; Wed,  5 Apr 2006 13:00:02 +0200 (CEST)
Date:	Wed, 5 Apr 2006 13:00:02 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, akpm@osdl.org
Subject: Re: [PATCH] Fix sed regexp to generate asm-offset.h
Message-ID: <20060405110002.GA22508@mars.ravnborg.org>
References: <20060328.001854.93020330.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328.001854.93020330.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.11
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 28, 2006 at 12:18:54AM +0900, Atsushi Nemoto wrote:
> Changes to Makefile.kbuild ("kbuild: add -fverbose-asm to i386
> Makefile") breaks asm-offset.h file on MIPS.  Other archs possibly
> suffer this change too but I'm not sure.
> 
> Here is a fix just for MIPS.  
Thanks, applied to the kbuild bugfix tree.

	Sam
