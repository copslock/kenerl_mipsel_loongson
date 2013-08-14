Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Aug 2013 21:41:33 +0200 (CEST)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:56019 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6865331Ab3HNTl3eX6af (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Aug 2013 21:41:29 +0200
Received: by mail-ob0-f178.google.com with SMTP id ef5so9408326obb.9
        for <linux-mips@linux-mips.org>; Wed, 14 Aug 2013 12:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vabB7YzlEJXdvxuPSMompnr46SZKTca4Rgd8b87szg0=;
        b=C6eaJD5NDGQEIwo2j6P2FP148bHniVSgZhw1QwbGdylKXbp9DgYGAW2yvL54atgetE
         Q/dBv6OSDgkvr+cBMHn7FBSuLbdWeop5Mps1iXo0JqYLo5koo5gpKGPObK37QSxPqgwh
         pQZ2rU1lZgFPoh8vSvdLXTmAHas+Ks+D6SNu6I109Hj4OaCI7T0q90VrKJL52GhiXCst
         pIW67Hh/Wc0KEfYO47xhgpi6FESOn1fmzuKCvRPIJxITyyd6gwz0Qqzx4qg2z2Z2qgCe
         HG9naJasnkUiOJZASD1LTkpPjDMpkLI5VtS/PcARgwCEREcFkts2QlZAgDOWVMLVMv3o
         1VBw==
X-Gm-Message-State: ALoCoQkT4zt68A8CIkIZH+hgwvVEGgfxUVk3ol0u/IIFDwT4EKbiKFsMOIGoula5j1R8RBKBa1Qf
MIME-Version: 1.0
X-Received: by 10.182.250.163 with SMTP id zd3mr22478957obc.20.1376509283393;
 Wed, 14 Aug 2013 12:41:23 -0700 (PDT)
Received: by 10.182.120.7 with HTTP; Wed, 14 Aug 2013 12:41:23 -0700 (PDT)
In-Reply-To: <1376073495-28730-2-git-send-email-blogic@openwrt.org>
References: <1376073495-28730-1-git-send-email-blogic@openwrt.org>
        <1376073495-28730-2-git-send-email-blogic@openwrt.org>
Date:   Wed, 14 Aug 2013 21:41:23 +0200
Message-ID: <CACRpkdb-+0hq20fVCuh-itgAZ_G4BhEhvJzL2gKKKhDEP7PD3A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] pinctrl/lantiq: add missing gphy led setup
From:   Linus Walleij <linus.walleij@linaro.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37549
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

> We found out how to set the gphy led pinmuxing.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>

Applied this instead.

Yours,
Linus Walleij
