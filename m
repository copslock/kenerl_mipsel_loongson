Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 20:37:32 +0200 (CEST)
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35624 "EHLO
        mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008743AbbCaSh3rujG9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 20:37:29 +0200
Received: by qgh3 with SMTP id 3so22664385qgh.2
        for <linux-mips@linux-mips.org>; Tue, 31 Mar 2015 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gJtGoabe62X0yHVBBnJ0KyQvW5FCaB4W6EvTHcFsnyo=;
        b=FxfYsljLFjObQoY0ySwvqEUz5J7iN3DoykSQ5z27PUkru/p8Buf22GdBfU00NANPG8
         twsWLqqSZgpT9fKiEjl55qlJ7p9EGu7sDXA44Yxsa0+zIa0tJtQjqMw7/Uv1r6R+XrAc
         jPkTf83e61kFXuRCXt+pHI0Jl88jHerhiS1brdVFR3UKi9TfgvDVvhoYGQAFDU9OcZnr
         SyBT1zJyoLcLKdnjXTT6mThNqTsBSu+7/cIs10R0aW78wOWmQnDjCbSMvUeDWsryJVPJ
         t0VMWyAKfYNDkVBU11DSMgPm4HthPUFA488YQ6NmchUxsONV0HQMFrmVU4Xj5afdGOuo
         qqgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gJtGoabe62X0yHVBBnJ0KyQvW5FCaB4W6EvTHcFsnyo=;
        b=aKIJRlcfrMhOwC1cPYb2HrS+uLi69sOBd07P3QJUHS9MpYhHAMO+H8dpwwfcQo06tF
         jbnKUpkSkdC7z/MIeCXlrkEcOVZ/I8EZQIDin3RFYjxNVEFgO1Ve0nJ0l3o2R0BLhyQa
         cCVMTBWJOQsDRrGgS9H5d4cKsbEw4asLwlqWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gJtGoabe62X0yHVBBnJ0KyQvW5FCaB4W6EvTHcFsnyo=;
        b=bWKxJkUvGtvnVSX2olUbkB3Q7lCAlbBMQcZxwaZ1agnYiPtTbNcosuFfSttoj04WXI
         YiVeGMlifv6iEAFbOX8slWmHSrrkdcCuSmRUraD6ZfL2pgsfqX8JgDC0euKCf977bcJH
         rOEdZfqL27jHJTvS+RjybTeGJBN8Q6NbS649fJKGIGMm+6Qv/UbmMVxPwIM3+Ua8KpwZ
         QXjOlGbXlPVy/MoANszAEo421ARa4aTWaAKgOf+pLe2PMAfyEa7PuEAAyh4EUbUjxwLP
         7feJOnU9+6ls6H1wVpirY2f+ADDIIjGWijYLfE4JVctJQ5Coc3ZYdD2+6nblG9jihWJs
         JY+Q==
X-Gm-Message-State: ALoCoQl0DH/1EH11Y7JIKn1O2qTnhVEqxY25RGnLzEiJ9uZhPGLQ40KVJTzndfa0uc+tiQu8sV6M
MIME-Version: 1.0
X-Received: by 10.55.23.220 with SMTP id 89mr82872215qkx.56.1427827044995;
 Tue, 31 Mar 2015 11:37:24 -0700 (PDT)
Received: by 10.140.19.104 with HTTP; Tue, 31 Mar 2015 11:37:23 -0700 (PDT)
In-Reply-To: <1427826015.2408.63.camel@x220>
References: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
        <1427757416-14491-4-git-send-email-abrestic@chromium.org>
        <1427789415.2408.45.camel@x220>
        <CAL1qeaG70_42p8r9ogHxMv2h-yx_TENYV_gZbX1wQMhqSaiFpg@mail.gmail.com>
        <1427826015.2408.63.camel@x220>
Date:   Tue, 31 Mar 2015 11:37:23 -0700
X-Google-Sender-Auth: JbpIPL9LeKwSsCz2VYvD9wKbpNw
Message-ID: <CAL1qeaHg2oLbnxCmk_TaxRMYA6vM8cfgUeLk=i7Q5b1CJfS9LQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] pinctrl: Add Pistachio SoC pin control driver
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46660
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

Hi Paul,

On Tue, Mar 31, 2015 at 11:20 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> Hi Andrew,
>
> On Tue, 2015-03-31 at 09:56 -0700, Andrew Bresticker wrote:
>> On Tue, Mar 31, 2015 at 1:10 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
>> > The patch adds a mismatch between the Kconfig symbol (a bool) and the
>> > code (which suggests that a modular build is also possible).
>>
>> Nearly all of the pinctrl drivers (with the exception of qcom and
>> intel) are like this.
>
> Could be, I didn't check. Perhaps copy and pasting is to blame. (Copy
> and pasting appears to me a sensible way to start writing a new driver).
>
>> They use a bool Kconfig symbol but they are
>> written so that they could be built as a module in the future.
>
> Did I miss a comment or a remark in the commit explanation that explains
> this? Anyhow, if that modular future is not expected to be the near
> future, can you perhaps carry these lines in a branch called, say
> pinctrl-modular?

I have no immediate plans to make this a module, but since the changes
to make it buildable as a module have no overhead (at least I think
they don't!) I'd prefer to leave them in for consistency and to
eliminate any need for these changes in the future.  I'll leave it up
to LinusW though.

Thanks,
Andrew
