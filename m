Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Nov 2002 18:52:41 +0100 (CET)
Received: from noose.gt.owl.de ([62.52.19.4]:6929 "HELO noose.gt.owl.de")
	by linux-mips.org with SMTP id <S1123966AbSKQRwk>;
	Sun, 17 Nov 2002 18:52:40 +0100
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 5FD34847; Sun, 17 Nov 2002 18:52:29 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 46A21B2A7; Sun, 17 Nov 2002 18:52:17 +0100 (CET)
Date: Sun, 17 Nov 2002 18:52:17 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@linux-mips.org
Subject: loadavg calculation current cvs
Message-ID: <20021117175217.GA23404@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Could it be that somethings broken ? Although the machine is=20
idle after booting the load is automatically at 1 - Some process
is getting counted in the loadavg although it shouldnt. This is 2.4cvs
2 days old.

remake:~# vmstat 1 10
   procs                      memory    swap          io     system        =
 cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy=
  id
 0  0  1      0  20092   9476  86636   0   0    37    24   10   206   2   3=
  94
 0  0  1      0  20092   9476  86636   0   0     0     0    7   205   0   0=
 100
 0  0  1      0  20092   9476  86636   0   0     0     0    9   206   0   1=
  99
 0  0  1      0  20092   9476  86636   0   0     0     0   12   205   0   1=
  99
 0  0  1      0  20084   9484  86636   0   0     0    48   11   202   3   9=
  88
 0  0  1      0  20084   9484  86636   0   0     0     0    8   206   0   1=
  99
 0  0  1      0  20084   9484  86636   0   0     0     0    9   206   0   1=
  99
 0  0  1      0  20084   9484  86636   0   0     0     0   10   205   0   1=
  99
 0  0  1      0  20084   9484  86636   0   0     0     0   11   205   0   1=
  99
 0  0  1      0  20076   9492  86636   0   0     0    48    9   202   3   9=
  88
remake:~# uptime
 18:47:00 up 51 min,  1 user,  load average: 1.10, 1.13, 1.01
remake:~# ps auxw
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.4  1988  600 ?        S    17:55   0:01 init
root         2  0.0  0.0     0    0 ?        SW   17:55   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        RWN  17:55   0:00 [ksoftirqd_C=
PU0]
root         4  0.0  0.0     0    0 ?        SW   17:55   0:00 [kswapd]
root         5  0.0  0.0     0    0 ?        SW   17:55   0:00 [bdflush]
root         6  0.0  0.0     0    0 ?        SW   17:55   0:00 [kupdated]
root         7  0.0  0.0     0    0 ?        SW   17:55   0:00 [kjournald]
root       134  0.0  0.6  2520  880 ?        S    17:55   0:00 /sbin/dhclie=
nt-2.2.x -q eth0
root      1611  0.0  0.5  2320  696 ?        S    17:55   0:00 /sbin/syslogd
root      1614  0.0  0.7  2372  984 ?        S    17:55   0:00 /sbin/klogd
root      1622  0.0  0.4  2276  628 ?        S    17:55   0:00 /usr/sbin/in=
etd
root      1626  0.0  0.4  1976  532 ?        S    17:55   0:00 /usr/sbin/sm=
artd
root      1642  0.0  1.1  6356 1492 ?        S    17:55   0:02 /usr/sbin/ss=
hd
daemon    1646  0.0  0.5  2652  716 ?        S    17:55   0:00 /usr/sbin/atd
root      1651  0.0  0.6  3700  836 ?        S    17:55   0:00 /usr/sbin/cr=
on
root      1655  0.0  1.0  4420 1384 ?        S    17:55   0:00 /bin/sh /usr=
/local/sbin/display
root      2598  0.0  0.4  1956  576 ttyS0    S    18:09   0:00 /sbin/getty =
57600 ttyS0 vt100
root      4039  0.1  1.7 12192 2236 ?        S    18:40   0:00 /usr/sbin/ss=
hd
root      4045  0.0  1.2  4472 1656 pts/0    S    18:40   0:00 -bash
root      4711  1.0  0.4  3452  584 ?        S    18:50   0:00 sleep 5
root      4712  0.0  1.0  4656 1372 pts/0    R    18:50   0:00 ps auxw
remake:~# cat /proc/cpuinfo
system type             : MQ Pro
processor               : 0
cpu model               : R5000 V4.0  FPU V1.0
BogoMIPS                : 249.85
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 48
extra interrupt vector  : no
hardware watchpoint     : no
VCED exceptions         : not available
VCEI exceptions         : not available
remake:~# uname -a
Linux remake.rfc822.org 2.4.20-pre6 #1 Fri Nov 15 23:16:01 CET 2002 mips un=
known

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE919dRUaz2rXW+gJcRAtoPAKCU452GYLDVzJuVpgQX2I0XRZTDkgCghGLU
jWxzdVA3+UhVUxL32lrl7U8=
=FeZ2
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
