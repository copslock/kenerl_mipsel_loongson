Received:  by oss.sgi.com id <S305164AbQCXNLQ>;
	Fri, 24 Mar 2000 05:11:16 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:15995 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQCXNLD>;
	Fri, 24 Mar 2000 05:11:03 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id FAA26690; Fri, 24 Mar 2000 05:06:24 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id FAA48369; Fri, 24 Mar 2000 05:10:32 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA96139
	for linux-list;
	Fri, 24 Mar 2000 04:47:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA72084
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 24 Mar 2000 04:47:38 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA08134
	for <linux@cthulhu.engr.sgi.com>; Fri, 24 Mar 2000 04:47:34 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6C9CF7FB; Fri, 24 Mar 2000 13:47:22 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A742E8FC3; Fri, 24 Mar 2000 13:43:15 +0100 (CET)
Date:   Fri, 24 Mar 2000 13:43:15 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: Decstation 5000/150 2.3.99pre2/ still login problems
Message-ID: <20000324134315.A6208@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,
still the same problems - since the mid 2.3.4x kernels i cant
log into my decstation 5000 - It seems the pseudo tty code
is non functional.

An telnet or "ssh" causes the connection to close if requesting a tty.

(flo@ping)~# ssh root@repeat.rfc822.org sh
root@repeat.rfc822.org's password: 
Warning: Remote host denied X11 forwarding, perhaps xauth program could not be run on the server side.
uname -a
Linux 193.189.250.44 2.3.99-pre2 #1 Fri Mar 24 13:12:06 CET 2000 mips unknown
tty
not a tty
cat /proc/devices
Character devices:
  1 mem
  2 pty/m%d
  3 pty/s%d
  4 ttyS
  5 cua
 10 misc
162 raw

Block devices:
  7 loop
  8 sd
 65 sd
 66 sd

cat /proc/tty/drivers
pty_slave            /dev/pty/s%d    3   0-255 pty:slave
pty_master           /dev/pty/m%d    2   0-255 pty:master
unknown              /dev/cua        5   64-67 serial:callout
unknown              /dev/ttyS       4   64-67 serial
/dev/console         /dev/console    5       1 system:console
/dev/tty             /dev/tty        5       0 system:/dev/tty


I have compiled the kernel without PTY98 support:

# CONFIG_UNIX98_PTYS is not set
# CONFIG_DEVPTS_FS is not set


This looks a bit different:


(root@193)~# uname -a
Linux 193.189.250.44 2.3.21 #1 Tue Jan 4 18:39:20 GMT 2000 mips unknown
(root@193)~# cat /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
 10 misc
162 raw

Block devices:
  8 sd
(root@193)~# cat /proc/tty/drivers
pty_slave            /dev/ttyp       3   0-255 pty:slave
pty_master           /dev/pty        2   0-255 pty:master
unknown              /dev/cua        5   64-67 serial:callout
unknown              /dev/ttyS       4   64-67 serial
/dev/console         /dev/console    5       1 system:console
/dev/tty             /dev/tty        5       0 system:/dev/tty

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
