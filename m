Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2011 05:16:38 +0100 (CET)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:52708 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491028Ab1BDEQf convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Feb 2011 05:16:35 +0100
Received: by qyk10 with SMTP id 10so8180378qyk.15
        for <multiple recipients>; Thu, 03 Feb 2011 20:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y1bdS1MWuKnnmTDKUjWKv6OzOYsZ85uJbNlWYXsaYPg=;
        b=BLNdhHqCBMP69M9HFQUyqT0/v4GB2CZurytC5964NF7YmP6J5TmHDHRh9CKw+CsFlM
         Axyc2z9im7sKudKA4dzw6+IYKPpzxXhOQSfol40rvQwxaTLiaGB+AIAyQJdXaBfA7LGz
         GzwuOjOCf+kD6LPv9gr6VZjy0limoCU/UYpFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dxVbclfeastaYFjUsOAzAO2oeyT71ZLkZLaRDkNiONmvnMnA9mjFSnAF7OqKOZQbtM
         ukqsEyO2NzuZ0GnSgzdnfcmZyt6JFoBnmSv0XWb0nQebiAgTPYhFPKAh3EQIXrYPm7Jh
         UH0tOukUKHrXKbzYyOavVXehLJyoOPFHrDpaM=
MIME-Version: 1.0
Received: by 10.229.223.195 with SMTP id il3mr8020136qcb.278.1296792987110;
 Thu, 03 Feb 2011 20:16:27 -0800 (PST)
Received: by 10.229.98.5 with HTTP; Thu, 3 Feb 2011 20:16:27 -0800 (PST)
In-Reply-To: <AANLkTi=UTRk8e6fv3USP5RPKY-Fg0ehGBXrf0bD8NthX@mail.gmail.com>
References: <AANLkTik+vpiWR4Xk4Pu+uCHq3XO=BZMGVka8-B9vuQew@mail.gmail.com>
        <4D3DCB5A.6060107@caviumnetworks.com>
        <AANLkTin6GkKeJATbafP-k9YNcSTHeT8ohDpUD2RLDZ1J@mail.gmail.com>
        <20110131130820.GB26217@linux-mips.org>
        <AANLkTi=UTRk8e6fv3USP5RPKY-Fg0ehGBXrf0bD8NthX@mail.gmail.com>
Date:   Fri, 4 Feb 2011 09:46:27 +0530
Message-ID: <AANLkTimCfioamQWGeRCFFN=OoWE7-PhGs2tCH+_9H=HO@mail.gmail.com>
Subject: Re: page size change on MIPS
From:   naveen yadav <yad.naveen@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Himanshu Aggarwal <lkml.himanshu@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        kernelnewbies@nl.linux.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, I am adding readelf info also .

