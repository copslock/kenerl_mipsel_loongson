Received:  by oss.sgi.com id <S305164AbQCXSIH>;
	Fri, 24 Mar 2000 10:08:07 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:27412 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQCXSHs>;
	Fri, 24 Mar 2000 10:07:48 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA29859; Fri, 24 Mar 2000 10:03:07 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA20286
	for linux-list;
	Fri, 24 Mar 2000 09:51:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA20174
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 24 Mar 2000 09:51:05 -0800 (PST)
	mail_from (richardh@penguin.nl)
Received: from smtpe.casema.net (smtpe.casema.net [195.96.96.172]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id HAA06636
	for <linux@cthulhu.engr.sgi.com>; Fri, 24 Mar 2000 07:40:10 -0800 (PST)
	mail_from (richardh@penguin.nl)
Received: (qmail 20775 invoked from network); 24 Mar 2000 15:39:57 -0000
Received: from unknown (HELO penguin.nl) (195.96.116.34)
  by smtpe.casema.net with SMTP; 24 Mar 2000 15:39:57 -0000
Message-ID: <38DB8C91.8423BE78@penguin.nl>
Date:   Fri, 24 Mar 2000 16:41:05 +0100
From:   Richard <richardh@penguin.nl>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC:     Florian Lohoff <flo@rfc822.org>, linux@cthulhu.engr.sgi.com
Subject: Re: Decstation 5000/150 2.3.99pre2/ still login problems
References: <Pine.GSO.4.10.10003241507430.7616-100000@dandelion.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Geert Uytterhoeven wrote:

> On Fri, 24 Mar 2000, Florian Lohoff wrote:
> > still the same problems - since the mid 2.3.4x kernels i cant
> > log into my decstation 5000 - It seems the pseudo tty code
> > is non functional.
> >
> > An telnet or "ssh" causes the connection to close if requesting a tty.
>
> I can confirm this on my DDB 5074. Does it work on SGI boxes? If yes, it may be
> an endianness problem (both DS 5000 and DDB 5074 are little endian).
>

Right now, it seems the kernel won't boot at all on SGI boxes.

Richard
