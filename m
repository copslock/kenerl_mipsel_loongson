Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 21:42:20 +0200 (CEST)
Received: from mail-wr1-x442.google.com ([IPv6:2a00:1450:4864:20::442]:44810
        "EHLO mail-wr1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeJMTmMtaL1w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 21:42:12 +0200
Received: by mail-wr1-x442.google.com with SMTP id 63-v6so16824186wra.11;
        Sat, 13 Oct 2018 12:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ENsa8mKA+KYkiEx8WLYfD1y5jJU/TfSdYYuBy4wsARY=;
        b=MfEqni4r7gugGbRVeFZc/OiTvtv96qeAh4+PCJqG0vDxOZ+QVNgmyq3KvIxBtrfb0s
         ckcfJJyAJUK+NzxITaqCII+ohHnuGNSSBprb0axyBcV1sqCDqQbTrKsRaZoJLPfJYrcs
         7LJt53TAX/4p4fgWzQak3awH50Meh8vQ5U6792qHISQZYwgFWGlCcXjGyj/GEMGSHYRZ
         +7YJQcAjuQ7nFr3SVte+QPHrq4JBZEBVeUma0olj8nA2PYX0KH06RGOwXphzeBGW8io0
         A9jAqqu+BEqitG6uA17NM4+/9iFWAFxAquILG1pHN77uzFAs7sKAikadc0PgceRU1FUL
         hOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ENsa8mKA+KYkiEx8WLYfD1y5jJU/TfSdYYuBy4wsARY=;
        b=PBg2qSRp1vbzP9pgEA8gBTUdO9xrTOPAujkPnb8S0cHuG0kmisoH4hLVievtxwzptA
         e9gNAemOsqAjUFrYf8W4StpV9x/6LfLkJOPya+k0H5iAWrWhBE9SNdoN4OC7BeHiptEp
         TGVrRn27XQZYFxsKZPrfdJ/pffzAJuDZiOC0e4lluQ2orb2T27HyBgztWyXfILm6q+ho
         gzhB1qF7bFy5d8dH85fMsIyH+tBJnK8MkssMCxWWRkmgRIBXepqqF3Qs41as3pK0P/Z/
         JKFndZxyLLJ5bkKcWr7XmiBYyKKxcBUtT5OmD0qlsQL+5fbruSmcGMY7BTVZIJkbW5GK
         IPhA==
X-Gm-Message-State: ABuFfojQoDb2g8S6WngZN6eGV7iBR8TlemHZ3fIfwD4d8h+Hrqxx242s
        HKtIOzkx+HwhVrykBgfGQHw=
X-Google-Smtp-Source: ACcGV634FjblERVVJ6u7MGTI2CnjquLzD+eRer3J/7Pdf6zgNuNqHJwiF/g3rAfNzrDjxMTjOWzy5g==
X-Received: by 2002:adf:8141:: with SMTP id 59-v6mr8715867wrm.127.1539459727435;
        Sat, 13 Oct 2018 12:42:07 -0700 (PDT)
Received: from laptop ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id s1-v6sm4229601wrw.35.2018.10.13.12.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 12:42:06 -0700 (PDT)
Message-ID: <a6e3c6c059a4a593d7c9228ed260ea24f993a3f6.camel@gmail.com>
Subject: Re: [RFC v2 2/7] dt-binding: interrupt-controller: Document RTL8186
 SoC DT bindings
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 13 Oct 2018 22:42:04 +0300
In-Reply-To: <20181012201346.GA17471@bogus>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
         <20181001102952.7913-3-yasha.che3@gmail.com> <20181012201346.GA17471@bogus>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

On Fri, 2018-10-12 at 15:13 -0500, Rob Herring wrote:
> On Mon, Oct 01, 2018 at 01:29:47PM +0300, Yasha Cherikovsky wrote:
> > This patch adds device tree binding doc for the
> > Realtek RTL8186 SoC interrupt controller.
> > 
> > Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-mips@linux-mips.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  .../interrupt-controller/realtek,rtl8186-intc  | 18 ++++++++++++++++++
> 
> .txt
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, will fix for v3.
