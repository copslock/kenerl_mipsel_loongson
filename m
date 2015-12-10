Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2015 17:24:04 +0100 (CET)
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35261 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013634AbbLJQYC0n9pm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Dec 2015 17:24:02 +0100
Received: by oige206 with SMTP id e206so49165871oig.2
        for <linux-mips@linux-mips.org>; Thu, 10 Dec 2015 08:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=27rbor6tP9E9yXg0YFnnjndZWXCJ0wmpUHs59EjQfUg=;
        b=Dx1IdupQRFjTdzzy6ZratKd3wDgNm9c07GRva75jcHC0PT724lxES1i42gcSWjlcaZ
         hljtKsIjQw2Xb3MG3wf6wzsxOtAeYDjqDbMk8TpiFUkxnKsQSC6JfrEKhfywhLjA0v88
         eQZtZHlmtxC/LTd5mScWuCA5OBbZRmJcX/s3Crly8gcdXEoRpGJ4aZJlSjuE/0bS4ei4
         DKaxJfHhnE+8JJ9JaitPY/lZQEFkNSCVpkxCYOMXK5hKMotlMAzApH/ONsu6LYYFf3bg
         /akYlRaiaHLcOddScVn2qungNMZ/qHsNj/SLCnaHTprCPi+cWeDUteMfNizZbfiFVeg6
         ywfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=27rbor6tP9E9yXg0YFnnjndZWXCJ0wmpUHs59EjQfUg=;
        b=Xzkeia2RJd0fJZ1NpngAPhDUtdwP+RhMEkWV0vtifQ6DAWmT+rwrGV3CHSRdfpWMuV
         pAq8mRBctV5zQo6BGFCOfUaN8cZ+a5WHW+14wO3UmpUgzy13eV5YBKjPB/kcPeDhy0jZ
         JvIPpeljQQi2XivnGMwMZdwXFBNNIat7ovRx1vV9IyHi0MFw3lALJVn5VuvLWgu3KziX
         xe3trUFHcUo8uN5NkmCtRBEF6EK3NBhPi84Fp/2ZGFjBbeD6CsQ2m6xPzx6UcSySQfbW
         wsZQ0AUr+ibwBwM5qwbB1G9K2bLrwSOOjdK/A9/rmVBgA7iy9exNr5EM345lSqNFUQ85
         pfog==
X-Gm-Message-State: ALoCoQkKV2Bl+NmSTnNZD5ChsMo1YtWPcSdnb2waeGkwc550eX3z7f6GnN2U9QFEzr7X4jvcCaNE4cq6kY/ok9W5Tcdr3ZMW4ouQ8bvT1PyOxSIEbOEOI/Q=
MIME-Version: 1.0
X-Received: by 10.202.51.138 with SMTP id z132mr9641621oiz.39.1449764636489;
 Thu, 10 Dec 2015 08:23:56 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Thu, 10 Dec 2015 08:23:56 -0800 (PST)
In-Reply-To: <1448900513-20856-13-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
        <1448900513-20856-13-git-send-email-paul.burton@imgtec.com>
Date:   Thu, 10 Dec 2015 17:23:56 +0100
Message-ID: <CACRpkdZgYFMgEqd3AZn0Vp14BDiYQuUPzT7eGPB69Qs1m7Bo7w@mail.gmail.com>
Subject: Re: [PATCH 12/28] gpio: pch: allow build on MIPS platforms
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50527
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

On Mon, Nov 30, 2015 at 5:21 PM, Paul Burton <paul.burton@imgtec.com> wrote:

> Allow the pch_gpio driver to be built for MIPS platforms, in preparation
> for use on the MIPS Boston board.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Patch applied to the GPIO tree.

All GPIO patches should go separately to the GPIO tree, especially
this merge window as I'm doing refactorings.

Yours,
Linus Walleij
