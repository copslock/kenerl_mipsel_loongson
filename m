Received:  by oss.sgi.com id <S305198AbQDBMMO>;
	Sun, 2 Apr 2000 05:12:14 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:20016 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305164AbQDBML4>; Sun, 2 Apr 2000 05:11:56 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA01174; Sun, 2 Apr 2000 05:15:39 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA26988
	for linux-list;
	Sun, 2 Apr 2000 01:32:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA19247
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 2 Apr 2000 01:32:41 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA09429
	for <linux@cthulhu.engr.sgi.com>; Sun, 2 Apr 2000 01:28:00 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D56187F3; Sun,  2 Apr 2000 11:19:20 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 735478FC3; Sun,  2 Apr 2000 11:09:10 +0200 (CEST)
Date:   Sun, 2 Apr 2000 11:09:10 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: current boot mileage with cvs on indigo2
Message-ID: <20000402110910.C9189@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ok,
after i probably fixed the prom_console that far that i get some useful
output the kernel halts for me nearly direct after prom_console init

I get something like the normal kernel output
(Which is buffered from before console init)
and then 

"On node 0 totalpages: 65413" and stop

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