mips-linux-gnu-readelf -S squashfs-root/bin/busybox
There are 35 section headers, starting at offset 0x174290:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .note.ABI-tag     NOTE            004000d4 0000d4 000020 00   A  0   0  4
  [ 2] .reginfo          MIPS_REGINFO    004000f4 0000f4 000018 18   A  0   0  4
  [ 3] .rel.dyn          REL             0040010c 00010c 000010 08   A  0   0  4
  [ 4] .init             PROGBITS        0040011c 00011c 00005c 00  AX  0   0  4
  [ 5] .text             PROGBITS        00400180 000180 11d2b0 00  AX  0   0 16
  [ 6] __libc_freeres_fn PROGBITS        0051d430 11d430 001368 00  AX  0   0  4
  [ 7] __libc_thread_fre PROGBITS        0051e798 11e798 000148 00  AX  0   0  4
  [ 8] .fini             PROGBITS        0051e8e0 11e8e0 000034 00  AX  0   0  4
  [ 9] .rodata           PROGBITS        0051e920 11e920 02d560 00   A  0   0 16
  [10] __libc_subfreeres PROGBITS        0054be80 14be80 000058 00   A  0   0  4
  [11] __libc_atexit     PROGBITS        0054bed8 14bed8 000004 00   A  0   0  4
  [12] __libc_thread_sub PROGBITS        0054bedc 14bedc 000008 00   A  0   0  4
  [13] .gcc_except_table PROGBITS        0054bee4 14bee4 0001fb 00   A  0   0  1
  [14] .eh_frame         PROGBITS        0055c0e0 14c0e0 002464 00  WA  0   0  4
  [15] .tdata            PROGBITS        0055e544 14e544 000018 00 WAT  0   0  4
  [16] .tbss             NOBITS          0055e55c 14e55c 000034 00 WAT  0   0  4
  [17] .ctors            PROGBITS        0055e55c 14e55c 000008 00  WA  0   0  4
  [18] .dtors            PROGBITS        0055e564 14e564 00000c 00  WA  0   0  4
  [19] .jcr              PROGBITS        0055e570 14e570 000004 00  WA  0   0  4
  [20] .data.rel.ro      PROGBITS        0055e574 14e574 000030 00  WA  0   0  4
  [21] .data             PROGBITS        0055e5b0 14e5b0 000b30 00  WA  0   0 16
  [22] .got              PROGBITS        0055f0e0 14f0e0 000148 04 WAp  0   0 16
  [23] .sdata            PROGBITS        0055f228 14f228 000004 00 WAp  0   0  4
  [24] .sbss             NOBITS          0055f230 14f22c 000184 00 WAp  0   0  8
  [25] .bss              NOBITS          0055f3c0 14f22c 00516c 00  WA  0   0 16
  [26] __libc_freeres_pt NOBITS          0056452c 14f22c 000040 00  WA  0   0  4
  [27] .pdr              PROGBITS        00000000 14f22c 016880 00      0   0  4
  [28] .comment          PROGBITS        00000000 165aac 0027e0 00      0   0  1
  [29] .debug_frame      MIPS_DWARF      00000000 16828c 00be88 00      0   0  4
  [30] .gnu.attributes   LOOS+ffffff5    00000000 174114 000010 00      0   0  1
  [31] .mdebug.abi32     PROGBITS        000030c0 174124 000000 00      0   0  1
  [32] .shstrtab         STRTAB          00000000 174124 00016c 00      0   0  1
  [33] .symtab           SYMTAB          00000000 174808 015320 10
34 2843  4
  [34] .strtab           STRTAB          00000000 189b28 012f65 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)


On Fri, Feb 4, 2011 at 8:54 AM, naveen yadav <yad.naveen@gmail.com> wrote:
> thanaks a lot for your suggestion ..
>
>
> I debug this issue further, and here is my observations:
>
> 1. If I replace init with simple static link executable binary, this
> can be executed.
> 2. In case of busy-box, I debug the reason why init fails to excute.
>
> When I execute init command from busybox the control goes in main()
> function of busybox(appletlib.c) with argv value
> as the command you are suppose to execute, which in our case is init.
>
> But when i check argv is coming null when page size is 64KB and it
> comes init when page size is 16KB.
>
> This behaviour is very strange and i am still debugging this issue.
>
>
> I have check in Glibc, the max_page size it support is 64 KB in
> codesourcercy toolchain 4.4.1
>
> How can I check alignment issue as mention by Mr. Ralf Baechle.
>
>
>
> Kind regards
>
>
>
>
> On Mon, Jan 31, 2011 at 6:38 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Sun, Jan 30, 2011 at 08:32:43PM +0530, Himanshu Aggarwal wrote:
>>
>>> Why should the application or the toolchains depend on pagesize? I am
>>> not very clear on this. Can someone explain it?
>>
>> To allow loading directly with mmap the executable file's layout must
>> be such that it's it's segments are on offsets that are a multiple of
>> the page size so in turn the linker must know that alignment.
>>
>>  Ralf
>>
>
