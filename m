Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2014 11:30:16 +0200 (CEST)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:43905 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860000AbaGBJaNWjRYk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jul 2014 11:30:13 +0200
Received: by mail-wg0-f49.google.com with SMTP id y10so10846537wgg.8
        for <linux-mips@linux-mips.org>; Wed, 02 Jul 2014 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=o2crN2D+pKxZI0s2T7onNKPy+cyeLjyekHSdK9/VXaI=;
        b=qfuZzQip8I3UgoA2uFChyrFUEY6Xox/+bKiG8s5qoUitXCpjFjJHW4MsvFOG9VTtuA
         ZRvzM0e5KOdrpRIYLIPSjX71MGIbwU3P015xpxXD14JukHc+JhIPUQubbPdGnAkf4gto
         yjkgUUzJ6fIMoqkYQQW/x938YwWz2smzXQF0wgxqK/sK4HvHGLsIYAcH1Bd7F4hCjG2z
         oAQUDG1L1s3YAgQ/1ocKkhaNIhS1yueaFKbVcdO6Poxf8QOghwz+RvO+wQuen/9M+t7e
         ALJK8y30IGZLGhvm7sfKLJCSGjoYE205TnDlBTBI0EGcevYisKwNLVnZ2s/d71NKoW0n
         I7Iw==
X-Received: by 10.194.6.134 with SMTP id b6mr53022514wja.64.1404293407255;
 Wed, 02 Jul 2014 02:30:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.111.72 with HTTP; Wed, 2 Jul 2014 02:29:27 -0700 (PDT)
In-Reply-To: <20140702052012.23338.54536@quantum>
References: <1404061055-89797-1-git-send-email-manuel.lauss@gmail.com>
 <1404061055-89797-3-git-send-email-manuel.lauss@gmail.com> <20140702052012.23338.54536@quantum>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 2 Jul 2014 11:29:27 +0200
Message-ID: <CAOLZvyH810_0yp=CaQjxYianguS++iXOmq6ZEW2FWRPDxZMW2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Alchemy: common clock framework integration
To:     Mike Turquette <mturquette@linaro.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Hi Mike,

On Wed, Jul 2, 2014 at 7:20 AM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Manuel Lauss (2014-06-29 09:57:35)
>> Expose chip-internal configurable clocks to the common clk framework,
>> and fix a few drivers to take advantage of it.
>
> Thanks for the patch series! Both patches cover a lot of ground, but
> I'll focus on #2. It would be best to split the driver changes out

I sent the first one along because the second doesn't compile without it.


> separately. You can introduce the common clk changes but not compile
> them in, then change the drivers, then add the logic to compile the new
> common clock driver all as separate patches.

I'll split them into pure clock framework and enablement parts.


> Additionally, it would be cool to push this driver out to drivers/clk/
> if you are so inclined. It looks like your header dependencies are not
> so bad as to make that task impossible. Just a suggestion from me.

This clock framework is for a single line of MIPS SoCs which are no longer
being developed by the manufacturer and I don't think it is reusable for any
other soc line currently in existence.  I'd like to keep it within the mips tree
for that reason.  (I find the ARM way of sprinkling the whole tree with
a single driver for each iteration of each custom on-chip peripheral on
each ARM chip [exaggerated of course] quite messy.   But that's just me).

Manuel
