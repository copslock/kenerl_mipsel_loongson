Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2012 22:28:24 +0100 (CET)
Received: from mail-la0-f49.google.com ([209.85.215.49]:38653 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823118Ab2LFV2XRO-Bs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Dec 2012 22:28:23 +0100
Received: by mail-la0-f49.google.com with SMTP id r15so5159030lag.36
        for <multiple recipients>; Thu, 06 Dec 2012 13:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JQ2nrOU/dfh1hXQld9/BvzmciAaC5Ckd/XcHonKQ504=;
        b=ptuBkwQqDpBEkp8Tjmw1AgAIXCTnGO62ELiFEJLaa5VG2Vkn26crzaelf1wIWFpyqk
         uMm7lcOIqDU7CM4VNLQBkEwNumLE9/FJZq/HM5uD4rAFZCrMRuJ1mNvmtJOrHrDIGVQV
         8AGREi9X8NtpoaVPEAB86hb/cXhUBBXMLq2ZtAjhwrWijkOmumr86R/MZdEStMeal4YR
         wJGTN3/IyO4JeLBO5lIJQowmpslfRkiUXICDBCnkO1+7jUgSq4yxNlrn9tdmD5VcplO/
         Jft8PgvMl1sAdNIfFUQXFM4GGm5RxLQKhny8DjreSHDLLvdK6oFZSusr88kGmnFlQAam
         nXew==
MIME-Version: 1.0
Received: by 10.152.113.225 with SMTP id jb1mr3273402lab.23.1354829297427;
 Thu, 06 Dec 2012 13:28:17 -0800 (PST)
Received: by 10.112.114.37 with HTTP; Thu, 6 Dec 2012 13:28:17 -0800 (PST)
In-Reply-To: <20121206160052.GB32620@linux-mips.org>
References: <20121206160052.GB32620@linux-mips.org>
Date:   Thu, 6 Dec 2012 15:28:17 -0600
Message-ID: <CACoURw7JTFMzmcRZHmBchcWPC8x5LFFfC1nGH-Xxc8f3KjNE2Q@mail.gmail.com>
Subject: Re: RM9000 / E9000, MSP71xx class processors, SOCs and eval boards
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Dec 6, 2012 at 10:00 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> Folks,
>
> since many years the support code for those devices is rusting away in
> the lmo git tree and frankly, I'd get rid of it because there's been
> very few patch submissions or any kind of indication that somebody
> still cares.  In short, this has turned into a waste of resource not
> least my time.
>
> So, is anybody still interested in maintaining that code?  If so, you
> better attach a bunch of patches to your reply.
>
>   Ralf
>

I'm interested in the MSP71xx eval board, although I may be
the only person in the world who cares.  Specifically, I use the
msp71xx_defconfig.  3.7-rc8 compiles with gcc-4.6.3
without requiring any patches.

I don't know when the last time the RM9000 was compilable,
but I have no interest in that, nor do I have interest in the
FPGA or eval board versions of the MSP7120 (no hardware to
test with).

I had hoped that someone from PMC-Sierra would respond, but
maybe they don't care anymore...

Shane McDonald
