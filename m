Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Sep 2016 15:36:04 +0200 (CEST)
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38581 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbcIPNf6N9rWn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Sep 2016 15:35:58 +0200
Received: by mail-wm0-f49.google.com with SMTP id 1so42181063wmz.1
        for <linux-mips@linux-mips.org>; Fri, 16 Sep 2016 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHxJXKmhwNmSL/K+/r7PMaEQwpSFrpUjGft8jztfkhY=;
        b=LeDk/KqH5ls1Z5Fe0GYVe1Wxm0OltzZ6o+gzCFcyN7atQ751wzbjCnU7XPrqRzijn9
         ODEYYXW4NSCfzNDBrYEghLXH8mYxBv1+oVINQMQ1wODYLL+C71uFtunHibLylubp3bMZ
         T9V5jIvJQCH3QztwpmSDMCyXV9WM12OugCAgd9oiaw+THCDPTNeBjOw//28lWPRoeAqg
         p8tsAgKDLepfsNmf5soEBtmGJXcQm+EDK1TTTisLdkLy2+TY1wNBSuVFUI/NOKpyiIVc
         rzgE2G/V29yT7RExs8Q4zV9hfDcqbu4Ci3mhd6dHzWxA72s6fQ7J6PFLt5uhybE9fuXU
         8mRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHxJXKmhwNmSL/K+/r7PMaEQwpSFrpUjGft8jztfkhY=;
        b=K7pZiOqOdLJ1uqnqcYiHHhp9kXkY3GpxTxSKs576bGDQX7IkrfrniStxpT6R0IfmEP
         /68q7MT6JrB67T7oCxfeEonkIy4bW7D7urfK6+CbP/iv9BZB/yCtG04r2jmXIdYS+1N5
         TPWtWi4a2Iz97dzeOvE+C0aI/a2Sn0YfbitVv3WkPWI9NlNUSwA+SoDcOtx4pIqung64
         WfajHCZ26K4AhyzqM5QqoNup92JRgLV2Vud2H1SUl0UTBkYT8MCkDzPBYVMcN6DaZnoP
         kI6XB3J2vp5ec1iZVK1UCrmu2g9Jhl7vrchi6MbLofE7sYTKpe1mitwlJIx9IEaAuLY5
         rv6w==
X-Gm-Message-State: AE9vXwMSAOFu8NdrFg0UOOQbJIM7aQE52Tie6LMDQ+fWl9EbGn7lMF2S0U4ed/dYjXTuow==
X-Received: by 10.28.101.214 with SMTP id z205mr5661566wmb.123.1474032952672;
        Fri, 16 Sep 2016 06:35:52 -0700 (PDT)
Received: from [192.168.1.82] (ARouen-653-1-214-191.w90-22.abo.wanadoo.fr. [90.22.23.191])
        by smtp.gmail.com with ESMTPSA id 193sm7441774wmo.14.2016.09.16.06.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Sep 2016 06:35:52 -0700 (PDT)
Message-ID: <1474032950.9425.12.camel@gmail.com>
Subject: Re: genirq: Setting trigger mode 0 for irq 11 failed
 (txx9_irq_set_type+0x0/0xb8)
From:   Alban Browaeys <alban.browaeys@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Krzysztof Kozlowski <k.kozlowski.k@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Hunter <jonathanh@nvidia.com>
Date:   Fri, 16 Sep 2016 15:35:50 +0200
In-Reply-To: <57DBEBC8.7000209@arm.com>
References: <CAMuHMdVW1eTn20=EtYcJ8hkVwohaSuH_yQXrY2MGBEvZ8fpFOg@mail.gmail.com>
         <1473980577.17787.21.camel@gmail.com> <57DBA464.9010506@arm.com>
         <1474023805.17258.10.camel@gmail.com> <57DBEBC8.7000209@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <alban.browaeys@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alban.browaeys@gmail.com
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

Le vendredi 16 septembre 2016 à 13:55 +0100, Marc Zyngier a écrit :
> At that stage, I'm not sure I should care. Does the workaround make
> your
> platform usable?

However awkward this was all about logs and clearing worries. There was
no change in behavior  between the three cases : upstream, upstream
commit reverted and patched upstream.

Mind this hardware (the Odroid U2) has no hardware buttons. Only power
on plug.

Best regards,
Alban
