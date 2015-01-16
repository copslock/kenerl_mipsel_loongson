Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 21:05:08 +0100 (CET)
Received: from mail-we0-f179.google.com ([74.125.82.179]:58412 "EHLO
        mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009340AbbAPUFGeIMez (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 21:05:06 +0100
Received: by mail-we0-f179.google.com with SMTP id m14so360751wev.10;
        Fri, 16 Jan 2015 12:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hRGC2AkYUzb9jbnKTR3/xSb5omjxORxNUiBXHy5lSwA=;
        b=ItfOQPeC94Dms+46ZbStRDSfwORFj+e76qFlhsRMMGDKDum3WXR84h7DPQHOW8n/C8
         X7+/GGlCSLBNWqBwijDW7/lpt4klN+Qc57qeLPwXH8evCSjgHWL9o6Hbk88/KXPh5tdy
         0KCdo0bPcwpum87FA9rxDqMePP7On12f10kz1C9KKe8M3DJ09QZUc6qomD991EPCnBJI
         JY+MdKPhG0tLghjccWcxhFFBS1CnCYmao7UhUj6s1f2Lv5vVgusAgeXhf4qWVeEmPfYa
         OI4trlthPI95g6Hcjz1O24kpaV1evaLqGiJyvrClX+cKmrvZPQqFTNzYSwKnwpQ+BcgP
         EmXA==
X-Received: by 10.180.90.81 with SMTP id bu17mr9317524wib.23.1421438701358;
 Fri, 16 Jan 2015 12:05:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.216.105.144 with HTTP; Fri, 16 Jan 2015 12:04:20 -0800 (PST)
In-Reply-To: <CAOLZvyGUGr3ubbzNjoFLCEDk29Fbn4qjoT6xmT=F1OZ4L-YhMA@mail.gmail.com>
References: <CAOLZvyFP6FX3ydFdU7fmDd7GCnBCAPyLnxkmyjYknXP8Wui0kg@mail.gmail.com>
 <CAOLZvyGBOqCARmLx+rQ1CEgFw2TZBYYauGOiD9tF31MFsB-peQ@mail.gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320FA97DF@LEMAIL01.le.imgtec.org> <CAOLZvyGUGr3ubbzNjoFLCEDk29Fbn4qjoT6xmT=F1OZ4L-YhMA@mail.gmail.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 16 Jan 2015 21:04:20 +0100
Message-ID: <CAOLZvyE7nk4r+gcYTkdbfeDWh6c75RRhijuh-XY=AK98LF81LA@mail.gmail.com>
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
X-archive-position: 45237
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

On Fri, Jan 16, 2015 at 9:01 PM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
> On Fri, Jan 16, 2015 at 8:12 PM, Matthew Fortune
> <Matthew.Fortune@imgtec.com> wrote:
>>> On Fri, Jan 16, 2015 at 6:59 PM, Manuel Lauss <manuel.lauss@gmail.com>
>>> wrote:
>>> > Hi Paul,
>>> >
>>> > Your patch commit 90cee759f08a6b7a8daab9977d3e163ebbcac220
>>> > ("MIPS: ELF: Set FP mode according to .MIPS.abiflags") completely
>>> > breaks my pure soft-float o32 userland:
>>> >
>>> > [...]
>>> > Freeing unused kernel memory: 244K (80993000 - 809d0000) Failed to
>>> > execute /usr/lib/systemd/systemd (error -84).  Attempting defaults...
>>> > Starting init: /sbin/init exists but couldn't execute it (error -84)
>>> > sh: cannot set terminal process group (-1): Inappropriate ioctl for
>>> > device
>>> > sh: no job control in this shell
>>> > sh-4.3# ls
>>> > sh: /bin/ls: Accessing a corrupted shared library sh-4.3#
>>> >
>>> > I've recently rebuilt bash, ncurses, readline and glibc-2.20 (with
>>> > binutils 2.25+) to track down another userland issue, so that may
>>> > explain why at least sh is able to run.
>>>
>>> Although ls and all its dependencies have the following soft-float abi
>>> tag:
>>> Displaying notes found at file offset 0x00000164 with length 0x00000020:
>>>   Owner                 Data size       Description
>>>   GNU                  0x00000010       NT_GNU_ABI_TAG (ABI version tag)
>>>     OS: Linux, ABI: 2.6.32
>>> Attribute Section: gnu
>>> File Attributes
>>>   Tag_GNU_MIPS_ABI_FP: Soft float
>>
>> Can you provide the output of readelf -hl for 'ls', 'init' and whatever is
>> listed as the interpreter for those executables in the header output shown
>> like:
>>
>>   INTERP         0x0000000000000238 0x0000000000400238 0x0000000000400238
>>                  0x000000000000001c 0x000000000000001c  R      1
>>       [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]


I noticed that /bin/sh does have a .MIPS.abiflags section while systemd
and ls do not.  Maybe that's the issue here?

 Section to Segment mapping:
  Segment Sections...
   00
   01     .interp
   02     .MIPS.abiflags

 Manuel
