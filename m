Received:  by oss.sgi.com id <S305165AbPLVAVi>;
	Tue, 21 Dec 1999 16:21:38 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:576 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbPLVAVV>;
	Tue, 21 Dec 1999 16:21:21 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA22846; Tue, 21 Dec 1999 16:16:35 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA16102
	for linux-list;
	Tue, 21 Dec 1999 16:00:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA13843
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 21 Dec 1999 16:00:27 -0800 (PST)
	mail_from (jmatsu@cse.canon.co.jp)
Received: from canongate.in.canon.co.jp (canongate.in.canon.co.jp [150.61.4.5]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04720
	for <linux@cthulhu.engr.sgi.com>; Tue, 21 Dec 1999 16:00:16 -0800 (PST)
	mail_from (jmatsu@cse.canon.co.jp)
Received: (from uucp@localhost)
	by canongate.in.canon.co.jp (3.7W) id JAA01999
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Dec 1999 09:00:13 +0900 (JST)
Received: from <jmatsu@cse.canon.co.jp> (isvw1.cecn.canon.co.jp [150.61.8.152]) by canongate via smap (V2.1)
	id xma001859; Wed, 22 Dec 99 08:59:25 +0900
Received: from canongw.cecn.canon.co.jp (localhost [127.0.0.1])
	by isvw1.cecn.canon.co.jp (8.9.3/3.7W) with ESMTP id IAA11091
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Dec 1999 08:59:24 +0900 (JST)
Received: from season.cse.canon.co.jp (season.cse.canon.co.jp [172.20.48.1])
	by canongw.cecn.canon.co.jp (8.9.3/3.7W) with ESMTP id IAA12544
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Dec 1999 08:59:24 +0900 (JST)
Received: from localhost (grass.cse.canon.co.jp [172.20.50.95])
	by season.cse.canon.co.jp (8.9.1/3.7W) with ESMTP id IAA19645;
	Wed, 22 Dec 1999 08:59:23 +0900 (JST)
To:     linux@cthulhu.engr.sgi.com
Subject: Re: patch for glibc-2.0.6
From:   Jun Matsuda <jmatsu@cse.canon.co.jp>
In-Reply-To: <19991221151930.A11668@uni-koblenz.de>
References: <19991206214429.T765@uni-koblenz.de>
	<19991221210256U.jmatsu@cse.canon.co.jp>
	<19991221151930.A11668@uni-koblenz.de>
	<19991221165444.W272@paradigm.rfc822.org>
X-Mailer: Mew version 1.95b3 on Emacs 20.5 / Mule 4.0
 =?iso-2022-jp?B?KBskQjJWMWMbKEIp?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <19991222085945O.jmatsu@cse.canon.co.jp>
Date:   Wed, 22 Dec 1999 08:59:45 +0900
X-Dispatcher: imput version 991025(IM133)
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,

  Ralf Baechle <ralf@oss.sgi.com> wrote:
> > Does anyone tell me the place where to find it?
> 
> In the SRPM package of glibc.

I found the SPRM package for egcs and binutils, but I could not
find package for glibc.

I expect the SPRM package for glibc is in:
ftp://ftp.linux.sgi.com/pub/linux/mips/crossdev/src/

Does anyone know the exact place of the SPRM package for
glibc in ftp.linux.sgi.com?

  Florian Lohoff <flo@rfc822.org> wrote:
> There is a source rpm for it somewhere - Or a debian source package
> for 2.0.7.981112 or something at
> 
> ftp://ftp.rfc822.org/pub/local/debian/debian/experimental 

Thanks! I will try it.

--
Best regards,
Jun Matsuda (jmatsu@cse.canon.co.jp)
