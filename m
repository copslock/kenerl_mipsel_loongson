Received:  by oss.sgi.com id <S553679AbQJUSez>;
	Sat, 21 Oct 2000 11:34:55 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:9227 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553660AbQJUSen>;
	Sat, 21 Oct 2000 11:34:43 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 1BF257D9; Sat, 21 Oct 2000 20:34:40 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 52F23900C; Sat, 21 Oct 2000 20:21:59 +0200 (CEST)
Date:   Sat, 21 Oct 2000 20:21:59 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Klaus Naumann <spock@mgnet.de>
Cc:     Linux/MIPS list <linux-mips@oss.sgi.com>,
        "Linux MIPS fnet.fr" <linux-mips@fnet.fr>
Subject: Re: Bug Tracker online
Message-ID: <20001021202159.A3619@paradigm.rfc822.org>
References: <Pine.LNX.4.21.0010201928160.8939-100000@spock.mgnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010201928160.8939-100000@spock.mgnet.de>; from spock@mgnet.de on Fri, Oct 20, 2000 at 07:45:22PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 20, 2000 at 07:45:22PM +0200, Klaus Naumann wrote:
> Hi all,
> 
> I've written a bug tracker lately which is online as of now.
> It is intended to make it easier to track the problems of
> Linux/MIPS and to give the developers a more clear input and
> overview of the situation.

If you are bored - Would you mind writing a "Boot output parser".

What i have seen lately is that sometimes we are not aware of what
drivers/machines work and which dont. So i thought of an idea where
you just run a script or something sending something like

dmesg
cat /proc/cpuinfo

to a central location which than parses the output.

The one sending these reports has to give possible additional
hints on what he did/patch/change to get it to work. So probabably
we will than be able to keep track on which kernel versions
worked on which machines.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
