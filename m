Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2011 19:45:02 +0200 (CEST)
Received: from mail-pz0-f53.google.com ([209.85.210.53]:54058 "EHLO
        mail-pz0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491803Ab1GORoz convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Jul 2011 19:44:55 +0200
Received: by pzk6 with SMTP id 6so1939552pzk.26
        for <linux-mips@linux-mips.org>; Fri, 15 Jul 2011 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fNGFwPa5t58uTJJWiyhaQcgxbBpkxw/KVuINtbdUJCU=;
        b=kjhPiZP/OUnAD4GKLWxhl95vrzsgczJsNWgF37CuazITYm4zzWs/0D+dC6/IXKxIuy
         v31hxwotaYJcsANVQUJs5A6s9iHP5t1l3JenwNdd7SsR1X/1EKgiaXGHy0OMzkFPy4hI
         M4zBXLgHCePm2WWptDRt+FHVYhlBWTyfiDXMo=
MIME-Version: 1.0
Received: by 10.68.57.71 with SMTP id g7mr4772586pbq.447.1310751888718; Fri,
 15 Jul 2011 10:44:48 -0700 (PDT)
Received: by 10.68.54.131 with HTTP; Fri, 15 Jul 2011 10:44:48 -0700 (PDT)
In-Reply-To: <CALGOZk2M8Hn_EA+Mqg3frZzLGZgr0bbj3VV8mUqUB1taCdwXJg@mail.gmail.com>
References: <CALGOZk2M8Hn_EA+Mqg3frZzLGZgr0bbj3VV8mUqUB1taCdwXJg@mail.gmail.com>
Date:   Fri, 15 Jul 2011 10:44:48 -0700
Message-ID: <CAJiQ=7Chq8zP9LHLvnQ_3Hi-YSD4PTbxT73ZLc=M2jLSZpW_cA@mail.gmail.com>
Subject: Re: Confusion with vmlinux objcopy translation
From:   Kevin Cernekee <cernekee@gmail.com>
To:     David Peverley <pev@sketchymonkey.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11237

On Fri, Jul 15, 2011 at 7:56 AM, David Peverley <pev@sketchymonkey.com> wrote:
> Checking via GDB to see what the code looks like :
>  (gdb) disassemble kernel_entry
>  Dump of assembler code for function kernel_entry:
>  0x80504590 <kernel_entry+0>:    add    %ah,0x8(%eax)
>  0x80504593 <kernel_entry+3>:    inc    %eax

In the future, you may want to use "disass/r kernel_entry" to see the
hex instructions, and correlate that output to what you see in the
file.

It would also be helpful to use a cross gdb built for MIPS.

But the "objdump -d" output is probably enough to go on.  e.g.
mipsel-percello-linux-gnu-objdump -d vmlinux | grep -A5
'kernel_entry.:'

> I then convert this vmlinux file to a binary image :
>  $ mipsel-percello-linux-gnu-objcopy -O binary ./vmlinux ./vmlinux.bin.test
>
> and then hexdump to see what's at the kernel_entry offset :
>  $ xxd -g xxd -g 4 -s 0x4550 -l 0x80 ./vmlinux.bin.test
>  0004550: 00600840 0010013c 1f002134 25400101  .`.@...<..!4%@..
>  0004560: 1f000839 00608840 c0000000 5080083c  ...9.`.@....P..<
>  0004570: bc450825 08000001 00000000 9c80083c  .E.%...........<
>  0004580: 00700825 000000ad a180093c dcb22925  .p.%.......<..)%
>  0004590: 04000825 feff0915 000000ad 9c80013c  ...%...........<
>  00045a0: 647624ac 9c80013c 687625ac 9c80013c  dv$....<hv%....<
>  00045b0: 6c7626ac 9c80013c 707627ac 00208040  lv&....<pv'.. .@
>  00045c0: 96801c3c 00609c27 e01f1d24 21e8bc03  ...<.`.'...$!...
>
> The code for kernel_entry seems to be at an offset of 0x0004550. This
> is -0x40 bytes below where I'd expected! Am I missing something? I can
> confirm this by using my bootloader to load vmlinux.bin a
> (load_address + 0x40) and it runs just fine.

I think the key here is the load address of the first ELF section.
>From the objcopy man page:

"objcopy can be used to generate a raw binary file by using an output
target of binary (e.g., use -O binary).  When objcopy generates a raw
binary file, it will essentially produce a memory dump of the contents
of the input object file.  All symbols and relocation information will
be discarded.  The memory dump will start at the load address of the
lowest section copied into the output file."

So, the kernel_entry address really does not matter in this context.
Although obviously it's good to know whether the kernel_entry code is
getting loaded into the right memory location.

Posting the output from "objdump -x vmlinux" (or maybe even a URL from
which to download your vmlinux file) may help shed light on what is
happening.

BTW: I enable CONFIG_BOOT_RAW on my images so that I don't have to
worry about finding the ELF start address after converting vmlinux
into a raw binary image.  This lets me jump to a fixed start address,
even if the address of kernel_entry moves around.
