Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 18:47:27 +0200 (CEST)
Received: from mail-lb0-f193.google.com ([209.85.217.193]:35304 "EHLO
        mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033277AbcEXQr0Sk2ej (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 18:47:26 +0200
Received: by mail-lb0-f193.google.com with SMTP id sh2so1303135lbb.2
        for <linux-mips@linux-mips.org>; Tue, 24 May 2016 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYPcbvWmkQ7QBBiC1NEGE1KwVseN/QIqt09LvcT8gqs=;
        b=AZ0GlJTqG4wtBs6kETz+XRYGzlK06UC08/LYY9UFyh/VNN9RY+JL2ItngV2VnixOqb
         Q80ZP6AnlI+5uUEExXcMw7hZgH1DGqIuT6HXP88K4vKkhk3gvsn7RCmZdVTVG0fQ+TWN
         kXINsXtRbdyGTHVy1iorFH7880oteSEtXFSHySBXlO/tETsN20iN8gst6/SfaGBRewdj
         HIju3Wk2XQf3JLofar04GlWTMc5br3po+ehhUFkazOYH39vqNdrM1yh4ynfAqtWIwkR9
         n5ZMQSpWrT7Oy8deyfyi5Ao5UxP8wShZHErftD1NEZcaa3STgdqdObh0fCw4FZ7HTXq7
         oLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYPcbvWmkQ7QBBiC1NEGE1KwVseN/QIqt09LvcT8gqs=;
        b=nMrmrop1fv14Tx/kgpRK7OKvi+6JbGC7X/Y4PZi+jFg/fLGkFtXiNawn7H3YB/OYuv
         CwTvXuqVY1Y67vTcBXhjYqX7z/Ea+WcB6brUSz8k2SXM58vVf0Ir/kBXFUMjo+/O4qGI
         29d+KsVpqSyCfkWKv+Jk+JQecPNMfKZE0Q3KwN/3J2+YG9YzuKI8uIzgHQffRoCt3oM9
         R1saIAg/mTppz5Ty7VCGtAxFeJJk8vLp1u2D64sN75xoKtktI+zRE2mCSObrbJOTqxbg
         cjIDWiiHCerWuyxBCLl9c/DKBqOFU/+Juv9vt/r65B0MwRRsr+oRYUBjN8GyLBwAF4Ir
         z5jg==
X-Gm-Message-State: AOPr4FUQO4szUXo30RpMcsPYfrOZ1+qxyxHDTDrFJwUDHRduXjE2G5aKgHHSG6lX9bbyng==
X-Received: by 10.112.167.97 with SMTP id zn1mr8059762lbb.41.1464108440810;
        Tue, 24 May 2016 09:47:20 -0700 (PDT)
Received: from flare ([193.232.173.35])
        by smtp.gmail.com with ESMTPSA id o79sm643003lfe.18.2016.05.24.09.47.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2016 09:47:19 -0700 (PDT)
Date:   Tue, 24 May 2016 19:48:18 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        Jonas Gorski <jogo@openwrt.org>,
        Mathias Kresin <openwrt@kresin.me>
Subject: Re: [RFC PATCH] Re: Adding support for device tree and command line
Message-Id: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
In-Reply-To: <1464103650.27173.26.camel@chimera>
References: <574372CD.1060201@hauke-m.de>
        <5743777F.9060801@hauke-m.de>
        <1464041521.5475.18.camel@chimera>
        <1464067930.27173.7.camel@chimera>
        <20160524142711.58a6bf90f3adbe18a28973b3@gmail.com>
        <1464102907.27173.23.camel@chimera>
        <1464103650.27173.26.camel@chimera>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Tue, 24 May 2016 08:27:30 -0700
Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us> wrote:

> On Tue, 2016-05-24 at 08:15 -0700, Daniel Gimpelevich wrote:
> > On Tue, 2016-05-24 at 14:27 +0300, Antony Pavlov wrote:
> > > We have too many 0xd00dfeed.
> > > Can we introduce some macro aliases, like
> > > arch/arm/kernel/head-common.S does?
> > > Something like this
> > > 
> > > #define OF_DT_MAGIC 0xd00dfeed
> > 
> > And exactly where would you propose to put that? Having the same #define
> > in multiple places is no better than just using the value…
> 
> Never mind. It's already in <linux/of_fdt.h>. I will supersede this
> after making any additional requested changes. What else needs to
> change?

Also we can drop '#if defined(CONFIG_*' in favour of 'if (IS_ENABLED(CONFIG_*'.

-- 
Best regards,
  Antony Pavlov
