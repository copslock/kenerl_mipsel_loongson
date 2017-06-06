Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 13:02:19 +0200 (CEST)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:34936
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993908AbdFFLBaEidmM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 13:01:30 +0200
Received: by mail-oi0-x242.google.com with SMTP id v74so1057016oie.2
        for <linux-mips@linux-mips.org>; Tue, 06 Jun 2017 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qHDKWJ4Uy1VdijPZeGOSploOIp4wW9O1Y1eMeDS5Ojc=;
        b=Mk4hwmoBipL0Ho91j65GjNMmdosFP1t4RuDpqWacyS88J3PwwLXQ5kxQztoozb32r3
         kzXpAiC0TfsSWiI+6J+0sY/NkE7w/HPmNR5jiFsZuXoQg7TuDhJ5f45oUbBCmHOe142E
         RpVomvEIHGRCiX9cOf54A7XAp1A+rj8Oni9j6YvKdVJiqoAR/zpIGqIDIiMZpdhdUqNw
         Ebhn7O5UjO/XULwZ8DTABxI/QFezGyYLUpjQdhvt8iCi2SkZR4d9GLEiHlOsSezqEMAI
         VSylnb+D1JpR7N3eDnk2PUpnFrRLNvw8Wmajir5+SG8D0/AS1BCv4ouXxiSP23IWrwlm
         nFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qHDKWJ4Uy1VdijPZeGOSploOIp4wW9O1Y1eMeDS5Ojc=;
        b=GsTCR6TACTg6M1OL19505atvSs7Ao/JlC65+F9wAF1gvkmz5p5mXFrI3S+wVwknbqI
         5CA8A6XgKHABOhJdDUFsQahW90u1tcXRZdFNEfVI37zaEP4kJH1PDe3KKsVL7Wp49ihA
         uR6YkOecdsDZZ/VWFD35Q8LpyDsud6HNxSHZXWWQnDJeruYNu/CjyGb4zk3OJSWvCRwx
         mSCdMn4SuI9vgQV3XPJAb1b6V68qFzD8wL8DpfQGHddUoyqjB8p4m21nKtiI2oVChXX8
         wUSQnWA49GHDj8Qf6WmqIqc7L12LGXR7fztaWxlPyV0dJBsGtN2PbVzbuxSkYwsLshFT
         Ds4g==
X-Gm-Message-State: AODbwcAsOeWr2ui/tWckX9OVteYI9V81dXivZmxTnak7192C2GDX5flj
        CrVsEv1gndDDawANgVudnwMXB7oA6Q==
X-Received: by 10.202.184.85 with SMTP id i82mr9925870oif.71.1496746884014;
 Tue, 06 Jun 2017 04:01:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.51.139 with HTTP; Tue, 6 Jun 2017 04:01:23 -0700 (PDT)
In-Reply-To: <20170603135111.5444-2-asarai@suse.de>
References: <20170603135111.5444-1-asarai@suse.de> <20170603135111.5444-2-asarai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jun 2017 13:01:23 +0200
X-Google-Sender-Auth: 8vMSgZqQ9mUIBJngx_a3gB0vwls
Message-ID: <CAK8P3a3j4rB+iVX=a36csE6mX9iMRp14TS1UeePyFsjTKQyiZw@mail.gmail.com>
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
X-archive-position: 58255
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

On Sat, Jun 3, 2017 at 3:51 PM, Aleksa Sarai <asarai@suse.de> wrote:
> In order to avoid future diversions between fs/compat_ioctl.c and
> drivers/tty/pty.c, define .compat_ioctl callbacks for the relevant
> tty_operations structs. Since both pty_unix98_ioctl() and
> pty_bsd_ioctl() are compatible between 32-bit and 64-bit userspace no
> special translation is required.
>
> Signed-off-by: Aleksa Sarai <asarai@suse.de>
> ---
>  Makefile          |  1 +
>  drivers/tty/pty.c | 22 ++++++++++++++++++++++
>  fs/compat_ioctl.c |  6 ------
>  3 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 470bd4d9513a..fb689286d83a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -401,6 +401,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>                    -fno-strict-aliasing -fno-common \
>                    -Werror-implicit-function-declaration \
>                    -Wno-format-security \
> +                  -Wno-error=int-in-bool-context \
>                    -std=gnu89 $(call cc-option,-fno-PIE)

This  slipped in by accident I assume? It seems completely unrelated.

> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index 65799575c666..2a6bd9ae3f8b 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -481,6 +481,16 @@ static int pty_bsd_ioctl(struct tty_struct *tty,
>         return -ENOIOCTLCMD;
>  }
>
> +static long pty_bsd_compat_ioctl(struct tty_struct *tty,
> +                                unsigned int cmd, unsigned long arg)
> +{
> +       /*
> +        * PTY ioctls don't require any special translation between 32-bit and
> +        * 64-bit userspace, they are already compatible.
> +        */
> +       return pty_bsd_ioctl(tty, cmd, arg);
> +}
> +

This looks correct but unnecessary, you can simply point both
function pointers to the same function:

>   * not really modular, but the easiest way to keep compat with existing
> @@ -502,6 +512,7 @@ static const struct tty_operations master_pty_ops_bsd = {
>         .chars_in_buffer = pty_chars_in_buffer,
>         .unthrottle = pty_unthrottle,
>         .ioctl = pty_bsd_ioctl,
> +       .compat_ioctl = pty_bsd_compat_ioctl,

           .compat_ioctl = pty_bsd_ioctl,

The separate handler would only be required when you need any kind
of special handling depending on the command.

> diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
> index 6116d5275a3e..112b3e1e20e3 100644
> --- a/fs/compat_ioctl.c
> +++ b/fs/compat_ioctl.c
> @@ -866,8 +866,6 @@ COMPATIBLE_IOCTL(TIOCGDEV)
>  COMPATIBLE_IOCTL(TIOCCBRK)
>  COMPATIBLE_IOCTL(TIOCGSID)
>  COMPATIBLE_IOCTL(TIOCGICOUNT)
> -COMPATIBLE_IOCTL(TIOCGPKT)
> -COMPATIBLE_IOCTL(TIOCGPTLCK)
>  COMPATIBLE_IOCTL(TIOCGEXCL)
>  /* Little t */
>  COMPATIBLE_IOCTL(TIOCGETD)
> @@ -883,16 +881,12 @@ COMPATIBLE_IOCTL(TIOCMGET)
>  COMPATIBLE_IOCTL(TIOCMBIC)
>  COMPATIBLE_IOCTL(TIOCMBIS)
>  COMPATIBLE_IOCTL(TIOCMSET)
> -COMPATIBLE_IOCTL(TIOCPKT)
>  COMPATIBLE_IOCTL(TIOCNOTTY)
>  COMPATIBLE_IOCTL(TIOCSTI)
>  COMPATIBLE_IOCTL(TIOCOUTQ)
>  COMPATIBLE_IOCTL(TIOCSPGRP)
>  COMPATIBLE_IOCTL(TIOCGPGRP)
> -COMPATIBLE_IOCTL(TIOCGPTN)
> -COMPATIBLE_IOCTL(TIOCSPTLCK)
>  COMPATIBLE_IOCTL(TIOCSERGETLSR)
> -COMPATIBLE_IOCTL(TIOCSIG)

Looks good.

       Arnd
