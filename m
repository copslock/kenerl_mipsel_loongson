Received:  by oss.sgi.com id <S305182AbPKWWrU>;
	Tue, 23 Nov 1999 14:47:20 -0800
Received: from [192.48.153.1] ([192.48.153.1]:23556 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305180AbPKWWrL>;
	Tue, 23 Nov 1999 14:47:11 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08927
	for <linuxmips@oss.sgi.com>; Tue, 23 Nov 1999 14:53:18 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA19351
	for linux-list;
	Tue, 23 Nov 1999 14:28:57 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA99503
	for <linux@engr.sgi.com>;
	Tue, 23 Nov 1999 14:28:41 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05539
	for <linux@engr.sgi.com>; Tue, 23 Nov 1999 14:28:29 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
Received: from cacc-17.uni-koblenz.de (cacc-17.uni-koblenz.de [141.26.131.17])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA07877;
	Tue, 23 Nov 1999 23:26:19 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPKWWVK>;
	Tue, 23 Nov 1999 23:21:10 +0100
Date:   Tue, 23 Nov 1999 23:21:10 +0100
From:   Ralf Baechle <ralf@uni-koblenz.de>
To:     "Bradley D. LaRonde" <brad@ltc.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Location of init_task_union
Message-ID: <19991123232110.H16508@uni-koblenz.de>
References: <007801bf3500$90edf810$b8119526@ltc.com> <19991123230824.E16508@uni-koblenz.de> <01f101bf3601$0cf42fa0$b8119526@ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <01f101bf3601$0cf42fa0$b8119526@ltc.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Nov 23, 1999 at 05:21:12PM -0500, Bradley D. LaRonde wrote:

> > > I can easily move it to .data or .data.init_task like i386, but I'm
> > > wondering if there is some special reason why it is in .text on mips and
> > > .data on i386.
> >
> > Doesn't matter when it ends up, it only needs to be 8kb aligned which is
> > why we have to do such silly things.
> 
> i386 does it by putting it in it's own segment, then aligning that segment
> in the linker script.  Can we switch to that way?

Yes.  I already did this in my private source for another, MIPS64 related
reason.

  Ralf
