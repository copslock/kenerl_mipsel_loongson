Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 18:56:44 +0200 (CEST)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33378 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014824AbbCaQ4nZiJQO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 18:56:43 +0200
Received: by iebmp1 with SMTP id mp1so14149763ieb.0
        for <linux-mips@linux-mips.org>; Tue, 31 Mar 2015 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vWSjpJftcOjra4dqTGrNjMl4umEG5C4pZYRwbmhI/Iw=;
        b=KwXGdoCT4FuYtZ/TOkT5rp+klbiUQ6z8NNf6dk7E3tRSuEMHJg4U+5r1j0phl+BSmM
         Mt7gs6LteeceTFrcAODIj8LT81NF7c+e8UopXBORlWiZClLOH6kJO25r9vDq+GWCEwUl
         TL4uMs/MmUhxO7vESGzllVLhSfXOyHrcIYWEl62BhRfUpKIqU1ghTkUCAdxmRrXL8YJH
         P89l89Scb2xxi9pnubvOh8ozarttmTRjpdDEdhiGIMx++uXhgOb06ZIMhTPS/ZOgtd8n
         BlF88xgDNlQApwlOUYzopy07K04vUXHg6/zPxCO+Zb2Ft9Otq2WlBs9sjQBOE93uRNC/
         /IhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vWSjpJftcOjra4dqTGrNjMl4umEG5C4pZYRwbmhI/Iw=;
        b=U51gZ69F5mU4x66JlMWuHHRIID2NW5XnghXCenOVRHbLTQHxgucSNHfxKg3V9myTRU
         NpWjqyPfxnV/iEAjHHmWHa9mgFOVzkt2mDV9slePp2fn9ct+++dC/wNQQQnP37YK6k/B
         AfE0QoYgIWUoqvnBW/21xv7GOIZgz3CofEyqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vWSjpJftcOjra4dqTGrNjMl4umEG5C4pZYRwbmhI/Iw=;
        b=Rp2MMsLYiX06jfJfLN599C1lam7Hov3oTs/jgag0CVMR3+qXg0ZxOjes9TgbDbtVo+
         e6r7mF/vowMJ3KLTjK1TpJnXyX88id7QoBm4zwhJvp6YdYdE/+6c/cDrN/w+kplYCYo0
         saGoF/KOXJwLv9zq2OQl6em+gdcsGIAmWA3UAOpPDWUjeSfwv+fa7HTm8KEjxrEgBXDf
         QGaOF27P8mQp1N3P/wlGW/hMFdJznU8fXM9BYqaDAm7FljiawRSwUCSZ0JXHlpimXIGP
         VvTsxDXA9qvuY/Tm/9HYHiElwXd+xXSyVdBYi0V7vwlk4Ph3OtZXBjGQzKwvPBH6DQrj
         F8xg==
X-Gm-Message-State: ALoCoQmVUrr/qItOwmhzDrQlR9VIXYLHxyjB5rNlb7dKr5fCLhZPusWaMMo+a8gD85HfOWlqSmE0
MIME-Version: 1.0
X-Received: by 10.43.14.10 with SMTP id po10mr67037744icb.64.1427820998464;
 Tue, 31 Mar 2015 09:56:38 -0700 (PDT)
Received: by 10.64.58.45 with HTTP; Tue, 31 Mar 2015 09:56:38 -0700 (PDT)
In-Reply-To: <1427789415.2408.45.camel@x220>
References: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
        <1427757416-14491-4-git-send-email-abrestic@chromium.org>
        <1427789415.2408.45.camel@x220>
Date:   Tue, 31 Mar 2015 09:56:38 -0700
X-Google-Sender-Auth: QnT1cjwTj6rC-DbBSm911nXgzFk
Message-ID: <CAL1qeaG70_42p8r9ogHxMv2h-yx_TENYV_gZbX1wQMhqSaiFpg@mail.gmail.com>
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
X-archive-position: 46656
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

On Tue, Mar 31, 2015 at 1:10 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> The patch adds a mismatch between the Kconfig symbol (a bool) and the
> code (which suggests that a modular build is also possible).

Nearly all of the pinctrl drivers (with the exception of qcom and
intel) are like this.  They use a bool Kconfig symbol but they are
written so that they could be built as a module in the future.

Thanks,
Andrew
