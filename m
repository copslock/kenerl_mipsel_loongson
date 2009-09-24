Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2009 21:44:05 +0200 (CEST)
Received: from [195.41.46.235] ([195.41.46.235]:60526 "EHLO pfepa.post.tele.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493317AbZIXTn6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 Sep 2009 21:43:58 +0200
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
	by pfepa.post.tele.dk (Postfix) with ESMTP id 6BD93A5005D;
	Thu, 24 Sep 2009 21:43:48 +0200 (CEST)
Date:	Thu, 24 Sep 2009 21:43:48 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Subject: Re: MIPS: Alchemy build broken in latest linus-git [with patch]
Message-ID: <20090924194348.GA1922@merkur.ravnborg.org>
References: <f861ec6f0909232344s72af6bax5bd77f1a5be45b4f@mail.gmail.com> <20090924091539.GA929@merkur.ravnborg.org> <f861ec6f0909240224m4b5dcbd9hc835409e7a66102d@mail.gmail.com> <f861ec6f0909240241x5c5858d4g4d44b40107021bb6@mail.gmail.com> <4ABB6189.5010909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ABB6189.5010909@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

> 
> From: Manuel Lauss <manuel.lauss@gmail.com>
> Subject: [PATCH] MIPS: fix build of vmlinux.lds
> 
> Commit 51b563fc93c8cb5bff1d67a0a71c374e4a4ea049 removed a few
> CPPFLAGS with vital include paths necessary to build vmlinux.lds
> on MIPS, and moved the calculation of the 'jiffies' symbol
> directly to vmlinux.lds.S but forgot to change make ifdef/... to
> cpp macros.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks for providing a patch!

The assignment of CPPFLAGS was supposed to be
in arch/mips/kernel/MAkefile.

I fixed this up.
Please test this patch - I will await testing
feedback before I submit to Linus.

	Sam
