Received:  by oss.sgi.com id <S42268AbQG1Azm>;
	Thu, 27 Jul 2000 17:55:42 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:56174 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42222AbQG1Azg>; Thu, 27 Jul 2000 17:55:36 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id SAA06655
	for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 18:01:31 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id RAA73086 for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 17:55:09 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA63068
	for <linux@engr.sgi.com>;
	Thu, 27 Jul 2000 17:53:37 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA06905
	for <linux@engr.sgi.com>; Thu, 27 Jul 2000 17:53:36 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id RAA27043;
	Thu, 27 Jul 2000 17:52:45 -0700
Message-ID: <3980D95A.5949E980@mvista.com>
Date:   Thu, 27 Jul 2000 17:52:42 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
CC:     ralf@oss.sgi.com
Subject: Turning off cache ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Ralf,

Is there is easy way to turn off caching entirely?  I understand I need
to set k0 bits in config register.  What about those C bits in TLB
entries?  My CPU only has primary cache.

I am running into some weired crashing problems, which makes me suspect
about the cache code that I modified ...

Thanks.  (BTW, thanks for the info on strace files.) 

Jun
