Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 02:15:50 +0200 (CEST)
Received: from mail-qc0-f182.google.com ([209.85.216.182]:33275 "EHLO
        mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010143AbbCaAPsiMrVd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 02:15:48 +0200
Received: by qcbjx9 with SMTP id jx9so1436480qcb.0
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4ktLsigL2qggLpg2xHVMZouFjtPQ8e6SwVGjBW4X1fs=;
        b=lxwXl3PNUJgf5bIBcIZqRDqkgijKN0TssoY8pOzk9xzv1dACCYyOOYBzy8ymREm6V/
         izoqWvanAejZ4BggdIlf7b40er7UJWWkA9SobyErKg0f8zRBF3Sv6hDCjLcpaJqhbJ9R
         hVVK8olRweAG1ppwGolrgPscdMED3IPDEeNcYFZ5o/3m1f7pz1LMJn5CtKAR/wDDAmxc
         WppA0QIrrUyHAXr14jlv9iCgW9b2yBAT73HL9yJOoTICRRpNSGNtkSH/Ia46zfdWO36T
         B8ZpHqzyB/MhangsPDuqf1ZphyF3zOXDAHR1ZLo3fgmmJSzpY1Sjf0JFBG9pttG435ia
         T+5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4ktLsigL2qggLpg2xHVMZouFjtPQ8e6SwVGjBW4X1fs=;
        b=TYcTYtLJEygqUfKrebQfwPoLAtyHw52c/I12mtvmz9ae+0dz9iVr0Yyj/S5k3VL1ZI
         lEnw76+TYaGkM2xaPa4XQTnr7aUekze2SCBujN5Ru5kPems8eb9H7Qb7tAkAfekRmVjB
         VxLSjeJeJubNDvtgU9rGr5CGol+YJ5TH26eo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4ktLsigL2qggLpg2xHVMZouFjtPQ8e6SwVGjBW4X1fs=;
        b=ALKx+/QyduhRbWqRlI+1RZwUz22jrABHHejNf/e9aPpLDxF59mqjxz1FFAAqmD7pnC
         YurszRYDWdD854dsnu++lzOG3zmTmiecyHgXaf38s1wXXa6gFCHwLM9zjN3Kb8glqWA9
         OkIP9dpK/kAqBnTRqi2Sak+xlGiXqdQuuI961JFQKErI6Bcj6VYVwy9KFapv0b8wccZM
         Bfjeur3vTAapckAkKbexbm0E7O6eaIMC2qAWWSJ+JWAkom7/zTAwYPFZ3uxxlY6xj3N1
         0QPkDln5TFCxTi/xY+uDOIKy2pjLpiz/E0GzSZQJSN2/ui6LYKO/430CZHWrUBVinll9
         WmlQ==
X-Gm-Message-State: ALoCoQn3YOdV6/91iITAJjwvhg4aP239hUfONsj5bBjZJPeipZBfN2Us3bPllA6ndVXRKbxKTwS+
MIME-Version: 1.0
X-Received: by 10.55.55.4 with SMTP id e4mr72442781qka.97.1427760943854; Mon,
 30 Mar 2015 17:15:43 -0700 (PDT)
Received: by 10.140.19.104 with HTTP; Mon, 30 Mar 2015 17:15:43 -0700 (PDT)
In-Reply-To: <5519E37C.9010201@codeaurora.org>
References: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
        <1424836567-7252-3-git-send-email-abrestic@chromium.org>
        <5519E37C.9010201@codeaurora.org>
Date:   Mon, 30 Mar 2015 17:15:43 -0700
X-Google-Sender-Auth: A52eXlDiJdcZHKZBn_quthfOESs
Message-ID: <CAL1qeaGTtMWDM+p+FpDRP=L-yqQ_ai7LY8GwcBUO_C1F+V1LzQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] clk: Add basic infrastructure for Pistachio clocks
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Mike Turquette <mturquette@linaro.org>,
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
X-archive-position: 46634
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

On Mon, Mar 30, 2015 at 4:59 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 02/24/15 19:56, Andrew Bresticker wrote:
>> +
>> +void pistachio_clk_force_enable(struct pistachio_clk_provider *p,
>> +                             unsigned int *clk_ids, unsigned int num)
>> +{
>> +     unsigned int i;
>> +     int err;
>> +
>> +     for (i = 0; i < num; i++) {
>> +             struct clk *clk = p->clk_data.clks[clk_ids[i]];
>> +
>> +             if (IS_ERR(clk))
>> +                     continue;
>> +
>> +             err = clk_prepare_enable(clk);
>> +             if (err)
>> +                     pr_err("Failed to enable clock %s: %d\n",
>> +                            __clk_get_name(clk), err);
>> +     }
>> +}
>>
>
> Is this to workaround some problems in the framework where clocks are
> turned off? Or is it that these clocks are already on before we boot
> Linux and we need to make sure the framework knows that?

It's the former.  These clocks are enabled at POR and may only be
gated as the final step to entering suspend, so they must remain on at
runtime.  The issue we were running into was that consumers of these
critical clocks or their descendants would enable/disable their clocks
during boot or runtime PM and cause these clocks to get disabled.
Bumping up the prepare/enable count of these critical clocks seemed
like the best way to handle this - is there a more preferred way?
FWIW, this is also how the Tegra and Rockchip drivers handled this
problem.
