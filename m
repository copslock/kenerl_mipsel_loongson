Received:  by oss.sgi.com id <S305166AbQCXXfz>;
	Fri, 24 Mar 2000 15:35:55 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:17954 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305159AbQCXXfq>; Fri, 24 Mar 2000 15:35:46 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA02252; Fri, 24 Mar 2000 15:39:16 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id PAA17104; Fri, 24 Mar 2000 15:35:42 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA59221
	for linux-list;
	Fri, 24 Mar 2000 13:33:51 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA69692
	for <linux@engr.sgi.com>;
	Fri, 24 Mar 2000 13:33:45 -0800 (PST)
	mail_from (jarwyp@charybda.icm.edu.pl)
Received: from charybda.icm.edu.pl (charybda.icm.edu.pl [212.87.0.242]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA06663
	for <linux@engr.sgi.com>; Fri, 24 Mar 2000 13:33:44 -0800 (PST)
	mail_from (jarwyp@charybda.icm.edu.pl)
Received: from kraken.lab.icm.edu.pl (kraken.lab.icm.edu.pl [10.0.0.231])
	by charybda.icm.edu.pl (8.9.3/8.9.3) with ESMTP id VAA32144
	for <linux@engr.sgi.com>; Fri, 24 Mar 2000 21:23:56 -0500
Received: from pirania.lab.icm.edu.pl (pirania.lab.icm.edu.pl [10.0.0.220])
	by kraken.lab.icm.edu.pl (8.9.1b+Sun/8.9.1) with ESMTP id WAA11366
	for <linux@engr.sgi.com>; Fri, 24 Mar 2000 22:32:57 +0100 (MET)
Received: from localhost (jarwyp@localhost) by pirania.lab.icm.edu.pl (8.8.0/8.8.0) with ESMTP id WAA25985 for <linux@engr.sgi.com>; Fri, 24 Mar 2000 22:38:34 +0100 (MET)
X-Authentication-Warning: pirania.lab.icm.edu.pl: jarwyp owned process doing -bs
Date:   Fri, 24 Mar 2000 22:38:34 +0100
From:   Jaroslaw Wypchowski <jarwyp@charybda.icm.edu.pl>
To:     linux@cthulhu.engr.sgi.com
Subject: Some basic problems with booting SGI Challange.
Message-ID: <Pine.SGI.4.10.10003242211310.25741-100000@pirania.lab.icm.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Cause i'm completely new to the problem i'm afraid i will put some
complete idiotism. But the problem is :

I've got a SGI Challange S (on R5000).
It has: no cd, no keyboard, no eth, one aacp(i think), scsi disc, console
serial ouput connected to linux and used with minicom.
There is no kernel on disc. It is in network where i have for my
disposition several MIPS'es R4000 and several other pltforms. 
What i need is to load a system onto the sgi. It would be great if it
could be linux. But now i found several problems. First : To obtain linux
i need an Irix on my SGI. Unfortunatelly i have none. 
Tried to boot it vie the network from one of my MIPS'es with its kernel
and /var/... files All i received is that the kerenel started logging but
ouputed panic and foult and died. 
What more about my configuration.
sash on sgi is in version 5.3 and on that MIPS (called further pirania) i
got 6.3 version of system. 

Oh - i don't have any IRIX installation disc's except 5.3 but have no
SGI's scsi CD.

Any hints and ideas of what could i do ? 

Solution that i "discovered"
I think that if i've got working image of basic system installation i
could put it into the sgi's disc from other computer with scsi drive. 
But i don't have such image. And have no idea where to get it from. 

This is my first problem. 
Next problems will follow after i deal with this one.

thx for all help.

	jarwyp
/\
  \/\  Jarwyp@charybda.icm.edu.pl
   \ \ Jaroslaw Wypychowski.
