Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA81062 for <linux-archive@neteng.engr.sgi.com>; Sun, 31 Jan 1999 21:48:40 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA45962
	for linux-list;
	Sun, 31 Jan 1999 21:47:51 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA47051
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 31 Jan 1999 21:47:49 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: from slug.rigelfore.com (c69494-a.plstn1.sfba.home.com [24.2.21.88]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id VAA02966
	for <linux@cthulhu.engr.sgi.com>; Sun, 31 Jan 1999 21:47:48 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: (qmail 14864 invoked from network); 1 Feb 1999 06:06:16 -0000
Received: from unknown (HELO rigelfore.com) (192.168.42.2)
  by 192.168.42.1 with SMTP; 1 Feb 1999 06:06:16 -0000
Message-ID: <36B53F82.6BEF8DFC@rigelfore.com>
Date: Sun, 31 Jan 1999 21:45:38 -0800
From: Eric Melville <m_thrope@rigelfore.com>
Organization: iLL
X-Mailer: Mozilla 4.5 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: sgi linux
References: <Pine.LNX.3.96.990131213407.28403D-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> - your filesystem isn't exported properly from whatever nefs server you
> have, in which case you need to veryify that /dev/console (at least) is
> exported properly.
> 
> - you're trying to use a serial console, which is currently unsupported.

aha... i think it's caus i untarred to an msdos partition first ;) so i
don't have _anything_ in my /dev dir... heh...

-E
