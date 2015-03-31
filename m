Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 03:49:43 +0200 (CEST)
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34764 "EHLO
        mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010169AbbCaBtmGryBf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 03:49:42 +0200
Received: by qgep97 with SMTP id p97so2994477qge.1
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 18:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BhHAfFoTdQxv+7i13xrGMVyHy3XqVQdCTULIp/V3BGk=;
        b=iWkqmdXRPaEh2hZb3imiQpCNp95y5q53fxSe1gn0zkQY97IZrhy39XW/EIsbDUu3XS
         822TJlOv6vvnARXEtL4s+JNuAAyvM7ij8S9FtyCUMwlB8Isfq8ZFCE2A5zzMpm4Qc3DN
         tnPNR2d6Sf3d1Dz2wE4aO5HQjxryCq924pUknX39oF4gNgbbmJ28Q65ug8viTPx6NIhq
         oDhlQrGiDBm4AFqVtHMHLTePFZvo+H08gcs7Gm69ojBgVJLVoRw/nLGz1U/REVXMpjL1
         XEF++t1eIx4rna1XnsGbJ+I13oS6d4hzf/nuLXA1C4GdWkk5bBo+/q1sF3aH0mJ+nqng
         dAHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BhHAfFoTdQxv+7i13xrGMVyHy3XqVQdCTULIp/V3BGk=;
        b=OVQgAJCSu2k2enf1N5raQnX5Vu/fbpj1GLl0kIVPJeklHu7PKnM5jGXLS8XNbNbicS
         ckueUWcsOVW41wbRfn/Vl/dX4iM20oh24j8blAPF3+I1CWuq0NIEGk2lxXJWZYapCSKI
         36VgHZ1TNYHzdWbd5ZPfm+GdjWCwTOmu9dvNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BhHAfFoTdQxv+7i13xrGMVyHy3XqVQdCTULIp/V3BGk=;
        b=lV72OkJq5K/g9v6H4wTja4BkQQhXIPR4t+pNeGfV7bhJXuD5WKpIiIVn9NqJzmw/0L
         YgJO2MckdSTuLLd2TUeyPwJLDGM8tXIKbPFtTS6DjapBePFvg4TcayhHdBuZpGK0g+Hm
         EY7tmjawlHeT0VTiizcbH0hdObkZSnH311xDLv7kxknQWKH6cdL7lPRzjpLuEJTt8TFV
         33k47JR5oEBZcAvzsgRM0AaP1yuOiVqWgKsZSpTk+Ed8hptd1LZP5iKKCXa3EkiCZcKZ
         AQlwKj772WwZCdiC3CDqi9FYa8Cr7h3VjAdH6rh64l1TX+2/qYte7rppbZaX97bIspWC
         kgNg==
X-Gm-Message-State: ALoCoQlHdnAtFqMNnzeZgk3TMO+ioyxhnx8JJHucrBRkRmy4y8ov2wwNdrrO+zp3RwA86Gm3R8Q1
MIME-Version: 1.0
X-Received: by 10.55.16.87 with SMTP id a84mr26296354qkh.86.1427766577429;
 Mon, 30 Mar 2015 18:49:37 -0700 (PDT)
Received: by 10.140.19.104 with HTTP; Mon, 30 Mar 2015 18:49:37 -0700 (PDT)
In-Reply-To: <20150331013659.25195.31669@quantum>
References: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
        <1424836567-7252-3-git-send-email-abrestic@chromium.org>
        <5519E37C.9010201@codeaurora.org>
        <CAL1qeaGTtMWDM+p+FpDRP=L-yqQ_ai7LY8GwcBUO_C1F+V1LzQ@mail.gmail.com>
        <20150331013659.25195.31669@quantum>
Date:   Mon, 30 Mar 2015 18:49:37 -0700
X-Google-Sender-Auth: 0JRiQuPRmp4KHMLP0SbA7_NdH2s
Message-ID: <CAL1qeaHLwKKk0Pb4hGvuN2KnoKRGfJL68nA0CQvkjqmkSn5bAQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] clk: Add basic infrastructure for Pistachio clocks
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Michael Turquette <mturquette@linaro.org>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46638
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

Hi Mike,

On Mon, Mar 30, 2015 at 6:36 PM, Michael Turquette
<mturquette@linaro.org> wrote:
> Quoting Andrew Bresticker (2015-03-30 17:15:43)
>> On Mon, Mar 30, 2015 at 4:59 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> > On 02/24/15 19:56, Andrew Bresticker wrote:
>> >> +
>> >> +void pistachio_clk_force_enable(struct pistachio_clk_provider *p,
>> >> +                             unsigned int *clk_ids, unsigned int num)
>> >> +{
>> >> +     unsigned int i;
>> >> +     int err;
>> >> +
>> >> +     for (i = 0; i < num; i++) {
>> >> +             struct clk *clk = p->clk_data.clks[clk_ids[i]];
>> >> +
>> >> +             if (IS_ERR(clk))
>> >> +                     continue;
>> >> +
>> >> +             err = clk_prepare_enable(clk);
>> >> +             if (err)
>> >> +                     pr_err("Failed to enable clock %s: %d\n",
>> >> +                            __clk_get_name(clk), err);
>> >> +     }
>> >> +}
>> >>
>> >
>> > Is this to workaround some problems in the framework where clocks are
>> > turned off? Or is it that these clocks are already on before we boot
>> > Linux and we need to make sure the framework knows that?
>>
>> It's the former.  These clocks are enabled at POR and may only be
>> gated as the final step to entering suspend, so they must remain on at
>> runtime.  The issue we were running into was that consumers of these
>> critical clocks or their descendants would enable/disable their clocks
>> during boot or runtime PM and cause these clocks to get disabled.
>> Bumping up the prepare/enable count of these critical clocks seemed
>> like the best way to handle this - is there a more preferred way?
>> FWIW, this is also how the Tegra and Rockchip drivers handled this
>> problem.
>
> Hi Andrew,
>
> Why are your drivers allowed to disable clocks which must not be
> disabled? (you mentioned boot and runtime pm)

The issue is that they do not directly consume a critical clock, but
rather a descendant of the critical clock and thus could cause the
critical clock to be disabled.  For example, the periph_sys clock is
one of these critical clocks and it is the parent of various
peripheral clocks, like the watchdog, I2C, PWM, etc.  If the I2C
driver enables and disables it's clock during probe(), and nothing
else has caused the periph_sys clock to be enabled, the disable() call
will cause periph_sys to become disabled since its enable count drops
to 0.

Now this could be solved if there was a driver to directly consume
these clocks and keep them enabled, but, like Stephen mentioned, there
really isn't a proper driver for that.  So it looks like I want
something like the always-on feature Lee is trying to introduce.

Thanks,
Andrew
