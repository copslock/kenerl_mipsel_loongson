Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2014 16:23:35 +0200 (CEST)
Received: from mail-la0-f52.google.com ([209.85.215.52]:42344 "EHLO
        mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009415AbaIVOXc1ysPk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Sep 2014 16:23:32 +0200
Received: by mail-la0-f52.google.com with SMTP id gq15so6724302lab.25
        for <multiple recipients>; Mon, 22 Sep 2014 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Hq0JmXAZLGqf3MXCzmW/rSuimVsspT9nu3NPkyJNFYU=;
        b=HgvMGAL6RIVvyF42I2C7BTTA5tAgdC987r7S3eMrMKEYaeNXX7Ju1YS5zTVIjZr+uh
         e/cpSKynu9j3g4TPMrUkOJFje6Nn2yNNM/FIzJgzWxCSEMYBzP9j/gkLY1VsPb6y59RG
         vv+wL1bXM9EP0+KVNPsw1nf8eejA3TkILY+YaPil+ACSGuJVLzWQf1YSnqB71elG5X8K
         KU/s+/hd1mtXY6oItC6vivGDMfTJVC6IbsXMpKQ4ID3hiNuu34OVK3VRQD+dSHncXQCb
         LSvzkX39yAoCYozbhf46GLNF14GVAxVcrku66/5AFRmplosmKXT4MPGTa8rZKB2kf09n
         gwcg==
X-Received: by 10.112.184.161 with SMTP id ev1mr3041906lbc.82.1411395806894;
 Mon, 22 Sep 2014 07:23:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.11.233 with HTTP; Mon, 22 Sep 2014 07:23:06 -0700 (PDT)
In-Reply-To: <1409938218-9026-11-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org> <1409938218-9026-11-git-send-email-abrestic@chromium.org>
From:   Rob Herring <robherring2@gmail.com>
Date:   Mon, 22 Sep 2014 09:23:06 -0500
Message-ID: <CAL_JsqKGG3ei9=Od74VSL9Sm_=+vsW4U+WBgXmCEtK3iTDfJ0g@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] of: Add vendor prefix for MIPS Technologies, Inc.
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On Fri, Sep 5, 2014 at 12:30 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> Add the vendor prefix "mti" for MIPS Technologies, Inc.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
> New for v2.
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ac7269f..efa5a5b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -86,6 +86,7 @@ microchip     Microchip Technology Inc.
>  mosaixtech     Mosaix Technologies, Inc.
>  moxa   Moxa
>  mpl    MPL AG
> +mti    MIPS Technologies, Inc.

Why not mips as that is more common and the stock ticker.

Rob
