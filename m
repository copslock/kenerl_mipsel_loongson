Received:  by oss.sgi.com id <S305193AbQBJOtX>;
	Thu, 10 Feb 2000 06:49:23 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:29736 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQBJOtH>; Thu, 10 Feb 2000 06:49:07 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id GAA02275; Thu, 10 Feb 2000 06:51:53 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA92300
	for linux-list;
	Thu, 10 Feb 2000 06:35:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA50974
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 10 Feb 2000 06:35:31 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA09411
	for <linux@cthulhu.engr.sgi.com>; Thu, 10 Feb 2000 06:35:30 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA05450;
	Thu, 10 Feb 2000 06:35:16 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id GAA10905;
	Thu, 10 Feb 2000 06:35:14 -0800 (PST)
Message-ID: <00f001bf73d4$4b5f21d0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:     <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>
Subject: Re: Enhanced 2.2.12 MIPS Kernel Sources  Available
Date:   Thu, 10 Feb 2000 15:36:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>It'll be great if you would put just patches too. I guess, it'll be easy
>for us to look through set of patches instead of downloading entire
>2.2.12 and making diff -ruN on it. Then, there might be a core patch
>that decribes changes in machine independent part of the kernel and the
>rest might cover specific boards. Most of developers here will be
>interested in the core patch, I guess.


OK, there is now a patch file available on the Paralogos site
(http://www.paralogos.com/mipslinux/) with the deltas relative
to the kernel.org 2.2.12 distribution.  It covers the whole kernel
tree - I don't think I can reasonably decompose the changes
without introducing a gratuitous opportunity to generate bugs.

            Happy hacking,

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
