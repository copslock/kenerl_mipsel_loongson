Received:  by oss.sgi.com id <S305186AbPLUM0V>;
	Tue, 21 Dec 1999 04:26:21 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:39280 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbPLUMZ7>;
	Tue, 21 Dec 1999 04:25:59 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA05412; Tue, 21 Dec 1999 04:21:11 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA26190
	for linux-list;
	Tue, 21 Dec 1999 04:03:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA55570
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 21 Dec 1999 04:03:00 -0800 (PST)
	mail_from (jmatsu@cse.canon.co.jp)
Received: from canongate.in.canon.co.jp (canongate.in.canon.co.jp [150.61.4.5]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA01628
	for <linux@cthulhu.engr.sgi.com>; Tue, 21 Dec 1999 04:02:58 -0800 (PST)
	mail_from (jmatsu@cse.canon.co.jp)
Received: (from uucp@localhost)
	by canongate.in.canon.co.jp (3.7W) id VAA15286
	for <linux@cthulhu.engr.sgi.com>; Tue, 21 Dec 1999 21:02:56 +0900 (JST)
Received: from <jmatsu@cse.canon.co.jp> (isvw1.cecn.canon.co.jp [150.61.8.152]) by canongate via smap (V2.1)
	id xma015281; Tue, 21 Dec 99 21:02:36 +0900
Received: from canongw.cecn.canon.co.jp (localhost [127.0.0.1])
	by isvw1.cecn.canon.co.jp (8.9.3/3.7W) with ESMTP id VAA27176
	for <linux@cthulhu.engr.sgi.com>; Tue, 21 Dec 1999 21:02:35 +0900 (JST)
Received: from season.cse.canon.co.jp (season.cse.canon.co.jp [172.20.48.1])
	by canongw.cecn.canon.co.jp (8.9.3/3.7W) with ESMTP id VAA19116
	for <linux@cthulhu.engr.sgi.com>; Tue, 21 Dec 1999 21:02:35 +0900 (JST)
Received: from localhost (grass.cse.canon.co.jp [172.20.50.95])
	by season.cse.canon.co.jp (8.9.1/3.7W) with ESMTP id VAA28116;
	Tue, 21 Dec 1999 21:02:34 +0900 (JST)
To:     linux@cthulhu.engr.sgi.com
Subject: patch for glibc-2.0.6
From:   Jun Matsuda <jmatsu@cse.canon.co.jp>
X-Mailer: Mew version 1.95b3 on Emacs 20.5 / Mule 4.0
 =?iso-2022-jp?B?KBskQjJWMWMbKEIp?=
References: <19991206214429.T765@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <19991221210256U.jmatsu@cse.canon.co.jp>
Date:   Tue, 21 Dec 1999 21:02:56 +0900
X-Dispatcher: imput version 991025(IM133)
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,

I plan to construct the cross compilation environment as
described in the Linux/MIPS-HOWTO. But I could not find the
patch for glibc-2.0.6 (glibc-2.0.6-mips.patch) and without
this patch, I failed to compile glibc-2.0.6.

Does anyone tell me the place where to find it?

--
Best regards,
Jun Matsuda (jmatsu@cse.canon.co.jp)
