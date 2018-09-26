Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2018 22:52:33 +0200 (CEST)
Received: from mail-wm1-x341.google.com ([IPv6:2a00:1450:4864:20::341]:39591
        "EHLO mail-wm1-x341.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992328AbeIZUw3qnyJv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2018 22:52:29 +0200
Received: by mail-wm1-x341.google.com with SMTP id q8-v6so3793767wmq.4;
        Wed, 26 Sep 2018 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wkGCeYtE2WgVZ1DvgQhO4F4mu1Ob35imFAmQvQskoTY=;
        b=dFRXczT9p+P4Gb4hxCIRZOcYO9T3Jn+AOYEz3tJFTbcA/Qs+Kutq8s0MN805H51rYZ
         3HJCpDaYXnTIN6Kh0+yGkRaLUK4sOPQtChyUedIJJCI7u7wP/3oIFdo4qpMmjrOVxpPA
         N/UsFy4BrlRaMqnRceSUBQdvOfHH9Dq9Zvxx6dbMcW+cWq/4lA0MLnf+hnbwseIbQv4+
         0g1Zs9ZxmdnDQ1O61GF+Ta8D1wtHvpvLZeK3Wcu2K7+WCsniRBAmuskfXXeG3GqUHArN
         bgNKavs8x2PPFtMHKefsUMyBb6YGN0ZaNabWNesuNa7tBSHKMiuoeKeJmNF1b0juHl6s
         x+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wkGCeYtE2WgVZ1DvgQhO4F4mu1Ob35imFAmQvQskoTY=;
        b=J+Z+onc7l/geI/8UneHS9QXlU1prkreGYWzFFLmQKIw2luS6k0BSsbrzw8wfHDKYCl
         4oHNv7BzylaSDubEaCbe5VjmaybkkBKxWLsBsGLGXsKYcLvXzXC4AXUYahrcYDO0l8QK
         uxf1DufAwj2w744yaqbxB4jX55UhMJLNfxrXJwahD/RB9i8tDgDQJtu7kKXVE2HefUZu
         V/3Rtxb5XtWEa9QU9DIKBxol2WLZHcmSVc3dMEkpY/6DRBVNGDyAcR356Wo/dh1vB39p
         K9Np0lBRQswmRUCZgxa/Dn7onx34ep8hQC/QQC42LDLBYH0P+vLbYYjwFCgm4PLVYNp3
         VNpw==
X-Gm-Message-State: ABuFfoh5GnKIs03x8gSMRzE6QFmvyLg294rwCxuZ37qAB8eQhHVEFaKZ
        lveUtb9ra3rV4pBB8D5emLw=
X-Google-Smtp-Source: ACcGV63tbgcYNOZMK/QDdUH16L8liNwT+0VL0wn8zikXAR6CQjSc3c/QqquSkIHUh8QECUPUti9WKA==
X-Received: by 2002:a1c:908b:: with SMTP id s133-v6mr5388140wmd.69.1537995144850;
        Wed, 26 Sep 2018 13:52:24 -0700 (PDT)
Received: from laptop ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id b193-v6sm262323wmb.31.2018.09.26.13.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:52:24 -0700 (PDT)
Message-ID: <5dad38f5158860a4c8da4d122af89d3e84def312.camel@gmail.com>
Subject: Re: [PATCH 0/4] MIPS: Simplify ELF appended dtb handling
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Sep 2018 23:52:22 +0300
In-Reply-To: <20180926203618.bnmo5ys4ay24tbrr@pburton-laptop>
References: <20180925180825.24659-1-yasha.che3@gmail.com>
         <20180926203618.bnmo5ys4ay24tbrr@pburton-laptop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

Hi Paul,

On Wed, 2018-09-26 at 20:36 +0000, Paul Burton wrote:
> Hi Yasha,
> 
> On Tue, Sep 25, 2018 at 09:08:21PM +0300, Yasha Cherikovsky wrote:
> > Hi,
> > 
> > This patch series simplifies and cleans up the handling of
> > CONFIG_MIPS_ELF_APPENDED_DTB in the MIPS tree.
> > 
> > Specifically, it makes sure that the dtb appears in 'fw_passed_dtb'
> > also under CONFIG_MIPS_ELF_APPENDED_DTB=y.
> > 
> > This allows to remove special platform code that handled the ELF
> > appended dtb case, and replace it with the generic appended dtb
> > case (fw_passed_dtb).
> > 
> > There's also a bonus: platforms that already handle 'fw_passed_dtb',
> > gain now automatic support for detecting a DT blob under
> > CONFIG_MIPS_ELF_APPENDED_DTB=y.
> 
> Thanks - applied to mips-next for 4.20.
> 
> Paul

Thanks!

Yasha
