Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA26375 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 11:53:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA03620
	for linux-list;
	Thu, 16 Jul 1998 11:53:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA89966
	for <linux@engr.sgi.com>;
	Thu, 16 Jul 1998 11:53:34 -0700 (PDT)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id LAA91562 for linux@engr.sgi.com; Thu, 16 Jul 1998 11:53:34 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199807161853.LAA91562@oz.engr.sgi.com>
Subject: apache and other problems (fwd)
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Thu, 16 Jul 1998 11:53:34 -0700 (PDT)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[forwarding bounced message]

----- Forwarded message from owner-linux@cthulhu -----
From: "Francis M.J. Hsieh" <mjhsieh@life.nthu.edu.tw>
To: linux@cthulhu.engr.sgi.com
Subject: Re: The pre-release of Hard Hat Linux for SGI...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.79e
In-Reply-To: <Pine.LNX.3.95.980714192038.7212G-100000@lager.engsoc.carleton.ca>; from Alex deVries on Tue, Jul 14, 1998 at 07:38:32PM -0400

On Tue, Jul 14, 1998 at 07:38:32PM -0400, Alex deVries wrote:
> Enjoy, and let me know if you do have the bandwidth do download and use
> it.

This two files were uploaded in ftp://helix.life.nthu.edu.tw/pub/
(yes, it is a Linux/SGI machine) for people in Taiwan save their
download time.

I got some problem here.

- apache httpd is still buggy (can't deliver text/html correctly)

- ifconfig is still buggy, TX packets is 0 (see followed)

| [root@helix /root]# ifconfig
| lo        Link encap:Local Loopback
|           inet addr:127.0.0.1  Bcast:127.255.255.255  Mask:255.0.0.0
|           UP LOOPBACK RUNNING  MTU:3584  Metric:1
|           RX packets:27 errors:0 dropped:0 overruns:0
|           TX packets:0 errors:1962 dropped:27 overruns:0
|
| eth0      Link encap:Ethernet  HWaddr 08:00:69:08:BD:9A
|           inet addr:140.114.98.34  Bcast:140.114.98.255  Mask:255.255.255.0
|           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
|           RX packets:157929 errors:0 dropped:0 overruns:0
|           TX packets:0 errors:0 dropped:72422 overruns:0
|           Interrupt:3

- mouse doesn't work?


-- 
Francis M. J. Hsieh      | Email:   mjhsieh@life.nthu.edu.tw
Life Science Department, | Webpage: http://www.life.nthu.edu.tw/~mjhsieh/
National Tsing Hua Univ, | Voice:   +886 3 5715131 ext 3482
HsinChu, Taiwan Republic | 	    +886 3 5715649

----- End of forwarded message from owner-linux@cthulhu -----

-- 
Peace, Ariel
