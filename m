Received:  by oss.sgi.com id <S305176AbQDDAUJ>;
	Mon, 3 Apr 2000 17:20:09 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:4663 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305168AbQDDATx>; Mon, 3 Apr 2000 17:19:53 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA09297; Mon, 3 Apr 2000 17:23:37 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id RAA78397; Mon, 3 Apr 2000 17:19:52 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA52465
	for linux-list;
	Mon, 3 Apr 2000 17:05:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA17339
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 3 Apr 2000 17:05:29 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA06951
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 Apr 2000 17:05:28 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id EF7E77D9; Tue,  4 Apr 2000 02:05:28 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id D91D28FC3; Tue,  4 Apr 2000 01:54:30 +0200 (CEST)
Date:   Tue, 4 Apr 2000 01:54:30 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: kernel hang indigo2 current cvs more specific
Message-ID: <20000404015430.E275@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Ok,
i debugged a bit arround and found that the current CVS kernel
hang at "alloc_page.c" (For SGI_IP22)

        lmem_map = (struct page *) alloc_bootmem_node(nid, map_size);

I had a small look into the function alloc_bootmem_node/core but didnt
understand a word.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
