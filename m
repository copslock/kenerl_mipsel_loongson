Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 21:02:24 +0100 (CET)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:51000 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006154AbbAPUCXBPEqz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 21:02:23 +0100
Received: by mail-wi0-f173.google.com with SMTP id r20so4760300wiv.0;
        Fri, 16 Jan 2015 12:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gzpsemYdj7HYbOMpviy/b+t/v+B6/nxm5LWP0tF7Fog=;
        b=C2ovuDiReJXm9hHI6G3Ik5P+4Xo5Gl/3lCaAae3TMjhvJFBzwL9bn8SY6AVDATabpS
         Y1tJ2uXwwtrwqxlHvRn/zNA6kGhy91E6maxwv+MENq00rspngLrF7i7dUVKdQrdYALsh
         HI7JX+VfHoOW9vq7zeodMjmfZ6ZwK8yg3FiYajPE9mxdgqMLAT7MVqFKj8WKoJ/WABBm
         bCH3SavSFhwVwpNuSjBrlIlEOfVjx/G5YND8KE9xc2dFyXdLrLyuJQwNIWegJA+LSqIg
         3lJUtK9w4ygbd5pn64rXYSC2JsObfKNoirAKGZn5v2i+IExF6Sc0xZti3iHCGp7xTan7
         7cVg==
X-Received: by 10.180.83.129 with SMTP id q1mr9571031wiy.8.1421438537764; Fri,
 16 Jan 2015 12:02:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.216.105.144 with HTTP; Fri, 16 Jan 2015 12:01:37 -0800 (PST)
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320FA97DF@LEMAIL01.le.imgtec.org>
References: <CAOLZvyFP6FX3ydFdU7fmDd7GCnBCAPyLnxkmyjYknXP8Wui0kg@mail.gmail.com>
 <CAOLZvyGBOqCARmLx+rQ1CEgFw2TZBYYauGOiD9tF31MFsB-peQ@mail.gmail.com> <6D39441BF12EF246A7ABCE6654B0235320FA97DF@LEMAIL01.le.imgtec.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 16 Jan 2015 21:01:37 +0100
Message-ID: <CAOLZvyGUGr3ubbzNjoFLCEDk29Fbn4qjoT6xmT=F1OZ4L-YhMA@mail.gmail.com>
Subject: Re: 3.18+: soft-float userland unusable due to .MIPS.abiflags patch
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     Paul Burton <Paul.Burton@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Fri, Jan 16, 2015 at 8:12 PM, Matthew Fortune
<Matthew.Fortune@imgtec.com> wrote:
>> On Fri, Jan 16, 2015 at 6:59 PM, Manuel Lauss <manuel.lauss@gmail.com>
>> wrote:
>> > Hi Paul,
>> >
>> > Your patch commit 90cee759f08a6b7a8daab9977d3e163ebbcac220
>> > ("MIPS: ELF: Set FP mode according to .MIPS.abiflags") completely
>> > breaks my pure soft-float o32 userland:
>> >
>> > [...]
>> > Freeing unused kernel memory: 244K (80993000 - 809d0000) Failed to
>> > execute /usr/lib/systemd/systemd (error -84).  Attempting defaults...
>> > Starting init: /sbin/init exists but couldn't execute it (error -84)
>> > sh: cannot set terminal process group (-1): Inappropriate ioctl for
>> > device
>> > sh: no job control in this shell
>> > sh-4.3# ls
>> > sh: /bin/ls: Accessing a corrupted shared library sh-4.3#
>> >
>> > I've recently rebuilt bash, ncurses, readline and glibc-2.20 (with
>> > binutils 2.25+) to track down another userland issue, so that may
>> > explain why at least sh is able to run.
>>
>> Although ls and all its dependencies have the following soft-float abi
>> tag:
>> Displaying notes found at file offset 0x00000164 with length 0x00000020:
>>   Owner                 Data size       Description
>>   GNU                  0x00000010       NT_GNU_ABI_TAG (ABI version tag)
>>     OS: Linux, ABI: 2.6.32
>> Attribute Section: gnu
>> File Attributes
>>   Tag_GNU_MIPS_ABI_FP: Soft float
>
> Can you provide the output of readelf -hl for 'ls', 'init' and whatever is
> listed as the interpreter for those executables in the header output shown
> like:
>
>   INTERP         0x0000000000000238 0x0000000000400238 0x0000000000400238
>                  0x000000000000001c 0x000000000000001c  R      1
>       [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]


