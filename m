Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA23504 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 Aug 1998 10:06:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA41864
	for linux-list;
	Thu, 27 Aug 1998 10:04:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA97416
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Aug 1998 10:04:51 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: from calvin.tor.onramp.ca (calvin.tor.onramp.ca [204.225.88.15]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id KAA24020
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 Aug 1998 10:04:53 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: (qmail 5935 invoked from network); 27 Aug 1998 17:04:51 -0000
Received: from imail.hgeng.com (HELO bart.hgeng.com) (199.246.72.233)
  by mail.onramp.ca with SMTP; 27 Aug 1998 17:04:51 -0000
Received: by BART with Internet Mail Service (5.5.1960.3)
	id <RH7SNLPS>; Thu, 27 Aug 1998 13:10:26 -0400
Message-ID: <60222E63C9F4D011915F00A02435011C126379@BART>
From: Mike Hill <mikehill@hgeng.com>
To: linux@cthulhu.engr.sgi.com
Subject: Installing Rough Hat in South Simcoe County
Date: Thu, 27 Aug 1998 13:10:24 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.1960.3)
Content-Type: text/plain
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Finally[1] I've got my Indy connected to a Debian 2.0 pentium that has
the tarball of the dist formerly known as Hard Hat.

The kernel boots locally *and* with bootp, putting me into the installer
in either case.  According to the pc's syslog, the Indy successfully
nfsmounts the installfs directory.  After mounting /dev/sdb1 (without
checking), the installer fails with this:

	Fatal error opening RPM database (I pick "Ok")
	install exited abnormally...received signal 11

Is this a configuration problem, in which case I should continue to
pursue the perfect tftp config, or would it be simpler to finish the
process manually as others have done?

Thanks,

Mike


Footnotes: 
[1]  Recently moving to a country estate means my ISP is no longer a
local call.  I was able to download Hard Hat at the rate of about
20M/day.
