Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA62066 for <linux-archive@neteng.engr.sgi.com>; Mon, 17 Aug 1998 09:58:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA05976
	for linux-list;
	Mon, 17 Aug 1998 09:58:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA54566
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Aug 1998 09:57:58 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn (dialup90-1-22.swipnet.se [130.244.90.22]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA00464
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Aug 1998 09:57:55 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: (from grim@localhost)
	by calypso.saturn (8.9.1/8.9.1/Debian/GNU) id SAA29305;
	Mon, 17 Aug 1998 18:57:41 +0200
From: Ulf Carlsson <grim@zigzegv.ml.org>
Message-Id: <199808171657.SAA29305@calypso.saturn>
Subject: R4[04]00SC
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Date: Mon, 17 Aug 1998 18:57:40 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I can report that I've a R4000SC running here with Linux. After hard work
(many long hours, mainly reading MIPS Manual), the VCE exceptions are now
correctly handled. R4400SC will (probably) also work now. The next step is to
make this exceptions never happen.

Greetings to Ralf, Alex and last but not least - myself.

- Ulf
