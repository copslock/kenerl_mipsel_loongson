Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 17:28:03 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:64236 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20024580AbYHEQ14 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Aug 2008 17:27:56 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m75GQqZ2016897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Aug 2008 09:26:53 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m75GQoOg011805;
	Tue, 5 Aug 2008 09:26:50 -0700
Date:	Tue, 5 Aug 2008 09:26:50 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Stephen Rothwell <sfr@canb.auug.org.au>
Cc:	Adrian Bunk <bunk@kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: v4l/mips build problem
Message-Id: <20080805092650.af88364a.akpm@linux-foundation.org>
In-Reply-To: <20080806020647.2cf11a2b.sfr@canb.auug.org.au>
References: <20080806012357.55625daf.sfr@canb.auug.org.au>
	<20080805154122.GC22895@cs181140183.pp.htv.fi>
	<20080806020647.2cf11a2b.sfr@canb.auug.org.au>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Wed, 6 Aug 2008 02:06:47 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Tue, 5 Aug 2008 18:41:22 +0300 Adrian Bunk <bunk@kernel.org> wrote:
> >
> > On Wed, Aug 06, 2008 at 01:23:57AM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Linus' current tree gets the following error during a mips allmodconfig
> > > build:
> > > 
> > > drivers/media/video/vino.c:4364: error: implicit declaration of function `video_usercopy'
> > 
> > Andrew fixed it with drivers-media-video-vinoc-needs-v4l2-ioctlh.patch 
> > in -mm.
> 
> Maybe we should send that one Linusward ...
> 

yup, I'll send it in unless it turned up in today's linux-next.
