Received:  by oss.sgi.com id <S305160AbPLBITA>;
	Thu, 2 Dec 1999 00:19:00 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:59412 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbPLBISm>; Thu, 2 Dec 1999 00:18:42 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id AAA05767; Thu, 2 Dec 1999 00:27:09 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA72293
	for linux-list;
	Thu, 2 Dec 1999 00:15:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA78841
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 2 Dec 1999 00:14:27 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA09010
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Dec 1999 00:14:26 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA07534;
	Thu, 2 Dec 1999 00:14:25 -0800 (PST)
Received: from satanas (lyon-fw1-serial [194.51.122.30])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA04806;
	Thu, 2 Dec 1999 00:13:27 -0800 (PST)
Message-ID: <000e01bf3c9e$99711e90$0228a8c0@satanas>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Khaled Labib" <labibk@taec.toshiba.com>,
        <linux@cthulhu.engr.sgi.com>
Cc:     <labibk@taec.toshiba.com>
Subject: Re: Problems with glibc RPM
Date:   Thu, 2 Dec 1999 09:23:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>
>I downloaded glibc-2.0.6-4.src.rpm and glibc-2.0.6-3.src.rpm from 
>ftp.linux.sgi.com.
>
>When I tried to use the rpm tool to install them, I got the following error 
>message:
>
>unpacking of archive failed on file glibc-2.0.6.tar.gz: cpio: read failed - 
>Success
>
>
>Can someone help ? I really need these sources from the rpm.
>
>I am using RedHat Linux 6.0 on a PC.


I believe there are some interoperatbility problems between
Red Hat 5.2 and 6.0 rpm programs.   When I did a port of
mipsel linux to a MIPS development board, I started by
booting the RH 6.0 mipsel root file system, with the 6.0
rpm program, and found that I could not reliably install
the 5.2 gcc/glibc binary RPMs on the SGI server.  I
backed off to a 5.2 level root file system and rpm program,
and the problems went away.

__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
