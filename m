Received:  by oss.sgi.com id <S305184AbPLIS0o>;
	Thu, 9 Dec 1999 10:26:44 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:13854 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbPLIS0U>; Thu, 9 Dec 1999 10:26:20 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA08520; Thu, 9 Dec 1999 10:35:32 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA00275
	for linux-list;
	Thu, 9 Dec 1999 10:24:19 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA79011
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Dec 1999 10:23:42 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA01772
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Dec 1999 10:22:50 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 476817F7; Thu,  9 Dec 1999 19:22:09 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id E309C8F93; Thu,  9 Dec 1999 16:49:08 +0100 (CET)
Date:   Thu, 9 Dec 1999 16:49:08 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Snapshot
Message-ID: <19991209164908.A3212@paradigm.rfc822.org>
References: <19991206214429.T765@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <19991206214429.T765@uni-koblenz.de>; from Ralf Baechle on Mon, Dec 06, 1999 at 09:44:29PM -0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Dec 06, 1999 at 09:44:29PM -0200, Ralf Baechle wrote:
> I've put a snapshot of current CVS kernel sources into
> oss.sgi.com:/pub/linux/mips/src/kernel/linux-19991206.tar.gz.

Short resume:

Doesnt work on Decstation 5000/150 Mips R4000 ...
Reboots immediatly after end of tftp download ...

KN04 V2.1k    (PC: 0x8005c044, SP: 0x838a9de0)

-tftp boot(3), bootp 193.189.250.46:/boot/vmlinux-2.3.21-decR4k.ecoff
-tftp load 1222624+0+369568

KN04 V2.1k    (PC: 0x8005c044, SP: 0x80047f78)

-tftp boot(3), bootp 193.189.250.46:/boot/vmlinux-2.3.21-decR4k.ecoff
-tftp load 1222624+0+369568

So long ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
  ...  The failure can be random; however, when it does occur, it is
  catastrophic and is repeatable  ...             Cisco Field Notice