Here's the output, identical on all tested binaries and libs:

# readelf -hl /bin/ls
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0x403f20
  Start of program headers:          52 (bytes into file)
  Start of section headers:          131784 (bytes into file)
  Flags:                             0x50001005, noreorder, cpic, o32, mips32
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         9
  Size of section headers:           40 (bytes)
  Number of section headers:         33
  Section header string table index: 32

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  PHDR           0x000034 0x00400034 0x00400034 0x00120 0x00120 R E 0x4
  INTERP         0x000154 0x00400154 0x00400154 0x0000d 0x0000d R   0x1
      [Requesting program interpreter: /lib/ld.so.1]
  REGINFO        0x000184 0x00400184 0x00400184 0x00018 0x00018 R   0x4
  LOAD           0x000000 0x00400000 0x00400000 0x1d290 0x1d290 R E 0x10000
  LOAD           0x01e000 0x0042e000 0x0042e000 0x00378 0x00fb0 RW  0x10000
  DYNAMIC        0x00019c 0x0040019c 0x0040019c 0x00140 0x00140 R   0x4
  NOTE           0x000164 0x00400164 0x00400164 0x00020 0x00020 R   0x4
  GNU_EH_FRAME   0x01cb30 0x0041cb30 0x0041cb30 0x0002c 0x0002c R   0x4
  NULL           0x000000 0x00000000 0x00000000 0x00000 0x00000     0x4

 Section to Segment mapping:
  Segment Sections...
   00
   01     .interp
   02     .reginfo
   03     .interp .note.ABI-tag .reginfo .dynamic .hash .dynsym
.dynstr .gnu.version .gnu.version_r .rel.dyn .rel.plt .init .text
.MIPS.stubs .fini .rodata .eh_frame_hdr .eh_frame .plt
   04     .init_array .fini_array .jcr .got.plt .data .rld_map .got .sdata .bss
   05     .dynamic
   06     .note.ABI-tag
   07     .eh_frame_hdr
   08


# readelf -hl /usr/lib/systemd/systemd
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              DYN (Shared object file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0x165a0
  Start of program headers:          52 (bytes into file)
  Start of section headers:          1574780 (bytes into file)
  Flags:                             0x50001005, noreorder, cpic, o32, mips32
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         10
  Size of section headers:           40 (bytes)
  Number of section headers:         32
  Section header string table index: 31

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  PHDR           0x000034 0x00000034 0x00000034 0x00140 0x00140 R   0x4
  INTERP         0x000174 0x00000174 0x00000174 0x0000d 0x0000d R   0x1
      [Requesting program interpreter: /lib/ld.so.1]
  LOAD           0x000000 0x00000000 0x00000000 0x148bf8 0x148bf8 R E 0x10000
  LOAD           0x14ef68 0x0015ef68 0x0015ef68 0x1a788 0x1b06c RW  0x10000
  NULL           0x000000 0x00000000 0x00000000 0x00000 0x00000     0
  DYNAMIC        0x15feb0 0x0016feb0 0x0016feb0 0x00150 0x00150 RW  0x4
  NOTE           0x000184 0x00000184 0x00000184 0x00020 0x00020 R   0x4
  GNU_EH_FRAME   0x148bd4 0x00148bd4 0x00148bd4 0x00024 0x00024 R   0x4
  TLS            0x14ef68 0x0015ef68 0x0015ef68 0x00008 0x00061 R   0x8
  GNU_RELRO      0x14ef68 0x0015ef68 0x0015ef68 0x11098 0x11098 RW  0x8
