Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2008 11:33:40 +0100 (BST)
Received: from p549F5460.dip.t-dialin.net ([84.159.84.96]:8578 "EHLO
	p549F5460.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20030694AbYFCKdh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Jun 2008 11:33:37 +0100
Received: from vigor.karmaclothing.net ([217.169.26.28]:46261 "EHLO
	vigor.karmaclothing.net") by lappi.linux-mips.net with ESMTP
	id S527010AbYFCI1X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Jun 2008 10:27:23 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m538QrGr001314;
	Tue, 3 Jun 2008 09:26:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m538Qq49001313;
	Tue, 3 Jun 2008 09:26:52 +0100
Date:	Tue, 3 Jun 2008 09:26:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: email does not get through to linux-mips.org
Message-ID: <20080603082652.GB27478@linux-mips.org>
References: <90edad820806022345g6383e5b3hf2d0e73eed3e375e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90edad820806022345g6383e5b3hf2d0e73eed3e375e@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 03, 2008 at 09:45:08AM +0300, Dmitri Vorobiev wrote:

> When I send mail to linux-mips at linux-mips dot org from one of my
> mail accounts (located in the domain movial dot fi), my emails
> apparently do not get through. I do not see the messages in the Web
> archive, neither do I receive these messages in my Gmail account,
> which is also subscribed to the linux-mips mailing list.
> 
> I tried sending messages using both Thunderbird and Git. Messages did
> not arrive in both cases.
> 
> Will you please check what's going on? I suspect that other users of
> the mailing list could experience similar problems, and that is why
> I'm Cc:ing the mailing list itself now.

Unfortunately I'm aware of the problem.  Since a few days a packet raping
machine otherwise known as Cisco PIX is molesting conectivity of
linux-mips.org resuling in SMTP sessions with some hosts to fail.  To
keep the show running I installed a temporary workaround.

The email which you forwarded me in private got lost in the spam filter
as a side effect of an attempted workaround for above problem, so I'm
now going to engineer something better.

  Ralf
