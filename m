Received:  by oss.sgi.com id <S305165AbQBDJaI>;
	Fri, 4 Feb 2000 01:30:08 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:62566 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305160AbQBDJ3o>;
	Fri, 4 Feb 2000 01:29:44 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA03914; Wed, 2 Feb 2000 17:24:21 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA58570
	for linux-list;
	Wed, 2 Feb 2000 17:10:59 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA60366
	for <linux@engr.sgi.com>;
	Wed, 2 Feb 2000 17:10:57 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA07103
	for <linux@engr.sgi.com>; Wed, 2 Feb 2000 17:10:55 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-17.uni-koblenz.de (cacc-17.uni-koblenz.de [141.26.131.17])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id CAA20314;
	Thu, 3 Feb 2000 02:10:49 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407893AbQBCBKS>;
	Thu, 3 Feb 2000 02:10:18 +0100
Date:   Thu, 3 Feb 2000 02:10:18 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Indy crashes
Message-ID: <20000203021018.A25786@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Today I exchanged the R5000 CPU module in my Indy against a R4600 module
and found that on R4600SC the kernel runs reliable while it crashs pretty
soon after booting on a R5000SC module.  This is consistent with the
reports that I've looked at.

I'd appreciate some more reports from people who did upgrade from a
kernel older than 2.3.11 to 2.3.11 or newer.  Do you experience crashes
with the newer kernel?  What type of CPU are you using?

Thanks,

  Ralf
