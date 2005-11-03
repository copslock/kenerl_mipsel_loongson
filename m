Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 18:07:04 +0000 (GMT)
Received: from web403.biz.mail.mud.yahoo.com ([68.142.201.34]:36992 "HELO
	web403.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133872AbVKCSGq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Nov 2005 18:06:46 +0000
Received: (qmail 67849 invoked by uid 60001); 3 Nov 2005 18:07:30 -0000
Message-ID: <20051103180730.67847.qmail@web403.biz.mail.mud.yahoo.com>
Received: from [161.88.255.139] by web403.biz.mail.mud.yahoo.com via HTTP; Thu, 03 Nov 2005 10:07:30 PST
Date:	Thu, 3 Nov 2005 10:07:30 -0800 (PST)
From:	Peter Popov <ppopov@embeddedalley.com>
Subject: Re: 2.6.14 on Au1550 panics in free_hot_cold_page from init
To:	Ralf Baechle <ralf@linux-mips.org>,
	Clem Taylor <clem.taylor@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20051103175945.GA7461@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips



Just to confirm what Ralf said - 2.6.13 runs fine on
my board so this is a new problem.

Pete

--- Ralf Baechle <ralf@linux-mips.org> wrote:

> On Wed, Nov 02, 2005 at 08:35:25PM -0500, Clem
> Taylor wrote:
> 
> > I was wondering if anyone has gotten 2.6.14 to run
> on an Au1550. I had
> > 2.6.14-rc2 mostly working (except for jffs2
> writes) and was previously
> > using 2.6.13 (had a jffs2 sync problem on reboot)
> and 2.6.11 (seems
> > okay).
> > 
> > I tried out a linux-mips-git tree from this
> afternoon
> > (6e47ab8b0ad1ca7bddbc086e2ce7736632c18df4). 2.6.14
> is panicing right
> > after the 'Freeing unused kernel memory' with:
> 
> What you're running is actually post-linux 2.6.14
> already, with a few
> megs of finest breakage of Linus merged in.  I
> suggest you try
> what's tagged as linux-2.6.14 instead.
> 
> I'm currently aggressivly following Linus and so the
> repository is gets
> all the good and bad stuff from kernel.org in
> undilluted form on the
> master branch.
> 
>   Ralf
> 
> 
