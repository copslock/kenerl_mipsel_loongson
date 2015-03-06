Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 12:30:02 +0100 (CET)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:47072 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007216AbbCFLaBI6RMt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 12:30:01 +0100
Received: by oiav63 with SMTP id v63so17096248oia.13
        for <linux-mips@linux-mips.org>; Fri, 06 Mar 2015 03:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4PJ56WiwclOOOUDZqWw9AnxfDC1bwX+hg9Ql3Bt0ENM=;
        b=X9xxKAiaB1jp6Y2jE8jTs43o572EdZlQzddWGaIHSolRnzbQQs2NBbsi/vL32eKa5A
         uDO9KoOrSpT8dFHtoLSL3OpJPoDfrWLmgbfW8TiBM/q3OYB4oTx/v/GX5j/+YJjoiEkk
         b7+GZcZ8rU2QpcL8yngFMpwbrEwbgkZyCpi3kx1ZUwY1m6N2Hs+jfWZ5N2ge+I/lA2HE
         QRX8RBJrdJeXwi6b+HdWEbfDL5rcOLv964KIj2S6oqLbdC3VhF6N1+ebzyAIhUUPtV+/
         /7jG6tXA7bQW2xcHRqu4RZqwpgYNd8EjMpCRzx+Y7MdNTojA5s5dpe/rVBsDfOgLqx1X
         tHAg==
X-Gm-Message-State: ALoCoQkcT8+CxjJuAMWivodXy+/nmNfOt/1LqbMZjLl/YMHXXD2wonkzP1Qx0I87xYNxEQxRZ6jH
MIME-Version: 1.0
X-Received: by 10.60.42.42 with SMTP id k10mr10649086oel.15.1425641395872;
 Fri, 06 Mar 2015 03:29:55 -0800 (PST)
Received: by 10.182.132.45 with HTTP; Fri, 6 Mar 2015 03:29:55 -0800 (PST)
In-Reply-To: <1424744104-14151-1-git-send-email-abrestic@chromium.org>
References: <1424744104-14151-1-git-send-email-abrestic@chromium.org>
Date:   Fri, 6 Mar 2015 12:29:55 +0100
Message-ID: <CACRpkdbCOHNPs5Y58h--X6pOVvYyxTrgcFhFyk5dWE+JLo=rhg@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: Support for IMG Pistachio
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
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46228
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

On Tue, Feb 24, 2015 at 3:15 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:

>  I'd like this to go through the MIPS tree with
> Linus'/Alex's ACKs if possible.

Why? It will only help creating merge conflicts.
There seem to be no compile-related dependencies, just Kconfig
symbols, so patches using this can go in orthogonally.

Yours,
Linus Walleij
