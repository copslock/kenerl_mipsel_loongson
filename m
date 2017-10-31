Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 00:43:26 +0100 (CET)
Received: from adrastea.cedarwireless.com ([IPv6:2620:26:c001:1001:0:1:7:44]:50068
        "EHLO adrastea.cedarwireless.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991726AbdJaXnT2kGHU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2017 00:43:19 +0100
Received: from localhost (localhost [127.0.0.1])
        by adrastea.cedarwireless.com (Postfix) with ESMTP id 921A1FC7
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 16:43:15 -0700 (PDT)
X-Virus-Scanned: amavisd-new at cedarwireless.com
Received: from adrastea.cedarwireless.com ([127.0.0.1])
        by localhost (adrastea.cedarwireless.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z2Day79DacNc for <linux-mips@linux-mips.org>;
        Tue, 31 Oct 2017 16:42:44 -0700 (PDT)
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smtprelay)
        by adrastea.cedarwireless.com (Postfix) with ESMTPSA id CE3F7E1A
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 16:42:42 -0700 (PDT)
Received: by mail-wm0-f46.google.com with SMTP id y83so1905440wmc.4
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 16:42:42 -0700 (PDT)
X-Gm-Message-State: AMCzsaUzzl+qDHNsoCuj67KYVWaBY/ilTovlSO7A4fdCy8OvRzH/cpKD
        creFt23yzNViGvmL25tiHJHoboVpKWHbmFCOAdw=
X-Google-Smtp-Source: ABhQp+S3rPUVy2KhRqth0FiH41wus7LZe0hDe80qZcsj4iJem/qLrizBPnL65YsJKL7PgHzPbGIcoAlGsachbNFDJtY=
X-Received: by 10.28.91.65 with SMTP id p62mr2848491wmb.126.1509493360703;
 Tue, 31 Oct 2017 16:42:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.163.3 with HTTP; Tue, 31 Oct 2017 16:42:40 -0700 (PDT)
In-Reply-To: <CAO3KpR1MRHr=1_2g=UT3P8Jq1fEA3XbEf=-rA6nk4mBHdU5CDg@mail.gmail.com>
References: <CAO3KpR3+j86m_Bbq=C0Ws4jR3RHO9oq0Gdkq60JP4szqNKcosQ@mail.gmail.com>
 <3d272dc1-4012-c7ed-7c34-876265afb25e@caviumnetworks.com> <CAO3KpR1VGFYdY-Mxb+Xx6yzKhzXAycizEm_7f9LT5GdXcLbkDQ@mail.gmail.com>
 <c726a4ab-632a-0788-1147-c3de26ab6b75@caviumnetworks.com> <CAO3KpR2oYGY89utWTpwd0+hzXQ8xJCsNpxLaX7fxV6hWiFbtNQ@mail.gmail.com>
 <148da245-c31e-03e9-3d19-f7d125507b96@caviumnetworks.com> <CAO3KpR1MRHr=1_2g=UT3P8Jq1fEA3XbEf=-rA6nk4mBHdU5CDg@mail.gmail.com>
From:   Gabriel Kuri <gkuri@ieee.org>
Date:   Tue, 31 Oct 2017 16:42:40 -0700
X-Gmail-Original-Message-ID: <CAO3KpR0N_ySTUgjuj=0_2gaobTv1AoixKwbACUNNwbrggACYbw@mail.gmail.com>
Message-ID: <CAO3KpR0N_ySTUgjuj=0_2gaobTv1AoixKwbACUNNwbrggACYbw@mail.gmail.com>
Subject: Re: Octeon CN5010 - Kernel 4.4.92
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <gkuri@ieee.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gkuri@ieee.org
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

>> When booting Octeon Linux, it is important to use the bootoctlinux command.
>
> I had to hard code the command line before compiling the kernel, it
> wouldn't take the argument in their U-Boot.
>
> But now it panics saying "Incorrect memory mapping". See below.
>
> It seems it thinks it has 0 RAM at location 0x0 according to the output below.
>
> Is there anyway to tell it via the command line to use 64M @ 0x0 ?

When mem=0 didn't work, I figured out I could give it mem=64M@0 and
now it thinks it has 64M of RAM, but it's still stuck only using 20MB
of RAM out of the 64M, which goes back to my original issue of the
kernel memory map being messed up?


[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 0000000001800000 @ 0000000002800000 (usable)
[    0.000000]  memory: 00000000016186c8 @ 0000000001100000 (usable)
[    0.000000] User-defined physical RAM map:
[    0.000000]  memory: 0000000004000000 @ 0000000000000000 (usable)
[    0.000000] Using internal Device Tree.
[    0.000000] software IO TLB [mem 0x02724000-0x02764000] (0MB)
mapped at [8000000002724000-800000000]
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000efffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000003ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000003ffffff]
[    0.000000] Primary instruction cache 32kB, virtually tagged, 4
way, 64 sets, linesize 128 bytes.
[    0.000000] Primary data cache 16kB, 64-way, 2 sets, linesize 128 bytes.
[    0.000000] PERCPU: Embedded 13 pages/cpu @8000000002771000 s16048
r8192 d29008 u53248
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 16160
[    0.000000] Kernel command line:  bootoctlinux bed00000
console=ttyS0,9600 mtdparts=phys_mapped_fla0
[    0.000000] PID hash table entries: 256 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 21392K/65536K available (3384K kernel code,
264K rwdata, 968K rodata, 1312K ini)



# cat /proc/iomem
00000000-03ffffff : System RAM
  01100000-0144e613 : Kernel code
  0144e614-01587fff : Kernel data
1f400000-1fbfffff : 1f400000.nor
1070000000800-10700000008ff : /soc@0/gpio-controller@1070000000800
1180000000800-118000000083f : serial
1180000000c00-1180000000c3f : serial
1180000001000-11800000011ff : /soc@0/i2c@1180000001000
1180000001800-118000000183f : /soc@0/mdio@1180000001800
1180040000000-118004000000f : octeon_rng
11b00f0000000-11b0130000000 : Octeon PCI MEM
  11b00f0000000-11b00f000ffff : 0000:00:03.0
  11b00f0010000-11b00f001ffff : 0000:00:04.0
1400000000000-1400000000007 : octeon_rng
