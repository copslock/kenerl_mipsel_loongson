Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA89870 for <linux-archive@neteng.engr.sgi.com>; Thu, 10 Jun 1999 15:31:59 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA39998
	for linux-list;
	Thu, 10 Jun 1999 15:30:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA85642
	for <linux@engr.sgi.com>;
	Thu, 10 Jun 1999 15:30:13 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from mail.cobaltnet.com (firewall.cobaltmicro.com [209.133.34.37]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA01250
	for <linux@engr.sgi.com>; Thu, 10 Jun 1999 15:30:12 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from cobaltnet.com (lease41.cobaltnet.com [10.9.25.191])
	by mail.cobaltnet.com (8.9.3/8.9.3) with ESMTP id PAA16534;
	Thu, 10 Jun 1999 15:29:50 -0700
Message-ID: <37603CAB.8094D1CD@cobaltnet.com>
Date: Thu, 10 Jun 1999 15:31:07 -0700
From: TIm Hockin <thockin@cobaltnet.com>
Organization: Cobalt Networks
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: PIC code
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

hey crew.

Working on a Cobalt box, I notice that gcc compiles EVERYTHING as if
-fPIC has been requested.

1) Why?
2) Can this be changed?
3) Should this be changed?
4) How?
5) What effects would it have?

I have never seen ld complain about linking PIC and non-PIC code
before...

Thanks (pardon my ignorance - I am 4 days old with MIPS  Linux :)

Tim
