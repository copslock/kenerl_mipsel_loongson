Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Jan 2011 16:02:54 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:57075 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491128Ab1A3PCv convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 30 Jan 2011 16:02:51 +0100
Received: by iyj21 with SMTP id 21so4268615iyj.36
        for <linux-mips@linux-mips.org>; Sun, 30 Jan 2011 07:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ylb4WnsJxMsYb7oCveeDVdTu7TknPB2jnXdj1xRIMeA=;
        b=k8WXAEWC+RgCnimOeJs5KTcpHCxsnc4+1A+rZSq2ApP/5yl5pleD0HoJiSoCxT5qEX
         CYMdXNf8YH1OvJ09EMx/isMTFNifRYNnQ7A2I9gKLeNX/9g0uN7FQ5LoldFm/+ZhBu1T
         BxySua0VPEwsSAT8RmtNb+ERrtp0XFoI9Riv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ETOh339m0y4gyG7j3Xsj8MAikW/Ez/tfl0rK63cXA/qYezg90Pk9KMZZ+gG7YvSzzz
         Mou5ljqikqw8QBFQUTnGRBtrgpalpIbpCnwOL8VHgoTvyXy6FnOTFyYTld6DD4aAz43u
         gmdmT6CPGK5AWtlI8uTwwIRpCEv6CFCamxhy8=
MIME-Version: 1.0
Received: by 10.42.230.1 with SMTP id jk1mr6666754icb.67.1296399763976; Sun,
 30 Jan 2011 07:02:43 -0800 (PST)
Received: by 10.42.224.193 with HTTP; Sun, 30 Jan 2011 07:02:43 -0800 (PST)
In-Reply-To: <4D3DCB5A.6060107@caviumnetworks.com>
References: <AANLkTik+vpiWR4Xk4Pu+uCHq3XO=BZMGVka8-B9vuQew@mail.gmail.com>
        <4D3DCB5A.6060107@caviumnetworks.com>
Date:   Sun, 30 Jan 2011 20:32:43 +0530
Message-ID: <AANLkTin6GkKeJATbafP-k9YNcSTHeT8ohDpUD2RLDZ1J@mail.gmail.com>
Subject: Re: page size change on MIPS
From:   Himanshu Aggarwal <lkml.himanshu@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     naveen yadav <yad.naveen@gmail.com>, kernelnewbies@nl.linux.org,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <lkml.himanshu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lkml.himanshu@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 25, 2011 at 12:26 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 01/24/2011 07:02 AM, naveen yadav wrote:
>> Hi All,
>>
>>
>> we are using mips32r2  so I want to know which all pages size it can support?
>> When I modify arch/mips/Kconfig.  it boot sucessfully on 16KB page
>> size. but hang/not boot crash when change page size to 8KB,32KB and 64
>> KB.
>
> I don't think 8KB and 32KB work on most mips32r2 processors.  You would
> have to check the processor manual to be sure.
>
>
>>
>> We are using 2.6.30 kernel.
>>
>> At Page Size 8KB and 32KB  it hang in unpack_to_rootfs() function of
>> init/initramfs.c
>>
>> 64KB it hangs when execute init  Kernel panic - not syncing: Attempted
>> to kill init!
>
> I regularly run 4K, 16K, and 64K page sizes with a Debian rootfs.  If
> you run with a broken uClibc toolchain that doesn't support larger
> pages, it will of course fail.  In this case the problem is with your
> toolchain, not the kernel.
>
> David Daney
>
>
>>
>> config PAGE_SIZE_4KB
>>          bool "4kB"
>>          help
>>           This option select the standard 4kB Linux page size.  On some
>>           R3000-family processors this is the only available page size.  Using
>>           4kB page size will minimize memory consumption and is therefore
>>           recommended for low memory systems.
>>
>> config PAGE_SIZE_8KB
>>          bool "8kB"
>>         depends on (EXPERIMENTAL&&  CPU_R8000) || CPU_CAVIUM_OCTEON
>>          help
>>            Using 8kB page size will result in higher performance kernel at
>>            the price of higher memory consumption.  This option is available
>>            only on R8000 and cnMIPS processors.  Note that you will need a
>>            suitable Linux distribution to support this.
>>
>> config PAGE_SIZE_16KB
>>          bool "16kB"
>>         depends on !CPU_R3000&&  !CPU_TX39XX
>>          help
>>            Using 16kB page size will result in higher performance kernel at
>>            the price of higher memory consumption.  This option is available on
>>            all non-R3000 family processors.  Note that you will need a suitable
>>            Linux distribution to support this.
>>
>> config PAGE_SIZE_32KB
>>          bool "32kB"
>>          help
>>            Using 32kB page size will result in higher performance kernel at
>>            the price of higher memory consumption.  This option is available
>>            only on cnMIPS cores.  Note that you will need a suitable Linux
>>            distribution to support this.
>>
>> config PAGE_SIZE_64KB
>>          bool "64kB"
>>         depends on EXPERIMENTAL&&  !CPU_R3000&&  !CPU_TX39XX
>>          help
>>            Using 64kB page size will result in higher performance kernel at
>>            the price of higher memory consumption.  This option is available on
>>            all non-R3000 family processor.  Not that at the time of this
>>            writing this option is still high experimental.
>>
>>
>
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>

Why should the application or the toolchains depend on pagesize? I am
not very clear on this. Can someone explain it?

Regards,
Himanshu
