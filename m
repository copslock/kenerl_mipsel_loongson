Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 22:22:17 +0100 (CET)
Received: from mail-qc0-f181.google.com ([209.85.216.181]:59205 "EHLO
        mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013795AbaKQVWMegCLP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 22:22:12 +0100
Received: by mail-qc0-f181.google.com with SMTP id m20so4345059qcx.12
        for <multiple recipients>; Mon, 17 Nov 2014 13:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D7q56/1ColYsOGeuTGJ5hdJz8KYJ3jmzzJ6yXaTYRsc=;
        b=qc9JXTvmJDSlYzhgXcYeP7g4vu/KeZGWbtMKi4NLhCG/nNaNkz8rpETFosdEbtk9lv
         hBtJWZtWrGbugiJTXdEw3FG8SyLtTE2Ly/dmyaL2oUjGiftf9gSN9NVMJcIscQCtP6aK
         /loKjmvJj5Nm90rGPhCWJeZZv4og22nPVXlw1MjrJyaejxxCuwYnOiPl7DYABUlGeS7w
         yFkZUXeUNQa4kH3a5CwrGoIcX2W4eXBCnn6NKg14sFUwPdqztV54qpLsamx9M3873nZn
         qCWBFsAdienQisvahFCm8Hsf2pRlsJgZRfjspg0MdDb3J+VwE6aXDzsoGonjLIucNk3z
         cOqA==
X-Received: by 10.140.46.75 with SMTP id j69mr29725621qga.106.1416259325758;
 Mon, 17 Nov 2014 13:22:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Mon, 17 Nov 2014 13:21:45 -0800 (PST)
In-Reply-To: <3357597.nYlNZ6O0nJ@wuerfel>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
 <2911624.UJRs5QOPN5@wuerfel> <CAJiQ=7BH8K=Q+JcWTKSfn6xAteOF4B6jahMu_qVd-FyZWD3pjA@mail.gmail.com>
 <3357597.nYlNZ6O0nJ@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 17 Nov 2014 13:21:45 -0800
Message-ID: <CAJiQ=7B6Xwz2iqqH4vEG8WzPOzHj7NHsuGWqq49uy-E34RHp4A@mail.gmail.com>
Subject: Re: [PATCH V2 22/22] MIPS: Add multiplatform BMIPS target
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Mon, Nov 17, 2014 at 12:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> One possible complication: for BCM63xx/BCM7xxx (MIPS) there is no
>> decompressor in the kernel.  The firmware loads an ELF image into
>> memory and jumps directly to kernel_entry.
>>
>
> Right, that complicates it a bit, but is there a reason why a decompressor
> would be hard to do, or would be considered a bad thing?
> There is already generic decompressor code in arch/mips/boot/compressed/
> that I would assume you could use without firmware changes. Are you
> worried about boot time overhead?

Currently the bootloader is responsible for decompressing the image.
On STB the bootloader typically loads a gzipped ELF file; on DSL/CM
the bootloader unpacks a custom image format containing an
LZMA-compressed kernel in some form.  So we would be
double-compressing the same kernel in this scheme.

STB/DSL should be able to boot the arch/mips/boot/compressed "vmlinuz"
ELF file; I tested STB.  CM might be questionable, but doesn't need
decompressor mods because the bootloader is DT-aware.

Also, the decompressor may need to be modified so that it recognizes /
passes / doesn't overwrite DTB blobs coming from the bootloader.  And
to make sure it doesn't stomp on any of the code or data that our
bootloaders use for their callback mechanisms.

So, one possibility is to submit a V3 patch which allows 0 or 1 DTB
files to be compiled in statically (similar to
CONFIG_ARM_APPENDED_DTB) and requires a DT-aware bootloader or
decompressor for anything else.  Any opinions?
