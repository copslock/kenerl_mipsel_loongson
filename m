Received:  by oss.sgi.com id <S305165AbPKDLnc>;
	Thu, 4 Nov 1999 03:43:32 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:50494 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305162AbPKDLnP>;
	Thu, 4 Nov 1999 03:43:15 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA8933061
	for <linuxmips@oss.sgi.com>; Thu, 4 Nov 1999 06:47:53 -0500 (EST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAB70404
	for linux-list;
	Thu, 4 Nov 1999 03:12:54 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA22303
	for <linux@engr.sgi.com>;
	Thu, 4 Nov 1999 03:12:51 -0800 (PST)
	mail_from (e1097757@ceng.metu.edu.tr)
Received: from mendelson.ceng.metu.edu.tr (mendelson71.ceng.metu.edu.tr [144.122.71.3]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA1919789
	for <linux@engr.sgi.com>; Thu, 4 Nov 1999 06:12:47 -0500 (EST)
	mail_from (e1097757@ceng.metu.edu.tr)
Received: (from e1097757@localhost)
	by mendelson.ceng.metu.edu.tr (8.9.0/8.9.0) id NAA06854
	for linux@engr.sgi.com; Thu, 4 Nov 1999 13:12:56 +0200 (EET)
From:   SERTKAYA BARIS <e1097757@ceng.metu.edu.tr>
Message-Id: <199911041112.NAA06854@mendelson.ceng.metu.edu.tr>
Subject: gerenimo !!!
To:     linux@cthulhu.engr.sgi.com
Date:   Thu, 4 Nov 1999 13:12:55 +0200 (EET)
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



	Hi,

	At last I managed to install HardHat to my Indy.Everything is nice,
	(better than Irix to me :) but I still could not run X.In the 
	distribution there are two X servers.When I try to run XF86_FBDEV,
	I get the message:
		Configured drivers:
		FBDEV: Server for frame buffer device
		(Patchlecel 7): mfb, iplan2p2, iplan2p4, iplan2p8, ilbm,
		afb, cfb8
		Fatal server error:
		xf86OpenConsole: Cannot open /dev/fb0current (No such file 
		or directory)
	And when I try to run the other, X, it says sth like :
		'waiting for X server to begin accepting connections...'
	which server should I run and how?

	thanx in advance..

---------------
#!/usr/bin/perl          
use Tranquilizan;        
goto bed;                
bed: while (!&asleep) {  
                ++$sheep;
        }                
