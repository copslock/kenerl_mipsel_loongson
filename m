Received:  by oss.sgi.com id <S305157AbQAGTow>;
	Fri, 7 Jan 2000 11:44:52 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:44370 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQAGTog>;
	Fri, 7 Jan 2000 11:44:36 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA19141; Fri, 7 Jan 2000 11:41:10 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA09202
	for linux-list;
	Fri, 7 Jan 2000 11:09:40 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA08198;
	Fri, 7 Jan 2000 11:09:03 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA04884; Fri, 7 Jan 2000 11:08:51 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port14.koeln.ivm.de [195.247.239.14])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id UAA14536;
	Fri, 7 Jan 2000 20:08:40 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000107200905.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <14452.58782.750095.352886@liveoak.engr.sgi.com>
Date:   Fri, 07 Jan 2000 20:09:05 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     "William J. Earl" <wje@cthulhu.engr.sgi.com>
Subject: Re: Decstation 5000/150 2.3.21 Boot successs
Cc:     linux@cthulhu.engr.sgi.com, Florian Lohoff <flo@rfc822.org>,
        "Kevin D. Kissell" <kevink@mips.com>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On 06-Jan-00 William J. Earl wrote:
>      Note that the SVR4 MIPS ABI assumes FR=0 (R3000-compatible), as
> do SGI IRIX "-32" ("O32") binaries (and, I believe, default gcc
> binaries).  SGI IRIX "-n32" and "-n64" binaries assumes FR=1
> (R4000-compatible), and also have a somewhat different register calling
> convention (which affects where arguments to system calls reside).

Wouldn't it make sense then if we made FR=0 the default for Linux/MIPS?

---
Regards,
Harald
