Received:  by oss.sgi.com id <S305243AbQCaSOv>;
	Fri, 31 Mar 2000 10:14:51 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:25426 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305239AbQCaSOp>; Fri, 31 Mar 2000 10:14:45 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA01149; Fri, 31 Mar 2000 10:18:25 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA13048
	for linux-list;
	Fri, 31 Mar 2000 09:57:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA03847
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 31 Mar 2000 09:57:12 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA09344
	for <linux@cthulhu.engr.sgi.com>; Fri, 31 Mar 2000 09:57:09 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 7E3F27D9; Fri, 31 Mar 2000 19:57:07 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 709BD8FC3; Fri, 31 Mar 2000 19:45:26 +0200 (CEST)
Date:   Fri, 31 Mar 2000 19:45:26 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: kernel for indigo2
Message-ID: <20000331194525.A20241@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,
i recently (a couple of days ago) got an Indigo2 Impact and i thought
of beginning to bootstrap debian-mips (I already have >900 Package for
debian-mipsel) but i cant even boot a kernel. The standard (and old)
kernel on oss.sgi.com simple halt the machine after tftp boot - When
building a kernel from the current CVS the machine
crashes with a UTLB Miss as mentioned in the MIPS-FAQ as the 
-N binutils bugs although there is no -N in the makefile.

Does anyone have a working kernel for the Indigo2 ?

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
