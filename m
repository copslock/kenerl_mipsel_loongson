Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA67370 for <linux-archive@neteng.engr.sgi.com>; Sun, 2 May 1999 03:21:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA48631
	for linux-list;
	Sun, 2 May 1999 03:17:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA81861
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 2 May 1999 03:17:48 -0700 (PDT)
	mail_from (richardh@penguin.nl)
Received: from perron-null.patser.net (9dyn90.breda.casema.net [195.96.116.90]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA06633
	for <linux@cthulhu.engr.sgi.com>; Sun, 2 May 1999 06:17:46 -0400 (EDT)
	mail_from (richardh@penguin.nl)
Received: from penguin.nl (root@bronx.patser.net [192.168.6.90])
	by perron-null.patser.net (8.9.0/8.9.0) with ESMTP id LAA17157;
	Sun, 2 May 1999 11:03:28 +0200
Message-ID: <372C27E9.8E3F82B0@penguin.nl>
Date: Sun, 02 May 1999 12:24:41 +0200
From: Richard Hartensveld <richardh@penguin.nl>
X-Mailer: Mozilla 4.5 [en] (X11; I; Linux 2.2.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jcoffin@sv.usweb.com
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Yet closer
References: <199905011939.MAA23712@lil.brown-dog.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

jcoffin@sv.usweb.com wrote:

>
> In any event, what do I need to do to "change setup-1.9.1-2.noarch.rpm
> to add some securetty's"?
>
>

/etc/securetty

add:

ttyp0
ttyp1
ttyp2
etc.

Richard
