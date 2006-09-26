Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 14:48:02 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:45791 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037758AbWIZNr6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 14:47:58 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8QDmnno029243;
	Tue, 26 Sep 2006 14:48:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8QDmmZY029242;
	Tue, 26 Sep 2006 14:48:48 +0100
Date:	Tue, 26 Sep 2006 14:48:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: How to work with Linux-Mips ?
Message-ID: <20060926134848.GB27446@linux-mips.org>
References: <4518D33F.9070208@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4518D33F.9070208@innova-card.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 26, 2006 at 09:14:07AM +0200, Franck Bui-Huu wrote:

> These patchs have been kindly reviewed and acked by Atsushi Nemoto,
> but then no feedback from the MIPS team. I tried to get a status for
> MIPS team a couple of time, to know if something was wrong with them
> but MIPS people seem to not care about them. They even haven't
> bothered to take 10 seconds for replying something like:
> 
>   - your patches are broken because...
> 
>   - your patches do not respect our MIPS protocol, please resend...
> 
>   - Sorry we are very busy, please hold on...

You should interpret a non-answer as exactly this.

>   - OK your patches suck please try to work on ARM chips because MIPS
>     is a very closed circle reserved to MIPS gurus.
> 
> Another question, is that MIPS tree seems to not care about linux
> mainline release process. I actually notice that even Linus do not
> pull MIPS tree anymore during the last release candidate cycle.

While my employer encourages my linux-mips.org activities at times there
are things that take priority and that has happened before 2.6.18 until
the time where it was too late to submit anything.  Still 2.6.18 from
kernel.org is usable on MIPS.

> Is MIPS aware that some of its customers are trying to make stable
> releases ?

I pass on answering a polemic question.

> Does the linux-mips team exist to ease life of its
> customers to use the linux kernel on MIPS chips or is the purpose of
> this team doing only some development for fun ?

You should draw a line between linux-mips.org and MIPS Technologies.
linux-mips.org isn't a formal organization and not to be considered part
of MTI.  If anything call it a loosely knit group of hackers with
interest in running Linux and anything and all that has a MIPS processors.
There is more to be said I guess you rather want me to return to my
pending patches ;-)

  Ralf
