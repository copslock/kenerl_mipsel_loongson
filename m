Received:  by oss.sgi.com id <S305161AbQAVXkM>;
	Sat, 22 Jan 2000 15:40:12 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:23917 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305157AbQAVXjv>; Sat, 22 Jan 2000 15:39:51 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA08212; Sat, 22 Jan 2000 15:44:29 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA77034
	for linux-list;
	Sat, 22 Jan 2000 15:27:00 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA90495
	for <linux@engr.sgi.com>;
	Sat, 22 Jan 2000 15:26:58 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA04344
	for <linux@engr.sgi.com>; Sat, 22 Jan 2000 15:26:45 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-24.uni-koblenz.de (cacc-24.uni-koblenz.de [141.26.131.24])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id AAA21451;
	Sun, 23 Jan 2000 00:26:32 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQAVPvs>;
	Sat, 22 Jan 2000 16:51:48 +0100
Date:   Sat, 22 Jan 2000 16:51:48 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: IP22 and lots of memory
Message-ID: <20000122165148.A15183@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Some SGI IP22 systems which have more than a certain critical amount of
memory will overwrite firmware data structures which will result in
a crash when the sgiseeq Ethernet driver initializes.  With the 32-bit
kernel the critical amount of memory is somewhere between 128mb and 192mb
of memory; for the 64-bit kernel just half of it.  This will be fixed
in 2.3.23.

  Ralf
