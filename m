Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0B21eB04782
	for linux-mips-outgoing; Thu, 10 Jan 2002 18:01:40 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0B21Wg04779
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 18:01:32 -0800
Message-Id: <200201110201.g0B21Wg04779@oss.sgi.com>
Received: (qmail 16542 invoked from network); 11 Jan 2002 00:57:44 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 11 Jan 2002 00:57:44 -0000
Date: Fri, 11 Jan 2002 8:58:15 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Florian Lohoff <flo@rfc822.org>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: LTP tests / Crash :)
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g0B21Yg04780
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,Florian Lohoff£¬

 i have noticed that a while ago and send ralf and fix,he
make his own fix in current cvs.

 My ltp runs turns out a number of failures,the one worry me
most are the filesystem corrupts(mmap write?),but i had no time
to follow them currently.

ÔÚ 2002-01-11 00:49:00 you wrote£º
>Hi,
>i am just trying to run the LTP (Linux Test Project -> ltp.sf.net) 
>on a 2.4.16 SGI/Indy and it seems to crash reproducable :)
>
><<<test_start>>>
>tag=getpeername01 stime=1010706641
>cmdline="getpeername01"
>contacts=""
>analysis=exit
>initiation_status="ok"
><<<test_output>>>
>
>On 2 different machines - Running both 2.4.16 Debian/Sid and
>Debian/Woody - I will try to gather the oops - But it seems we should
>take the LTP for regular regression tests :)
>
>Crashes are:
>
>Kernel unaligned instruction access in unaligned.c:do_ade, line 397
>
>and
>
>Unhandled kernel unaligned access in unaligned.c:emulate_load_store_isns, line 342
>
>Flo
>-- 
>Florian Lohoff                  flo@rfc822.org             +49-5201-669912
>Nine nineth on september the 9th              Welcome to the new billenium
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.0.6 (GNU/Linux)
>Comment: For info see http://www.gnupg.org
>
>iD8DBQE8PihvUaz2rXW+gJcRAtn5AJ9l7VzQ9wi3rHXgbRLnp6TGxkkW3gCeIgTF
>Cqf0yQfwWbm4CWjWo1TKpJs=
>=wSCI
>-----END PGP SIGNATURE-----

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
