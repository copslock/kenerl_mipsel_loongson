Received:  by oss.sgi.com id <S553663AbQJVIEv>;
	Sun, 22 Oct 2000 01:04:51 -0700
Received: from natmail2.webmailer.de ([192.67.198.65]:50609 "EHLO
        post.webmailer.de") by oss.sgi.com with ESMTP id <S553655AbQJVIEa>;
	Sun, 22 Oct 2000 01:04:30 -0700
Received: from scotty.mgnet.de (pD4B89433.dip.t-dialin.net [212.184.148.51])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id KAA17861
	for <linux-mips@oss.sgi.com>; Sun, 22 Oct 2000 10:04:28 +0200 (MET DST)
Received: (qmail 19333 invoked from network); 22 Oct 2000 08:04:27 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 22 Oct 2000 08:04:27 -0000
Date:   Sun, 22 Oct 2000 10:04:27 +0200 (CEST)
From:   Klaus Naumann <spock@mgnet.de>
To:     Florian Lohoff <flo@rfc822.org>
cc:     Linux/MIPS list <linux-mips@oss.sgi.com>,
        "Linux MIPS fnet.fr" <linux-mips@fnet.fr>
Subject: Re: Bug Tracker online
In-Reply-To: <20001021202159.A3619@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.21.0010220951060.4857-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 21 Oct 2000, Florian Lohoff wrote:

> On Fri, Oct 20, 2000 at 07:45:22PM +0200, Klaus Naumann wrote:
> > Hi all,
> > 
> > I've written a bug tracker lately which is online as of now.
> > It is intended to make it easier to track the problems of
> > Linux/MIPS and to give the developers a more clear input and
> > overview of the situation.
> 
> If you are bored - Would you mind writing a "Boot output parser".

Actually writing the bug tracker wasn't an act of boredom 
(if you meant it that way). I had the strong feeling that we have
a lot of open problems and we're loosing control which are still open.
Well, in fact your mail is the only comment from the mailinglists on a
project which has taken a week to write and makes sense to me and other 
ppl. I hoped that if ppl don't like the idea or the way I did it, that
they at least would tell me to make it better.
Just not saying anything is pretty lame and to be honest I'm pretty
disappointed about that.
Note that I'm not hunting for a "Hey what a cool idea !" or so -
but I'd have expected at least any comment.

> 
> What i have seen lately is that sometimes we are not aware of what
> drivers/machines work and which dont. So i thought of an idea where
> you just run a script or something sending something like
> 
> dmesg
> cat /proc/cpuinfo
> 
> to a central location which than parses the output.
> 
> The one sending these reports has to give possible additional
> hints on what he did/patch/change to get it to work. So probabably
> we will than be able to keep track on which kernel versions
> worked on which machines.

This is indeed a interesting idea. Writing it wouldn't be a big deal.
But the question is if it's worth writing it. First we would need
some ppl which actally send the info somewhere - I'm pretty
much in doubt, that we will find enough so that it rents.
Second question is if ppl are actually interested in such a thing.
I'll not again waste time writing something where I don't get at least a
small ammount of feedback and which noone is using.


	BFN, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
