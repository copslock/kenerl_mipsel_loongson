Received:  by oss.sgi.com id <S305160AbQCNPa4>;
	Tue, 14 Mar 2000 07:30:56 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:17258 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCNPaj>;
	Tue, 14 Mar 2000 07:30:39 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA11939; Tue, 14 Mar 2000 07:26:01 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA08919
	for linux-list;
	Tue, 14 Mar 2000 07:18:09 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA40228
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 14 Mar 2000 07:18:05 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA09437
	for <linux@cthulhu.engr.sgi.com>; Tue, 14 Mar 2000 07:17:42 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id QAA12319
	for <linux@cthulhu.engr.sgi.com>; Tue, 14 Mar 2000 16:17:24 +0100 (MET)
Date:   Tue, 14 Mar 2000 16:17:24 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     linux@cthulhu.engr.sgi.com
Subject: R5000 stability problems
Message-ID: <Pine.GSO.4.10.10003141603330.20140-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


My NEC DDB Vrc-5074 board (with NEC VR5000) is still suffering from stability
problems. If it crashes, it's always in do_page_fault(). If the board is
running without much activity, it can stay alive for days.

I once tried adding NOPs to the R5000 exception handler, as suggested on this
list, but that didn't seem to make any difference.

Anyone with a suggestion?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
