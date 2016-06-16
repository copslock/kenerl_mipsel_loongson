Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2016 08:17:24 +0200 (CEST)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35956 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042522AbcFPGRXLOvNj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Jun 2016 08:17:23 +0200
Received: by mail-oi0-f52.google.com with SMTP id p204so54288096oih.3;
        Wed, 15 Jun 2016 23:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=D6OWLCXeTDZabEisLOomKW7xVeCXrymlFNNYijCmKDc=;
        b=wqac77kqSCFpXfdVvVseTChjZAa17TLdFsz/r2qhd96+UfEHlotcc7Zy5FE591YAFY
         G+eDcVyznRmtKiLdMALKvn7K2AXTDtJHNdqi+0tBWtHlOTiDwVcN2s9lMoWxmC3uDtpf
         e4tbNbQ7NR28al5WjEE4/cfyQpE+jDleKm1o4se3xcWfPxnU//Hq7sPbGmQ5YnPj3hvP
         RIJ/OLnTkorbAkcLIZ25Oi3LilLBhmAkwWcMyaXf9nqAH+mpV59MVpmcXhReqwxQcFfm
         p53wXcfOYs+sXcGRuX2I2kftOxkMIrYWzCDMouew/0NZFANZhSF9PDKxwR4FNIclnfb4
         wG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=D6OWLCXeTDZabEisLOomKW7xVeCXrymlFNNYijCmKDc=;
        b=GbBP21Ldb8MHiADlHD5s18nO9G2WIhY7g/CT/k1hs1v71u9y/SHjKJI8tEZcK87cA3
         07rjAeb1xOZXwEH6YCtDnHbMLTJbTAJqtDMkTgk9enfnBFhoJaVvNptqU74w2+utCMDh
         WB61yTKvYcmMhin+BPJ/3mmQS+4wlBitGdqnKES7LeWgREmrNdaTyNMSw7uAgg4YddBI
         BxP/AsP7aeFcDyMi+1yGDqbGPnQtx11LBnp48kToMCHdp14rO00oZZWnehS+MObDvNzR
         7ZOIWyUQWre2m0XTh+bVSaswuXDya4MESV9HfnjArxg9+iejwRZxpLUGUFf+5fgkyIjI
         8SOQ==
X-Gm-Message-State: ALyK8tKYZq2LrLhB8vT4Yp+37pUZRCbBTFNWsPRLrzvujx1yjE54/XErI07MliMIq0eh9R1AbeI6WMAQYIKhMw==
X-Received: by 10.202.84.23 with SMTP id i23mr1280215oib.170.1466057837069;
 Wed, 15 Jun 2016 23:17:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.175.140 with HTTP; Wed, 15 Jun 2016 23:17:16 -0700 (PDT)
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Thu, 16 Jun 2016 08:17:16 +0200
Message-ID: <CACna6rwCPFWj1wJpm8sW2ZSfNpTRxi9-9MmzKSbJ617HW7LTNw@mail.gmail.com>
Subject: BCM4704 stopped booting with 4.4 (due to vmlinux size?)
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>,
        =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Larry Finger <larry.finger@lwfinger.net>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Paul Wassi <p.wassi@gmx.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

Hello,

From time to time I test new kernels with ancient Linksys WRT300N v1.0
device based on BCM4704 SoC.

I noticed that after updating kernel from 4.3 to 4.4 it doen't boot
anymore. All I can see is the last CFE's (bootloader's) message:
> Starting program at 0x80001000
Enabling CONFIG_EARLY_PRINTK doesn't help.

After hours or bisecting and testing I found out that it's not caused
by any /real/ code change but rather adding a kernel message. It seems
that by adding enough print messages I can stop kernel from booting.

I didn't know what exactly to look at so I started with "objdump
--syms vmlinux". I took 4.1.16 and 4.3.4 and tried adding to them
various amount of unique pr_info messages in some random error code
path (never executed). I noticed that address of .data was increasing
which makes me believe that it's a matter of .rodata size or some
affected size/offset in vmlinux.
1) 4.1.6: if .data starts at 80369000 of higher kernel doesn't boot.
2) 4.3.4: if .data starts at 80368000 of higher kernel doesn't boot.

Do you have any idea what this problem can be caused by? Any idea how
to fix/workaround it? Can I provide any extra info?

It doesn't affect all BCM4704 devices. Hauke also has some router
using this SoC and he couldn't reproduce this problem.
On the other hand Paul also experiences some problems with his Linksys
WRT54GL (BCM5352E), the last stable kernel for him seems to be 3.18.
Not sure if it's related however.


4.1.16

GOOD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802bd000 l    d  .rodata        00000000 .rodata
8035c000 l    d  .data  00000000 .data
8038ebc8 l    d  .init.data     00000000 .init.data

GOOD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802bd000 l    d  .rodata        00000000 .rodata
80365000 l    d  .data  00000000 .data
80398bc8 l    d  .init.data     00000000 .init.data

GOOD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802bd000 l    d  .rodata        00000000 .rodata
80367000 l    d  .data  00000000 .data
8039abc8 l    d  .init.data     00000000 .init.data

GOOD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802bd000 l    d  .rodata        00000000 .rodata
80368000 l    d  .data  00000000 .data
8039abc8 l    d  .init.data     00000000 .init.data

BAD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802bd000 l    d  .rodata        00000000 .rodata
80369000 l    d  .data  00000000 .data
8039cbc8 l    d  .init.data     00000000 .init.data

BAD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802bd000 l    d  .rodata        00000000 .rodata
8036a000 l    d  .data  00000000 .data
8039cbc8 l    d  .init.data     00000000 .init.data

BAD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802bd000 l    d  .rodata        00000000 .rodata
8036b000 l    d  .data  00000000 .data
8039ebc8 l    d  .init.data     00000000 .init.data


4.3.4

GOOD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802c0000 l    d  .rodata        00000000 .rodata
80362000 l    d  .data  00000000 .data
80394f68 l    d  .init.data     00000000 .init.data

GOOD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802c0000 l    d  .rodata        00000000 .rodata
80365000 l    d  .data  00000000 .data
80398f68 l    d  .init.data     00000000 .init.data

GOOD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802c0000 l    d  .rodata        00000000 .rodata
80367000 l    d  .data  00000000 .data
8039af68 l    d  .init.data     00000000 .init.data

BAD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802c0000 l    d  .rodata        00000000 .rodata
80368000 l    d  .data  00000000 .data
8039af68 l    d  .init.data     00000000 .init.data

BAD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802c0000 l    d  .rodata        00000000 .rodata
8036d000 l    d  .data  00000000 .data
803a0f68 l    d  .init.data     00000000 .init.data

BAD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802c0000 l    d  .rodata        00000000 .rodata
8036f000 l    d  .data  00000000 .data
803a2f68 l    d  .init.data     00000000 .init.data

BAD
> objdump --syms vmlinux | egrep "(ro)?data" | head -n 3
802c0000 l    d  .rodata        00000000 .rodata
80372000 l    d  .data  00000000 .data
803a4f68 l    d  .init.data     00000000 .init.data

-- 
Rafał
