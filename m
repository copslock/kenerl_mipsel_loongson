Received:  by oss.sgi.com id <S305163AbQCSVRe>;
	Sun, 19 Mar 2000 13:17:34 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:50959 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCSVRI>; Sun, 19 Mar 2000 13:17:08 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA07131; Sun, 19 Mar 2000 13:20:36 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA71951
	for linux-list;
	Sun, 19 Mar 2000 12:45:56 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA35870
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 19 Mar 2000 12:45:47 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA06704
	for <linux@cthulhu.engr.sgi.com>; Sun, 19 Mar 2000 12:45:46 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D7C6C7F6; Sun, 19 Mar 2000 21:45:44 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A4F578FC3; Sun, 19 Mar 2000 21:45:10 +0100 (CET)
Date:   Sun, 19 Mar 2000 21:45:10 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: header files state
Message-ID: <20000319214510.B1365@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,
I am currently trying to waste some cpu cycles with blindly compiling
packages instead of leaving the machine idle.

Most of the packages (~1/3) fail because of the already discussed problems
with the headers.

gcc -c  -g -O2 -Wall  -MD  -DHAVE_SYS_SELECT_H -DFLICK_VERSION=\"2.1\" -I. -I../
../../../runtime/libraries/link/iiop -I- -I../../../../runtime/headers -I../../.
./../runtime/headers -I../../../../runtime/libraries/link -I../../../.. -I../../
../..  communication.c
communication.c: In function `flick_client_send_request':
communication.c:390: `SOCK_STREAM' undeclared (first use this function)
communication.c:390: (Each undeclared identifier is reported only once
communication.c:390: for each function it appears in.)


gcc -O2 -g -I. -DHAVE_CONFIG_H -DPREFIX=\"/usr\"  -c -o additional.o additional.
c
In file included from /usr/include/sys/resource.h:27,
                 from additional.c:14:
/usr/include/resourcebits.h:103: warning: `RLIM_INFINITY' redefined
/usr/include/asm/resource.h:32: warning: this is the location of the previous de
finition
In file included from /usr/include/sys/resource.h:27,
                 from additional.c:14:
/usr/include/resourcebits.h:102: parse error before `0x7fffffffUL'


I am unsure where the problem is located exactly and how to fix it
correctly - So probably somebody else more knowledged and timely equipped
might fix this in the CVS (probably it is alread fixed ? - My CVS kernel
is 3-5 days old)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
