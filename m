Received:  by oss.sgi.com id <S305194AbQDBSBg>;
	Sun, 2 Apr 2000 11:01:36 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:23373 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305164AbQDBSBW>;
	Sun, 2 Apr 2000 11:01:22 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA07928; Sun, 2 Apr 2000 10:56:40 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA56054
	for linux-list;
	Sun, 2 Apr 2000 10:51:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA25770
	for <linux@engr.sgi.com>;
	Sun, 2 Apr 2000 10:51:27 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA03458
	for <linux@engr.sgi.com>; Sun, 2 Apr 2000 10:51:26 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-2.uni-koblenz.de (cacc-2.uni-koblenz.de [141.26.131.2])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id TAA01621;
	Sun, 2 Apr 2000 19:51:17 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S407778AbQDBRu6>;
	Sun, 2 Apr 2000 19:50:58 +0200
Date:   Sun, 2 Apr 2000 19:50:58 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: New glibc release
Message-ID: <20000402195057.A13982@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

The package and a patch can be downloaded from oss.sgi.com in
/pub/linux/mips/test-glibc/.  Two additional notes over what has already
been mentioned in other postings.  First, somebody else has made a libc
release without telling me, that one has a higher version number this
release even though it's older.  I don't know about the differences.
Second I changed rpm again such that it uses *.mips.rpm, not mipseb.rpm
als package extension.  This will make the assumption from many spec
files that $RPM_ARCH-linux is a valid GNU-style architecture descriptor
true also for big endian MIPS.  This did eleminate most of the
necessity to change spec files for big endian MIPS.  Anyway, that's
why the binary rpm packages again have the .mips.rpm extension.

  Ralf
