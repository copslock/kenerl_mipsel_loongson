Received:  by oss.sgi.com id <S305163AbQDLSgi>;
	Wed, 12 Apr 2000 11:36:38 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:56600 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305161AbQDLSgY>;
	Wed, 12 Apr 2000 11:36:24 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA19100; Wed, 12 Apr 2000 11:31:41 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id LAA83710; Wed, 12 Apr 2000 11:34:38 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA83362
	for linux-list;
	Wed, 12 Apr 2000 11:22:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA90563
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 12 Apr 2000 11:22:05 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA04308
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Apr 2000 11:22:04 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id CAC657F4; Wed, 12 Apr 2000 20:22:01 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 45EBC8FDF; Wed, 12 Apr 2000 20:18:30 +0200 (CEST)
Date:   Wed, 12 Apr 2000 20:18:29 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Cc:     linux-kernel@vger.rutgers.edu
Subject: sgiserial.c / rs_init invoke ?
Message-ID: <20000412201829.A451@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
i am currently digging deeper into sgiserial.c and friends.
My problem right now is that i dont understand when and how the
rs_init should and will be called - Currently i have an
__initcall(rs_init) in arch/mips/sgi/kernel/setup.c which is definitly
wrong - But should this be invoked - I cant find how i386 does this
(Could somebody enlighten me what module_init(rs_init) in
drivers/char/serial.c does ?)

Currently i have problems switching from serial_console to tty code
for userspace - I see sgiserial.c receiving transmit fifo empty
IRQs and i see filling the fifo but i dont see any chars although
i see chars with serial_console :(

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
