Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jul 2004 12:33:29 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:59600 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224923AbUGOLdY>; Thu, 15 Jul 2004 12:33:24 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 989A847A65; Thu, 15 Jul 2004 13:33:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 851224787C; Thu, 15 Jul 2004 13:33:17 +0200 (CEST)
Date: Thu, 15 Jul 2004 13:33:17 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Help with MOP network boot install on DECstation 5000/240
In-Reply-To: <20040714133039.GS2019@lug-owl.de>
Message-ID: <Pine.LNX.4.55.0407151323550.25184@jurand.ds.pg.gda.pl>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org>
 <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org>
 <000701c468ae$141c3e50$0a9913ac@swift> <20040713080320.GC18841@lug-owl.de>
 <000e01c4696f$f65cf4f0$0a9913ac@swift> <Pine.LNX.4.55.0407141058480.4513@jurand.ds.pg.gda.pl>
 <20040714124435.GR2019@lug-owl.de> <Pine.LNX.4.55.0407141446440.27072@jurand.ds.pg.gda.pl>
 <20040714133039.GS2019@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 14 Jul 2004, Jan-Benedict Glaw wrote:

> Eventually I'll re-get all the sources and compile again. Adding a
> timeout shouldn't be all that hard. It should be a matter of extending
> the "connection" table by "last packet's recv/send time" and check this
> table entry upon each new request.

 But you probably have to take resumption into account -- a client may
restart sending requests from the point it stopped.  It may happen after a
link is restored somewhere on the way after a break, for example.  Though
I haven't checked if there's any timeout defined in the MOP spec or
imposed by specific MOP download clients -- perhaps there is.

> >  Another problem which is already known is mopd dying when one of
> > interfaces it's listening on goes down.
> 
> Haven't seen that, but my interfaces tend to not go down (at least not
> until the whole machine goes down...).

 Mine tend to do that after I do `ifconfig <iface> down', which is what I
sometimes do.  I need to remember to restart mopd then.  Perhaps mopd
should monitor interfaces appearing and disappearing in general, taking
the restriction on the command line into account, of course.

  Maciej
