Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 14:01:09 +0200 (CEST)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55569 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824816Ab3IZMBGlAfb1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Sep 2013 14:01:06 +0200
Received: by mail-ie0-f174.google.com with SMTP id u16so1196966iet.33
        for <multiple recipients>; Thu, 26 Sep 2013 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WXVIo5uBeJngL0pBF2K9EQwdgD5DE1eugjTH76/ur10=;
        b=JpuAp4azkeErGneuxtft7EmmhKFfl9pLuDeq6FuPrGY8zpco9rfXjmdvCU5qG7sZ0w
         vB/Y7M1yqHcu6oXE8PKV3bBB6a5pSg06T/8u1DCheYPsxrM9FSer5jY4g5BfAXu/IYUp
         S3aBqb+H4P45CcCwv1MAYQGNrsiz3LttieacPLfXdxkT7p+gPaRckd2Mkyh2OzgQhnGm
         NotayHPl4JHpWD9vStEYhQTnQvXILmuCNzxr3JYMpJWpBsD2yWfEw8+KF/6n4X/xHr4E
         7kWwVjQDZW4beFAhWWt3mILZ7oEO/lb3XnEhlQ/48E51iGnHqN77Jh72sYga/LXj5GtT
         PUiw==
X-Received: by 10.43.161.199 with SMTP id mh7mr655754icc.66.1380196860247;
 Thu, 26 Sep 2013 05:01:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.73.36 with HTTP; Thu, 26 Sep 2013 05:00:20 -0700 (PDT)
In-Reply-To: <52442108.1020304@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
 <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com>
 <52441025.9030308@nod.at> <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com>
 <52441407.9010603@nod.at> <CALkWK0=FG4COEjv5+mu1JRiiFQ2k6vop1mhFPmAT4bjtYeK6nA@mail.gmail.com>
 <52442108.1020304@nod.at>
From:   Ramkumar Ramachandra <artagnon@gmail.com>
Date:   Thu, 26 Sep 2013 17:30:20 +0530
Message-ID: <CALkWK0nm=9n7DiV0MaGKVLMs=vxAiiQUx=OFuOg-DinkdMej5A@mail.gmail.com>
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
X-archive-position: 37988
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

Richard Weinberger wrote:
> I told you already that "make defconfig ARCH=um SUBARCH=x86" will spuriously
> create a x86_64 config on x86_64.
> This breaks existing setups.

I'll fix this and resubmit soon.

Thanks.
