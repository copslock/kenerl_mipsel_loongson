Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Mar 2016 22:55:14 +0100 (CET)
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35296 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013783AbcCOVzNl-89s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Mar 2016 22:55:13 +0100
Received: by mail-wm0-f41.google.com with SMTP id l68so167249035wml.0;
        Tue, 15 Mar 2016 14:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=u62Gc/H8uTaP6do3zbfnXgKQ0izrruDyszjxh9rWeJI=;
        b=n3aCi9UfKM0LwaEF22L6POFoDHE1UBg12DV0L7peYkfF0I6gjkX7grpCdoDc8u5HrV
         Pplv49HILrSP8mt2dcTPrxBR5m0Crw1z7brKujxlIzd6DwnR/OLADXJyx4SGSWAh4DHm
         Tb7+0L1sN7JnaMW0yni3V5LHOJkGhbpi4i7K4ltwvwhUx11CgUX4lllZi+7+ei/GMLv2
         a6HuEOV8FkD1Kzsgp1NjFvMse8PA39n77Mar52P+M9bMNml4TM9j76nXJadie6Co+Hxv
         P/d1uVWhvNhliciBHMwvB6wvdcMrv0list0pfGFrieldc44G2n03usao27/S/uQMhyhG
         bL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=u62Gc/H8uTaP6do3zbfnXgKQ0izrruDyszjxh9rWeJI=;
        b=gFwcTzYV/UQ/QCuGbUkVMvK+PndGA2roWhZ6XgbH4s4QLTBQ1YdSCYLClE1V8mFakE
         3soDmoEaBGEYUu9U/q02m5wbA9WLPY143SeWFtj5aIUoI+pdIkajg4yJPoyK+uRE05ya
         RmhoNy6PbhL4x93Npvqwm5BzcCnX1pdWtldFPyXAy42eSkTgTcslMvwBhpkRCeF0Btey
         8WdDre3MVCEuiQqk142X1tEmRHcmJoMOxkFkE79PKWpcWjseObYD5u4Ek/e4PVpHR6V2
         QuEMdehzhuKPm6JkMYNiM6a7LL6NhFnI1icCSKpzUUi/MBQz1XRhIBb87e6Fi+opoF01
         AzAg==
X-Gm-Message-State: AD7BkJKR/FjmM0CGp25k5xtSYexQVV4XAlMh2NjbIUfXs1pDIT/Lexb4KTzppWbxqfr4Bg==
X-Received: by 10.28.46.5 with SMTP id u5mr779230wmu.75.1458078908379;
        Tue, 15 Mar 2016 14:55:08 -0700 (PDT)
Received: from Qaiss-MacBook-Pro.local (host81-158-249-115.range81-158.btcentralplus.com. [81.158.249.115])
        by smtp.gmail.com with ESMTPSA id ka4sm122229wjc.47.2016.03.15.14.55.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Mar 2016 14:55:07 -0700 (PDT)
Subject: Re: linux-next: Tree for Mar 14 (mips qemu failure bisected)
To:     Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20160314174037.0097df55@canb.auug.org.au>
 <20160314143729.GA31845@roeck-us.net> <20160315052659.GA9320@roeck-us.net>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
From:   Qais Yousef <qsyousef@gmail.com>
Message-ID: <56E884BA.5050103@gmail.com>
Date:   Tue, 15 Mar 2016 21:55:06 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160315052659.GA9320@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <qsyousef@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qsyousef@gmail.com
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

Hi Guenter,

