Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA97887 for <linux-archive@neteng.engr.sgi.com>; Sat, 6 Jun 1998 00:33:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA38615
	for linux-list;
	Sat, 6 Jun 1998 00:32:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA83676
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 6 Jun 1998 00:32:55 -0700 (PDT)
	mail_from (pm215@cam.ac.uk)
Received: from mauve.csi.cam.ac.uk (mauve.csi.cam.ac.uk [131.111.8.38]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id AAA13214
	for <linux@cthulhu.engr.sgi.com>; Sat, 6 Jun 1998 00:32:54 -0700 (PDT)
	mail_from (pm215@cam.ac.uk)
Received: from mnementh.trin.cam.ac.uk ([131.111.213.48])
	by mauve.csi.cam.ac.uk with esmtp (Exim 1.92 #1)
	for linux@cthulhu.engr.sgi.com
	id 0yiDTA-0006k1-00; Sat, 6 Jun 1998 08:32:52 +0100
Received: from localhost (mnementh.trin.cam.ac.uk) [127.0.0.1] 
	by mnementh.trin.cam.ac.uk with esmtp (Exim 1.92 #1)
	id 0yiDT9-0005f5-00 (Debian); Sat, 6 Jun 1998 08:32:51 +0100
To: linux@cthulhu.engr.sgi.com
Subject: Re: Some questions... 
In-reply-to: Your message of "Fri, 05 Jun 1998 17:25:03 PDT."
             <199806060025.RAA47789@oz.engr.sgi.com> 
Date: Sat, 06 Jun 1998 08:32:49 +0200
From: Peter Maydell <pm215@cam.ac.uk>
Message-Id: <E0yiDT9-0005f5-00@mnementh.trin.cam.ac.uk>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ariel Faigon wrote:
>	1) If you have the Indy (hardware) you already have
>	   the license for IRIX (for your own use)

Does this hold for earlier machines as well? I have a 4D/70GT with no
system software... 

While I'm here, I thought I'd look into the feasibility of porting
Linux to this machine. [In fact, I'm probably not going to have access
to the machine for long enough to work on it, but maybe somebody else
will. (the machine belongs to the Computer Preservation Society here in
Cambridge...)]

Anyway, points that spring to mind:
* the CPU is an R2000; I don't think any of the current ports are for
less than an R3000 -- does anybody know how different the R2000 is?

* without hardware documentation I suspect it will be impossible to get
anywhere. Every board seems to have a CPU on it :-> The ESDI and ethernet
boards both have 68000s, and the graphics board set has a 68020 complete
with debugging monitor you can access via a serial terminal, in addition
to all those custom chips...
Are SGI being helpful about providing documentation on the older hardware?

Peter Maydell
