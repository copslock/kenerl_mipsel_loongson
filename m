Received:  by oss.sgi.com id <S305163AbQEQD0W>;
	Wed, 17 May 2000 03:26:22 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:44293 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQEQD0I>;
	Wed, 17 May 2000 03:26:08 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id UAA04833; Tue, 16 May 2000 20:21:17 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id UAA83591; Tue, 16 May 2000 20:24:22 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA46643
	for linux-list;
	Tue, 16 May 2000 20:15:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA60331
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 May 2000 20:15:27 -0700 (PDT)
	mail_from (soren@gnyf.wheel.dk)
Received: from gnyf.wheel.dk (gnyf.wheel.dk [193.162.159.104]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA02993
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 May 2000 20:15:26 -0700 (PDT)
	mail_from (soren@gnyf.wheel.dk)
Received: (from soren@localhost)
	by gnyf.wheel.dk (8.9.1/8.9.1) id FAA21109;
	Wed, 17 May 2000 05:15:24 +0200 (CEST)
Date:   Wed, 17 May 2000 05:15:24 +0200
From:   "Soren S. Jorvang" <soren@wheel.dk>
To:     linux@cthulhu.engr.sgi.com
Subject: O2 ARCS
Message-ID: <20000517051524.A21067@gnyf.wheel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,

I seem to remember some dire warnings about the O2 ARCS PROM
needing special care and feeding to even do basic stuff. Am I
on crack?

FWIW, as a system console it works just for me as the Indy, at
least well enough to do PCI enumeration and play with NetBSD DDB.

Of course, there still isn't really any hardware documentation
beyond sys/mace.h and friends..


-- 
Soren
