Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 16:27:00 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38752 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012029AbbDUO06X2fRY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2015 16:26:58 +0200
Received: by wiun10 with SMTP id n10so23622346wiu.1;
        Tue, 21 Apr 2015 07:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/jB2UTCvzTw1PiE00u72wh4AkVczILxSk8eNcQ82C9A=;
        b=SzlvLl/zM17+bK0yPmd4bcL0/qWd8WGS4HR7ZgAIfuads2Qu5rZ8ZUeR9Nm9VkJR06
         WxXvrT/1WosKVIucqSzlzzrImVispbPXjZ8+IJqJ/um39WJCYpGZ5TFG8p2nq6A0qGiH
         81EZyOZKduLLcRWaQsNat/WyJzOf74XGAtQAxx84Mf9OoIHuIoRI87TShghtBhdjyl4o
         KIdsYK5Lfreg+TQwlT63S537nm8FPBRyzU+NIgSb3hEAK185i7N8PJ8NBZHJN/N/mgVO
         2seeT3QlfmbTmOOQZGRiXctGIYWAS5NN/vo8SgRXK/b19Dg5SmUSP8+vx3BM8yb927IW
         XA+Q==
X-Received: by 10.194.133.133 with SMTP id pc5mr40477077wjb.31.1429626414768;
 Tue, 21 Apr 2015 07:26:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.139.195 with HTTP; Tue, 21 Apr 2015 07:26:34 -0700 (PDT)
In-Reply-To: <1429373607-9226-2-git-send-email-albeu@free.fr>
References: <1429280669-2986-1-git-send-email-albeu@free.fr>
 <1429373607-9226-1-git-send-email-albeu@free.fr> <1429373607-9226-2-git-send-email-albeu@free.fr>
From:   Rob Herring <robherring2@gmail.com>
Date:   Tue, 21 Apr 2015 09:26:34 -0500
Message-ID: <CAL_JsqJJnkMH7Tk6TxvtESEJisCeUVxcSPc7d8W-_AnLvZYfuw@mail.gmail.com>
Subject: Re: [PATCH 13/14] of: Add vendor prefix for TP-Link Technologies Co. Ltd
To:     Alban Bedel <albeu@free.fr>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46956
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

On Sat, Apr 18, 2015 at 11:13 AM, Alban Bedel <albeu@free.fr> wrote:
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index b13aa55..9e965b6 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -185,6 +185,7 @@ tbs TBS Technologies
>  thine  THine Electronics, Inc.
>  ti     Texas Instruments
>  tlm    Trusted Logic Mobility
> +tplink TP-LINK Technologies Co., Ltd.

Alphabetical order please.

Rob

>  toradex        Toradex AG
>  toshiba        Toshiba Corporation
>  toumaz Toumaz
> --
> 2.0.0
>
