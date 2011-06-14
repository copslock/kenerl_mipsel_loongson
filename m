Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2011 02:23:41 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:3985 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491120Ab1FNAXf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2011 02:23:35 +0200
Received: from [10.9.200.133] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Mon, 13 Jun 2011 17:25:11 -0700
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: from IRVEXCHCCR01.corp.ad.broadcom.com ([10.252.49.30]) by
 IRVEXCHHUB02.corp.ad.broadcom.com ([10.9.200.133]) with mapi; Mon, 13
 Jun 2011 17:20:56 -0700
From:   "Jian Peng" <jipeng@broadcom.com>
To:     "Jian Peng" <jipeng@broadcom.com>,
        "David Daney" <ddaney@caviumnetworks.com>
cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Mon, 13 Jun 2011 17:21:05 -0700
Subject: RE: patch to support topdown mmap allocation in MIPS
Thread-Topic: patch to support topdown mmap allocation in MIPS
Thread-Index: AcwbBVcOuMe2pbjkS7u+cbhp1RyQVgAABI5wA8d2QpAAAVJwwA==
Message-ID: <E18F441196CA634DB8E1F1C56A50A874572DE7E9A3@IRVEXCHCCR01.corp.ad.broadcom.com>
References: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DD1BD72.2000408@caviumnetworks.com>
 <E18F441196CA634DB8E1F1C56A50A8743242B54D97@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DD2A729.9090502@caviumnetworks.com>
 <E18F441196CA634DB8E1F1C56A50A8743242B54FA7@IRVEXCHCCR01.corp.ad.broadcom.com>
 <E18F441196CA634DB8E1F1C56A50A874572CCBB6B5@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DDD432D.4020200@caviumnetworks.com>
 <E18F441196CA634DB8E1F1C56A50A874572CCBB6D0@IRVEXCHCCR01.corp.ad.broadcom.com>
 <E18F441196CA634DB8E1F1C56A50A874572DE7E983@IRVEXCHCCR01.corp.ad.broadcom.com>
In-Reply-To: <E18F441196CA634DB8E1F1C56A50A874572DE7E983@IRVEXCHCCR01.corp.ad.broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
X-WSS-ID: 61E875ED4NS20234553-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-archive-position: 30374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jipeng@broadcom.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11092

Hi, David/Ralf,

I found out the commit log

commit 6f6c3c33c027f2c83d53e8562cd9daa73fe8108b
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Thu May 19 09:21:33 2011 +0100

    MIPS: Move arch_get_unmapped_area and gang to new file.
    
    It never really belonged into syscall.c and it's about to become well more
    complex.
    
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>


Ralf, do you want to pick up my patch on topdown mmap and merge into mmap.c or want me to do that?

I can test it if you have new patch.

Thanks,
Jian

-----Original Message-----
From: Jian Peng 
Sent: Monday, June 13, 2011 4:43 PM
To: Jian Peng; David Daney
Cc: linux-mips@linux-mips.org; Ralf Baechle
Subject: RE: patch to support topdown mmap allocation in MIPS

Hi, David/Ralf,

I tried to regenerate a patch for this, and after 

git clone git://git.linux-mips.org/pub/scm/linux

I found out that there is arch/mips/mm/mmap.c, but could not find out who/how this file was merged.

I doubt that I may "git clone" a wrong repo that is no longer valid.

Thanks,
Jian

-----Original Message-----
From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Jian Peng
Sent: Wednesday, May 25, 2011 11:07 AM
To: David Daney
Cc: linux-mips@linux-mips.org; Ralf Baechle
Subject: RE: patch to support topdown mmap allocation in MIPS

Hi, David,

I am willing to get more feedback and sort out issues before I forgot all details.

I post a simple testing program at http://www.linux-mips.org/archives/linux-mips/2011-05/msg00252.html
And it was also tested in a real application using mmap heavily and need this patch to avoid failure.

It is my bad to take your suggestion literally. How about arch_get_unmapped_area_common()?

Thanks,
Jian

-----Original Message-----
From: David Daney [mailto:ddaney@caviumnetworks.com] 
Sent: Wednesday, May 25, 2011 10:58 AM
To: Jian Peng
Cc: linux-mips@linux-mips.org; Ralf Baechle
Subject: Re: patch to support topdown mmap allocation in MIPS

On 05/25/2011 10:47 AM, Jian Peng wrote:
> Hi, Ralf/David,
>
> What else should I do to get this patch merged?
>

Be patient.  And tell how it was tested.


Also ....

[...]
> +
> +unsigned long arch_get_unmapped_area_foo(struct file *filp, unsigned long addr0,
> +               unsigned long len, unsigned long pgoff, unsigned long flags,
> +               enum mmap_allocation_direction dir)

I know I suggested the name *_foo, but really I expected you to choose a 
better name, as the 'foo' is just the default name for examples.

I think it needs a better name than that.

I will try to test it on my Octeon system sometime.

David Daney
