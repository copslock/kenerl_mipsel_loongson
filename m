Received:  by oss.sgi.com id <S42276AbQFTIrD>;
	Tue, 20 Jun 2000 01:47:03 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:34643 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42229AbQFTIqs>;
	Tue, 20 Jun 2000 01:46:48 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA19622
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 01:41:45 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA80080
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Jun 2000 01:46:13 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be ([193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA00344
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jun 2000 01:45:56 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA19425;
	Tue, 20 Jun 2000 10:44:28 +0200 (MET DST)
Date:   Tue, 20 Jun 2000 10:44:28 +0200 (MET DST)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Jun Sun <jsun@mvista.com>
cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: R5000 support (specifically two-way set-associative cache...)
In-Reply-To: <394EA5A0.B882F66A@mvista.com>
Message-ID: <Pine.GSO.4.10.10006201042320.8592-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 19 Jun 2000, Jun Sun wrote:
> 3. I understand Geert has a port to DDB5074 (with Vr5000 CPU).  Is this
> port completed (including all interrupts, PCI related stuff).  Is this
> port reliable?

  - Interrupts (both Nile4, PCI and ISA) are working.
  - PCI bus mastering doesn't work yet (I guess so because the Tulip driver
    doesn't work yet).
  - About reliability: I see random crashes, but they seem to happen on other
    platforms as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
