Received:  by oss.sgi.com id <S305178AbPLQU2K>;
	Fri, 17 Dec 1999 12:28:10 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:35915 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbPLQU1k>; Fri, 17 Dec 1999 12:27:40 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA01123; Fri, 17 Dec 1999 12:28:25 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA16714
	for linux-list;
	Fri, 17 Dec 1999 12:10:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA55043
	for <linux@engr.sgi.com>;
	Fri, 17 Dec 1999 12:10:32 -0800 (PST)
	mail_from (labibk@taec.toshiba.com)
Received: from godzilla.taec.com (godzilla.taec.com [204.162.152.130]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id MAA08732
	for <linux@engr.sgi.com>; Fri, 17 Dec 1999 12:08:53 -0800 (PST)
	mail_from (labibk@taec.toshiba.com)
Received: from mailhost.taec.com ([204.162.153.33]) by godzilla.taec.com
          via smtpd (for mx-engr.sgi.com [192.48.153.25]) with SMTP; 17 Dec 1999 20:08:53 UT
Received: from mailint.taec.com (mailint [204.162.153.34])
	by mailhost.taec.com (8.8.8+Sun/8.8.8) with ESMTP id MAA02026
	for <linux@engr.sgi.com>; Fri, 17 Dec 1999 12:07:38 -0800 (PST)
Received: from stafford.taec.com (stafford [209.243.133.46])
	by mailint.taec.com (8.8.8+Sun/8.8.8) with ESMTP id MAA05805;
	Fri, 17 Dec 1999 12:07:24 -0800 (PST)
Received: (from labibk@localhost)
	by stafford.taec.com (8.8.8+Sun/8.8.8) id MAA22757;
	Fri, 17 Dec 1999 12:08:51 -0800 (PST)
Date:   Fri, 17 Dec 1999 12:08:51 -0800 (PST)
From:   Khaled Labib <labibk@taec.toshiba.com>
Message-Id: <199912172008.MAA22757@stafford.taec.com>
To:     linux@cthulhu.engr.sgi.com
Subject: Milo
Cc:     labibk@taec.toshiba.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-MD5: A3hA69hNLLRVOsGSvrzpCQ==
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,

I am using linux/MIPS kernel v2.2.1 and I am now considering loading it. I 
looked at the Milo 0.27. 

There is very little documentation for Milo, basically, a single README file. 

Can some one point me on where to get more info about Milo. I need basically the 
following:

1- How exactly does Milo boot the kernel ?
2- Where should the Milo executable reside. On Disk, ROM ...etc. ?
3- What functions does Milo perform ?
4- Do I still need BIOS support with Milo ?
5- What is this ARC firmware ?
6- Where is the latest Milo ?

I'll be booting this kernel on a harware Emulator with a limited functionality 
target board. The Target board itself is a PCI-based board that sits in a 
regular PC and contains memory (system memory).

I would appreciate pointers to information related to the above.


Thank you.


Khaled Labib
