Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2015 08:35:43 +0200 (CEST)
Received: from mail-ob0-f176.google.com ([209.85.214.176]:36295 "EHLO
        mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012524AbbEFGfkUsf9z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2015 08:35:40 +0200
Received: by obbkp3 with SMTP id kp3so301882obb.3
        for <linux-mips@linux-mips.org>; Tue, 05 May 2015 23:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0UHhVtpqBA1AETL5aCzMANwPUa/4qUxTHC4Yj3t8O5I=;
        b=m28/HYdQL4duOVrS7P/KLe3BrVSHtfWtXYLjHeiUVwlLs8vMujS5V8f+3ZR7DwtnDw
         YYiQLqiYlz5xZPdGYDoCUsiN1gOOxZDndHom88TroLrwke3u2Gcpe9ZjDDVMdOB4mJcX
         /yFk7uP5AaVZQr/h6Nlolvkt9TDGT6uuGwB2Yr1FKcS8/bzGmvIFvz6cQbY3u5Ri6yzu
         /H9FHAmE1ONH9fTU9jyPlK3q980vIAxTIEqmZjzQWByUOLkVB5nXVlg7sHmTkbXt6JPV
         yHJW9wXiZ/a+9iIHyaqjj+BX9qzXkvaP8m26wIIUcQpeZLlCIlHlxrkykjCtc7BYM88n
         Chtw==
X-Gm-Message-State: ALoCoQlDNHJ0R5c58cgXpxyvSz1bmLGJoRdPSUsPZTS+XvpWidxEzJrmPdhtbjzk2VHad4zM8nCa
MIME-Version: 1.0
X-Received: by 10.202.73.81 with SMTP id w78mr12930002oia.89.1430894136360;
 Tue, 05 May 2015 23:35:36 -0700 (PDT)
Received: by 10.182.204.41 with HTTP; Tue, 5 May 2015 23:35:36 -0700 (PDT)
In-Reply-To: <1430269982-24129-2-git-send-email-abrestic@chromium.org>
References: <1430269982-24129-1-git-send-email-abrestic@chromium.org>
        <1430269982-24129-2-git-send-email-abrestic@chromium.org>
Date:   Wed, 6 May 2015 08:35:36 +0200
Message-ID: <CACRpkdbW8WNYy56U-KmsZPatQBFO8xSYAJV8R9BwsPMXnQzbwQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] pinctrl: Add Pistachio SoC pin control binding document
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
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
X-archive-position: 47250
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

On Wed, Apr 29, 2015 at 3:13 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:

> Add a device-tree binding document for the pin controller present
> on the IMG Pistachio SoC.
>
> Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> ---
> No changes from v2/v3.
> Changes from v1:
>  - Change compatible string to "img,pistachio-system-pinctrl".
>  - Specify GPIO sub-node names rather than forcing the nodes to be in order.

This binding looks nice.

Patch applied.

Yours,
Linus Walleij
