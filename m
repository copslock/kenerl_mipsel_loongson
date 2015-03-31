Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 03:37:18 +0200 (CEST)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36761 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010156AbbCaBhQiAMcH convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Mar 2015 03:37:16 +0200
Received: by iedm5 with SMTP id m5so4594754ied.3
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 18:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=m3RBYJiSjC263wYyfyDrWL2YDxdvWDkOuixZM0Olxwc=;
        b=g3QZCOmhwCauUzLrNYY23wkxMvfgs0K+nmJKXarDQcgoX2DmS5wVbvSywgCnoDj/z3
         bOW17rCERwSaZl3pH2Noe6xBKFkL1+2B6RvJYlz+FEyf0dxvVW43lt8pu779W4FHdhMe
         sIo4T/QkrostpFZovvJ3hN4mPeZnpO4Yh9ySDlrRnAwgVpCqCJNiDfQ7ym68CIzeu/t+
         s1MD7HD5ClsQAWblRccy4Das1r4OUHcU6B0OrcSsK35Lw9gCQHSPRpe3SQ0v/75qHgBV
         wNMy4ZP1nZtEM9YhghTlw0Y8ntUkTFEN7JvJ6Wc9qgavfy2pmyBSZ4uywK/z4+nF25Aj
         WGaA==
X-Gm-Message-State: ALoCoQkJq6CpIT6AkM/zwPEJZj/Ci74VcU/6UAfyioO91gySYs6KavbNrXb94qOl3LGyJECyVr9Y
X-Received: by 10.107.150.149 with SMTP id y143mr52018023iod.21.1427765831309;
        Mon, 30 Mar 2015 18:37:11 -0700 (PDT)
Received: from localhost (pool-71-119-96-202.lsanca.fios.verizon.net. [71.119.96.202])
        by mx.google.com with ESMTPSA id o8sm9070184igp.11.2015.03.30.18.37.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 18:37:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Andrew Bresticker <abrestic@chromium.org>,
        "Stephen Boyd" <sboyd@codeaurora.org>
From:   Michael Turquette <mturquette@linaro.org>
In-Reply-To: <CAL1qeaGTtMWDM+p+FpDRP=L-yqQ_ai7LY8GwcBUO_C1F+V1LzQ@mail.gmail.com>
Cc:     "Ralf Baechle" <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Linux-MIPS" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ezequiel Garcia" <ezequiel.garcia@imgtec.com>,
        "James Hartley" <james.hartley@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>
References: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
 <1424836567-7252-3-git-send-email-abrestic@chromium.org>
 <5519E37C.9010201@codeaurora.org>
 <CAL1qeaGTtMWDM+p+FpDRP=L-yqQ_ai7LY8GwcBUO_C1F+V1LzQ@mail.gmail.com>
Message-ID: <20150331013659.25195.31669@quantum>
User-Agent: alot/0.3.5
Subject: Re: [PATCH 2/7] clk: Add basic infrastructure for Pistachio clocks
Date:   Mon, 30 Mar 2015 18:36:59 -0700
Return-Path: <mturquette@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@linaro.org
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

Quoting Andrew Bresticker (2015-03-30 17:15:43)
> On Mon, Mar 30, 2015 at 4:59 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 02/24/15 19:56, Andrew Bresticker wrote:
> >> +
> >> +void pistachio_clk_force_enable(struct pistachio_clk_provider *p,
> >> +                             unsigned int *clk_ids, unsigned int num)
> >> +{
> >> +     unsigned int i;
> >> +     int err;
> >> +
> >> +     for (i = 0; i < num; i++) {
> >> +             struct clk *clk = p->clk_data.clks[clk_ids[i]];
> >> +
> >> +             if (IS_ERR(clk))
> >> +                     continue;
> >> +
> >> +             err = clk_prepare_enable(clk);
> >> +             if (err)
> >> +                     pr_err("Failed to enable clock %s: %d\n",
> >> +                            __clk_get_name(clk), err);
> >> +     }
> >> +}
> >>
> >
> > Is this to workaround some problems in the framework where clocks are
> > turned off? Or is it that these clocks are already on before we boot
> > Linux and we need to make sure the framework knows that?
> 
> It's the former.  These clocks are enabled at POR and may only be
> gated as the final step to entering suspend, so they must remain on at
> runtime.  The issue we were running into was that consumers of these
> critical clocks or their descendants would enable/disable their clocks
> during boot or runtime PM and cause these clocks to get disabled.
> Bumping up the prepare/enable count of these critical clocks seemed
> like the best way to handle this - is there a more preferred way?
> FWIW, this is also how the Tegra and Rockchip drivers handled this
> problem.

Hi Andrew,

Why are your drivers allowed to disable clocks which must not be
disabled? (you mentioned boot and runtime pm)

Is this the case that a critical clock is not directly disabled, but a
parent of that critical clock is and it is gated as a result?

Regards,
Mike
