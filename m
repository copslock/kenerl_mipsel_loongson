Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA97465 for <linux-archive@neteng.engr.sgi.com>; Sun, 13 Jun 1999 11:01:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA59541
	for linux-list;
	Sun, 13 Jun 1999 11:00:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA81938
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 13 Jun 1999 11:00:06 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup147-2-27.swipnet.se [130.244.147.91]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA01736
	for <linux@cthulhu.engr.sgi.com>; Sun, 13 Jun 1999 11:00:03 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10tF2i-003Ln2C; Sun, 13 Jun 1999 20:31:40 +0200 (CEST)
Date: Sun, 13 Jun 1999 20:31:40 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: CVS
Message-ID: <19990613203140.A8276@thepuffingroup.com>
Mail-Followup-To: Ralf Baechle <ralf@uni-koblenz.de>,
	linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
	linux-mips@vger.rutgers.edu
References: <19990613185518.A11493@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <19990613185518.A11493@uni-koblenz.de>; from Ralf Baechle on Sun, Jun 13, 1999 at 06:55:23PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jun 13, 1999 at 06:55:23PM +0200, Ralf Baechle wrote:
> I've just commited Linux 2.2.8 into the CVS archive.  Once this is
> finished I'll create a branch named linux_2_2 for the 2.2 development
> in the archive.  If you just do ``cvs update'' you'll stay on the
> mainline of the development, that is 2.3.  If you want to work with
> the 2.2 sources then you'll have to add the option ``-r linux_2_2''
> to your next cvs update or cvs co command.
> 
> I'm already running 2.2.9 and 2.3.1 on my Indy but the checkin is that
> slow that I won't commit these versions into the CVS archive now.

I would appreciate if it was possible to continue using 32 bit code on the Indy,
even if you add 64 bit code. Maybe we can add it as an option in the kernel
configuration scripts?

- Ulf
