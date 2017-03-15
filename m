Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 14:15:35 +0100 (CET)
Received: from mail-ot0-x241.google.com ([IPv6:2607:f8b0:4003:c0f::241]:36793
        "EHLO mail-ot0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990514AbdCONP2zyjZn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 14:15:28 +0100
Received: by mail-ot0-x241.google.com with SMTP id i1so2585066ota.3;
        Wed, 15 Mar 2017 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ekR+iZzCwGZhj0iNd0SWlun9z5HZ+6ehN1S+8WV7QfI=;
        b=AicWjpnvA/1CmVUTBk0C3RK+sr+WLBYdhoQObjqPaDdwg32mPKYIGpFSkP8Q/ttI+a
         2HwxEgSxFunr+jWyReRXyQgublgSSsseMxu2fvzzh71xgZbcxNCOYoYusrOkNea6Bmox
         vPAWB8iWE3J6jSccJ06dr4n08tS3W+AFzGFy55QYNLUjeUW7uv5PDjS/3R/iaYSpMfLR
         Nlxo2DmOYZTjmsFQA7VhfVlEcCMt9ZJsL1abgJOzNz7CKhe1EyCjNnWj5FlNcXgHltup
         uKQkol2bSUgV2DJyZGBeQ5YWGlLgzan14I6LLrEkUZ7ekaLzIruX6b8InmP3g4ec2N80
         tgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ekR+iZzCwGZhj0iNd0SWlun9z5HZ+6ehN1S+8WV7QfI=;
        b=OkO5wedWbc616JRdBTi4uEjQq3JnX15Rdhatxzqt4QOXKTiFiJKf0nQzJh4WlHfdX9
         /NOM6/1Wk3CHKXdwJjUIBxbUIIn6J+qfBINzLhs4W1nfoy4iM52RX7G5+eY4mIhEVR67
         PbutI8c9Me2HXjmP6FcFeqaARaahaxv/9pFpBr3nIa5EFc7bxMKbbekaeL5Lct86ygMT
         jy0scMtQi1GjNOWpymuZIVSSI4ya2zr7XqEVk+7JQtZOhtYprBpkRnTc+Cm8pC4PG/4b
         NejU1c8as56B5zfDyVImJr4AR31r8tZiN564wjqf/Gl+2BbKmIzaWKXteNzpHNKdJouR
         2ajQ==
X-Gm-Message-State: AFeK/H3oophC+Qmdj6UXoI1zIY8V881fheuN7Nt8LP5IyQloCU7N9OzoBUE/lIVFTH4PvW2x+yUiXjvD3721sA==
X-Received: by 10.157.1.171 with SMTP id e40mr1944491ote.41.1489583723131;
 Wed, 15 Mar 2017 06:15:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.6.42 with HTTP; Wed, 15 Mar 2017 06:15:22 -0700 (PDT)
In-Reply-To: <20170315072204.GB26837@kroah.com>
References: <58b2dc6f.cf4d2e0a.f521.74b3@mx.google.com> <CAK8P3a32nbd6Wv9wCjmUX+E3gpnWkAWwKurP9dkuwyf_oegCgg@mail.gmail.com>
 <20170315072204.GB26837@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Mar 2017 14:15:22 +0100
X-Google-Sender-Auth: PCqiucIeXmh9jeZnF4AaY0kcovM
Message-ID: <CAK8P3a2hmA_f8YZKB=fqpcmeP0wRaq9aEORhVF1kLUWtd0nx6Q@mail.gmail.com>
Subject: Re: stable build: 203 builds: 4 failed, 199 passed, 5 errors, 41
 warnings (v4.10.1)
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57291
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

On Wed, Mar 15, 2017 at 8:22 AM, gregkh <gregkh@linuxfoundation.org> wrote:
>
> All now queued up in the stable trees, thanks.

Like 4.9.y it builds clean except for a couple of stack frame size warnings
and this one that continues to puzzle me.

/bin/sh: 1: /home/buildslave/workspace/kernel-builder/arch/x86/defconfig/allmodconfig+CONFIG_OF=n/label/builder/next/build-x86/tools/objtool//fixdep:
Permission denied

https://storage.kernelci.org/next/next-20170309/x86-allmodconfig+CONFIG_OF=n/build.log

The same warning is referenced in this email:
http://lkml.iu.edu/hypermail/linux/kernel/1612.0/04384.html

but I can't figure out what patch is supposed to address it, or if that
patch made it into mainline.

Curiously, only allmodconfig+CONFIG_OF=n seems to be broken, not
plain allmodconfig, maybe this could be related to rebuilding in the same
object tree without "make clean". Also, all recent kernels (since December)
until next-20170309 seem to be affected, but it does not show up on
the latest linux-next (next-20170310). I don't seen anything in next-20170310
that could have addressed it, so it may also be a coincidence that we don't
hit a certain race condition during build this time.

Adding Ingo, Arnaldo and Stephen to Cc, maybe they know what is going
on here.

      Arnd
