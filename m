Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id PAA03945
	for <pstadt@stud.fh-heilbronn.de>; Wed, 7 Jul 1999 15:18:26 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA4819978; Wed, 7 Jul 1999 06:11:15 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA40819
	for linux-list;
	Wed, 7 Jul 1999 06:06:36 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA91268
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 7 Jul 1999 06:06:33 -0700 (PDT)
	mail_from (owner-linux@neteng.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA74604 for <linux@neteng.engr.sgi.com>; Wed, 7 Jul 1999 06:06:31 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA16855
	for <linux@neteng.engr.sgi.com>;
	Wed, 7 Jul 1999 06:06:29 -0700 (PDT)
	mail_from (clepple@mitre.org)
Received: from linus.mitre.org (linus.mitre.org [129.83.10.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA07651
	for <linux@neteng.engr.sgi.com>; Wed, 7 Jul 1999 06:06:28 -0700 (PDT)
	mail_from (clepple@mitre.org)
Received: from mitre.org (localhost [127.0.0.1])
	by linus.mitre.org (8.8.7/8.8.7) with ESMTP id JAA11713
	for <linux@neteng.engr.sgi.com>; Wed, 7 Jul 1999 09:06:26 -0400 (EDT)
Message-ID: <378350D1.77F4554D@mitre.org>
Date: Wed, 07 Jul 1999 09:06:26 -0400
From: Charles Lepple <clepple@mitre.org>
Reply-To: clepple@foo.tho.org
X-Mailer: Mozilla 4.51 [en] (X11; U; SunOS 5.5.1 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@neteng.engr.sgi.com
Subject: Re: where's dhcp_bootp?
References: <NDBBJCODHKOEMPLCNOFGAEKNCBAA.ivanl@pacific.net.sg> <19990707013401.C1630@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:
> IRIX bootp definately works, it unfortunately just has a different
> configfile from Linux's bootp.

One thing that can bite you is that many bootp daemons give no
indication of truncated replies (ie, your parameters don't fit into one
packet). Use a sniffer-- I've solved a number of problems by just not
sending as much.

--Charles Lepple
clepple@mitre.org
