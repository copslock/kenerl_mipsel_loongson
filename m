Received:  by oss.sgi.com id <S553775AbQJVQUS>;
	Sun, 22 Oct 2000 09:20:18 -0700
Received: from natmail2.webmailer.de ([192.67.198.65]:14792 "EHLO
        post.webmailer.de") by oss.sgi.com with ESMTP id <S553768AbQJVQUF>;
	Sun, 22 Oct 2000 09:20:05 -0700
Received: from scotty.mgnet.de (pC19F6C99.dip.t-dialin.net [193.159.108.153])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id SAA03108
	for <linux-mips@oss.sgi.com>; Sun, 22 Oct 2000 18:20:02 +0200 (MET DST)
Received: (qmail 20917 invoked from network); 22 Oct 2000 16:20:01 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 22 Oct 2000 16:20:01 -0000
Date:   Sun, 22 Oct 2000 18:20:01 +0200 (CEST)
From:   Klaus Naumann <spock@mgnet.de>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
cc:     Guido Guenther <guido.guenther@gmx.net>,
        Linux/MIPS list <linux-mips@oss.sgi.com>,
        "Linux MIPS fnet.fr" <linux-mips@fnet.fr>
Subject: Re: Bug Tracker online
In-Reply-To: <20001022083212.A29387@chem.unr.edu>
Message-ID: <Pine.LNX.4.21.0010221816270.8799-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, 22 Oct 2000, Keith M Wesolowski wrote:

> On Sun, Oct 22, 2000 at 10:58:58AM +0200, Klaus Naumann wrote:
> > Well, I thought about that. The point is, that I don't know yet if the
> > bugtracker doesn't get too inflexible if we use predefined
> > values. WHat do you think ?
> 
> The trouble is, for some bugs, by the time you've figured out what the
> bug belongs to, you're 90% of the way to having fixed it and there's
> usually no point to putting it into the bug tracker. At the same time,
> using something like "toolchain" is rather vague. It might be nice to
> have a list of common trouble areas and then an "Other: ____________"
> type field for bugs that aren't obvious.

The real point is that the "Belongs to" field is not mandatory.
If you don't know where the problem is leave it blank.
It was intented to give a hint where a problem might be.
For example when you're seeing a kernel panic it's obvious,
that this belongs to the kernel. If you're seeing a bus error
and don't know what it might be leave it open.

Having predefined values and a Other: possebility is rather complicated
to implement and is a overkill I'd say.

	CU, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
