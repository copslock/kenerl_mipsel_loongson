Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2011 21:55:01 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:44800 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491084Ab1C2Ty4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Mar 2011 21:54:56 +0200
Received: by qyl38 with SMTP id 38so438487qyl.15
        for <linux-mips@linux-mips.org>; Tue, 29 Mar 2011 12:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dyDOf3wl0aO1rCEnsNVKe+JJHvzPEWxrFhftHtr9mXw=;
        b=gz6jmhY8wFRRwk6sumAUdXFHJQNwESLxFy1f4KueIXWQFTX0iIXMOX1sqegufxnoqv
         G5rJHN+ZmhZ+tChlUoW77J72hBUUQPiLqJpmETJo3wcD8B0IJC48PAMT3kOgays+55Vd
         7xkTQ3pgiAV1dS3APbEIzxZHdGqj7pfR20vwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YgQuT8j5kJ2yvwRBT1eoFvPsmwY32hXXKMuRDLICPoTOcaVzaq8KYe0BbGJMjX0qt5
         72rnTEjWvTpfNxkxWY4vOZxf/itVT7zh4LWEy4nhpRsDJPFD8GbzWozJjHIGZRW6t/3R
         DmuJ/BQdsaqUEHWkqg57DjF4sKEuKisy9Bk64=
MIME-Version: 1.0
Received: by 10.224.217.8 with SMTP id hk8mr261726qab.181.1301428490601; Tue,
 29 Mar 2011 12:54:50 -0700 (PDT)
Received: by 10.224.2.146 with HTTP; Tue, 29 Mar 2011 12:54:50 -0700 (PDT)
In-Reply-To: <AANLkTi=gMP6jQuQFovfsOX=7p-SSnwXoVLO_DVEpV63h@mail.gmail.com>
References: <9bde694e1003020554p7c8ff3c2o4ae7cb5d501d1ab9@mail.gmail.com>
        <AANLkTinnqtXf5DE+qxkTyZ9p9Mb8dXai6UxWP2HaHY3D@mail.gmail.com>
        <1300960540.32158.13.camel@e102109-lin.cambridge.arm.com>
        <AANLkTim139fpJsMJFLiyUYvFgGMz-Ljgd_yDrks-tqhE@mail.gmail.com>
        <1301395206.583.53.camel@e102109-lin.cambridge.arm.com>
        <AANLkTim-4v5Cbp6+wHoXjgKXoS0axk1cgQ5AHF_zot80@mail.gmail.com>
        <1301399454.583.66.camel@e102109-lin.cambridge.arm.com>
        <AANLkTin0_gT0E3=oGyfMwk+1quqonYBExeN9a3=v=Lob@mail.gmail.com>
        <AANLkTi=gMP6jQuQFovfsOX=7p-SSnwXoVLO_DVEpV63h@mail.gmail.com>
Date:   Tue, 29 Mar 2011 22:54:50 +0300
Message-ID: <AANLkTimu54k-EEqfN58-hNTTgc54HktEeao+TyaKD30Z@mail.gmail.com>
Subject: Re: kmemleak for MIPS
From:   Daniel Baluta <daniel.baluta@gmail.com>
To:     Maxin John <maxin.john@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <daniel.baluta@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.baluta@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Mar 29, 2011 at 10:36 PM, Maxin John <maxin.john@gmail.com> wrote:
> Hi,
>
> I have prepared the combined patch for kmemleak porting to MIPS. After
> applying the patch and enabling the kmemleak in Kernel, I can see one
> kernel memleak reported during booting itself:
> ..
> ..
>
> TCP cubic registered
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> kmemleak: Kernel memory leak detector initialized
> rtc_cmos rtc_cmos: setting system clock to 2011-03-29 18:20:41 UTC (1301422841)
> kmemleak: Automatic memory scanning thread started
> EXT3-fs: barriers not enabled
> kjournald starting. �Commit interval 5 seconds
> EXT3-fs (hda1): mounted filesystem with ordered data mode
> VFS: Mounted root (ext3 filesystem) readonly on device 3:1.
> Freeing prom memory: 956k freed
> Freeing unused kernel memory: 244k freed
> modprobe: FATAL: Could not load
> /lib/modules/2.6.38-08826-g1788c20-dirty/modules.dep: No such file or
> directory
>
> INIT: version 2.86 booting
> Starting the hotplug events dispatcher: udevdudevd (863):
> /proc/863/oom_adj is deprecated, please use /proc/863/oom_score_adj
> instead.
> .
> Synthesizing the initial hotplug events...done.
> Waiting for /dev to be fully populated...kmemleak: 1 new suspected
> memory leaks (see /sys/kernel/debug/kmemleak)
> ....
> ....
>
> debian-mips:~#
> debian-mips:~# mount -t debugfs nodev /sys/kernel/debug/
> debian-mips:~# �cat /sys/kernel/debug/kmemleak
> unreferenced object 0x8f90d000 (size 4096):
> �comm "swapper", pid 1, jiffies 4294937330 (age 815.000s)
> �hex dump (first 32 bytes):
> � �00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 �................
> � �00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 �................
> �backtrace:
> � �[<80529644>] alloc_large_system_hash+0x2f8/0x410
> � �[<805383b4>] udp_table_init+0x4c/0x158
> � �[<805384dc>] udp_init+0x1c/0x94
> � �[<8053889c>] inet_init+0x184/0x2a0
> � �[<80100584>] do_one_initcall+0x174/0x1e0
> � �[<8051f348>] kernel_init+0xe4/0x174
> � �[<80103d4c>] kernel_thread_helper+0x10/0x18
>
>
> The standard kmemleak test case is behaving as expected. Based on
> this, I think, we can say that the kmemleak support for MIPS is
> working.
>
> Please let me know your comments.

This looks good to me.

thanks,
Daniel.
