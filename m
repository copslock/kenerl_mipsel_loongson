Received:  by oss.sgi.com id <S553739AbQJVKcD>;
	Sun, 22 Oct 2000 03:32:03 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:61447 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553725AbQJVKbi>;
	Sun, 22 Oct 2000 03:31:38 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 26D2F7DD; Sun, 22 Oct 2000 12:31:36 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 1ECFC900C; Sun, 22 Oct 2000 12:30:13 +0200 (CEST)
Date:   Sun, 22 Oct 2000 12:30:13 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Klaus Naumann <spock@mgnet.de>
Cc:     Linux/MIPS list <linux-mips@oss.sgi.com>,
        "Linux MIPS fnet.fr" <linux-mips@fnet.fr>
Subject: Re: Bug Tracker online
Message-ID: <20001022123012.A1564@paradigm.rfc822.org>
References: <20001021202159.A3619@paradigm.rfc822.org> <Pine.LNX.4.21.0010220951060.4857-100000@spock.mgnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010220951060.4857-100000@spock.mgnet.de>; from spock@mgnet.de on Sun, Oct 22, 2000 at 10:04:27AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Oct 22, 2000 at 10:04:27AM +0200, Klaus Naumann wrote:
> Actually writing the bug tracker wasn't an act of boredom 
> (if you meant it that way). I had the strong feeling that we have

No - I didnt think of it that way ...

> > The one sending these reports has to give possible additional
> > hints on what he did/patch/change to get it to work. So probabably
> > we will than be able to keep track on which kernel versions
> > worked on which machines.
> 
> This is indeed a interesting idea. Writing it wouldn't be a big deal.
> But the question is if it's worth writing it. First we would need
> some ppl which actally send the info somewhere - I'm pretty
> much in doubt, that we will find enough so that it rents.
> Second question is if ppl are actually interested in such a thing.
> I'll not again waste time writing something where I don't get at least a
> small ammount of feedback and which noone is using.

Right - I just thought as a feedback for the kernel cvs commits the other
way round that you implemented - Sometimes (most of the time ?) bugs
keep not found because noone is using some specific feature (Like the
Timeing stuff in the decstations) and though a lot of people simply
think its their fault instead of complaining - But with something like
that and possibly a simple shell script we yould collect not negative
but positive information on WHAT is actually working. Nevertheless this
only works for a small subset of the mips stuff (kernel) and though might
be pretty useless as most of the kernel stuff works and userspace is
getting the problem.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
