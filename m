Received:  by oss.sgi.com id <S305162AbQA2XPJ>;
	Sat, 29 Jan 2000 15:15:09 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:60953 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305160AbQA2XOw>; Sat, 29 Jan 2000 15:14:52 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA00582; Sat, 29 Jan 2000 15:20:12 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA98251
	for linux-list;
	Sat, 29 Jan 2000 15:07:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA06946
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 29 Jan 2000 15:07:04 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA05624
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Jan 2000 15:07:00 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 3701E80D; Sun, 30 Jan 2000 00:06:55 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 820638FC4; Sat, 29 Jan 2000 23:33:25 +0100 (CET)
Date:   Sat, 29 Jan 2000 23:33:25 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: WCHAN on R3000
Message-ID: <20000129233325.I1329@paradigm.rfc822.org>
References: <20000128212909.A11816@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000128212909.A11816@uni-koblenz.de>; from Ralf Baechle on Fri, Jan 28, 2000 at 09:29:09PM +0100
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Jan 28, 2000 at 09:29:09PM +0100, Ralf Baechle wrote:
> I've got bugreports which looks like get_wchan() is buggy.  For my machines
> things look ok, so I assume only R3000 machines might be affected.  Anybody
> seen the message ``Bug in get_wchan''?  Does the WCHAN column of ``ps axl''
> look sane?

I think i already reported this ..

------[dmesg output]------------------------------
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Setting flush to zero for dpkg-source.
Unimplemented exception for insn 4620a0a4 at 0x0046f084 in dpkg-source.
Should send SIGFPE to dpkg-source
Setting flush to zero for dpkg-source.
Unimplemented exception for insn 4620a0a4 at 0x0046f084 in dpkg-source.
Should send SIGFPE to dpkg-source
Setting flush to zero for dpkg-source.
Unimplemented exception for insn 4620a0a4 at 0x0046f084 in dpkg-source.
Should send SIGFPE to dpkg-source
------------------------------------------

------------------------------------------
(root@repeat)~# cat /proc/cpuinfo 
cpu                     : MIPS
cpu model               : R4000SC V3.0
system type             : Digital DECstation 5000/1xx
BogoMIPS                : 49.81
byteorder               : little endian
unaligned accesses      : 0
wait instruction        : no
microsecond timers      : yes
extra interrupt vector  : no
hardware watchpoint     : yes
VCED exceptions         : 750604
VCEI exceptions         : 4523546
(root@repeat)~# uname -a
Linux repeat 2.3.21 #1 Tue Jan 4 18:39:20 GMT 2000 mips unknown
------------------------------------

I dont know if you call this "sane" ...

-------------------------------
(root@repeat)~# ps axl
Unknown HZ value! (0) Assume 100.
  F   UID   PID  PPID PRI  NI   VSZ  RSS  WCHAN STAT TTY        TIME COMMAND
  100     0     1     0   0   0  1244  472  5a748 S    ?          0:15 init
  040     0     2     1   0   0     0    0  5a748 SW   ?          0:01 [kswapd]
  040     0     3     1   0   0     0    0  5a748 SW   ?          0:01 [kflushd]
  140     0   105     1   0   0  3772  828  5a6e0 S    ?          0:24 /usr/sbin/s
  140     0   113     1   0   0  1556  536  5a6e0 S    ?          0:04 syslogd
  140     0   120     1   0   0  1264  472  5ebb0 S    ?          0:00 klogd
  140     0   129     1   0   0  1524  468  5a6e0 S    ?          0:00 inetd
  140     0   142     1   0   0  1192  280  5a748 S    ?          0:12 update (bdf
  100     0   300     1   0   0  2612  720  5a748 S    ?          0:07 /usr/lib/po
  100   502   302   300   0   0  2716  824  5a748 S    ?          0:00 qmgr -l -t 
  100     0 17438     1   0   0  1624  584  5a748 S    ?          0:00 /sbin/mgett
  100   502 17439   300   0   0  2648  688  5a748 S    ?          0:00 pickup -l -
  140     0 17442   105   0   0  6080 1452  5a748 S    ?          0:01 /usr/sbin/s
  100     0 17444 17442   0   0  3232 1324  64a2c S    ttyp0      0:01 -bash
  100     0 17452 17444   0   0  3028  728      - R    ttyp0      0:00 ps axl
-------------------------------

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