On 15/03/2016 05:26, Guenter Roeck wrote:
> On Mon, Mar 14, 2016 at 07:37:29AM -0700, Guenter Roeck wrote:
>> On Mon, Mar 14, 2016 at 05:40:37PM +1100, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20160311:
>>>
>>> The vfs tree gained a conflict against Linus' tree. I also applied a
>>> patch for a known runtime bug.
>>>
>>> The tip tree gained a conflict against the mips tree.
>>>
>>> The aio tree still had a build failure so I removed several commits
>>> from it.  It also gained a conflict against the vfs tree.
>>>
>>> Non-merge commits (relative to Linus' tree): 11202
>>>   8646 files changed, 426680 insertions(+), 211740 deletions(-)
>>>
>> To give people an idea what to expect in the merge window, here are my current
>> build and runtime test results. Some of the runtime failures are due to the
>> newly introduced i2c bug, but many (including the arm64 boot failures) have
>> been around for a while.
>>
> [ ... ]
>
>> Qemu test results:
>> 	total: 96 pass: 69 fail: 27
>> Failed tests:
> [ ... ]
>> 	mips:mips_malta_smp_defconfig
> I bisected this failure to commit bb11cff327e54 ("MIPS: Make smp CMP, CPS and MT
> use the new generic IPI functions". Bisect log is attached.

Thanks for bisecting this. I tested this on a real Malta system but not 
qemu. I'll try to reproduce.

Can I get qemu run script and the instructions to use it from somewhere?

Thanks,
Qais

>
>> 	mips64:smp:mips_malta64_defconfig
>> 	mips:mipsel_malta_smp_defconfig
>> 	mips:mipsel_malta64_smp_defconfig
> If necessary I can repeat the bisect for those. Please let me know.
>
> Thanks,
> Guenter
>
> ---
> Bisect log:
>
> # bad: [4342eec3c5a2402ca5de3d6e56f541fe1c5171e2] Add linux-next specific files for 20160314
> # good: [f6cede5b49e822ebc41a099fe41ab4989f64e2cb] Linux 4.5-rc7
> git bisect start 'HEAD' 'v4.5-rc7'
> # good: [0525c3e26ec2c43cd509433be3be25210a0154ef] Merge remote-tracking branch 'drm-tegra/drm/tegra/for-next'
> git bisect good 0525c3e26ec2c43cd509433be3be25210a0154ef
> # bad: [385128a1b49762c1b9515c9f6294aeebbc55b956] Merge remote-tracking branch 'usb-chipidea-next/ci-for-usb-next'
> git bisect bad 385128a1b49762c1b9515c9f6294aeebbc55b956
> # good: [dfdb27baab4fc45c9399a991270413d0fb1c694a] Merge remote-tracking branch 'spi/for-next'
> git bisect good dfdb27baab4fc45c9399a991270413d0fb1c694a
> # bad: [e368d7d2a0dce6d6795ead1fc8a09bcca8a4a565] Merge branch 'timers/nohz'
> git bisect bad e368d7d2a0dce6d6795ead1fc8a09bcca8a4a565
> # good: [ced30bc9129777d715057d06fc8dbdfd3b81e94d] Merge tag 'perf-core-for-mingo-20160310' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core
> git bisect good ced30bc9129777d715057d06fc8dbdfd3b81e94d
> # bad: [656a61d4d9cbb8dfc2d007281190b2eccebad522] manual merge of mm/pkeys
> git bisect bad 656a61d4d9cbb8dfc2d007281190b2eccebad522
> # good: [16f7379f2da43f29d9faa2f474745e2705a3f510] Merge branch 'efi/core'
> git bisect good 16f7379f2da43f29d9faa2f474745e2705a3f510
> # bad: [a7fb9a8169be9a55e0cfb98346aece1b51c016fa] Merge branch 'locking/core'
> git bisect bad a7fb9a8169be9a55e0cfb98346aece1b51c016fa
> # good: [2a07870511829977d02609dac6450017b0419ea9] irqchip/mips-gic: Use gic_vpes instead of NR_CPUS
> git bisect good 2a07870511829977d02609dac6450017b0419ea9
> # good: [eaff0e7003cca6c2748b67ead2d4b1a8ad858fc7] locking/pvqspinlock: Move lock stealing count tracking code into pv_queued_spin_steal_lock()
> git bisect good eaff0e7003cca6c2748b67ead2d4b1a8ad858fc7
> # good: [013e379a3094ff2898f8d33cfbff1573d471ee14] tools/lib/lockdep: Fix link creation warning
> git bisect good 013e379a3094ff2898f8d33cfbff1573d471ee14
> # bad: [7eb8c99db26cc6499bfb1eba72dffc4730570752] MIPS: Delete smp-gic.c
> git bisect bad 7eb8c99db26cc6499bfb1eba72dffc4730570752
> # good: [fbde2d7d8290d8c642d591a471356abda2446874] MIPS: Add generic SMP IPI support
> git bisect good fbde2d7d8290d8c642d591a471356abda2446874
> # bad: [bb11cff327e54179c13446c4022ed4ed7d4871c7] MIPS: Make smp CMP, CPS and MT use the new generic IPI functions
> git bisect bad bb11cff327e54179c13446c4022ed4ed7d4871c7
> # first bad commit: [bb11cff327e54179c13446c4022ed4ed7d4871c7] MIPS: Make smp CMP, CPS and MT use the new generic IPI functions
