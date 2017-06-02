Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 12:05:08 +0200 (CEST)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:33385
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993921AbdFBKFCGxCmW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 12:05:02 +0200
Received: by mail-oi0-x243.google.com with SMTP id h4so10985177oib.0
        for <linux-mips@linux-mips.org>; Fri, 02 Jun 2017 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IWCJkxpcZdLEdtCOq4twVtZBuEXO4rbIIFD4I0IfQC4=;
        b=haOkrB0/15pkSW9lj+T/2/nMOzlM4nreUI1uxKEmvVc8avlaMW476OJRjVhIq9194R
         HgrWEqrW6Px7nmj7PupcfpzY1q5srWSnxE0c+u8EvUHcB+EUwL46np6SXBO3Bzv3wNks
         bmaie7lomKfEFPxMxmTzpBhN+JW6KFbb+Zyr8KnQmtCSNgAr2AHnbxgvohMLrX9VV6Io
         FH4ouZnmCzq5KX+/GtOlM/3MUGLDMVVI9LzKD7DpqbrughIj6MariBp2Tt/sPlOke7TS
         twF4QA7B2HeXGuyPVOiljJjbGC5JmoyPlQK4+HVpyRe9baKIDVyf4Ie+ugtESDR39/m/
         ZxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IWCJkxpcZdLEdtCOq4twVtZBuEXO4rbIIFD4I0IfQC4=;
        b=DeOUQ3bs3WTs/QhUObGBT2qRhA3qi4dty+cisI7jVALCbjymFo1MDrmCtCEuZCcuax
         qg1Xh8Ug/V9iqKRMNVFzDGFg0NmostZAoKIfYkHjSUlW54ZsfaFjHkr/OZ0v1B+ypuLH
         wCjDoCTCEsPYm0emRM7azw4htb4TyUq+Z3i8zldBcxTLoQntbdLqmLf4CN7uhtg2Hmra
         9deJvIi3A310uLbTee7RUIV8nG4/sJUtwcnN4JS5o7q8l3361V1dkKqmXoGZIF0hXh63
         qPb4SyFO5fKABXxn/5Y0wEgw6lrbu8yLnlIiUYl9tlAjsevvOv8AU6iDotrjn6td0N8J
         J8gQ==
X-Gm-Message-State: AODbwcCYIslAjT6aIlbP1RSbRPmCY9oI8/RCsoLQSo5i2ZWaYjEKdov0
        pqkct4aFDY2EgpMS+48fSWiwR15iAg==
X-Received: by 10.157.50.11 with SMTP id t11mr4278352otc.217.1496397896070;
 Fri, 02 Jun 2017 03:04:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.51.139 with HTTP; Fri, 2 Jun 2017 03:04:55 -0700 (PDT)
In-Reply-To: <20170602084858.4299-2-asarai@suse.de>
References: <20170602084858.4299-1-asarai@suse.de> <20170602084858.4299-2-asarai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 2 Jun 2017 12:04:55 +0200
X-Google-Sender-Auth: zGeAfGYRxSmSB5DQuCaPAauM95s
Message-ID: <CAK8P3a2Q5CwofO96fXyjTVqmm23UKZjd+mOopnvKr_TusLxXpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tty: add TIOCGPTPEER ioctl
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
X-archive-position: 58134
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

On Fri, Jun 2, 2017 at 10:48 AM, Aleksa Sarai <asarai@suse.de> wrote:
> When opening the slave end of a PTY, it is not possible for userspace to
> safely ensure that /dev/pts/$num is actually a slave (in cases where the
> mount namespace in which devpts was mounted is controlled by an
> untrusted process). In addition, there are several unresolvable
> race conditions if userspace were to attempt to detect attacks through
> stat(2) and other similar methods [in addition it is not clear how
> userspace could detect attacks involving FUSE].
>
> Resolve this by providing an interface for userpace to safely open the
> "peer" end of a PTY file descriptor by using the dentry cached by
> devpts. Since it is not possible to have an open master PTY without
> having its slave exposed in /dev/pts this interface is safe. This
> interface currently does not provide a way to get the master pty (since
> it is not clear whether such an interface is safe or even useful).

This should be added to the compat ioctls as well. There are two ways
of doing this:

a) like the other ioctls handled by pty_unix98_ioctl(), add it to the
list in fs/compat_ioctl.c, and check that the list is still up-to-date with
the current driver (someone else may have missed one)

b) remove all compat handling for ioctls that are specific to
pty_unix98_ioctl() and pty_bsd_ioctl() from fs/compat_ioctl.c
and add compat_ioctl callback pointers to master_pty_ops_bsd
and ptm_unix98_ops, pointing to the respective ioctl handlers.

I would recommend b) as it avoids the problem in the future,
but it is a little more upfront work, and should be done as a
separate preparation patch.
All the ioctls here are compatible between 32-bit and 64-bit
user space, so no special translation is needed.

      Arnd
