Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA08504 for <linux-archive@neteng.engr.sgi.com>; Tue, 30 Jun 1998 17:27:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA76032
	for linux-list;
	Tue, 30 Jun 1998 17:26:23 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA79201
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 30 Jun 1998 17:26:21 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA19991
	for <linux@cthulhu.engr.sgi.com>; Tue, 30 Jun 1998 17:26:20 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (root@pmport-27.uni-koblenz.de [141.26.249.27])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA00928
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Jul 1998 02:26:16 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id MAA00751;
	Tue, 30 Jun 1998 12:08:09 +0200
Message-ID: <19980630120809.A517@uni-koblenz.de>
Date: Tue, 30 Jun 1998 12:08:09 +0200
To: "Francis M. J. Hsieh" <mjhsieh@life.nthu.edu.tw>,
        linux@cthulhu.engr.sgi.com
Subject: Re: possible apache error?
References: <19980629045132.A432@life.nthu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980629045132.A432@life.nthu.edu.tw>; from Francis M. J. Hsieh on Mon, Jun 29, 1998 at 04:51:32AM +0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jun 29, 1998 at 04:51:32AM +0800, Francis M. J. Hsieh wrote:

> Did you found that some error occured when apache is transfering html
> text? The default faq file in http://localhost/manual/misc/FAQ.html
> corrupted at the browser. Did anybody get it, too?

Yes, and there is another code affected by the same syndrome.  rlogin
to an Indy looks like:

[ralf@lappi ralf]$ rlogin -l root indy
Last login: Wed Jul  1 11:14:13 from lappi
[root@indy /root]# ls
bookmarks              rpm-2.5-2.src.rpm      ttcp-1.rpm      ttcp-1.one.S
      ssone.S                  ssrpm  ttcp-1.4-1.rpm  ttcp-1.4-1.-980528.tar.gz
sh-1.2.25.tar.gzsh-1.2.25.tar.gz ssh-1.2.25.tar.gz.sig
[root@indy /root]# ll
total 5370
-rw-r--r--   1 root     root          146 Nov 3       146 Nov 3s
-rw-r--r--   1 root     root         3072 May  3 07:00 clone.S
-rw-r--r--   1 root     root      2568819 Jun 10  1996 dejagnu-980528.tar.gz
-rwxr-xr-x   1 root     root        15658 May  3 07:06 dliu*
-rw-r--r--   1 root     root         1001 Apr 28 01:01 dliu.c
-rw-r--r--   1 root     root       581465 Jun 13  1996 rpm-2.5-2.src.rpm
-rw-------   1 root     root      1268954 Jun 14 17:44 ssh-1.2.23-1i.src.rpm
-rw-r--r--   1 root     root         2591 Jun 14 17:15 ssh-1.2.25.release
-rw-r--r--   1 root     root      1002828 Jun 1   1002828 Jun 125.tar.gz
-rw-r--r--   1 root     root          152 Jun 14 17:20 ssh-1.2.25.tar.gz.sig
-rw-r--r--   1 root     root         9678 Dec        9678 Dec  -1.mips.rpm
-rw-r--r--   1 root     root         8310 Dec        8310 Dec  -1.src.rpm
-rw-r--r--   1 root     root         1139 May  8 00:10 vc-bug.c
[root@indy /root]#

The corruption pattern is repeatable the same in most cases and I bet
both the http and the rlogin corruption have the same cause.

  Ralf
