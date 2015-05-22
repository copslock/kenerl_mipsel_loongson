Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 19:42:51 +0200 (CEST)
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33678 "EHLO
        mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006684AbbEVRmtNh3tO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 19:42:49 +0200
Received: by qgfa63 with SMTP id a63so12660783qgf.0
        for <linux-mips@linux-mips.org>; Fri, 22 May 2015 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=K3reI0iBXo3mHxb6wKFjJEbf72CLI76Xq4Sp5zpfS5A=;
        b=bpbl1xnPg98iaL3akSYOpZ6K4b0YZm6VhekbPj6lvuNe3ldg99mteH1ReICb94jNQ5
         gIsEC7u3H54AqGeq36ItIqzjoXPgzHTwHR9h6yOZAI4VpL8tpGOPdM6YQCn0D8Bu2bJF
         38xhlbVEZSSuO0GjzkZ71vWFyBMuyQ3/2leuWGaBrxRdN6sr9dg16QeaTzyJwwSW8PJB
         /MJISUZyEW9e0xvtlKo2X2QAut16jmycCb5XjinK+o4m5pSo9EonafX0x0piH5+QnMCA
         ugp4V6vnppygB+K9iH3LYkSFjRpiFau0BzuQvU7rGdu2XaL7a5u4vuqRg14iIfKHDK1i
         nsng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=K3reI0iBXo3mHxb6wKFjJEbf72CLI76Xq4Sp5zpfS5A=;
        b=Wtw18yg/ik2p8KFE1KvkSGd8Ok+orHq1wlB5689KMsDOU++EpiKJwqQTMbJrrBRdl6
         vTcEMyWIU1T1IE+4Lr0XYnSTNFXe2h9BwOuzTUEmmTUD8a4oN08T04JTtWxdm5CApWoe
         TIdzOh3TBTVe/gVwHB4r2OhcM6AsqdTyouV/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=K3reI0iBXo3mHxb6wKFjJEbf72CLI76Xq4Sp5zpfS5A=;
        b=SgYgWrl59I/05XMkj9ju9QsavLbbIXUQmTWfWi9hqKXFInj3UxW+zPgeeYF4t5ne7U
         iU3GwSzKDOjHShGLP+v9ScDc7z5/aLWY0f0q0jAHfV0bvjmfi5BO5DWxstDTovynPFvs
         1oUTcpYAHu/v4xr8FVURA25qIVMZRh7heLXKKqlzUZCZKv0x+9y2KVXizbINnzPZ5IVW
         Z2He0HGLJHBWgqdlmDIEAQ1Ldte4QqDj7eNlX4OLffI3xiCm8XJspseOt82AUNGHFLCx
         MnBlqhUO7NOFU3y3lD1aUK2rPok3fNL2JnT761NMMHPf2w0U/qFZ968b79Y7BwamwgDF
         Ktqg==
X-Gm-Message-State: ALoCoQlmXre6bh+srdOOUcl/khHWKaRRencmBqEDwIs2uVaoAof/4sHYbWWYXsrCmNzSHa/Vk0Vx
MIME-Version: 1.0
X-Received: by 10.55.31.168 with SMTP id n40mr20879287qkh.56.1432316565831;
 Fri, 22 May 2015 10:42:45 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Fri, 22 May 2015 10:42:45 -0700 (PDT)
In-Reply-To: <1432252663-31318-7-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432252663-31318-7-git-send-email-ezequiel.garcia@imgtec.com>
Date:   Fri, 22 May 2015 10:42:45 -0700
X-Google-Sender-Auth: lxtg_Q3TcCwqAESmrfLpQXYDD9o
Message-ID: <CAL1qeaEKeNXWWgcu=sX_Ly=6mSsNm4i6OuN0561=_z55MaE6DA@mail.gmail.com>
Subject: Re: [PATCH 6/9] clk: pistachio: Propagate rate changes in the MIPS
 PLL clock sub-tree
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Hartley <james.hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Thu, May 21, 2015 at 4:57 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> This commit passes CLK_SET_RATE_PARENT to the "mips_div",
> "mips_internal_div", and "mips_pll_mux" clocks. This flag is needed for the
> "mips" clock to propagate rate changes up to the "mips_pll" root clock.
>
> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

IIRC the clk core will prefer changing a downstream divider over
propagating the rate change up another level.  So, for example, if
MIPS_PLL is initially 400Mhz and we request a MIPS rate of 200Mhz,
we'll change the first intermediate divider to /2 rather than
propagate the rate change up to MIPS_PLL.  Wouldn't it be more
power-efficient to set the MIPS_PLL directly to the requested rate
rather than using external dividers to divide it down?
