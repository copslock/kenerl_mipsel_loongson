Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2015 02:31:27 +0200 (CEST)
Received: from mail-yh0-f46.google.com ([209.85.213.46]:36706 "EHLO
        mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007721AbbEaAb0FJ-z4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2015 02:31:26 +0200
Received: by yhan67 with SMTP id n67so5015865yha.3;
        Sat, 30 May 2015 17:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QU03r+TgBA+uKXSA958qtx2GXgjpS9Xg2LnZo6AKWss=;
        b=pUcIfV8WQ050iLZg7FsmPPd4ACrOu7f9F+v1Z01f4u8UTSugzQL/nMfss6Q1ZdPW8E
         nPTv/EraD0zwtJvjtta3UZQin4gxkl7pJfiP8Wku5NvPOuaMaBGgAcV1s2BtEEPaIGlE
         uSrRrzC2oTQ9M8CrkNe0bzHzwH20TmBYdRi0K7m/SnLthK06zZKBC7dH0RHnYnuGHrZT
         Cpjs+DoGor1xCjGajtYPs4f0A3ZJ/R09cRVHyZPWIKspjpKg8kd/ItibJWAA4TZpMJiH
         15TtcGHqofVfkx/kccbeEJEQT+4SdTxCX2sp5rfToTpdPqTHdt3idWXwuiZEj978R6PE
         g2VA==
X-Received: by 10.236.36.4 with SMTP id v4mr15665739yha.168.1433032280161;
 Sat, 30 May 2015 17:31:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.210.193 with HTTP; Sat, 30 May 2015 17:30:59 -0700 (PDT)
In-Reply-To: <1433029955-7346-6-git-send-email-albeu@free.fr>
References: <1433029955-7346-1-git-send-email-albeu@free.fr> <1433029955-7346-6-git-send-email-albeu@free.fr>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Sun, 31 May 2015 03:30:59 +0300
Message-ID: <CAHNKnsT2etbFJzqavbeRSMmx5w+xtGKri27erm87-WeTo=N8xQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] devicetree: Add bindings for the ATH79 MISC
 interrupt controllers
To:     Alban Bedel <albeu@free.fr>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
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
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2015-05-31 2:52 GMT+03:00 Alban Bedel <albeu@free.fr>:
> +
> +Example:
> +
> +       interrupt-controller@18060010 {
> +               compatible = "qca,ar9132-misc-intc", qca,ar7100-misc-intc";

Sorry for meticulousness, but seems you missed a quote :)

-- 
Sergey
