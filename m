Received:  by oss.sgi.com id <S305160AbQCNMIp>;
	Tue, 14 Mar 2000 04:08:45 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:45101 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCNMI1>; Tue, 14 Mar 2000 04:08:27 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id EAA04332; Tue, 14 Mar 2000 04:11:49 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA43902
	for linux-list;
	Tue, 14 Mar 2000 03:59:21 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA65154
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 14 Mar 2000 03:59:18 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be ([193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA01930
	for <linux@cthulhu.engr.sgi.com>; Tue, 14 Mar 2000 03:59:14 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id MAA04764;
	Tue, 14 Mar 2000 12:58:41 +0100 (MET)
Date:   Tue, 14 Mar 2000 12:58:41 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: boot success 2.3.51 Decstation 5000/150 - no login via network
 possible
In-Reply-To: <20000314120430.A4321@paradigm.rfc822.org>
Message-ID: <Pine.GSO.4.10.10003141256170.15255-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, 14 Mar 2000, Florian Lohoff wrote:
> i am able to report boot success for 2.3.51 on a Decstation 5000/150 (R4000)
> 
> 
> The same problem as 2.3.47 and up applies - I am not able to 
> log in anymore over network to that machine ..

Aha, it's a kernel problem...

I have the same problem with 2.3.51 on DDB Vrc-5074. I retried with some older
kernels, and 2.3.47 failed as well. 2.3.41 allowed me to telnet to the box. I
do have images in between .41 and .47, but they don't boot sufficiently far.

Does it also happen on SGI? If not, perhaps it's an endianness problems? Both
DS and DDB run in little endian.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
