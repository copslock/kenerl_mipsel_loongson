Received:  by oss.sgi.com id <S305163AbQESPIz>;
	Fri, 19 May 2000 15:08:55 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:23634 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305155AbQESPIh>;
	Fri, 19 May 2000 15:08:37 +0000
Received: from cthulhu.engr.sgi.com ([192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA03128; Fri, 19 May 2000 07:57:41 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA30299
	for linux-list;
	Fri, 19 May 2000 07:31:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA29846
	for <linux@engr.sgi.com>;
	Fri, 19 May 2000 07:31:34 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA00503
	for <linux@engr.sgi.com>; Fri, 19 May 2000 07:31:32 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-21.uni-koblenz.de (cacc-21.uni-koblenz.de [141.26.131.21])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id QAA15892;
	Fri, 19 May 2000 16:31:24 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1405596AbQESLSC>;
	Fri, 19 May 2000 13:18:02 +0200
Date:   Fri, 19 May 2000 13:18:02 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20000519131802.B1244@uni-koblenz.de>
References: <20000519083237Z305155-391+603@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000519083237Z305155-391+603@oss.sgi.com>; from flo@oss.sgi.com on Fri, May 19, 2000 at 08:32:31AM +0000
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, May 19, 2000 at 08:32:31AM +0000, Florian Lohoff wrote:

> Log message:
> 	Let tty_io.c call init_serial_console (CONFIG_SERIAL vs. CONFIG_SGI_SERIAL)

Which reminds me that sgiserial.c and serial.c have a namespace collison
that's actually relevant in certain configurations.  I'll prepare a fix.

  Ralf
