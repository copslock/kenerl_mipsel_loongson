Received:  by oss.sgi.com id <S305160AbPLAXdK>;
	Wed, 1 Dec 1999 15:33:10 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:16171 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305156AbPLAXcv>;
	Wed, 1 Dec 1999 15:32:51 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA09304; Wed, 1 Dec 1999 15:39:16 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA81500
	for linux-list;
	Wed, 1 Dec 1999 15:25:30 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA35886
	for <linux@engr.sgi.com>;
	Wed, 1 Dec 1999 15:25:27 -0800 (PST)
	mail_from (labibk@taec.toshiba.com)
Received: from godzilla.taec.com (godzilla.taec.com [204.162.152.130]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id PAA02233
	for <linux@engr.sgi.com>; Wed, 1 Dec 1999 15:24:22 -0800 (PST)
	mail_from (labibk@taec.toshiba.com)
Received: from mailhost.taec.com ([204.162.153.33]) by godzilla.taec.com
          via smtpd (for mx-engr.sgi.com [192.48.153.25]) with SMTP; 1 Dec 1999 23:21:31 UT
Received: from mailint.taec.com (mailint [204.162.153.34])
	by mailhost.taec.com (8.8.8+Sun/8.8.8) with ESMTP id PAA23511
	for <linux@engr.sgi.com>; Wed, 1 Dec 1999 15:22:13 -0800 (PST)
Received: from stafford.taec.com (stafford [209.243.133.46])
	by mailint.taec.com (8.8.8+Sun/8.8.8) with ESMTP id PAA20799;
	Wed, 1 Dec 1999 15:21:57 -0800 (PST)
Received: (from labibk@localhost)
	by stafford.taec.com (8.8.8+Sun/8.8.8) id PAA14951;
	Wed, 1 Dec 1999 15:20:27 -0800 (PST)
Date:   Wed, 1 Dec 1999 15:20:27 -0800 (PST)
From:   Khaled Labib <labibk@taec.toshiba.com>
Message-Id: <199912012320.PAA14951@stafford.taec.com>
To:     linux@cthulhu.engr.sgi.com
Subject: Problems with glibc RPM
Cc:     labibk@taec.toshiba.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-MD5: Wi6X4KO2IgfhQW6sd1m3og==
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,

I downloaded glibc-2.0.6-4.src.rpm and glibc-2.0.6-3.src.rpm from 
ftp.linux.sgi.com.

When I tried to use the rpm tool to install them, I got the following error 
message:

unpacking of archive failed on file glibc-2.0.6.tar.gz: cpio: read failed - 
Success


Can someone help ? I really need these sources from the rpm.

I am using RedHat Linux 6.0 on a PC.

Thank you for your help.



Khaled
