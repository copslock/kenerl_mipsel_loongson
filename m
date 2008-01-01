Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jan 2008 17:58:34 +0000 (GMT)
Received: from pasmtpb.tele.dk ([80.160.77.98]:14809 "EHLO pasmtpB.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20026205AbYAAR6Y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Jan 2008 17:58:24 +0000
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id B16F7E30AF0;
	Tue,  1 Jan 2008 18:57:52 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id DD798580D2; Tue,  1 Jan 2008 18:57:54 +0100 (CET)
Date:	Tue, 1 Jan 2008 18:57:54 +0100
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Andreas Schwab <schwab@suse.de>
Cc:	WANG Cong <xiyou.wangcong@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-kbuild@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org
Subject: Re: [Patch 2/8] MIPS: Remove 'TOPDIR' from Makefiles
Message-ID: <20080101175754.GC31575@uranus.ravnborg.org>
References: <20080101071311.GA2496@hacking> <20080101072238.GC2496@hacking> <20080101101540.GB28913@uranus.ravnborg.org> <jefxxhlkxb.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jefxxhlkxb.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 01, 2008 at 02:44:48PM +0100, Andreas Schwab wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> >> @@ -24,7 +24,7 @@ HEAD_DEFINES := -D_kernel_start=0x$(KERNEL_START) \
> >>  		-D TIMESTAMP=$(shell date +%s)
> >>  
> >>  $(obj)/head.o: $(obj)/head.S $(KERNEL_IMAGE)
> >> -	$(CC) -fno-pic $(HEAD_DEFINES) -I$(TOPDIR)/include -c -o $@ $<
> >> +	$(CC) -fno-pic $(HEAD_DEFINES) -I$(objtree)/include -c -o $@ $<
> > This has never worked with O=.. builds.
> > The correct fix here is to use:
> >> +	$(CC) -fno-pic $(HEAD_DEFINES) -Iinclude -Iinclude2 -c -o $@ $<
> >
> > The -Iinclude2 is only for O=... builds so to keep current
> > behaviour removing $(TOPDIR)/ would do it.
> 
> Shouldn't that use $(LINUXINCLUDE), or $(KBUILD_CPPFLAGS)?
It would be better to use $(LINUXINCLUDE) as we then pull in all config
symbols too and do not have to hardcode kbuild internal names (include2).

As for the use of KBUILD_CPPFLAGS at present the usage is not consistent
across the architectures. Why does arm for example say:
KBUILD_CPPFLAGS       += -mbig-endian

This looks like a KBUILD_CFLAGS thing to me.

So we should preferably stick with LINUXINCLUDE for now.

	Sam
