Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 19:07:10 +0100 (CET)
Received: from mail-wg0-f51.google.com ([74.125.82.51]:54295 "EHLO
        mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006154AbbAPSHIga--u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 19:07:08 +0100
Received: by mail-wg0-f51.google.com with SMTP id x12so21851941wgg.10;
        Fri, 16 Jan 2015 10:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XtQxocVBIzZMWYwbTRkdD6Lb9qok47lm75YoR108l2Q=;
        b=BNPugwuHm4waeoojqZWLsuAWr31cZLNybMs7RwPO5N0VZdcDi22exSO+PTBKQppnoI
         6ZjM7zT6TCYtNu5PYBaIOPutzGPVou+NDzz2uV9KrQbWw5HG8dxFQ2LHyEPcJvb8lxNS
         ggYENhAdfzKYcv9j2VlbA9w3ur6oFcd4rxEk2XLhiZBmYsRwpXLgxWfeiD//60iZ8u1c
         N1oYNAVVQ7nYv4ik76WOF3LmAO8/dOoYLT0FFToWEuOWq+lyGlcw1ex3V53WM8vT02nv
         fXasi97IbWODjqDa+tl+5F/eeIRDoHdnBz2xmH5K2Xo0TVwUyfkOu3vtrz+h3PtrHa9q
         yBTw==
X-Received: by 10.180.160.144 with SMTP id xk16mr8912206wib.12.1421431623400;
 Fri, 16 Jan 2015 10:07:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.216.105.144 with HTTP; Fri, 16 Jan 2015 10:06:23 -0800 (PST)
In-Reply-To: <CAOLZvyFP6FX3ydFdU7fmDd7GCnBCAPyLnxkmyjYknXP8Wui0kg@mail.gmail.com>
References: <CAOLZvyFP6FX3ydFdU7fmDd7GCnBCAPyLnxkmyjYknXP8Wui0kg@mail.gmail.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 16 Jan 2015 19:06:23 +0100
Message-ID: <CAOLZvyGBOqCARmLx+rQ1CEgFw2TZBYYauGOiD9tF31MFsB-peQ@mail.gmail.com>
Subject: Re: 3.18+: soft-float userland unusable due to .MIPS.abiflags patch
To:     Paul Burton <paul.burton@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45232
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

On Fri, Jan 16, 2015 at 6:59 PM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
> Hi Paul,
>
> Your patch commit 90cee759f08a6b7a8daab9977d3e163ebbcac220
> ("MIPS: ELF: Set FP mode according to .MIPS.abiflags") completely
> breaks my pure soft-float o32 userland:
>
> [...]
> Freeing unused kernel memory: 244K (80993000 - 809d0000)
> Failed to execute /usr/lib/systemd/systemd (error -84).  Attempting defaults...
> Starting init: /sbin/init exists but couldn't execute it (error -84)
> sh: cannot set terminal process group (-1): Inappropriate ioctl for device
> sh: no job control in this shell
> sh-4.3# ls
> sh: /bin/ls: Accessing a corrupted shared library
> sh-4.3#
>
> I've recently rebuilt bash, ncurses, readline and glibc-2.20 (with
> binutils 2.25+)
> to track down another userland issue, so that may explain why at least
> sh is able to run.

Although ls and all its dependencies have the following soft-float abi tag:
Displaying notes found at file offset 0x00000164 with length 0x00000020:
  Owner                 Data size       Description
  GNU                  0x00000010       NT_GNU_ABI_TAG (ABI version tag)
    OS: Linux, ABI: 2.6.32
Attribute Section: gnu
File Attributes
  Tag_GNU_MIPS_ABI_FP: Soft float


Manuel
