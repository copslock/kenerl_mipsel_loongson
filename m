Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA46569 for <linux-archive@neteng.engr.sgi.com>; Tue, 4 May 1999 18:45:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA52744
	for linux-list;
	Tue, 4 May 1999 18:44:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA76929
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 4 May 1999 18:44:27 -0700 (PDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (pr250.pheasantrun.net [208.140.225.250]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA07321
	for <linux@cthulhu.engr.sgi.com>; Tue, 4 May 1999 21:44:26 -0400 (EDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (clepple@sprocket.foo.tho.org [206.223.45.3])
	by foo.tho.org (8.8.7/8.8.7) with ESMTP id VAA30938
	for <linux@cthulhu.engr.sgi.com>; Tue, 4 May 1999 21:44:24 -0400
Message-ID: <372FA277.D3174BF4@foo.tho.org>
Date: Wed, 05 May 1999 01:44:23 +0000
From: Charles Lepple <clepple@foo.tho.org>
X-Mailer: Mozilla 4.5 [en] (X11; U; Linux 2.0.36 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux/SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: CP0_STATUS interrupt mask patch
References: <Pine.LNX.4.04.9905041342400.30478-100000@foo.tho.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Charles Lepple wrote:
> I just pulled down the CVS kernel with the patch, and it seems that it
> causes a 'keyboard timeout[2]' to be printed on the console after the SCSI

Omitted a critical detail -- it hangs hard-core after this message.
Evidently the power button was initialized by this point, because it
doesn't turn off immediately, and it doesn't start the LED blinking
indicating an impending power-off.

System summary: 
Indy R5000
gcc version egcs-2.90.27 980315 (egcs-1.0.2 release)
binutils-2.8.1

-- 
Charles Lepple
System Administrator, Virginia Tech EE Workstation Labs
clepple@ee.vt.edu || http://www.foo.tho.org/charles/
