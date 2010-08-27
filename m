Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Aug 2010 21:07:32 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:44148 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490959Ab0H0THZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Aug 2010 21:07:25 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id o7RJ7Ekk029153;
        Fri, 27 Aug 2010 12:07:14 -0700
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id o7RJ7CwI016548;
        Fri, 27 Aug 2010 12:07:13 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id o7RJ7Be02239;
        Fri, 27 Aug 2010 12:07:11 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Does Linux Mips support compressed Kernel?
Date:   Fri, 27 Aug 2010 12:07:09 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D07601005C14@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTin5_3PPUoRocZFZuWhF9kFvmThUHgz3jp5ZaXMU@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: Does Linux Mips support compressed Kernel?
thread-index: ActGCzQWBMvHnvnETl2kVd8EAG5Z2gADs0Qw
References: <AEA634773855ED4CAD999FBB1A66D07601005801@CORPEXCH1.na.ads.idt.com> <AANLkTin5_3PPUoRocZFZuWhF9kFvmThUHgz3jp5ZaXMU@mail.gmail.com>
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     "wu zhangjin" <wuzhangjin@gmail.com>
Cc:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi Wu,

Thanks a lot for all the details.

I am using MALTA board with 74K. 
From your email I understand that the bootloader must uncompress the
Kernel before launching it, so the compressed Kernel cannot run and
decompress itself? Could you confirm? I am asking that because in some
book I have read that Linux can boot a compressed image and the Kernel
was able to uncompress itself, but maybe it was my misunderstanding.

Thanks,
Andrei
 

-----Original Message-----
From: wu zhangjin [mailto:wuzhangjin@gmail.com] 
Sent: Friday, August 27, 2010 1:09 PM
To: Ardelean, Andrei
Cc: linux-mips@linux-mips.org
Subject: Re: Does Linux Mips support compressed Kernel?

Hi,

On 8/27/10, Ardelean, Andrei <Andrei.Ardelean@idt.com> wrote:
> Hi,
>
> Does Linux Mips support compressed Kernel?

The answer maybe yes for we have added the basic compressed kernel
support from 2.6.33:

arch/mips/boot/compressed/

but which board are you using? I just checked the arch/mips/Kconfig of
2.6.35 and only found the following boards enabled it:

config MACH_ALCHEMY
        bool "Alchemy processor based machines"
        select SYS_SUPPORTS_ZBOOT

config AR7
        bool "Texas Instruments AR7"
        [snip]
        select SYS_SUPPORTS_ZBOOT_UART16550

config MACH_LOONGSON
        bool "Loongson family of machines"
        select SYS_SUPPORTS_ZBOOT_UART16550

config MIPS_MALTA
        bool "MIPS Malta board"
        [snip]
        select SYS_SUPPORTS_ZBOOT

> How can I obtain it?
>

If your board are not related to any of the ones above, then, you may
need to select SYS_SUPPORTS_ZBOOT for your board and try it.

If it doesn't work, you may need to debug it with serial port or the
other methods. If your board have a 16550 compatible serial port, you
may be possible to select SYS_SUPPORTS_ZBOOT_UART16550 instead of
SYS_SUPPORTS_ZBOOT to enable the serial port debugging support, and at
last, to enable the serial port debugging output, you need to enable
CONFIG_DEBUG_ZBOOT.

You can get more help from arch/mips/boot/compressed/

BTW, to enable the zboot support, the bootloader of your board may
need the capability to parse the elf file.

Regards,
Wu Zhangjin
