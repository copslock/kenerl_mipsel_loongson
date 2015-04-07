Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 16:13:22 +0200 (CEST)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35846 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010588AbbDGONV2umr2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 16:13:21 +0200
Received: by iebrs15 with SMTP id rs15so47502315ieb.3
        for <linux-mips@linux-mips.org>; Tue, 07 Apr 2015 07:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IqRNFQ+DM00y4H32xwKGF3qflD58lBZGZWlJc93uGWk=;
        b=DOcHfSRbn1oiPMWhcKW2fk5rL+OcPGg6G4xNesXCMVvMEdkq08Xdp6b3bstyoF9DNo
         YZEtCuW8jcLjezBP/oC/WYNTDVGX6wSY6Jl9bN3kwHL3tS8PZI18UliJVzQ0l+1fr+Wr
         MeEnoFUE7nfO4UDRwvld2q1JEV9sN4v7mFTKm2DN/eeHYK/hRQpE2Uq3uYr05vAqXPOd
         zw4Nt9pkr2IT6cvATVr1sO5JpCxZi4ygMy0KIW5E4sKjvzmmYe/3GIZ1pEBAQnFTg/qF
         sLD7PhFKsc59dX5d2KbBjU5WUaGQfpZ0I9pE5F8JCrOUzajuk8yjc9DxrOjLVE37tlxO
         UZBw==
X-Gm-Message-State: ALoCoQm83Ek5nfF0NIubmlPqULpzze08lKqCNlCsO2WKRn/mDEu5/tS+m1YmS1nm5hIsOKgh0+p4
MIME-Version: 1.0
X-Received: by 10.43.181.130 with SMTP id pi2mr26974568icc.21.1428415996605;
 Tue, 07 Apr 2015 07:13:16 -0700 (PDT)
Received: by 10.42.103.133 with HTTP; Tue, 7 Apr 2015 07:13:16 -0700 (PDT)
In-Reply-To: <CAL1qeaG70_42p8r9ogHxMv2h-yx_TENYV_gZbX1wQMhqSaiFpg@mail.gmail.com>
References: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
        <1427757416-14491-4-git-send-email-abrestic@chromium.org>
        <1427789415.2408.45.camel@x220>
        <CAL1qeaG70_42p8r9ogHxMv2h-yx_TENYV_gZbX1wQMhqSaiFpg@mail.gmail.com>
Date:   Tue, 7 Apr 2015 16:13:16 +0200
Message-ID: <CACRpkdYfN_AV47G8cni=gApcwf8nx_fUrreGZp7ASRsU5PM1bA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] pinctrl: Add Pistachio SoC pin control driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Paul Bolle <pebolle@tiscali.nl>,
        Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46805
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

On Tue, Mar 31, 2015 at 6:56 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> Hi Paul,
>
> On Tue, Mar 31, 2015 at 1:10 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
>> The patch adds a mismatch between the Kconfig symbol (a bool) and the
>> code (which suggests that a modular build is also possible).
>
> Nearly all of the pinctrl drivers (with the exception of qcom and
> intel) are like this.  They use a bool Kconfig symbol but they are
> written so that they could be built as a module in the future.

There are many aspects to this and I have no strong opinion,
it doesn't really disturb me either way as both are familiar
ways of writing drivers be it modular or not.

I think it's more disturbing that bool drivers have .remove()
functions, and as pointed out elsewhere this is because the
module can still be bound/unbound from sysfs even if compiled
into the kernel and then that code path will actually be executed.

And as I remarked again, elsewhere, that can be overcome
by adding the .suppress_bind_attrs = true to struct device_driver
inside the platform driver.

So if going through all the hazzle to remove anything compiled-out
for non-modules, also take the step above removing .remove()
calls and setting .suppress_bind_attrs.

I will maybe do so sometime myself for any bool drivers...

Yours,
Linus Walleij
