Received:  by oss.sgi.com id <S305159AbQARCGT>;
	Mon, 17 Jan 2000 18:06:19 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:41592 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQARCGK>; Mon, 17 Jan 2000 18:06:10 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id SAA02381; Mon, 17 Jan 2000 18:10:18 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA94504
	for linux-list;
	Mon, 17 Jan 2000 17:58:59 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA03828
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Jan 2000 17:58:50 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA08948
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Jan 2000 17:58:46 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id TAA18969;
	Mon, 17 Jan 2000 19:58:24 -0600
Date:   Mon, 17 Jan 2000 19:56:42 -0600 (CST)
From:   "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Jeff Harrell <jharrell@ti.com>,
        Conrad Parker <conradp@cse.unsw.edu.au>,
        linux@cthulhu.engr.sgi.com
Subject: Re: question concerning serial console setup
In-Reply-To: <20000117050602.C16920@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.1000117195358.28191A-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



On Mon, 17 Jan 2000, Ralf Baechle wrote:
> On Sun, Jan 16, 2000 at 08:41:38PM -0700, Jeff Harrell wrote:
> 
> > Unfortunately I am working on an embedded platform, only using this code
> > as a starting point for our design.  If possible I would like to initialize
> > the console w/o the use of command line parameters.
> 
> A simple solution is to hardwire the commmand line in
> arch/mips/kernel/setup.c.
> 

I have some hackish code that queries the prom enviroment and edits the
commandline to reflect the appropriate console.  If that is worthwhile to
have available I will dig up a diff.

-Andrew
