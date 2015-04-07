Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 15:20:43 +0200 (CEST)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36512 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010150AbbDGNUi21xPn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 15:20:38 +0200
Received: by igblo3 with SMTP id lo3so11270171igb.1
        for <linux-mips@linux-mips.org>; Tue, 07 Apr 2015 06:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=X9pztutcX3aDYNXo/Ds5SL9Y4zxX8w0a6nQoAtmban0=;
        b=dEs+/i/8oUwCkx8VxYHCaOL6Vu9IthPmJOluGMDmVoGnlwusGqPXm8aTZZKdijX/W5
         VEl9k1B6YCl/9/DnfZMW1kSJYP7aNfUum8MUCSHS+STwW4m9zzpZirbr+FBLbjGRLhpZ
         tYg4a47fkiy3O+i6J6g8hON6z3URxEPf/2gDkkm09wzU7gF6UDDBIgAOzxqqQlh3etLw
         vQ8xNrNIhS1mtbdhkIsnG1lKuT0t6KO++8TTUzhEzWik4KcToZNP6IhNKJFtFq9ENwc2
         HrKKDpB0xkw3PsXNMlq2hZERJoqGlfdxPPhRwibkcom+p6C884k2cfmpiajG3OIC8wWH
         U+cQ==
X-Gm-Message-State: ALoCoQns/894pCxDTt4NCrz2KPyz1P/IWAajarT7/fWr+VAZQiA1Gklmz8CQzySvM7Q12WEMF6Tj
MIME-Version: 1.0
X-Received: by 10.50.111.115 with SMTP id ih19mr3465265igb.47.1428412834015;
 Tue, 07 Apr 2015 06:20:34 -0700 (PDT)
Received: by 10.42.103.133 with HTTP; Tue, 7 Apr 2015 06:20:33 -0700 (PDT)
In-Reply-To: <1427757416-14491-2-git-send-email-abrestic@chromium.org>
References: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
        <1427757416-14491-2-git-send-email-abrestic@chromium.org>
Date:   Tue, 7 Apr 2015 15:20:33 +0200
Message-ID: <CACRpkdZ=kCyW37z-2C-2aK_Y8HaEwnfGXxfFNfMiUKkJSYpUAg@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] pinctrl: Document "function" + "pins" pinmux binding
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Tue, Mar 31, 2015 at 1:16 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:

> Currently the "function" + "groups" combination is the only documented
> format for pinmux nodes, although many drivers use "function" + "pins".
> Update the generic pinctrl binding to include the "function" + "pins"
> combination as well.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> ---
> New for v2.

Patch applied, as it just documents what some drivers are
already doing. Not much to be discussed there.

Yours,
Linus Walleij
