Received:  by oss.sgi.com id <S42246AbQG1BJv>;
	Thu, 27 Jul 2000 18:09:51 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:29551 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42222AbQG1BJY>; Thu, 27 Jul 2000 18:09:24 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id SAA01350
	for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 18:15:14 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA67356
	for <linux@engr.sgi.com>;
	Thu, 27 Jul 2000 18:09:10 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from u-151.karlsruhe.ipdial.viaginterkom.de (u-151.karlsruhe.ipdial.viaginterkom.de [62.180.19.151]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA01375
	for <linux@engr.sgi.com>; Thu, 27 Jul 2000 18:09:07 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868870AbQG1BIg>;
        Fri, 28 Jul 2000 03:08:36 +0200
Date:   Fri, 28 Jul 2000 03:08:36 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com, ralf@oss.sgi.com
Subject: Re: Turning off cache ...
Message-ID: <20000728030836.A1906@bacchus.dhis.org>
References: <3980D95A.5949E980@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3980D95A.5949E980@mvista.com>; from jsun@mvista.com on Thu, Jul 27, 2000 at 05:52:42PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jul 27, 2000 at 05:52:42PM -0700, Jun Sun wrote:

> Is there is easy way to turn off caching entirely?  I understand I need
> to set k0 bits in config register.  What about those C bits in TLB
> entries?  My CPU only has primary cache.

The C bits are per page, the k0 bits are for KSEG0.  If you want to
turn of caching, then you need to:

  - change the k0 bits to uncached on startup, then flush the caches or a
    writeback might corrupt your data.
  - change the caching mode of the usermode pages by modifying the
    definitions for PAGE_NONE etc. in pgtable.h.
  - comment out the cache Create_Dirty_Exclusive instructions in r4xx0.c,
    using them on uncached pages would corrupt data.

Which will make the kernel crawl awfully ...

  Ralf
