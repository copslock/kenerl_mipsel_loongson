Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2011 20:07:10 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4916 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491193Ab1EYSHD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 May 2011 20:07:03 +0200
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Wed, 25 May 2011 11:10:54 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from IRVEXCHCCR01.corp.ad.broadcom.com ([10.252.49.30]) by
 IRVEXCHHUB02.corp.ad.broadcom.com ([10.9.200.133]) with mapi; Wed, 25
 May 2011 11:06:39 -0700
From:   "Jian Peng" <jipeng@broadcom.com>
To:     "David Daney" <ddaney@caviumnetworks.com>
cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Wed, 25 May 2011 11:06:44 -0700
Subject: RE: patch to support topdown mmap allocation in MIPS
Thread-Topic: patch to support topdown mmap allocation in MIPS
Thread-Index: AcwbBVcOuMe2pbjkS7u+cbhp1RyQVgAABI5w
Message-ID: <E18F441196CA634DB8E1F1C56A50A874572CCBB6D0@IRVEXCHCCR01.corp.ad.broadcom.com>
References: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DD1BD72.2000408@caviumnetworks.com>
 <E18F441196CA634DB8E1F1C56A50A8743242B54D97@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DD2A729.9090502@caviumnetworks.com>
 <E18F441196CA634DB8E1F1C56A50A8743242B54FA7@IRVEXCHCCR01.corp.ad.broadcom.com>
 <E18F441196CA634DB8E1F1C56A50A874572CCBB6B5@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DDD432D.4020200@caviumnetworks.com>
In-Reply-To: <4DDD432D.4020200@caviumnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
X-WSS-ID: 61C399A41IC11794642-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <jipeng@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jipeng@broadcom.com
Precedence: bulk
X-list: linux-mips

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
