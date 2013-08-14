Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Aug 2013 21:40:36 +0200 (CEST)
Received: from mail-oa0-f53.google.com ([209.85.219.53]:58733 "EHLO
        mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827311Ab3HNTkcRs5wk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Aug 2013 21:40:32 +0200
Received: by mail-oa0-f53.google.com with SMTP id k18so13844436oag.12
        for <linux-mips@linux-mips.org>; Wed, 14 Aug 2013 12:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FAdavmvmMfP3xoPVlCV/FK++q7Ev4oSmnTCjRFdATAA=;
        b=ZyiA6Xix4hX9y1vZLh0xDEHyWdS52ko9WlqCIW1FM/2Uwaevwne+FzkH+il3hKb94v
         2Tx9UF38rErFajEvTBfk864pzUdevDFCVPhar5QhCcgrZfnBcfOFi99CuUKaQtSNTnpi
         rn1wyAi/xPf6lbUayXzqCQRcN3wHwIRkprMGO2dx116djssJ3emfvZ/47Qh/A374RDfu
         Vjyu3GOG254sGxRXHLa1IL7DgI9LUF0abeHEJBBdkDN8sjAQZ8ypT1wKZQSXe2qdEDVn
         GQHseCm1f5gyqQ9HqZCL93XnejfCYA9/pAQpMXpoucZc2ZRc+iEIgFdH+RccaBB2pagP
         Vuew==
X-Gm-Message-State: ALoCoQnoo8VZ7CGeO47No24BlPc2Zt7tAU+IpstAuqH0ZTGOyaVjq5Dl7YNkSV9owOB1oRxWGXTt
MIME-Version: 1.0
X-Received: by 10.60.44.240 with SMTP id h16mr10813426oem.2.1376509226205;
 Wed, 14 Aug 2013 12:40:26 -0700 (PDT)
Received: by 10.182.120.7 with HTTP; Wed, 14 Aug 2013 12:40:26 -0700 (PDT)
In-Reply-To: <1376073495-28730-1-git-send-email-blogic@openwrt.org>
References: <1376073495-28730-1-git-send-email-blogic@openwrt.org>
Date:   Wed, 14 Aug 2013 21:40:26 +0200
Message-ID: <CACRpkdYAG=qc-iOYWpFF+_Jk5fQwo2prex63vqGOiguEVg5PNA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] pinctrl/lantiq: add missing pin definition to
 falcon pinctrl driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37548
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

On Fri, Aug 9, 2013 at 8:38 PM, John Crispin <blogic@openwrt.org> wrote:

> From: Thomas Langer <thomas.langer@lantiq.com>
>
> The pps pin definition is missing in the current code.
>
> Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
> Acked-by: John Crispin <blogic@openwrt.org>
> ---
> Sorry i just noticed that i sent the 2 wrong files yesterday

OK applied this instead then.

Yours,
Linus Walleij
