Received:  by oss.sgi.com id <S305184AbPLITHN>;
	Thu, 9 Dec 1999 11:07:13 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:59762 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305163AbPLITG4>;
	Thu, 9 Dec 1999 11:06:56 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA05983; Thu, 9 Dec 1999 11:13:56 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA58565
	for linux-list;
	Thu, 9 Dec 1999 11:04:14 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA74290
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Dec 1999 11:03:28 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA08924
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Dec 1999 11:03:19 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407732AbPLITCJ>;
	Thu, 9 Dec 1999 17:02:09 -0200
Date:   Thu, 9 Dec 1999 17:02:09 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Snapshot
Message-ID: <19991209170209.A21723@uni-koblenz.de>
References: <19991206214429.T765@uni-koblenz.de> <19991209164908.A3212@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <19991209164908.A3212@paradigm.rfc822.org>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Dec 09, 1999 at 04:49:08PM +0100, Florian Lohoff wrote:

> On Mon, Dec 06, 1999 at 09:44:29PM -0200, Ralf Baechle wrote:
> > I've put a snapshot of current CVS kernel sources into
> > oss.sgi.com:/pub/linux/mips/src/kernel/linux-19991206.tar.gz.
> 
> Short resume:
> 
> Doesnt work on Decstation 5000/150 Mips R4000 ...
> Reboots immediatly after end of tftp download ...
> 
> KN04 V2.1k    (PC: 0x8005c044, SP: 0x838a9de0)
> 
> -tftp boot(3), bootp 193.189.250.46:/boot/vmlinux-2.3.21-decR4k.ecoff
> -tftp load 1222624+0+369568
> 
> KN04 V2.1k    (PC: 0x8005c044, SP: 0x80047f78)
> 
> -tftp boot(3), bootp 193.189.250.46:/boot/vmlinux-2.3.21-decR4k.ecoff
> -tftp load 1222624+0+369568

The CVS now has a couple of fixes, could you retry?

  Ralf
