Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA09400
	for <pstadt@stud.fh-heilbronn.de>; Wed, 7 Jul 1999 01:39:33 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA15105; Tue, 6 Jul 1999 16:37:30 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA78491
	for linux-list;
	Tue, 6 Jul 1999 16:35:04 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA86708
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 6 Jul 1999 16:35:01 -0700 (PDT)
	mail_from (owner-linux@neteng.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA40520 for <linux@neteng.engr.sgi.com>; Tue, 6 Jul 1999 16:34:56 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA46429
	for <linux@neteng.engr.sgi.com>;
	Tue, 6 Jul 1999 16:34:55 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04202
	for <linux@neteng.engr.sgi.com>; Tue, 6 Jul 1999 16:34:52 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-28.uni-koblenz.de [141.26.131.28])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA00643
	for <linux@neteng.engr.sgi.com>; Wed, 7 Jul 1999 01:34:43 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id BAA01736;
	Wed, 7 Jul 1999 01:34:03 +0200
Date: Wed, 7 Jul 1999 01:34:01 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Ivan Leong <ivanl@pacific.net.sg>
Cc: linux@neteng.engr.sgi.com
Subject: Re: where's dhcp_bootp?
Message-ID: <19990707013401.C1630@uni-koblenz.de>
References: <NDBBJCODHKOEMPLCNOFGAEKNCBAA.ivanl@pacific.net.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <NDBBJCODHKOEMPLCNOFGAEKNCBAA.ivanl@pacific.net.sg>; from Ivan Leong on Tue, Jul 06, 1999 at 09:38:24PM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jul 06, 1999 at 09:38:24PM +0800, Ivan Leong wrote:

> i've two indies and right in the midst of getting
> linux on it off the net.
> 
> both indies are on irix 5.3 and it's bootp
> doesn't work correctly. i believe a dhcp_bootp
> is needed but where can i find such a beast?

IRIX bootp definately works, it unfortunately just has a different
configfile from Linux's bootp.

The bootp daemon usually used with Linux build and works just perfect
under IRIX (6.5 in my case), so just rip of the sources from some
Linux distribution.  I uses RH 6.0 in my case, btw.

  Ralf
