Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA12069 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Feb 1999 21:39:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA48760
	for linux-list;
	Fri, 26 Feb 1999 21:38:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA31689
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Feb 1999 21:38:40 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: from slug.rigelfore.com (c69494-a.plstn1.sfba.home.com [24.2.21.88]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id VAA02209
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Feb 1999 21:38:39 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: (qmail 16080 invoked from network); 27 Feb 1999 05:56:45 -0000
Received: from unknown (HELO rigelfore.com) (192.168.42.2)
  by 192.168.42.1 with SMTP; 27 Feb 1999 05:56:45 -0000
Message-ID: <36D78434.82C30922@rigelfore.com>
Date: Fri, 26 Feb 1999 21:35:48 -0800
From: Eric Melville <m_thrope@rigelfore.com>
Organization: iLL
X-Mailer: Mozilla 4.5 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: R4400 200MHz Indys
References: <19990227002251.B4022@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

drats! it looks exactly the same (except it says it's linux version
2.2.1 ;) ... it hangs on:

"Freeing unused kernel memory: 52k freed"

weird.

-E

> Yesterday Ralf told me about a bug in the R4400 Rev 6.0 250 MHz devices.
> As we can't say, whether the 200Mhz are real 250 MHz chip, it's worth
> a try to activate the workaround for it, which is already present in
> the kernel (but never gets enabled). People, which have problem with
> R4400 Indys, please try the kernel below.
