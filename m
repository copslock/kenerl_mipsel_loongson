Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id QAA19308
	for <pstadt@stud.fh-heilbronn.de>; Wed, 4 Aug 1999 16:03:13 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA05438; Wed, 4 Aug 1999 06:58:05 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA21276
	for linux-list;
	Wed, 4 Aug 1999 06:52:55 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA41779
	for <linux@engr.sgi.com>;
	Wed, 4 Aug 1999 06:52:51 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA00460
	for <linux@engr.sgi.com>; Wed, 4 Aug 1999 06:50:25 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-17.uni-koblenz.de [141.26.131.17])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id PAA16383
	for <linux@engr.sgi.com>; Wed, 4 Aug 1999 15:39:00 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id PAA15054;
	Wed, 4 Aug 1999 15:38:00 +0200
Date: Wed, 4 Aug 1999 15:38:00 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Tseng Chou Ming <kevin@idns.gv.com.tw>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: howdy
Message-ID: <19990804153800.A15002@uni-koblenz.de>
References: <199908040808.QAA02722@idns.gv.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <199908040808.QAA02722@idns.gv.com.tw>; from Tseng Chou Ming on Wed, Aug 04, 1999 at 04:08:49PM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Aug 04, 1999 at 04:08:49PM +0800, Tseng Chou Ming wrote:

> howdy, how can i prepare a cross-development environment
> for decstation-linux on host i386-linux?
> to make dynamic/static librarys 
> and basic applications of "/sbin" & "/bin"
> like "/sbin/init" , etc..
> thx in advanced!:)

Try avoiding crossc-compilation if possible ...  Crosscompiler & linker
binaries are available on ftp.linux.sgi.com just like all the native
binaries & source you might need.

  Ralf
