Return-Path: <SRS0=CBLp=R6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2690BC43381
	for <linux-mips@archiver.kernel.org>; Wed, 27 Mar 2019 23:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38032075C
	for <linux-mips@archiver.kernel.org>; Wed, 27 Mar 2019 23:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ODxVbkR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbfC0XPn (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:15:43 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33400 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfC0XPk (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 27 Mar 2019 19:15:40 -0400
Received: by mail-vs1-f68.google.com with SMTP id a190so8836333vsd.0
        for <linux-mips@vger.kernel.org>; Wed, 27 Mar 2019 16:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbXO/VWyJiCmltAKiBOIF6+4WZxY/EdHeUCq/+V/gkU=;
        b=ODxVbkR6cVb59Srw7EmkVqTJ3SDl2tx485kKU493XWp55lV+lw5+LNag/5755s106R
         rqtbccvR3wEnv0m6Ub8/cMUpkHV6696pQBYMRd3+CobEb6YFpciVhR01VdBck7x855Ii
         js0hxSLwvcnCHW33h7m6+dFY8BVUUycLFxv2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbXO/VWyJiCmltAKiBOIF6+4WZxY/EdHeUCq/+V/gkU=;
        b=AV3+uWtTJihv5B/bswyQ+8HclO0+n9jwRk23F7tRqs/eSXTRkbK3Ces4jS5ZedIVt4
         2cmg6WPslzD5ScvVOFsQAnwEdQy6DOkcaBPdlEWd0ZhDLEUHWfsQ8dfG2cKlULBJ7tkB
         K4+Xjri5d8n4PptaKbzhEnA1oR8CpF7cFwoxj5FfexZRboef8Ob3osiODVUS7XePIWFw
         AOEs9NOqfapGoIxqbe+P4EAzNG9IONX8rCFRnuLSwONP/Hnac4/qO1fvcwrjysyASFDi
         bP70wpSxWpFBkq4djnGY1DGIHMkZBY/Vx5Ci6lPoIHvzGy28Ih7Pb0bAZai8XYLOT5xc
         1otQ==
X-Gm-Message-State: APjAAAVDzntVpb2eiA0HDljFJAhbEP7wyZOmbz40jb5aHZBaXw1p4GQN
        om+deSW5c0lqYHmezhR4+3OGrStA3h4=
X-Google-Smtp-Source: APXvYqyjfgDDJ5sS2qrLFM4mZnh4anHTCQdAwRo8eJG2Nn5KvNvP2dZ3hkcdKII4dH1xo2NVf0UEJw==
X-Received: by 2002:a67:f358:: with SMTP id p24mr25174347vsm.3.1553728538793;
        Wed, 27 Mar 2019 16:15:38 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id o10sm240571uak.19.2019.03.27.16.15.37
        for <linux-mips@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 16:15:38 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id e1so11013159vsp.2
        for <linux-mips@vger.kernel.org>; Wed, 27 Mar 2019 16:15:37 -0700 (PDT)
X-Received: by 2002:a67:bc01:: with SMTP id t1mr24650125vsn.149.1553728537476;
 Wed, 27 Mar 2019 16:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190327230801.3650-1-qiaochong@loongson.cn>
In-Reply-To: <20190327230801.3650-1-qiaochong@loongson.cn>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Mar 2019 16:15:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Unvv6qNyx-1A_5KUOr-PxjuctaAf5e+Ea0tpJ1c17vKg@mail.gmail.com>
Message-ID: <CAD=FV=Unvv6qNyx-1A_5KUOr-PxjuctaAf5e+Ea0tpJ1c17vKg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: KGDB: fix kgdb support for SMP platforms.
To:     Chong Qiao <qiaochong@loongson.cn>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On Wed, Mar 27, 2019 at 4:08 PM Chong Qiao <qiaochong@loongson.cn> wrote:
>
> KGDB_call_nmi_hook is called by other cpu through smp call.
> MIPS smp call is processed in ipi irq handler and regs is saved in
>  handle_int.
> So kgdb_call_nmi_hook get regs by get_irq_regs and regs will be passed
>  to kgdb_cpu_enter.
>
> Signed-off-by: Chong Qiao <qiaochong@loongson.cn>

Since you didn't really change any content, you could have just
carried my previous review.  In any case I'll add my tag again:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'd also note that it's nice if you version your patches and include
version history.  If you need help you might consider using patman to
help you send upstream patches.  See:

http://git.denx.de/?p=u-boot.git;a=blob;f=tools/patman/README

...never mind that it lives in the U-Boot tree--it's great for kernel work too.

Thanks for contributing to the kernel!  :-)

-Doug
