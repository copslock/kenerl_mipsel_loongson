Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 21:02:19 +0100 (CET)
Received: from mail-ot0-x241.google.com ([IPv6:2607:f8b0:4003:c0f::241]:36214
        "EHLO mail-ot0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992100AbdCOUCMfejrL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 21:02:12 +0100
Received: by mail-ot0-x241.google.com with SMTP id i1so4391144ota.3;
        Wed, 15 Mar 2017 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pqSFIu5AFDDp1ku4lguK9aBeWTnQSuRC9NlBL21dPO4=;
        b=NZadsDFg+5W1Jir8svHecMEydyY2oBJ/R1s98KMD1o3PSbdX6fqT1mHAh1PptGJKtb
         Jx6lD3WNURVMtTQ8Cr+JYILrlwxiQr7i57K2/qP6PPwJ2Xpqhystc9ptAXx86Co2OfMs
         OZz6+NFTrdW4nJtzVty3WEhqiokE+S/kCiX9hJpC6pGRgAxX0tQ2CLDcmkqjcmnOmPTO
         SY/pgYDr8kR4zTSOoAScgBEm2V73QrwnJGj5cpB/PUMB0k2bAN5XJ7IZm/SZ1Px54445
         u1wsmWv4J2Z//YHqMc1CmXxqku+wcTV8jG8OKqlRqYRFT7VMmhPZ55zAsNrtF0cdSJXW
         ybEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pqSFIu5AFDDp1ku4lguK9aBeWTnQSuRC9NlBL21dPO4=;
        b=OWEdyBmnrhLSLSAW/ZrnnzelktxqXgeD2sUWJ+sJ4dID5bg714uFjrxYggROWy+Fmc
         sFGP9GXrhexqsoqLUfRRYxGabpGZ4HZ7EzFyUNQd5F5FZ5CJLwzK2QZIQY6NNz3n13my
         ZRP3680heErdyF6UyRFyZMGF0YnRAmcLV+LEt+BAsiTV+z/TuG5BNpTWpFnMfTNwvtou
         hIDhDrdgjPy9wEwHLcR8WHztDFg2wT675H53+kyk04eiv0A/N+u+5el6dBabVz7FPNDS
         6g89Eqr/Do2daQ93G08cYmc7LiJmBF6g5BJfMAW+J1EvFv2GidUsdu0wKwOwhudQ+pOU
         42ig==
X-Gm-Message-State: AFeK/H3MsrehBzEVKGHg0WGr1HqksW4eiRGAyrC3cpZCjc4cutx1wr8bhH0H8aSM2ydmYPnOpIFYsPxmkwHYpg==
X-Received: by 10.202.235.68 with SMTP id j65mr2850834oih.155.1489608126688;
 Wed, 15 Mar 2017 13:02:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.6.42 with HTTP; Wed, 15 Mar 2017 13:02:06 -0700 (PDT)
In-Reply-To: <58c97f8f.c4b5190a.8c4e4.300d@mx.google.com>
References: <58c97f8f.c4b5190a.8c4e4.300d@mx.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Mar 2017 21:02:06 +0100
X-Google-Sender-Auth: jWhMyV7DfrZrqvKzP9ma_OzctcY
Message-ID: <CAK8P3a1jHhM=80Zo59JoDNd2RKwTfdR_i61_=ASqqUeJ1oecxg@mail.gmail.com>
Subject: Re: mainline build: 208 builds: 0 failed, 208 passed, 422 warnings (v4.11-rc2-164-gdefc7d752265)
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     kernel-build-reports@lists.linaro.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57306
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

On Wed, Mar 15, 2017 at 6:53 PM, kernelci.org bot <bot@kernelci.org> wrote:
>
> mainline build: 208 builds: 0 failed, 208 passed, 422 warnings (v4.11-rc2-164-gdefc7d752265)

The last build failure in mainline is gone now, though I don't know
what fixed it.
Let's hope this doesn't come back as the cause was apparently a race condition
in Kbuild that might have stopped triggering.

> Warnings summary:
> 409 :1325:2: warning: #warning syscall statx not implemented [-Wcpp]

The warning triggers for arm, arm64 and mips on every build. I saw a patch
was posted for asm-generic, which takes care of arm64.

Catalin and Will: can you take this through the arm64 tree? I don't have
anything else for asm-generic at the moment.

Russell and Ralf, do you already have patches for ARM and MIPS to
add the syscalls, or would you like me to send you patches for it?
I assume all arch maintainers will get to it eventually, but I'd like to
see this gone from the kernelci reporting.

Once the syscall number has been assigned for arch/arm, we will
also need to update the compat syscall table for arm64 of course.

> 2 include/linux/device.h:1479:15: warning: passing argument 1 of 'platform_driver_unregister' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> 2 include/linux/device.h:1474:20: warning: passing argument 1 of '__platform_driver_register' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]

Mauro has applied the fix in linux-next, I assume this is going to hit mainline
before v4.11-rc3.

> 1 net/wireless/nl80211.c:5743:1: warning: the frame size of 2064 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 1 net/bridge/br_netlink.c:1339:1: warning: the frame size of 2544 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 1 drivers/tty/vt/keyboard.c:1472:1: warning: the frame size of 2344 bytes is larger than 2048 bytes [-Wframe-larger-than=]

I still have this one on my list, should be able to post an updated version
in a few days after I'm through with my backlog of older patches.

      Arnd
