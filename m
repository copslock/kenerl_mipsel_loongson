Received: (from majordomo@localhost)
	by oss.sgi.com (8.9.3/8.9.3) id CAA22214
	for linuxmips-outgoing; Thu, 28 Oct 1999 02:20:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linuxmips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.9.3/8.9.3) with ESMTP id CAA22211
	for <linuxmips@oss.sgi.com>; Thu, 28 Oct 1999 02:20:04 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA01758
	for <linuxmips@oss.sgi.com>; Thu, 28 Oct 1999 02:20:05 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA36139
	for linux-list;
	Thu, 28 Oct 1999 02:00:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA13090
	for <linux@engr.sgi.com>;
	Thu, 28 Oct 1999 02:00:11 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA5532448
	for <linux@engr.sgi.com>; Thu, 28 Oct 1999 02:00:01 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 7B2627F6; Thu, 28 Oct 1999 11:00:00 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 0A329902A; Thu, 28 Oct 1999 10:59:14 +0200 (CEST)
Date: Thu, 28 Oct 1999 10:59:13 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: asm/timex.h include mipsregs.h ?
Message-ID: <19991028105913.A1254@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk

Hi,
i am just in the process of building glibc and discovered a bug i stumpled
over before ...

static inline cycles_t get_cycles (void)
{
        return read_32bit_cp0_register(CP0_COUNT);
}

CP0_COUNT undefined ...

Shouldnt timex.h include mipsregs.h ?

And is this possibly fixed in later Kernels (this is 2.2.1) 

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
  ...  The failure can be random; however, when it does occur, it is
  catastrophic and is repeatable  ...             Cisco Field Notice
