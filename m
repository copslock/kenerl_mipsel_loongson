Received:  by oss.sgi.com id <S305159AbQARCb7>;
	Mon, 17 Jan 2000 18:31:59 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:9788 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305155AbQARCbl>;
	Mon, 17 Jan 2000 18:31:41 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA07344; Mon, 17 Jan 2000 18:33:26 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA20991
	for linux-list;
	Mon, 17 Jan 2000 18:14:48 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA25758
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Jan 2000 18:14:46 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA01051
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Jan 2000 18:14:44 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-8.uni-koblenz.de (cacc-8.uni-koblenz.de [141.26.131.8])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id DAA23147;
	Tue, 18 Jan 2000 03:14:39 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQARCOT>;
	Tue, 18 Jan 2000 03:14:19 +0100
Date:   Tue, 18 Jan 2000 03:14:19 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Andrew R. Baker" <andrewb@uab.edu>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, Jeff Harrell <jharrell@ti.com>,
        Conrad Parker <conradp@cse.unsw.edu.au>,
        linux@cthulhu.engr.sgi.com
Subject: Re: question concerning serial console setup
Message-ID: <20000118031419.B10759@uni-koblenz.de>
References: <20000117050602.C16920@uni-koblenz.de> <Pine.LNX.3.96.1000117195358.28191A-100000@mdk187.tucc.uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.3.96.1000117195358.28191A-100000@mdk187.tucc.uab.edu>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Jan 17, 2000 at 07:56:42PM -0600, Andrew R. Baker wrote:

> > > Unfortunately I am working on an embedded platform, only using this code
> > > as a starting point for our design.  If possible I would like to initialize
> > > the console w/o the use of command line parameters.
> > 
> > A simple solution is to hardwire the commmand line in
> > arch/mips/kernel/setup.c.
> 
> I have some hackish code that queries the prom enviroment and edits the
> commandline to reflect the appropriate console.  If that is worthwhile to
> have available I will dig up a diff.

Have you considered hacking kerne/printk.c:console_setup() instead?
There is already some SPARC code there.

  Ralf
