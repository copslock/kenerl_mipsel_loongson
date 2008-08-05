Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 16:42:54 +0100 (BST)
Received: from smtp6.pp.htv.fi ([213.243.153.40]:9884 "EHLO smtp6.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20032155AbYHEPmr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2008 16:42:47 +0100
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp6.pp.htv.fi (Postfix) with ESMTP id 8A61B5BC023;
	Tue,  5 Aug 2008 18:42:44 +0300 (EEST)
Date:	Tue, 5 Aug 2008 18:41:22 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Stephen Rothwell <sfr@canb.auug.org.au>
Cc:	Mauro Carvalho Chehab <mchehab@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: v4l/mips build problem
Message-ID: <20080805154122.GC22895@cs181140183.pp.htv.fi>
References: <20080806012357.55625daf.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20080806012357.55625daf.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 06, 2008 at 01:23:57AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Linus' current tree gets the following error during a mips allmodconfig
> build:
> 
> drivers/media/video/vino.c:4364: error: implicit declaration of function `video_usercopy'

Andrew fixed it with drivers-media-video-vinoc-needs-v4l2-ioctlh.patch 
in -mm.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
