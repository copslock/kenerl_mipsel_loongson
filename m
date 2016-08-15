Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2016 19:07:07 +0200 (CEST)
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33434 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992147AbcHORHAtJH05 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Aug 2016 19:07:00 +0200
Received: by mail-pf0-f172.google.com with SMTP id y134so18482866pfg.0
        for <linux-mips@linux-mips.org>; Mon, 15 Aug 2016 10:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=WYlICbUZMLgD/O/GT6+3w39sk/yFhIyyX74MRMwnyCY=;
        b=Cccmv31pCA+8frI+mBkfyvvrKGGPa8wUPGVddq6yNf0UgROKH3Te+n70ne/8QLVjMd
         h48LGmOEeFLGKarLBkx1PYo6L6J6fEbIQXcKkgdsG5wPm7Qy+XyRW9K3SNlYWkKhukIK
         1i4axgkXu0FDZcVuXauGHdF9MdHPe9tCZh3TP7B7Bu8q3+fcbHfPEuHdnDCu/GvfEpP4
         F8MRkPKegFoZ0eDS6OJHrwuYWJCoWb1LlopZq61EPPPhfN0SwE2UVaOaJpUcuH0TcaGm
         Td+WO1fR3nfAC9ay6paf29I51VgsuoymABtZodTU0gQODYJJF2dge1vmNZ/feM2z7ixH
         mR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=WYlICbUZMLgD/O/GT6+3w39sk/yFhIyyX74MRMwnyCY=;
        b=kE4lu6f5W30YchN16LGdjur+jGFLTZ2XcVSlCo9CvVGayljoY+6QFdzNB+SczHdHUD
         uQItQGRHqXJhkeR7nx60AOz2WTp1eVtAnYLfbWt8DniuJC4Zu3iBP2kN2IyFlOlGEJn3
         JjIEBzjIURELN0my1QiE/sfas5reU/ZVviikTDTPQ/XnOaw5/j3ZgmxiGsogjacjUCDW
         nZVD+muTqHrIWl1TKHHQY/c3qlzDo36jp+w5KsoBmTWXMlKiQTcP3+4MfKX8w7aj9ZGG
         DgjKOG/VYpd4A3aFILDJvxMaPqBKnGMfeBb5lcO96JUK09O+/J0mZzLajInwbQ0e6466
         YHqA==
X-Gm-Message-State: AEkoousSBq07itKGmC1EVJZQz0yXQlssNIUOIrODt4AXOwvjKYd9Xlif2jCHZLO82O2Gq17n
X-Received: by 10.98.70.8 with SMTP id t8mr55969775pfa.36.1471280813797;
        Mon, 15 Aug 2016 10:06:53 -0700 (PDT)
Received: from ?IPv6:2001:470:b8f6:1b:a8fa:c0f1:9ed4:3a65? ([2001:470:b8f6:1b:a8fa:c0f1:9ed4:3a65])
        by smtp.gmail.com with ESMTPSA id n10sm32897883pap.16.2016.08.15.10.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2016 10:06:53 -0700 (PDT)
Subject: Re: [V4 PATCH 2/2] mips/panic: Replace smp_send_stop() with kdump
 friendly version in panic path
To:     =?UTF-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?= 
        <hidehiro.kawai.ez@hitachi.com>, Dave Young <dyoung@redhat.com>
References: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160810080950.11028.28000.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160812031755.GB2983@dhcp-128-65.nay.redhat.com>
 <57ADD55D.1050003@mvista.com>
 <04EAB7311EE43145B2D3536183D1A84454CBBB00@GSjpTKYDCembx31.service.hitachi.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "x86@kernel.org" <x86@kernel.org>,
        David Daney <david.daney@cavium.com>,
        Xunlei Pang <xpang@redhat.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Vivek Goyal <vgoyal@redhat.com>
From:   Corey Minyard <cminyard@mvista.com>
Message-ID: <a618ef9b-25d5-da8b-6829-ce124b76033e@mvista.com>
Date:   Mon, 15 Aug 2016 12:06:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <04EAB7311EE43145B2D3536183D1A84454CBBB00@GSjpTKYDCembx31.service.hitachi.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <cminyard@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cminyard@mvista.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 08/15/2016 06:35 AM, 河合英宏 / KAWAI，HIDEHIRO wrote:
> Hi Corey,
>
>> From: Corey Minyard [mailto:cminyard@mvista.com]
>> Sent: Friday, August 12, 2016 10:56 PM
>> I'll try to test this, but I have one comment inline...
> Thank you very much!
>
>> On 08/11/2016 10:17 PM, Dave Young wrote:
>>> On 08/10/16 at 05:09pm, Hidehiro Kawai wrote:
> [snip]
>>>> diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
>>>> index 610f0f3..1723b17 100644
>>>> --- a/arch/mips/kernel/crash.c
>>>> +++ b/arch/mips/kernel/crash.c
>>>> @@ -47,9 +47,14 @@ static void crash_shutdown_secondary(void *passed_regs)
>>>>
>>>>    static void crash_kexec_prepare_cpus(void)
>>>>    {
>>>> +	static int cpus_stopped;
>>>>    	unsigned int msecs;
>>>> +	unsigned int ncpus;
>>>>
>>>> -	unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
>>>> +	if (cpus_stopped)
>>>> +		return;
>> Wouldn't you want an atomic operation and some special handling here to
>> ensure that only one CPU does this?  So if a CPU comes in here and
>> another CPU is already in the process stopping the CPUs it won't result in a
>> deadlock.
> Because this function can be called only one panicking CPU,
> there is no problem.
>
> There are two paths which crash_kexec_prepare_cpus is called.
>
> Path 1 (panic path):
> panic()
>    crash_smp_send_stop()
>      crash_kexec_prepare_cpus()
>
> Path 2 (oops path):
> crash_kexec()
>    __crash_kexec()
>      machine_crash_shutdown()
>        default_machine_crash_shutdown() // for MIPS
>          crash_kexec_prepare_cpus()
>
> Here, panic() and crash_kexec() run exclusively via
> panic_cpu atomic variable.  So we can use cpus_stopped as
> normal variable.

Ok, if the code can only be entered once, what's the purpose of 
cpus_stopped?
I guess that's what confused me.  You are right, the panic_cpu atomic should
keep this on a single CPU.

Also, panic() will call panic_smp_self_stop() if it finds another CPU 
has already
called panic, which will just spin with interrupts off by default. I 
didn't see a
definition for it in MIPS, wouldn't it need to be overridden to avoid a 
deadlock?

-corey

>
> Best regards,
>
> Hidehiro Kawai
>
