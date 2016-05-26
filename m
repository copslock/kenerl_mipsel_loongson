Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2016 10:37:30 +0200 (CEST)
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36045 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27034297AbcEZIh0u9Mck (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 May 2016 10:37:26 +0200
Received: by mail-oi0-f43.google.com with SMTP id j1so113649686oih.3
        for <linux-mips@linux-mips.org>; Thu, 26 May 2016 01:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=II2bnpFXva4v/QAZ2J5OiM0SVJwG7JSKrbPtTmVxctE=;
        b=J1qwXDJvfCdGxgd7WfDIXxRQ4zg3cNTBhVMSNH6b5XiVQYb8ouX3XoszKOjBsQLAv6
         jFLaBMFdzTsYZ3PKZe7Um51YRy7azh33BIw/A5Ari2i+K9ChOCJoWxIeuYm4AaWK2Cs3
         mSPm0W6qX+8/+M5pSaYJVSo2KnjenLea6Mlbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=II2bnpFXva4v/QAZ2J5OiM0SVJwG7JSKrbPtTmVxctE=;
        b=YjhknRjuC6HWEFOsRvemetGEmnnfWb+QNirhKTYDel+uCOWTmIEdVTeZdQo0pNOepI
         hlIGI8jh0qJ2xsEllBWDxG6dxycKzzR9J8ncxru98FV5zWgtBbvHCJ63SoJyB2XlkQ66
         G9oXMKOSSH+Q5HUWLzm5cl9c6N65zcB1hNFswInDP/mf9rbxOT/PSezx9APJ58mgtCL6
         SSAJBTEklfKEG1DodmMvHH/vo/nvkodZpsWo6QCOZbMH/BEL1ljI0f/D5W0D9NHF/4pE
         TAIhFwLjpIZIQf0vYr1iwNshWU/VpkQNq9qSyeXw2Xk5uXFfL3Gun6v3LBTgDMY40Tce
         4EuA==
X-Gm-Message-State: ALyK8tJlckze8set9Eu7KSCd0xat9RynuBHinKE3kaV0YiKMHc22SgqcZoex7b+16JnlZi2yRc5TyAnmC4a8cfEn
MIME-Version: 1.0
X-Received: by 10.157.44.72 with SMTP id f66mr5368392otb.126.1464251840675;
 Thu, 26 May 2016 01:37:20 -0700 (PDT)
Received: by 10.182.176.104 with HTTP; Thu, 26 May 2016 01:37:20 -0700 (PDT)
In-Reply-To: <1463461560-9629-7-git-send-email-purna.mandal@microchip.com>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
        <1463461560-9629-7-git-send-email-purna.mandal@microchip.com>
Date:   Thu, 26 May 2016 10:37:20 +0200
Message-ID: <CACRpkdZPHd2G+LRu5WJBDOu2rjWBqprqYYbfTnOQhXpkT3g=dQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] dt/bindings: Correct clk binding example for PIC32 pinctrl
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Purna Chandra Mandal <purna.mandal@microchip.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53659
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

On Tue, May 17, 2016 at 7:05 AM, Purna Chandra Mandal
<purna.mandal@microchip.com> wrote:

> Update binding example based on new clock binding scheme.
> [1] Documentation/devicetree/bindings/clock/microchip,pic32.txt
>
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>

Patch applied to the pinctrl tree with Rob's ACK.

Yours,
Linus Walleij
