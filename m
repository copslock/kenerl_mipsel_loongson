Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 14:47:47 +0200 (CEST)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:33153
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994231AbdFFMq2tYvbb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 14:46:28 +0200
Received: by mail-oi0-x243.google.com with SMTP id h4so24425650oib.0
        for <linux-mips@linux-mips.org>; Tue, 06 Jun 2017 05:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=T7lYZQVgrqA2+m4wU/qywIxN+Ygu0d7zAsKu+uFHBrs=;
        b=tfPGXbj3YOVA/R/EN+WvuPM9hOz4Bx/6i4xj/nkMxpVXWWVxuMFzi7XW7XjYxGUTuW
         poSCInNI+HJpBka3lypO+WDBdZEyACm1bjJDMp2k72tHQUM2j0hsWI7BUIDS2NtEWZ68
         pkZo+0+tMXEq42IDIucabVQ10qcINfbJtS3O2LV9zOE/OsVYvvU5gzti5SB8TC4LQTRh
         iK4A/Re6QTEaA66BoadD0mNZ8x52xG+LA2ttDWqeb3iZID1VyFBxtYLtnudPlY2RYTGv
         eXLJFtNUyHzSheFGCx/vS5uQOeoXK33LGmp/xYPLRdnG/97SO357PsUjTBPpTit5ga+5
         +j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=T7lYZQVgrqA2+m4wU/qywIxN+Ygu0d7zAsKu+uFHBrs=;
        b=Da+PynJiMtGxOVjr2Lj8n+sPPBF8jjtybAJHEfbDpDGSIQytkfzhbe5fPtv9vsr3rH
         6pGINJRjJHFxIPGuWsA5U5oKmVBSLQ30G9bthMcojZgHBPTCuPdLxX72FOetc+CHSuyk
         2m6Sbp8b54F2nqXGVYePADmxyMFPUFDD0qeW0CFUEFwCYulgyg3KIN4xELs31T/E0F3R
         E1p3WlbkIwcNy9GsacnwSrhfPBJOpFKN47GI7r1powMzgPMO+IH9lPXea9xyRO5+M+fE
         ttx48cYLOLypGzPOt5o3DbGA6TLsF1AQTVqEzMZ1F+ty+J768y5WeHNCHvYWc8UPAzxu
         7eLg==
X-Gm-Message-State: AODbwcDbqMj1I1nfLkj+gmeIaT7JDNqgc5evmCo+tzOYUFpj/UF1mXcq
        i/aysVCwQzJ1K8fBS90PV3pE0PDTCw==
X-Received: by 10.202.196.67 with SMTP id u64mr8107764oif.40.1496753181111;
 Tue, 06 Jun 2017 05:46:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.51.139 with HTTP; Tue, 6 Jun 2017 05:46:20 -0700 (PDT)
In-Reply-To: <6faa7b93-a355-f7ba-e5e9-12f2414ac695@suse.de>
References: <20170603135111.5444-1-asarai@suse.de> <20170603135111.5444-2-asarai@suse.de>
 <CAK8P3a3j4rB+iVX=a36csE6mX9iMRp14TS1UeePyFsjTKQyiZw@mail.gmail.com> <6faa7b93-a355-f7ba-e5e9-12f2414ac695@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jun 2017 14:46:20 +0200
X-Google-Sender-Auth: R6Vewl9M6cNqc8Mmqc9xy7qmFGY
Message-ID: <CAK8P3a1XsE9uCwn9N7oc4GycPERX3t1XhGyiixxRjhG8GXoEuA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tty: add compat_ioctl callbacks
To:     Aleksa Sarai <asarai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Valentin Rothberg <vrothberg@suse.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Tue, Jun 6, 2017 at 1:05 PM, Aleksa Sarai <asarai@suse.de> wrote:
>>> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
>>> index 65799575c666..2a6bd9ae3f8b 100644
>>> --- a/drivers/tty/pty.c
>>> +++ b/drivers/tty/pty.c
>>> @@ -481,6 +481,16 @@ static int pty_bsd_ioctl(struct tty_struct *tty,
>>>          return -ENOIOCTLCMD;
>>>   }
>>>
>>> +static long pty_bsd_compat_ioctl(struct tty_struct *tty,
>>> +                                unsigned int cmd, unsigned long arg)
>>> +{
>>> +       /*
>>> +        * PTY ioctls don't require any special translation between
>>> 32-bit and
>>> +        * 64-bit userspace, they are already compatible.
>>> +        */
>>> +       return pty_bsd_ioctl(tty, cmd, arg);
>>> +}
>>> +
>>
>>
>> This looks correct but unnecessary, you can simply point both
>> function pointers to the same function:
>
>
> They have different types, since they have different return types:
>
> int  (*ioctl)(struct tty_struct *tty,
>             unsigned int cmd, unsigned long arg);
> long (*compat_ioctl)(struct tty_struct *tty,
>                      unsigned int cmd, unsigned long arg);
>
> If you like, I can change (*ioctl) to return longs as well, and then change
> all of the call-sites (since unlocked_ioctl also returns long).

Ah, my mistake. In most other data structures that have a compat_ioctl
callback pointer, the prototypes are the same, and I had not realized
that tty_operations is an exception.

        Arnd
