Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA56046 for <linux-archive@neteng.engr.sgi.com>; Sat, 20 Feb 1999 02:07:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA40429
	for linux-list;
	Sat, 20 Feb 1999 02:06:47 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA28775
	for <linux@engr.sgi.com>;
	Sat, 20 Feb 1999 02:06:45 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: from slug.rigelfore.com (c69494-a.plstn1.sfba.home.com [24.2.21.88]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id CAA04748
	for <linux@engr.sgi.com>; Sat, 20 Feb 1999 02:06:44 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: (qmail 10416 invoked from network); 20 Feb 1999 10:19:15 -0000
Received: from unknown (HELO rigelfore.com) (192.168.42.2)
  by 192.168.42.1 with SMTP; 20 Feb 1999 10:19:15 -0000
Message-ID: <36CE8895.A251FB2A@rigelfore.com>
Date: Sat, 20 Feb 1999 02:04:05 -0800
From: Eric Melville <m_thrope@rigelfore.com>
Organization: iLL
X-Mailer: Mozilla 4.5 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Joseph Michaud <jmichaud@chaos.boston.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: able to bootp/NFS-install/reboot R4400SC Indy
References: <199902170714.XAA09589@kilimanjaro.engr.sgi.com> 
		<36CBB931.D552C44@rigelfore.com> <9902181451.ZM96@chaos.boston.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

it says ---

offset = 0
offset = 1
offset = 2
offset = 3
offset = 0
offset = 1
offset = 2

etc etc etc

???????

-E

> I had encountered a problem once with a bad R4400 CPU (only one)
> incorrectly loading halfword (16-bit) values from memory.  The
> following uuencoded gzipped mips2 binary mallocs lines of four
> halfwords, loads it with a certain bit pattern, and then in a loop
> checks all 0th halfwords, then all 1st, then 2nd, then 3rd.  (I had
> problems with the 3rd halfwords.)
> 
> Boot up IRIX and give it a try.  If it prints out anything other
> than "offset = 0", etc., then there is a problem.  (You could probably run
> it under miniroot as well.)  It was built on 6.2.
