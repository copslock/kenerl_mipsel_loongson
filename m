Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 16:21:34 +0100 (CET)
Received: from mail-io0-x233.google.com ([IPv6:2607:f8b0:4001:c06::233]:49199
        "EHLO mail-io0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992188AbdKGPV1XIiKo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 16:21:27 +0100
Received: by mail-io0-x233.google.com with SMTP id n137so2483078iod.6
        for <linux-mips@linux-mips.org>; Tue, 07 Nov 2017 07:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y8nenzJnunsQhQfzw037Ej1eAtsWGfXgIm+95sisWoQ=;
        b=UNwmPWuFN4z57CFdCvpzDH+9/7HncLeKJGWnkftb95/Eg2VE2zFLxu8ZBmHMJFem3w
         KYQjPnwtTAWTOISrMQazEMAS5x7MS1gC8BPWpE87/yc16KZIsN/p1GD+qp/QcS1PitEc
         xo3OU0/GqNzLIwdFxckfpohOmgG9aOia/I+ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y8nenzJnunsQhQfzw037Ej1eAtsWGfXgIm+95sisWoQ=;
        b=dhmuNgoRbwDVDCU2SkUDxv1uQuG37cITg0JXsw7B98auLvl/3yaIDN6WIgi5hm7W76
         1fvn0Vwmxce5lE17IdgLbaR9oIMx4FUx9BaHxlVNlTYwkiQ6E690KHcjC9jHMziBEyHt
         wGcdCJnW/jUa8/3ZGP4WEbkyHRbXaRnhu5Q7Z2RW4QXly8V4kaGTPc9QUVZRBzVaczLZ
         iywPZgxnUSm1XKrExtjPD/i01DB7wQZrEn2aNPERRrX2AW1hltAJUzUx0+Se62859T13
         o/ELznFfKdr5EohwPVHA2dwVV/7/n1iRGzovwXDygg6yxgTGmvB/GcxfMZmc0SOIpR7O
         nAfA==
X-Gm-Message-State: AJaThX7+IDUrXKij/WFC+yGORl6w69wCp5Oc2UxYNAwEMgNnzvu2qdGk
        dm5SgKEcHY3JmwBjYfSTUrJXXWbZ6M4E1v1kmGsR2A==
X-Google-Smtp-Source: ABhQp+TsZXGURc5fIRV0eFoSLuGLMiaOj1RnsqZ/jAaykSG8etf2PPXHgkagRGiYTWrze7FXtA/k8nyrZ55PrwI9SNM=
X-Received: by 10.107.150.67 with SMTP id y64mr13975017iod.74.1510068080087;
 Tue, 07 Nov 2017 07:21:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.14.140 with HTTP; Tue, 7 Nov 2017 07:21:19 -0800 (PST)
In-Reply-To: <CAK8P3a3QKkGv6eSjX7wH6LpOY0-1XUPFoX0ntog5-ZSHPab6iA@mail.gmail.com>
References: <5a0159b6.08bc500a.ebe4b.25c6@mx.google.com> <CAK8P3a3QKkGv6eSjX7wH6LpOY0-1XUPFoX0ntog5-ZSHPab6iA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Nov 2017 16:21:19 +0100
Message-ID: <CACRpkdZLggJA_qcRSJv4tndHDU4SG6HhP1U8uJpiKn=gBpAneA@mail.gmail.com>
Subject: Re: next/master build: 214 builds: 26 failed, 188 passed, 28 errors,
 6333 warnings (next-20171107)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Kernel Build Reports Mailman List 
        <kernel-build-reports@lists.linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Tue, Nov 7, 2017 at 1:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:

>> 2 arch/arm/mach-footbridge/dc21285.c:145:2: error: expected ';' before 'else'
>
> A harmless rework that Linus Walleij did apparently uncovered an
> ancient bug. I'm
> waiting for Linus to suggest a fix.

In footbridge? Oh my. I just sent a fix for an ancient bug in the
mach-sa1100 simpad.c
boardfile. Isn't that what you're referring to?

(I intended to CC you but git send-email doesn't pick up Reported-by..
I'll forward.)


Yours,
Linus Walleij
