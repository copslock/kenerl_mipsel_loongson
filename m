Received:  by oss.sgi.com id <S305292AbQEBMxA>;
	Tue, 2 May 2000 05:53:00 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:23595 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305164AbQEBMw5>; Tue, 2 May 2000 05:52:57 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA07348; Tue, 2 May 2000 05:57:12 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA52071
	for linux-list;
	Tue, 2 May 2000 05:43:44 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA83776
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 May 2000 05:43:41 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA04581
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 May 2000 05:43:31 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 707B57D9; Tue,  2 May 2000 14:43:18 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 6CB398FFD; Tue,  2 May 2000 14:25:44 +0200 (CEST)
Date:   Tue, 2 May 2000 14:25:44 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: autoboot via bootp ?
Message-ID: <20000502142544.C2508@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
does somebody have an idea on how to set the prom env vars to values
which do the same as this - bootp booting and some kernel parms

---------------
System Maintenance Menu                                                         
                                                                                
1) Start System                                                                 
2) Install System Software                                                      
3) Run Diagnostics                                                              
4) Recover System                                                               
5) Enter Command Monitor                                                        
                                                                                
Option? 5                                                                       
Command Monitor.  Type "exit" to return to the menu.                            
>> bootp():vmlinux-ip22 root=/dev/sda1 console=ttyS0                            
Setting $netaddr to 195.71.99.220 (from server watchdog.rfc822.org)             
Obtaining vmlinux-ip22 from server watchdog.rfc822.org                          
ARCH: SGI-IP22                                                                  
--------------------------

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
