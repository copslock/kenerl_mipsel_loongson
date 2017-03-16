Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 11:00:11 +0100 (CET)
Received: from mail-ot0-x244.google.com ([IPv6:2607:f8b0:4003:c0f::244]:36816
        "EHLO mail-ot0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991359AbdCPKACv4n2Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 11:00:02 +0100
Received: by mail-ot0-x244.google.com with SMTP id i1so6844551ota.3;
        Thu, 16 Mar 2017 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Zwf3FMVUxWRWXml9NMgS8FZTD24rwD3y4W0N14uGE7c=;
        b=JavIsa5sn1c0k484+TT05mHOkrblckL7Qr7+YlVT9D5bguj+vuQ1ZWjKxTcbTA4Mqa
         MObOJBZjq0OuvHJZ8uu1IVtMgUPaNJO2IggnOHFmN6fzVHqZVQhIL/twwljAh/M0jxUr
         D6+kCGqru5I6lXoXXWY0mrjzumi9Sb8fpm/5Q/W2xVbuAUmM7rRK5p08Xs+TfUPfDd8n
         ZfYZPfHfjJrxqLVl80b/v6BMrsrEaavK7/PrOabohInWamVWodROPGO8Odc8OjzrLBYP
         jO/Isslt2j5a0LzKLUPKh9OFxJh+MKG3Nczf4zhUZuN1OXX68naOxI85AVNVdCyDouyb
         5f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Zwf3FMVUxWRWXml9NMgS8FZTD24rwD3y4W0N14uGE7c=;
        b=lLP/qMKPYZS1l66j9ZKyIcufQ9DIzu0RPSPJyDvDnVBtTzvEg4NwcYtW3XJ+5TiPa/
         EDnnp7Z1HfZtELuzbpIfO0r/KaNl6W9vPoGdJDnRUYVShUMhQS5X0UlB7pGD0FwPm+gf
         GOI+Bc53mw7FMr/un6EnA+wg4dKJdVW+bYP/w1e4H6BxaWgFhF/XdlklovlYzgXWNOZ+
         tlOFHgohouA5d7avMjQ63gBJpDgN5aCWmDeQP/Y8oDdGHcUlHHoRrh7FhQtUZl01rSdc
         HLWAo/4RxUOQjslMge0eic0rDTJNcpTxOWvCisiTWun/vAuDkSl1a0RtrLbnQEvg21Dn
         OdtQ==
X-Gm-Message-State: AFeK/H1iD5BjioVUX+ZRit/GsOYGjeGULJSyCKCOSZtZzHc06JTHkYUth7mvW+gk/16NvJDr36YhRX5FU4x/zg==
X-Received: by 10.202.86.82 with SMTP id k79mr3839570oib.150.1489658396291;
 Thu, 16 Mar 2017 02:59:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.6.42 with HTTP; Thu, 16 Mar 2017 02:59:55 -0700 (PDT)
In-Reply-To: <CAK8P3a1jHhM=80Zo59JoDNd2RKwTfdR_i61_=ASqqUeJ1oecxg@mail.gmail.com>
References: <58c97f8f.c4b5190a.8c4e4.300d@mx.google.com> <CAK8P3a1jHhM=80Zo59JoDNd2RKwTfdR_i61_=ASqqUeJ1oecxg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Mar 2017 10:59:55 +0100
X-Google-Sender-Auth: IKerLF249iwTCKBQlpiRvkoWPdg
Message-ID: <CAK8P3a145sL=DHiyP39c2FrH9Vh9aZBd7GUs96pWd-93NngQDg@mail.gmail.com>
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
X-archive-position: 57318
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

On Wed, Mar 15, 2017 at 9:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Mar 15, 2017 at 6:53 PM, kernelci.org bot <bot@kernelci.org> wrote:
>>
>> mainline build: 208 builds: 0 failed, 208 passed, 422 warnings (v4.11-rc2-164-gdefc7d752265)
>
> The last build failure in mainline is gone now, though I don't know
> what fixed it.
> Let's hope this doesn't come back as the cause was apparently a race condition
> in Kbuild that might have stopped triggering.

Now the failure in x86_64 allmodconfig+CONFIG_OF=n is back, which makes it
particularly hard to bisect as the problem only shows up sometimes.

     Arnd
