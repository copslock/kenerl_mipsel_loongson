Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id SAA30451
	for <pstadt@stud.fh-heilbronn.de>; Fri, 17 Sep 1999 18:04:19 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA09523; Fri, 17 Sep 1999 08:55:26 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA01534
	for linux-list;
	Fri, 17 Sep 1999 08:42:26 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA90541
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Sep 1999 08:42:23 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA05264
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Sep 1999 08:42:22 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA01795
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Sep 1999 08:42:21 -0700 (PDT)
Received: from satanas (lyon-fw1-serial [194.51.122.30])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id IAA09884
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Sep 1999 08:42:19 -0700 (PDT)
Message-ID: <00da01bf0124$198796b0$0228a8c0@satanas>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "SGI Linux Alias" <linux@cthulhu.engr.sgi.com>
Subject: Bug in Indy serial driver?
Date: Fri, 17 Sep 1999 17:48:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

In trying to use remote gdb targets, I came across
a problem with the Indy serial driver.  I'm running
2.2.12, but the driver and line discipline code are
unchanged from 2.2.10.  

If one turns off output postprocessing via ioctl, or simply 
with an stty -opost < /dev/ttyS0, writes to the device 
succeed, but the data is never sent.  A close of the 
device will then hang for a 30 second timeout, but 
the data isn't flushed then, either.  The line discipline
follows a different code path in the O_POST case
than in the no-opost case, and it looked to me as
if perhaps things were working in the O_POST
case simply because there are more explicit
flushes being performed, as the restart of the
transmitter in ns_write is conditional on a status
that may never be satisfied.  I removed that 
condition, but this has no effect on the behaviour.

Has anyone else seen this, or better still, fixed it?
It's possible that the bug is in n_tty.c itself, but
as that is generic to all Linux serial ports, I would
be rather surprised if it had not been found and
fixed long ago.

            Regards,

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
