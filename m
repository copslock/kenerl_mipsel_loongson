Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id JAA31944
	for <pstadt@stud.fh-heilbronn.de>; Thu, 23 Sep 1999 09:36:53 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id AAA06866; Thu, 23 Sep 1999 00:34:45 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA24605
	for linux-list;
	Thu, 23 Sep 1999 00:29:08 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA44436
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 23 Sep 1999 00:29:04 -0700 (PDT)
	mail_from (sparker@taz.cs.utah.edu)
Received: from wrath.cs.utah.edu (wrath.cs.utah.edu [155.99.198.100]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA00517
	for <linux@cthulhu.engr.sgi.com>; Thu, 23 Sep 1999 00:29:03 -0700 (PDT)
	mail_from (sparker@taz.cs.utah.edu)
Received: from taz.cs.utah.edu (taz.cs.utah.edu [155.99.203.51])
	by wrath.cs.utah.edu (8.8.8/8.8.8) with SMTP id BAA10067;
	Thu, 23 Sep 1999 01:29:03 -0600 (MDT)
Received: by taz.cs.utah.edu (950413.SGI.8.6.12/utah-2.15sun-leaf)
	id BAA765517; Thu, 23 Sep 1999 01:29:02 -0600
Date: Thu, 23 Sep 1999 01:29:02 -0600
From: sparker@taz.cs.utah.edu (Steven G. Parker)
Message-Id: <9909230129.ZM763626@taz.cs.utah.edu>
In-Reply-To: Rory Hunter <roryh@dcs.ed.ac.uk>
        "Re: oddness" (Sep 23,  8:16am)
References: <37E95D52.AC2CE967@dcs.ed.ac.uk>  <37E96210.64A50BBF@csd.sgi.com> 
	<37E9D3C8.F665545A@dcs.ed.ac.uk>
X-Mailer: Z-Mail-SGI (3.2S.3 08feb96 MediaMail)
To: Rory Hunter <roryh@dcs.ed.ac.uk>
Subject: Re: oddness
Cc: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>From the df man page:
     The proc filesystem (normally mounted under /proc) is not printed by
     default, but can be explicitly specified.  This filesystem consumes no
     actual disk space, but is an interface to the virtual space of running
     processes.  The total and free blocks reported represent the total
     virtual memory (real memory plus swap space) present and the amount
     currently free, respectively.


You will see /proc if you use GNU df.  Otherwise, you have to explicitly
ask for it (df /prof).

If you use IRIX df /proc, you will see that the Type is proc - a
virtual filesystem.

If you want to independently verify it - use prtvtoc to look at
how your disk is partitioned.  You will probably not see a /proc
paritition.

Steve Parker

On Sep 23,  8:16am, Rory Hunter wrote:
> Subject: Re: oddness
> Hi,
>
> I know the proc is virtual, but it puzzled me that 'df' should list it
> when linux doesn't... if I can confirm that the partition itself is
> virtual then I'll happliy ignore it.
>
> Cheers,
>
> Rory Hunter
>-- End of excerpt from Rory Hunter
