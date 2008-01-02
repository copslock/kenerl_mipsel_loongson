Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jan 2008 19:24:25 +0000 (GMT)
Received: from pasmtpb.tele.dk ([80.160.77.98]:35025 "EHLO pasmtpB.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20032839AbYABTYR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Jan 2008 19:24:17 +0000
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 5D4A1E31C49;
	Wed,  2 Jan 2008 20:24:14 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id E1DEB580D2; Wed,  2 Jan 2008 20:24:16 +0100 (CET)
Date:	Wed, 2 Jan 2008 20:24:16 +0100
From:	Sam Ravnborg <sam@ravnborg.org>
To:	WANG Cong <xiyou.wangcong@gmail.com>
Cc:	Andreas Schwab <schwab@suse.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-kbuild@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org
Subject: Re: (Try #3) [Patch 2/8] MIPS: Remove 'TOPDIR' from Makefiles
Message-ID: <20080102192416.GB11217@uranus.ravnborg.org>
References: <20080101071311.GA2496@hacking> <20080101072238.GC2496@hacking> <20080101101540.GB28913@uranus.ravnborg.org> <jefxxhlkxb.fsf@sykes.suse.de> <20080101175754.GC31575@uranus.ravnborg.org> <20080102062135.GE2493@hacking>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080102062135.GE2493@hacking>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 02, 2008 at 02:21:36PM +0800, WANG Cong wrote:
> 
> >> 
> >> Shouldn't that use $(LINUXINCLUDE), or $(KBUILD_CPPFLAGS)?
> >It would be better to use $(LINUXINCLUDE) as we then pull in all config
> >symbols too and do not have to hardcode kbuild internal names (include2).
> 
> OK. Refine this patch.
> 
> ----------->
> 
> Since TOPDIR is obsolete, this patch removes TOPDIR
> from the Mips Makefiles.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
> 
Applied.

	Sam
