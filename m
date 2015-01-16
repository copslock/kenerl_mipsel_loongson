Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 21:36:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17130 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009839AbbAPUgV0fGLr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 21:36:21 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 17A40A3D840A3;
        Fri, 16 Jan 2015 20:36:11 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 20:36:14 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Fri, 16 Jan 2015 20:36:14 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Paul Burton <Paul.Burton@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: 3.18+: soft-float userland unusable due to .MIPS.abiflags patch
Thread-Topic: 3.18+: soft-float userland unusable due to .MIPS.abiflags patch
Thread-Index: AQHQMbZETJL51Hv6jkWZmajb6hjbjpzDCtmAgAARsJCAAA6CgIAAAMIAgAAAiiA=
Date:   Fri, 16 Jan 2015 20:36:12 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320FA9A04@LEMAIL01.le.imgtec.org>
References: <CAOLZvyFP6FX3ydFdU7fmDd7GCnBCAPyLnxkmyjYknXP8Wui0kg@mail.gmail.com>
 <CAOLZvyGBOqCARmLx+rQ1CEgFw2TZBYYauGOiD9tF31MFsB-peQ@mail.gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320FA97DF@LEMAIL01.le.imgtec.org>
 <CAOLZvyGUGr3ubbzNjoFLCEDk29Fbn4qjoT6xmT=F1OZ4L-YhMA@mail.gmail.com>
 <CAOLZvyE7nk4r+gcYTkdbfeDWh6c75RRhijuh-XY=AK98LF81LA@mail.gmail.com>
In-Reply-To: <CAOLZvyE7nk4r+gcYTkdbfeDWh6c75RRhijuh-XY=AK98LF81LA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.111]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Manuel Lauss <manuel.lauss@gmail.com> writes:
> On Fri, Jan 16, 2015 at 9:01 PM, Manuel Lauss <manuel.lauss@gmail.com>
> wrote:
> > On Fri, Jan 16, 2015 at 8:12 PM, Matthew Fortune
> > <Matthew.Fortune@imgtec.com> wrote:
> >>> On Fri, Jan 16, 2015 at 6:59 PM, Manuel Lauss
> >>> <manuel.lauss@gmail.com>
> >>> wrote:
> >>> > Hi Paul,
> >>> >
> >>> > Your patch commit 90cee759f08a6b7a8daab9977d3e163ebbcac220
> >>> > ("MIPS: ELF: Set FP mode according to .MIPS.abiflags") completely
> >>> > breaks my pure soft-float o32 userland:
> >>> >
> >>> > [...]
> >>> > Freeing unused kernel memory: 244K (80993000 - 809d0000) Failed to
> >>> > execute /usr/lib/systemd/systemd (error -84).  Attempting
> defaults...
> >>> > Starting init: /sbin/init exists but couldn't execute it (error
> >>> > -84)
> >>> > sh: cannot set terminal process group (-1): Inappropriate ioctl
> >>> > for device
> >>> > sh: no job control in this shell
> >>> > sh-4.3# ls
> >>> > sh: /bin/ls: Accessing a corrupted shared library sh-4.3#
> >>> >
> >>> > I've recently rebuilt bash, ncurses, readline and glibc-2.20 (with
> >>> > binutils 2.25+) to track down another userland issue, so that may
> >>> > explain why at least sh is able to run.
> >>>
> >>> Although ls and all its dependencies have the following soft-float
> >>> abi
> >>> tag:
> >>> Displaying notes found at file offset 0x00000164 with length
> 0x00000020:
> >>>   Owner                 Data size       Description
> >>>   GNU                  0x00000010       NT_GNU_ABI_TAG (ABI version
> tag)
> >>>     OS: Linux, ABI: 2.6.32
> >>> Attribute Section: gnu
> >>> File Attributes
> >>>   Tag_GNU_MIPS_ABI_FP: Soft float
> >>
> >> Can you provide the output of readelf -hl for 'ls', 'init' and
> >> whatever is listed as the interpreter for those executables in the
> >> header output shown
> >> like:
> >>
> >>   INTERP         0x0000000000000238 0x0000000000400238
> 0x0000000000400238
> >>                  0x000000000000001c 0x000000000000001c  R      1
> >>       [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
> 
> 
> I noticed that /bin/sh does have a .MIPS.abiflags section while systemd
> and ls do not.  Maybe that's the issue here?
> 
>  Section to Segment mapping:
>   Segment Sections...
>    00
>    01     .interp
>    02     .MIPS.abiflags

It is the ABIFLAGS program header that I am focussed on but the presence of
a .MIPS.abiflags section is a strong indicator that there will be an
ABIFLAGS pheader. The key is in the readelf output for the interpreter i.e.
/lib/ld.so.1. I would expect it has the ABIFLAGS header too given you
said that you recently rebuilt glibc.

You are right that it is the .MIPS.abiflags patch that is causing your
trouble. For a long time I had to put a restriction in the ABI plan that
soft-float binaries without an ABIFLAGS pheader could not be linked against
soft-float binaries with an ABIFLAGS pheader. We have since found a way to
relax that restriction without reducing the effectiveness of the new
compatibility checks. I would need to check the code in the kernel but I 
suspect that is the issue. Markos has done a significant update to this
piece of code which he posted earlier today. That updated version should
allow the combination of soft-float without ABIFLAGS and soft-float with
ABIFLAGS.

Matthew
