Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2011 19:58:20 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13047 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491192Ab1EYR6O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 May 2011 19:58:14 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ddd43720000>; Wed, 25 May 2011 10:59:14 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 25 May 2011 10:58:10 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 25 May 2011 10:58:10 -0700
Message-ID: <4DDD432D.4020200@caviumnetworks.com>
Date:   Wed, 25 May 2011 10:58:05 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Jian Peng <jipeng@broadcom.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: patch to support topdown mmap allocation in MIPS
References: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com> <4DD1BD72.2000408@caviumnetworks.com> <E18F441196CA634DB8E1F1C56A50A8743242B54D97@IRVEXCHCCR01.corp.ad.broadcom.com> <4DD2A729.9090502@caviumnetworks.com> <E18F441196CA634DB8E1F1C56A50A8743242B54FA7@IRVEXCHCCR01.corp.ad.broadcom.com> <E18F441196CA634DB8E1F1C56A50A874572CCBB6B5@IRVEXCHCCR01.corp.ad.broadcom.com>
In-Reply-To: <E18F441196CA634DB8E1F1C56A50A874572CCBB6B5@IRVEXCHCCR01.corp.ad.broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 May 2011 17:58:10.0689 (UTC) FILETIME=[4F588710:01CC1B05]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

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
