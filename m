Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id VAA29832
	for <pstadt@stud.fh-heilbronn.de>; Thu, 15 Jul 1999 21:11:59 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA25503; Thu, 15 Jul 1999 12:04:28 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA15785
	for linux-list;
	Thu, 15 Jul 1999 12:01:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA21266
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 15 Jul 1999 12:01:20 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from mail.cobaltnet.com (firewall.cobaltmicro.com [209.133.34.37] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA07289
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jul 1999 12:01:19 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from cobaltnet.com (freakshow.cobaltnet.com [10.9.24.15])
	by mail.cobaltnet.com (8.9.3/8.9.3) with ESMTP id LAA16092
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jul 1999 11:58:58 -0700
Message-ID: <378E2FEF.6E82871A@cobaltnet.com>
Date: Thu, 15 Jul 1999 12:01:03 -0700
From: Tim Hockin <thockin@cobaltnet.com>
Organization: Cobalt Networks
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: gp
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Ralf + crew

just playing around with kernel, and wondering what (if any) work has
been done to use gp within the kernel.  I know it is built with -G 0
now.

I looked into it, and made sure that gp got saved and restored correctly
(I think), but when I compile with -G > 0 gcc (or egcs) gets signal 11 -
ideas?

Tim
