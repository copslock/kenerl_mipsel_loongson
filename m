Received:  by oss.sgi.com id <S305194AbQDCIcl>;
	Mon, 3 Apr 2000 01:32:41 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:35365 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305164AbQDCIcV>;
	Mon, 3 Apr 2000 01:32:21 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA24177; Mon, 3 Apr 2000 01:27:39 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA08955
	for linux-list;
	Mon, 3 Apr 2000 01:22:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA14404
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 3 Apr 2000 01:22:20 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be ([193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA01859
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 Apr 2000 01:22:18 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA14505;
	Mon, 3 Apr 2000 10:21:20 +0200 (MET DST)
Date:   Mon, 3 Apr 2000 10:21:20 +0200 (MET DST)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: configure spaghetti code
In-Reply-To: <20000401181931.M3970@paradigm.rfc822.org>
Message-ID: <Pine.GSO.4.10.10004031020170.22512-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sat, 1 Apr 2000, Florian Lohoff wrote:
> 3. Only show devices which are really available for the architectures
>    (I dont think anyone has succeeded in plugging a 3C509 into a DecStation 
>    5000 or a Telephony card or even IDE)

If you configure for a DS5000, you won't have ISA, and the 3c509 question
should depend on CONFIG_ISA (which was added very recently, so probably the ISA
questions aren't protected by CONFIG_ISA yet).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
