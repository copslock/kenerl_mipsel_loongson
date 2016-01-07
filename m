Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 07:05:49 +0100 (CET)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35269 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008245AbcAGGFqagvG7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 07:05:46 +0100
Received: by mail-ig0-f181.google.com with SMTP id t15so21547155igr.0
        for <linux-mips@linux-mips.org>; Wed, 06 Jan 2016 22:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=x+Doae/nP61xetUJtaTXErmWFR37qL0ksmQe4n4/0oI=;
        b=l1pH8o88C8daGpN5L3bzDW3+jRTr6NUkdYJ/HZcqvz8VSveb6wy2ucaOzXtvN/6yoA
         4kznQy8yfFZjr1DuztX4OLQvmNeZEDKeDMF9hv29Gi0L+jOEBkKO5HyWLfXrSwS7cCKf
         hotlVs31O/h/jp9fJSzPMOy8wHKO3cFnbx26yEgyxFfKrzD2DW+bCTLxrmiSxlORt/k2
         brGNp8AwlxDWVz44y+H+q03m1rBPwD5Pp3ZN3IqtXV3Pe3xBxgYUgSE+fLAD861nXysu
         ndTBCqaPRCqA8awxwTx0DowCR02CWziby57sYdRMMD8UAnzt1knVPDsuBKh953GEShRu
         1qQQ==
X-Received: by 10.50.43.136 with SMTP id w8mr13368750igl.96.1452146740491;
 Wed, 06 Jan 2016 22:05:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.125.69 with HTTP; Wed, 6 Jan 2016 22:05:10 -0800 (PST)
In-Reply-To: <1452106523-11556-2-git-send-email-f.fainelli@gmail.com>
References: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com> <1452106523-11556-2-git-send-email-f.fainelli@gmail.com>
From:   Gregory Fong <gregory.0xf0@gmail.com>
Date:   Wed, 6 Jan 2016 22:05:10 -0800
Message-ID: <CADtm3G7_pGdgM8EJgRzRf8j1JAJKivxzd85ie5haWP8ivZvwSg@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: brcmstb: have driver register during subsys_initcall()
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-gpio@vger.kernel.org,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        jaedon.shin@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregory.0xf0@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregory.0xf0@gmail.com
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

Hello Florian and Jim,

On Wed, Jan 6, 2016 at 10:55 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> From: Jim Quinlan <jim2101024@gmail.com>
>
> Because regulators are started with subsys_initcall(), and gpio references may
> be contained in the regulators, it makes sense to start the brcmstb-gpio's with
> a subsys_initcall(). The order within the drivers/Makefile ensures that the
> gpio initialization happens prior to the regulator's initialization.
>
> We need to unroll module_platform_driver() now to allow this and have custom
> exit and init module functions to control the initialization level.

If gpio pins are needed for a regulator to come up, wouldn't it be
better to handle this using deferred probe instead of initcall-based
initialization?  Deferred probe has its problems, but I was under the
impression that it's the encouraged way to resolve these sort of
initialization order issues.

Best regards,
Gregory
