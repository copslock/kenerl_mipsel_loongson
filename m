Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2012 19:21:04 +0100 (CET)
Received: from mail-vc0-f177.google.com ([209.85.220.177]:33075 "EHLO
        mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825927Ab2KOSVD00160 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2012 19:21:03 +0100
Received: by mail-vc0-f177.google.com with SMTP id p16so1963313vcq.36
        for <linux-mips@linux-mips.org>; Thu, 15 Nov 2012 10:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :x-gm-message-state;
        bh=PYYstxlEQ25W3Znjk6fvfiS4x5NIhE7Fj45Tpp/+Nug=;
        b=oDY6aA/10l1yOF7Ko2qCFL9DgE/iIPz4SuoewZPQcmne3jFT0OxQ5Zj3N8CgfGnZvV
         URWsjNO9W0KGrdeYFm9DYzh/iTHMxQ8Lzu8bU4JT/G6D98W6AjSvSk9F1wSkwQ3G/Ihi
         skxQia0Tn8OJMx5j5m6tLGLFBtvh4DBgDGs6au18fx+xGMEYYJBrEcuo7+p80tCtnW0y
         UjK49ySIZMiQl4dqWHaMts2SqpAE7J5Jm7Gxv4SC6tMaWKnPZNbpIzJ0t0GyJkVKfNX4
         kW6UdM1VqkqZaJYFxZX26Gx6Hbp1bwBUkI9gdBjrQfubnA4xUKdmdtZxaf514dYJowjQ
         RvwA==
Received: by 10.58.240.107 with SMTP id vz11mr271451vec.45.1353003656799; Thu,
 15 Nov 2012 10:20:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.58.249.198 with HTTP; Thu, 15 Nov 2012 10:20:36 -0800 (PST)
In-Reply-To: <50A52FEC.4080409@wwwdotorg.org>
References: <CACxGe6vhd_4rcBbYyqtvbySVaY6XpNE+HQq42PZhKe5yt=zcaA@mail.gmail.com>
 <1352980284-2819-1-git-send-email-grant.likely@secretlab.ca> <50A52FEC.4080409@wwwdotorg.org>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Thu, 15 Nov 2012 18:20:36 +0000
X-Google-Sender-Auth: vuH6zKx7VEbnte_JvW70zJuAXdI
Message-ID: <CACxGe6tZOjMXR6CNDzDTSUkcERLiX-2+Qoad0bcPum5Z-Jxaaw@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] kbuild: centralize .dts->.dtb rule
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Stephen Warren <swarren@nvidia.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQkxIetBeDizNTRekiGG6x93d0Oe2fw5oC6AT1hd6J8J+t7pIglU6ik/lm0BFVleOy9yrFmM
X-archive-position: 35015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
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

On Thu, Nov 15, 2012 at 6:09 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/15/2012 04:51 AM, Grant Likely wrote:
>> Grant Likely wrote:
>>> Or how about: I could pick up the patch with only the MIPS hunk and
>>> every other user can be fixed up independently to use the new rule.
>>
>> Here's a trial patch to fix up ARM. Does this look correct? This patch
>> depends on the generic dtb build rule already being applied.
>
> I think the patch looks OK technically, except for one minor comment below.
>
> One issue with this patch is that it moves *.dts from arch/arm/boot to
> arch/arm/boot/dts, which means everyone has to adjust their scripts/...
> that package/install/... the kernel. I guess it's an easy change for
> people to make, but could easily catch people unawares if they do
> incremental builds so that arch/arm/boot/*.dtb still exists but is stale.

True. We could temporarily remove or rename if the same file exists in
the directory below to help people catch that problem. I really would
like to clean up that build rule to be consistent though.

The other option is to move all the .dts files into the boot
directory, but I don't think that is a good idea at all.

>> +targets += dtbs
>
> Doesn't that make the "dtbs" target always run by default? Perhaps
> that's reasonable though, and doesn't actually affect anything since the
> make command for this directory always specifies an explicit target?
>
> Or, was that meant to be the following that got removed from ../Makefile?
>
> targets += $(dtb-y)

Yes it is supposed to be the same thing. Doesn't it effectively do the
same since dtbs depends on $(dtb-y)?

g.
