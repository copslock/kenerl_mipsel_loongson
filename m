Received:  by oss.sgi.com id <S305163AbQBQKnz>;
	Thu, 17 Feb 2000 02:43:55 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:49235 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQBQKnf>;
	Thu, 17 Feb 2000 02:43:35 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA02731; Thu, 17 Feb 2000 02:39:03 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA19375
	for linux-list;
	Thu, 17 Feb 2000 02:33:51 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA60900
	for <linux@engr.sgi.com>;
	Thu, 17 Feb 2000 02:33:48 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA06218
	for <linux@engr.sgi.com>; Thu, 17 Feb 2000 02:33:52 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-23.uni-koblenz.de (cacc-23.uni-koblenz.de [141.26.131.23])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id LAA09185;
	Thu, 17 Feb 2000 11:33:39 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407916AbQBPSY1>;
	Wed, 16 Feb 2000 19:24:27 +0100
Date:   Wed, 16 Feb 2000 19:24:27 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: 32-bit MIPS with > 512mb mem
Message-ID: <20000216192427.A6330@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Is anybody using 32-bit MIPS CPUs which have more than 512mb of memory or
to be more exact have RAM that isn't accessible via the KSEG0 / KSEG1
window?

So far I haven't ever seen such a machine.  For 64-bit CPUs the right
thing to do is easy - use a 64-bit kernel.  But for 32-bit CPUs the Intel
highmem stuff in the memory managment now gives us a sane way to use
the memory of such configuration with just a little bit of extra code.

So if anybody wants support for such a configuration, please drop me a
note.

Thanks,

  Ralf
