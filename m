Received:  by oss.sgi.com id <S305164AbQCXRfh>;
	Fri, 24 Mar 2000 09:35:37 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:34172 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQCXRfS>;
	Fri, 24 Mar 2000 09:35:18 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA25130; Fri, 24 Mar 2000 09:30:38 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA05581
	for linux-list;
	Fri, 24 Mar 2000 09:17:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA05513
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 24 Mar 2000 09:17:28 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA02427
	for <linux@cthulhu.engr.sgi.com>; Fri, 24 Mar 2000 09:05:20 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port108.duesseldorf.ivm.de [195.247.65.108])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id SAA04832;
	Fri, 24 Mar 2000 18:05:02 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000324180557.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.GSO.4.10.10003241507430.7616-100000@dandelion.sonytel.be>
Date:   Fri, 24 Mar 2000 18:05:57 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: Decstation 5000/150 2.3.99pre2/ still login problems
Cc:     linux@cthulhu.engr.sgi.com, Florian Lohoff <flo@rfc822.org>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On 24-Mar-00 Geert Uytterhoeven wrote:
> On Fri, 24 Mar 2000, Florian Lohoff wrote:
>> still the same problems - since the mid 2.3.4x kernels i cant
>> log into my decstation 5000 - It seems the pseudo tty code
>> is non functional.
>> 
>> An telnet or "ssh" causes the connection to close if requesting a tty.
> 
> I can confirm this on my DDB 5074. Does it work on SGI boxes? If yes, it may
> be
> an endianness problem (both DS 5000 and DDB 5074 are little endian).

Same here on my 5k/260 but it seems to be neither an endianness nor a semaphore
problem.

I haven't nailed it down yet but with some hacks I am able to boot 2.3.99-pre2
on my 5k/133. To my surprise I *can* telnet into this box, hmmm...

On the other hand, a kernel for the /260 compiled without CONFIG_CPU_HAS_LLSB
(i.e. using the R3000 semaphore code) does not work as well.

-- 
Regards,
Harald
