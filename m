Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Apr 2014 20:52:03 +0200 (CEST)
Received: from mail-qa0-f43.google.com ([209.85.216.43]:36310 "EHLO
        mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817040AbaDESwAg2YZ7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Apr 2014 20:52:00 +0200
Received: by mail-qa0-f43.google.com with SMTP id j15so4385714qaq.2
        for <multiple recipients>; Sat, 05 Apr 2014 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WAYOuWuNTJbq5uhick26a3h6AEcqnTqSSyf+sb42MR0=;
        b=yGYZ+7+rPczIycoxBeDcotBjbSKIIcNRdZy0yPNH5BMuond7For/G41HGYsPNQULyj
         sa3Ph7Ql78NfIe6V8Ml8VUafl790F/IDn6PKCrOdzt6TnKHMkqh8+NOrW+Z/AdsC7aoT
         mUGif5WR2q0jBai/7Ao8spsorfSsxpS4nNhfw9O3BUFzJKAs5JmKE/xse2RsHq4iqaWp
         bN22nJwMIqoeXY/TwxQHgWXJ5HD9xYqFbIouIN2ER66v9zR/TthgEvCyZFiQsOzO6Hmn
         jN7JbgCl/DkTwEWeOjvM44omO5+WDbfOAYRyIKqUWuQopniF4zrF4S7+Z/DqhynShryW
         nS6A==
X-Received: by 10.224.72.12 with SMTP id k12mr4158948qaj.81.1396723914299;
 Sat, 05 Apr 2014 11:51:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.207.65 with HTTP; Sat, 5 Apr 2014 11:51:34 -0700 (PDT)
In-Reply-To: <1396599104-24370-9-git-send-email-chenhc@lemote.com>
References: <1396599104-24370-1-git-send-email-chenhc@lemote.com> <1396599104-24370-9-git-send-email-chenhc@lemote.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 5 Apr 2014 11:51:34 -0700
Message-ID: <CAEdQ38F-WHEUFqACwGGNGsWQFqTjwwk2ZwNis8zbNWff2xT8Vw@mail.gmail.com>
Subject: Re: [PATCH 8/9] MIPS: Loongson-3: Enable the COP2 usage
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Fri, Apr 4, 2014 at 1:11 AM, Huacai Chen <chenhc@lemote.com> wrote:
> Loongson-3 has some specific instructions (MMI/SIMD) in coprocessor 2.
> COP2 isn't independent because it share COP1 (FPU)'s registers. This
> patch enable the COP2 usage so user-space programs can use the MMI/SIMD
> instructions. When COP2 exception happens, we enable both COP1 (FPU)
> and COP2, only in this way the fp context can be saved and restored
> correctly.

Is there a Loongson 3 programmers manual somewhere, similar to
Loongson2FUserGuide.pdf?

I optimized pixman for Loongson 2E/2F using their SIMD instructions.
I've compiled pixman for Loongson 3A and I see some new instructions
being used in the disassembly, but I have no Loongson 3 system to test
on. At minimum, having a manual would be nice.

Thanks,
Matt
