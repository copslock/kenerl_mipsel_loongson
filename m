Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 18:21:33 +0100 (BST)
Received: from bombadil.infradead.org ([18.85.46.34]:57523 "EHLO
	bombadil.infradead.org") by ftp.linux-mips.org with ESMTP
	id S20023138AbYHERV1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Aug 2008 18:21:27 +0100
Received: from localhost ([127.0.0.1])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KQQCE-0007a3-LJ; Tue, 05 Aug 2008 17:19:42 +0000
Date:	Tue, 5 Aug 2008 13:19:42 -0400 (EDT)
From:	Mauro Carvalho Chehab <mchehab@infradead.org>
To:	Stephen Rothwell <sfr@canb.auug.org.au>
cc:	Andrew Morton <akpm@linux-foundation.org>,
	Adrian Bunk <bunk@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: v4l/mips build problem
In-Reply-To: <20080806023906.c2f919b4.sfr@canb.auug.org.au>
Message-ID: <alpine.LFD.1.10.0808051315440.22576@bombadil.infradead.org>
References: <20080806012357.55625daf.sfr@canb.auug.org.au> <20080805154122.GC22895@cs181140183.pp.htv.fi> <20080806020647.2cf11a2b.sfr@canb.auug.org.au> <20080805092650.af88364a.akpm@linux-foundation.org> <20080806023906.c2f919b4.sfr@canb.auug.org.au>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org
	See http://www.infradead.org/rpr.html
Return-Path: <SRS0+84df8e96b69946864cad+1808+infradead.org+mchehab@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mchehab@infradead.org
Precedence: bulk
X-list: linux-mips

On Wed, 6 Aug 2008, Stephen Rothwell wrote:

> Hi Andrew,
>
> On Tue, 5 Aug 2008 09:26:50 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> yup, I'll send it in unless it turned up in today's linux-next.
>
> Which I think is unlikely:  the v4l/dvb tree has been unmergable since
> 29/7 and I haven't heard from Mauro since then.
Too busy during those days. I don't mind if Andrew prefer to forward this 
directly, but I have another bunch of patches to send Linus probably 
today.

I did some changes on the procedures I use for sending patches upstream, 
but I want to do some additional tests here to be sure that everything is 
all right. The idea is never rebase my main branches again.

-- 
Cheers,
Mauro Carvalho Chehab
http://linuxtv.org
mchehab@infradead.org
