Received:  by oss.sgi.com id <S42279AbQGaRX0>;
	Mon, 31 Jul 2000 10:23:26 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:54307 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42245AbQGaRXL>;
	Mon, 31 Jul 2000 10:23:11 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA07510
	for <linux-mips@oss.sgi.com>; Mon, 31 Jul 2000 10:15:38 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id KAA00766 for <linux-mips@oss.sgi.com>; Mon, 31 Jul 2000 10:21:21 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA41521
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 31 Jul 2000 10:19:07 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA00873
	for <linux@cthulhu.engr.sgi.com>; Mon, 31 Jul 2000 10:19:04 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id KAA04541;
	Mon, 31 Jul 2000 10:17:22 -0700
Message-ID: <3985B49E.58DAA36F@mvista.com>
Date:   Mon, 31 Jul 2000 10:17:18 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com, jpuhlman@mvista.com
Subject: Re: Bus error of gdb 5.0 with MIPS patch
References: <Pine.GSO.3.96.1000731180916.21648P-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Maciej W. Rozycki" wrote:
>  About the bus error -- try to compile gdb with debugging support and make
> it dump core on the bus error (you might need to tweak ulimit).  Then try
> to locate the crash address with gdb (`info stack' might be particularly
> useful).  It's most likely gdb cannot figure an address of the next
> instruction properly.
> 
>  What version of libc?
>

It is glibc 2.0.7.  Pretty old, but I don't think there is a newer one
working stably with MIPS.

Jun
