Received:  by oss.sgi.com id <S305170AbQAUCkH>;
	Thu, 20 Jan 2000 18:40:07 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:56339 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305167AbQAUCkD>;
	Thu, 20 Jan 2000 18:40:03 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA01455; Thu, 20 Jan 2000 18:41:48 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA09181
	for linux-list;
	Thu, 20 Jan 2000 18:10:25 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA90940
	for <linux@engr.sgi.com>;
	Thu, 20 Jan 2000 18:10:21 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA04793
	for <linux@engr.sgi.com>; Thu, 20 Jan 2000 18:10:17 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-8.uni-koblenz.de (cacc-8.uni-koblenz.de [141.26.131.8])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id DAA28772;
	Fri, 21 Jan 2000 03:10:10 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQAUCH4>;
	Fri, 21 Jan 2000 03:07:56 +0100
Date:   Fri, 21 Jan 2000 03:07:56 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: paccess.h & dbe exception
Message-ID: <20000121030755.A15497@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

In <asm/paccess.h> I've provided a set of get_user / put_user like functions
that are protecting against DBE exceptions just like get_user / put_user
are protecting against ``normal'' types of page faults.  Unlike their
*_user counterparts there is no verify_area equivalent - the kernel is
supposed to know what addresses it is using.  These routines are useful
to implement things like hardware detection routines.  Or like on the
Origin where I needed them to protect the PCI code against accesses to
the configuration space of non-existant devices.  For now the code only
exists for MIPS64 / IP27 but it'll be easy to port.

  Ralf
