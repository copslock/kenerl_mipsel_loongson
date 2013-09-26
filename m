Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 15:14:09 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:40120 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822345Ab3IZNODjWYWm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Sep 2013 15:14:03 +0200
Received: by mail-ie0-f177.google.com with SMTP id qd12so1304851ieb.8
        for <multiple recipients>; Thu, 26 Sep 2013 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iio4Rr30IHGThubCmiGm13OO3dbs/OvbpdMbc+ORgaI=;
        b=zKxodCWv0rUGoBJdzOKpT1M9q+TezC6N4UacKpJtvs5IaTKGieGQka7Dz9jxThlheZ
         h8e1sUvki1YSMRyYZoc08qQXG38VptD8bl+zhwH3I3PvSxEcV9lxrGInKAMnPzYwIMgF
         tX35YmVXy3h3a1VUj7inAmE7Modt2sCCxk44sxLftb7KAtu08QxOGxQq0k6z4qeD2amg
         CrHo4M4uIZXEuqyAwCH1qYt4tJQraw0bj3uYY5tsrZMvffbOFLDdYZmmOQjYTrpsFr9m
         moIIPW8+cGuYwAjFkbxyhv7TfRz5QODQjwjVnbetIZ8C1mIb5GKwPswfnzD3Ik815AGR
         XPKQ==
X-Received: by 10.43.155.147 with SMTP id li19mr63484icc.106.1380201236737;
 Thu, 26 Sep 2013 06:13:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.73.36 with HTTP; Thu, 26 Sep 2013 06:13:16 -0700 (PDT)
In-Reply-To: <CALkWK0nm=9n7DiV0MaGKVLMs=vxAiiQUx=OFuOg-DinkdMej5A@mail.gmail.com>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
 <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com>
 <52441025.9030308@nod.at> <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com>
 <52441407.9010603@nod.at> <CALkWK0=FG4COEjv5+mu1JRiiFQ2k6vop1mhFPmAT4bjtYeK6nA@mail.gmail.com>
 <52442108.1020304@nod.at> <CALkWK0nm=9n7DiV0MaGKVLMs=vxAiiQUx=OFuOg-DinkdMej5A@mail.gmail.com>
From:   Ramkumar Ramachandra <artagnon@gmail.com>
Date:   Thu, 26 Sep 2013 18:43:16 +0530
Message-ID: <CALkWK0ndMtyQxE0uK4H-Ly6oy+tRn-SFc=_1WoC2QAp2uy0dtw@mail.gmail.com>
Subject: Re: [PATCH 2/8] um: Do not use SUBARCH
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>,
        geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org,
        Jeff Dike <jdike@addtoit.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8
Return-Path: <artagnon@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: artagnon@gmail.com
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

Ramkumar Ramachandra wrote:
> Richard Weinberger wrote:
>> I told you already that "make defconfig ARCH=um SUBARCH=x86" will spuriously
>> create a x86_64 config on x86_64.
>> This breaks existing setups.
>
> I'll fix this and resubmit soon.

Wait a minute. You're now arguing about whether the generic "x86"
means i386 or x86_64. Its meaning is already defined in
arch/x86/Kconfig and arch/x86/um/Kconfig: see the config 64BIT. Unless
i386 is explicitly specified, the default is to build a 64-bit kernel.
That is already defined for a normal Linux kernel, and user-mode Linux
should not break that convention. So, in the example you pulled out of
your hat:

  $ make defconfig ARCH=um SUBARCH=x86

the user should expect a 64-bit build, and not an i386 build as you
say. Both my patches are correct, and the "regression" that you
pointed out is a red herring.
