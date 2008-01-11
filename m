Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 14:18:20 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:9886 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28579571AbYAKOSR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Jan 2008 14:18:17 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0BEHtJS005603;
	Fri, 11 Jan 2008 14:17:55 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0BEHsTo005602;
	Fri, 11 Jan 2008 14:17:54 GMT
Date:	Fri, 11 Jan 2008 14:17:54 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	WANG Cong <xiyou.wangcong@gmail.com>
Cc:	Sam Ravnborg <sam@ravnborg.org>, Andreas Schwab <schwab@suse.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-kbuild@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org
Subject: Re: (Try #3) [Patch 2/8] MIPS: Remove 'TOPDIR' from Makefiles
Message-ID: <20080111141754.GC19900@linux-mips.org>
References: <20080101071311.GA2496@hacking> <20080101072238.GC2496@hacking> <20080101101540.GB28913@uranus.ravnborg.org> <jefxxhlkxb.fsf@sykes.suse.de> <20080101175754.GC31575@uranus.ravnborg.org> <20080102062135.GE2493@hacking>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080102062135.GE2493@hacking>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 02, 2008 at 02:21:36PM +0800, WANG Cong wrote:

> >> Shouldn't that use $(LINUXINCLUDE), or $(KBUILD_CPPFLAGS)?
> >It would be better to use $(LINUXINCLUDE) as we then pull in all config
> >symbols too and do not have to hardcode kbuild internal names (include2).
> 
> OK. Refine this patch.

LDSCRIPT also needed fixing to get builds in a separate object directory
working again.

I've applied below fix.

  Ralf
