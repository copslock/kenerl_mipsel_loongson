Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 12:54:21 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:45114 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822345Ab3IZKyPja-01 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Sep 2013 12:54:15 +0200
Received: by mail-ie0-f177.google.com with SMTP id qd12so1105617ieb.36
        for <multiple recipients>; Thu, 26 Sep 2013 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JSZcCF9fsm/KqMK/hGNpKiTAsdo7+6nHXjKHsoxJh8E=;
        b=ZfmAG4XyOWnZFiYtRux/SUMGTwDDUFwXr/mAmEaDU5wzE3qyEH+CEE1cPAafXtw3i4
         3MU4EETkqwCRuXAXpSOAYO7kBIazA303HR0pPL+LCyxF+D5q87rUpqS0F05/IKJRDWa0
         WXpcbxVRFrauFeckXiIRg6hSWBLuuaNuBKvTE955jyXmoKgyi8YkvOsfuQNxUOVytfgf
         JvPat3d7tif3o1Gr/iXau0IGApN8coa49WloAc8wFQuSKPN8G8u2j/mbR6u9sXFDPY9a
         Hb2uLipv6SZLea0FYt0F4xXLa2fk0yIPBJB/lrqwwZxfVW1STFd+ScVXifgT7pQbOQGK
         e6og==
X-Received: by 10.42.223.134 with SMTP id ik6mr370904icb.4.1380192849201; Thu,
 26 Sep 2013 03:54:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.73.36 with HTTP; Thu, 26 Sep 2013 03:53:29 -0700 (PDT)
In-Reply-To: <52441025.9030308@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
 <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com>
 <52441025.9030308@nod.at>
From:   Ramkumar Ramachandra <artagnon@gmail.com>
Date:   Thu, 26 Sep 2013 16:23:29 +0530
Message-ID: <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com>
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
X-archive-position: 37985
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
> So, what exactly is broken in upstream?
> make defconfig works as it always did.

Auto-detection of SUBARCH, which can be done with a simple call to
uname -m (the 90% case). The second patch I submitted prevented
spawning xterms unnecessarily, which we discussed was a good move.

> make defconfig ARCH=um SUBARCH=x86 (or SUBARCH=i386) will create a defconfig for 32bit.
> make defconfig ARCH=um SUBARCH=x86_64 one for 64bit.

Yes, that's how I prepared the patch in the first place.
