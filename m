Received:  by oss.sgi.com id <S305169AbQA2Ae1>;
	Fri, 28 Jan 2000 16:34:27 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:12655 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305173AbQA2AeB>;
	Fri, 28 Jan 2000 16:34:01 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA01678; Fri, 28 Jan 2000 16:36:41 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA86559
	for linux-list;
	Fri, 28 Jan 2000 16:25:37 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA04715
	for <linux@engr.sgi.com>;
	Fri, 28 Jan 2000 16:25:35 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA00732
	for <linux@engr.sgi.com>; Fri, 28 Jan 2000 16:25:19 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-27.uni-koblenz.de (cacc-27.uni-koblenz.de [141.26.131.27])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA26431;
	Sat, 29 Jan 2000 01:25:08 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407896AbQA1U3J>;
	Fri, 28 Jan 2000 21:29:09 +0100
Date:   Fri, 28 Jan 2000 21:29:09 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: WCHAN on R3000
Message-ID: <20000128212909.A11816@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I've got bugreports which looks like get_wchan() is buggy.  For my machines
things look ok, so I assume only R3000 machines might be affected.  Anybody
seen the message ``Bug in get_wchan''?  Does the WCHAN column of ``ps axl''
look sane?

  Ralf
