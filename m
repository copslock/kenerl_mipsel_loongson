Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA54050 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 12:58:16 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA96695
	for linux-list;
	Wed, 25 Nov 1998 12:58:03 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id MAA72429
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 25 Nov 1998 12:58:02 -0800 (PST)
	mail_from (greg@xtp.engr.sgi.com)
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id MAA24004; Wed, 25 Nov 1998 12:56:41 -0800
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9811251256.ZM24002@xtp.engr.sgi.com>
Date: Wed, 25 Nov 1998 12:56:41 -0800
In-Reply-To: Olivier Galibert <galibert@pobox.com>
        "Re: help offered" (Nov 25,  8:49pm)
References: <365AA647.62A5565D@fra.se>  <199811242033.MAA31902@oz.engr.sgi.com> 
	<19981125204900.A4692@loria.fr>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Olivier Galibert <galibert@pobox.com>, linux@cthulhu.engr.sgi.com
Subject: Re: help offered
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>Interesting.  Our "local" SGI vendor  (i.e. the one for France),  told
>us that 1GB/sec write  speed was too much  and he could only guarantee
>800MB/sec for our 1TB raid array.

800 MB/s might be a good conversative estimate for a particular RAID array.
However, it is not a limit for Origin systems or disk arrays in general.
We regularly specify and deliver systems with file and network performance
much greater than 800 MB/s.  Also, regarding file system bandwidth
most discussions do not clarify between peak, sustained, or average performance
or specify the transfer sizes or number of clients or other important
environmental factors.  Disk vendors are the worst offenders.  RAID vendors
are pretty bad, too.  I've seen two different vendors claim the sum of the
peak bandwidths of the disk channels on their boxes as the expected
file system performance.  Woe to the customer who actually believes
such garbage.  And woe to the vendors who have to compete against such garbage.

g

-- 
Greg Chesson
