Received:  by oss.sgi.com id <S305195AbQD1MxK>;
	Fri, 28 Apr 2000 05:53:10 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:30518 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305175AbQD1MxI>; Fri, 28 Apr 2000 05:53:08 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA04212; Fri, 28 Apr 2000 05:57:19 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA94490
	for linux-list;
	Fri, 28 Apr 2000 05:41:05 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA76742
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Apr 2000 05:40:59 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA03754
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Apr 2000 05:40:43 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 1845481F; Fri, 28 Apr 2000 14:40:33 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id DD2618FFD; Fri, 28 Apr 2000 14:28:21 +0200 (CEST)
Date:   Fri, 28 Apr 2000 14:28:21 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: serial_console_init 
Message-ID: <20000428142821.D2891@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
serial_console_init is currently only called when CONFIG_SERIAL AND
CONFIG_SERIAL_CONSOLE is defined as shown in drivers/char/tty_io.c

   2189 #ifdef CONFIG_SERIAL_CONSOLE
   2190 #ifdef CONFIG_8xx
   2191         console_8xx_init();
   2192 #elif defined(CONFIG_SERIAL)
   2193         serial_console_init();
   2194 #endif /* CONFIG_8xx */
   2195 #if defined(CONFIG_MVME162_SCC) || defined(CONFIG_BVME6000_SCC) || defined(CONFIG_MVME147_SCC)
   2196         vme_scc_console_init();
   2197 #endif
   2198 #if defined(CONFIG_SERIAL167)
   2199         serial167_console_init();
   2200 #endif
   2201 #endif

As we changed CONFIG_SERIAL to CONFIG_SGI_SERIAL this NEVER gets
true whereas serial_console_init() never gets called.

What would be the correct way to go - Just append a || defined(CONFIG_SGI_SERIAL) ?

Or the other way round - Change CONFIG_SGI_SERIAL to CONFIG_SERIAL
and exclude building serial.c -> serial.o in the drivers/char/Makefile ...

Ill do it if somebody (Ralf?) gives me some hints ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
