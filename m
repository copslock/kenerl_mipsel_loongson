Received:  by oss.sgi.com id <S305154AbPKQApr>;
	Tue, 16 Nov 1999 16:45:47 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:5740 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305157AbPKQApV>;
	Tue, 16 Nov 1999 16:45:21 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA847970
	for <linuxmips@oss.sgi.com>; Tue, 16 Nov 1999 16:50:57 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA96034
	for linux-list;
	Tue, 16 Nov 1999 16:21:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA92441
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 Nov 1999 16:21:24 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA841835
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 Nov 1999 16:21:23 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id QAA00819;
	Tue, 16 Nov 1999 16:21:10 -0800 (PST)
Received: from satanas (lyon-fw1-serial [194.51.122.30])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id QAA21173;
	Tue, 16 Nov 1999 16:21:06 -0800 (PST)
Message-ID: <062a01bf3092$e54906b0$0228a8c0@satanas>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "SGI Linux Alias" <linux@cthulhu.engr.sgi.com>,
        <linux-mips@fnet.fr>
Subject: kernel-headers RPM?
Date:   Wed, 17 Nov 1999 01:30:03 +0100
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

I've managed to bring up a mipsel 2.2.12
kernel using the Red Hat 6.0 root filesystem
from off the SGI web site.  I can install the
egcs package, but I also need the development
glibc package to be installed before I can
"go native".   That package in turn depends
on the kernel-headers package, which I've
been unable to locate on the web.  Do any
of you know where I could find a copy, or
that failing, build/fake one? Forcing the
install by overriding the dependencies
seems to but the rpm database in a
corrupt state - rpm core dumps thereafter
on installation that would otherwise succeed.
:-(
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
