Received:  by oss.sgi.com id <S305162AbQBLA2V>;
	Fri, 11 Feb 2000 16:28:21 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:54039 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305161AbQBLA2A>; Fri, 11 Feb 2000 16:28:00 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA03693; Fri, 11 Feb 2000 16:30:48 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA90277
	for linux-list;
	Fri, 11 Feb 2000 16:17:28 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA35941
	for <linux@engr.sgi.com>;
	Fri, 11 Feb 2000 16:17:21 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04422
	for <linux@engr.sgi.com>; Fri, 11 Feb 2000 16:17:13 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-30.uni-koblenz.de (cacc-30.uni-koblenz.de [141.26.131.30])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA11938;
	Sat, 12 Feb 2000 01:17:07 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407894AbQBLAQ2>;
	Sat, 12 Feb 2000 01:16:28 +0100
Date:   Sat, 12 Feb 2000 01:16:28 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: 2.2 kernel fixes
Message-ID: <20000212011628.A19790@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I've fixed a number of bugs into the 2.2 branch.  At least one of them
seems to be significant, so I've put a new kernel binary for the Indy
as /pub/linux/mips/test/vmlinux-2.2.13-20000211.tar.bz2 and a new
source snapshot on oss.sgi.com.

  Ralf
