Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 11:59:17 +0200 (CEST)
Received: from mail-qt0-f171.google.com ([209.85.216.171]:37863 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994551AbeINJ6eA97AI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2018 11:58:34 +0200
Received: by mail-qt0-f171.google.com with SMTP id n6-v6so8151341qtl.4;
        Fri, 14 Sep 2018 02:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ByoDngbgdRqYXI3Lve5fbg6VKELAKjArTjP4KngbxL8=;
        b=pHODFPKHwDUzifuI+gXHoKFCHPeUAFRdEmX4/Vz9UezCDiYaVOLjIQGMWs6bDsF7L/
         g6WPQGtOHaNWxlnuM/dk74n6TPRk7tgHqTULQmv1Xne3AKxI6P0QZ09RPoDURNI+gxV6
         qvr/OjQW9DHInrfCXMc9Qg77/3HJvRk6EsmNHTTHx9UrtebXmoOBXVjqeQCM2FjQSHWC
         rXdP3BXrtOka3Mw25S701UVf37gh1XWRKFQFUtpTmFDFG5DMKjWdH4LREQ/uS+6GFyix
         8hrUETG6WZwb1LxxkrqB/OLah2GZJzOC6smudHcMNQxSitp9ka0+steosbjWqw7tlytH
         T6/A==
X-Gm-Message-State: APzg51C4CEgwVqWWqEHIETm2o2Td3wugBLsBnX20ik1/C8Hx5Qm0x2cc
        pwoMW2fyq58GM3jS7+pi4mNU/Rv8H4lR743xBxQ=
X-Google-Smtp-Source: ANB0Vda80WgNhoqsjnF80IfKebNPcI64np6Q5lt77wrpEaOzSm98mqkwimH2ruLk6ctY7zy4kRcGCxEbuZ6cGArAW0M=
X-Received: by 2002:a0c:fb08:: with SMTP id c8-v6mr8162127qvp.149.1536919105907;
 Fri, 14 Sep 2018 02:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org> <1536914314-5026-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536914314-5026-3-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 11:58:09 +0200
Message-ID: <CAK8P3a221wz4iqwoKcof2ioVWzHmUCOwt8Y5cdVPvZEEtHcycQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips: Add system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66253
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

On Fri, Sep 14, 2018 at 10:39 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The system call tables are in different format in all
> architecture and it will be difficult to manually add or
> modify the system calls in the respective files. To make
> it easy by keeping a script and which'll generate the
> header file and syscall table file so this change will
> unify them across all architectures.
>
> The system call table generation script is added in
> syscalls directory which contain the script to generate
> both uapi header file system call table generation file
> and syscall_32/64.tbl file which'll be the input for the
> scripts.

I think it would be best to name the files
o32/n64/n32 instead of 32/64/n32

It would also be helpful to mention why the n32/n64
files cannot be combined into one nfile here.


> +364     32      pkey_alloc                      sys_pkey_alloc
> +365     32      pkey_free                       sys_pkey_free
> +366     32      statx                           sys_statx

You missed the additon of rseq and io_pgetevetns here.

       Arnd
