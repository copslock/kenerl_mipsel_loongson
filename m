Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA92740 for <linux-archive@neteng.engr.sgi.com>; Sat, 20 Jun 1998 19:58:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA93070
	for linux-list;
	Sat, 20 Jun 1998 19:58:19 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA15304
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 20 Jun 1998 19:58:17 -0700 (PDT)
	mail_from (LetherGlov@aol.com)
Received: from imo14.mx.aol.com (imo14.mx.aol.com [198.81.17.4]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id TAA26919
	for <linux@cthulhu.engr.sgi.com>; Sat, 20 Jun 1998 19:58:16 -0700 (PDT)
	mail_from (LetherGlov@aol.com)
From: LetherGlov@aol.com
Received: from LetherGlov@aol.com
	by imo14.mx.aol.com (IMOv14_b1.1) id 1KUa013455
	for <linux@cthulhu.engr.sgi.com>; Sat, 20 Jun 1998 22:58:04 +2000 (EDT)
Message-ID: <f48fe728.358c76bd@aol.com>
Date: Sat, 20 Jun 1998 22:58:04 EDT
To: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Subject: Running Linux on Linus
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
X-Mailer: Windows AOL sub 85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

       In response to the ideas floating around about running Linux on Linus,
I think that before you give Bob Mende and William Earl tons of work
configuring it (and rebooting), that If I understand things correctly it is a
good idea to enable the Watchdog features of the Dallas 1386 clock, so that if
there are any kernel panics or troubles or whatever may occur that the
watchdog would automatically restart linus in the event that the kernel was
no-longer updating the timer.

If I am just completely off on the whole general concept of a Watchdog please
tell me, but I think that(if I'm right) it might be a good idea for everybody
to have that feature available to them :-) The documentation that I was
reading at Dallas' website implied that the only thing involved was to have
the clock stuff to reset, or update, the reset time of the timer every xxx
seconds to prevent it from restarting an out-of-control processor.


Thanks,
Robbie Stone

P.S. In /src/web the permissions of the *.in files were changed somehow to
root-only editing, it would be nice if you could enable the vip user group to
have write-permissions as well, since there are a couple of things off in the
documentation.

P.P.S--To Alex, there doesn't appear anywhere in the web-pages a link into the
manhattan/rpm2html hierarchy, I don't know If I missed the link, or if your
just not done, but it isn't existent at the moment. And in the rpm2html
generated files there is no page at the other end of the Help hyperlink on the
top left-corner of the menu in the generated pages.

P.P.P.S--to Mende, the root partition on Linus is _very_ close to being full,
perhaps a clean up of the unnessesary programs/files is in order, otherwise
the maintenance and addition of space on the /src partition is very nice.

Good Night 8-)
