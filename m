Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2017 09:30:28 +0200 (CEST)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:34933
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992196AbdGKHaV1FE56 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Jul 2017 09:30:21 +0200
Received: by mail-oi0-x241.google.com with SMTP id l130so14625268oib.2
        for <linux-mips@linux-mips.org>; Tue, 11 Jul 2017 00:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=j42UM+l67ybSj9H+sUgHlPehOBQ67zJxoPae4Os7tdM=;
        b=GfTbOHQ4fe9k6y0v0ZPynk8j+4lrTmKrSH5tyT7qRgNUq2EQyJHGBQo+jwSJU4hlQk
         Wp6Kk9OC2GuyzjQiQZ3hmBELPEaJWOxMIoyrOeY4wy9jYPq7RdC08FZ6hOCVYt78knJW
         5mcHvFsdo4C/MZ9ZqZ0o7jvJx2riEm9sdvWrmsoXXGAN4yuXfhhbxnhLrVOtxqiuZh/O
         wP7IV4z84jcZp1VjtUe018eGMaz4gj2POItzrNtID/Fi5UG4daZQ3QiTkD9ZdRfJoULD
         uHjGHC/TA74oOYq1QxN/uXzDGkuhL9GRLeb+5Z0i7/UJEcHtlboVH+lgTvqe3tVDqxYE
         mydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=j42UM+l67ybSj9H+sUgHlPehOBQ67zJxoPae4Os7tdM=;
        b=M3B09LCRi095ZvoZisWlE+ayKbqTm5Cdjgv88zSgTcyjNqF9wbetfqaQuMTIlgOVZa
         pJnmmwt/NSKYWJP3zT3jkfqEXC98gRd0NnCTXu1xzOMhMhZ72twNBk4f1tj6ahRV3s14
         MVBdrkMf0HJsv5TGeXD2h4Vju9kRmf3eqhJnf1INsnUFJH8Iz/+MV02x+AC8QtC/dnK4
         L9xE/EBsvNhCzlSIWWDi0GIo+AzxG2fGnYrazAFyBrXfm/2BQ3cWyZEWcKBEHxPChj/6
         88nmtMjSaCDYDy+6T8HWV7y1klyuyeRhSVXE+Qz5jCDDxOdWFS9Cu/Se8ag0syQm0anK
         zZYg==
X-Gm-Message-State: AIVw112jJIon1nOr7LonImNIBBdAeqVs0NewT1oCU6m9oiQES/x15zcK
        7FA+a6Y9pGYvHTIDCNNsLYZUbP84Kw==
X-Received: by 10.202.166.136 with SMTP id t8mr11270698oij.61.1499758215626;
 Tue, 11 Jul 2017 00:30:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.78.163 with HTTP; Tue, 11 Jul 2017 00:30:14 -0700 (PDT)
In-Reply-To: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
References: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Jul 2017 09:30:14 +0200
X-Google-Sender-Auth: O_9qzVRUe7a_LTiGXtdMhC3WNkQ
Message-ID: <CAK8P3a1uJc0dNoELw1KWKnc9Lme3HDxR2Coj0-snuCmO4n-81A@mail.gmail.com>
Subject: Re: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
To:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Cc:     Aleksa Sarai <asarai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Valentin Rothberg <vrothberg@suse.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59089
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

On Tue, Jul 11, 2017 at 2:12 AM, Gleb Fotengauer-Malinovskiy
<glebfm@altlinux.org> wrote:
> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
> because it doesn't copy anything from/to userspace to access the
> argument.
>
> Fixes: 54ebbfb1 ("tty: add TIOCGPTPEER ioctl")
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
