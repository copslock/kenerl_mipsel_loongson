Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA70984 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Jun 1998 03:49:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA39085
	for linux-list;
	Fri, 26 Jun 1998 03:49:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA87609
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Jun 1998 03:49:48 -0700 (PDT)
	mail_from (mjhsieh@sparc.life.nthu.edu.tw)
Received: from sparc.life.nthu.edu.tw (life.nthu.edu.tw [140.114.98.21]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id DAA27810
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Jun 1998 03:49:47 -0700 (PDT)
	mail_from (mjhsieh@sparc.life.nthu.edu.tw)
Received: (from mjhsieh@localhost)
	by sparc.life.nthu.edu.tw (8.8.8/8.8.8) id SAA08421;
	Fri, 26 Jun 1998 18:47:31 +0800 (CST)
Message-ID: <19980626184731.09737@life.nthu.edu.tw>
Date: Fri, 26 Jun 1998 18:47:31 +0800
From: "Francis M.J. Hsieh" <mjhsieh@life.nthu.edu.tw>
To: linux@cthulhu.engr.sgi.com
Subject: possible driver error?
References: <19980626151336.37322@life.nthu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.79e
In-Reply-To: <19980626151336.37322@life.nthu.edu.tw>; from Francis M.J. Hsieh on Fri, Jun 26, 1998 at 03:13:36PM +0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Dear SGI/Linuxer:
 
  Here is a possible driver error (but seems harmless, I checked it
  using network managerment hardware, no transmission error occured)

[root@helix /root]# ifconfig -a
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Bcast:127.255.255.255  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3584  Metric:1
          RX packets:18 errors:0 dropped:0 overruns:0
          TX packets:0 errors:1260 dropped:18 overruns:0
          ^^^^^^^^^^^^ ---> ?

eth0      Link encap:Ethernet  HWaddr 08:00:69:08:BD:9A
          inet addr:140.114.98.34  Bcast:140.114.98.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4144 errors:0 dropped:0 overruns:0
          TX packets:0 errors:0 dropped:943 overruns:0
          ^^^^^^^^^^^^ ---> ?
          Interrupt:
-- 
Francis M. J. Hsieh      | Email:   mjhsieh@life.nthu.edu.tw
Life Science Department, | Webpage: http://www.life.nthu.edu.tw/~mjhsieh/
National Tsing Hua Univ, | Voice:   +886 3 5715131 ext 3482
HsinChu, Taiwan Republic | 	    +886 3 5715649
