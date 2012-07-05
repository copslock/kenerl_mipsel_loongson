Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2012 15:03:00 +0200 (CEST)
Received: from mail-qc0-f177.google.com ([209.85.216.177]:65235 "EHLO
        mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903749Ab2GENCy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2012 15:02:54 +0200
Received: by qcsu28 with SMTP id u28so4892310qcs.36
        for <linux-mips@linux-mips.org>; Thu, 05 Jul 2012 06:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=/qYkC7e4rYfHVxaB+eaVms3QGaOzRsDJgknvOpVz1oQ=;
        b=lbrKOASYnFw4a8tLYt/RFG6v/FNqTWwIdc0cyhe3cYZJHuW/aXDJCXd9vAJ/u3gWxF
         BfLcUaCOJpHv52l2yUaanMMTHDFkMwWb5iMeAFHcNE9/btRSximlRSIgTSB8vZLm1eMu
         vPLigeGuVN5estU+sjEnh1C3QSX0FZ/0CDw7lGMhhv6xIWYx1m9DZ0K9nFOj/A43meWp
         h5+d+Wb7XW+sd8DHxW5jzix69nQEGjnXpB051i8XR2fraa77gQTiG4gq3vabVHwmqOw1
         u2d57ckAyUUlcKJMho4prDlCovy9Pp4EoH3dI7vE0+CHZXxoP0GQOqvb0KJFSnIrJ/zA
         NZZA==
MIME-Version: 1.0
Received: by 10.229.115.12 with SMTP id g12mr12847685qcq.58.1341493368305;
 Thu, 05 Jul 2012 06:02:48 -0700 (PDT)
Received: by 10.229.234.81 with HTTP; Thu, 5 Jul 2012 06:02:48 -0700 (PDT)
In-Reply-To: <1340011706-32281-1-git-send-email-stigge@antcom.de>
References: <1340011706-32281-1-git-send-email-stigge@antcom.de>
Date:   Thu, 5 Jul 2012 15:02:48 +0200
Message-ID: <CACRpkdbrfrJzri7DOhzWf1n8UGGByw74ALsPQV1npgZNRtF08A@mail.gmail.com>
Subject: Re: [PATCH] mips: pci-lantiq: Fix check for valid gpio
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Roland Stigge <stigge@antcom.de>
Cc:     ralf@linux-mips.org, blogic@openwrt.org, jkosina@suse.cz,
        standby24x7@gmail.com, bhelgaas@google.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        grant.likely@secretlab.ca, linus.walleij@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQkYSOUb6Zsliupfl21hw9R+wN/s0kRhV8zobhMc3Q6IZcgTyr22RltbsIbcZxIg56xqrsAa
X-archive-position: 33876
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Jun 18, 2012 at 11:28 AM, Roland Stigge <stigge@antcom.de> wrote:

> This patch fixes two checks for valid gpio number, formerly (wrongly)
> considering zero as invalid, now using gpio_is_valid().
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Applied.

Thanks,
Linus Walleij
