Received:  by oss.sgi.com id <S305166AbQCXXhe>;
	Fri, 24 Mar 2000 15:37:34 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:2851 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305159AbQCXXhZ>; Fri, 24 Mar 2000 15:37:25 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA05695; Fri, 24 Mar 2000 15:40:58 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id PAA17615; Fri, 24 Mar 2000 15:37:24 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA08328
	for linux-list;
	Fri, 24 Mar 2000 06:10:28 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA24491
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 24 Mar 2000 06:10:21 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA04003
	for <linux@cthulhu.engr.sgi.com>; Fri, 24 Mar 2000 06:10:10 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id PAA29955;
	Fri, 24 Mar 2000 15:08:55 +0100 (MET)
Date:   Fri, 24 Mar 2000 15:08:55 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Decstation 5000/150 2.3.99pre2/ still login problems
In-Reply-To: <20000324134315.A6208@paradigm.rfc822.org>
Message-ID: <Pine.GSO.4.10.10003241507430.7616-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, 24 Mar 2000, Florian Lohoff wrote:
> still the same problems - since the mid 2.3.4x kernels i cant
> log into my decstation 5000 - It seems the pseudo tty code
> is non functional.
> 
> An telnet or "ssh" causes the connection to close if requesting a tty.

I can confirm this on my DDB 5074. Does it work on SGI boxes? If yes, it may be
an endianness problem (both DS 5000 and DDB 5074 are little endian).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
