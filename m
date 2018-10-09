Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2018 08:36:52 +0200 (CEST)
Received: from mail-wr1-x441.google.com ([IPv6:2a00:1450:4864:20::441]:41191
        "EHLO mail-wr1-x441.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992363AbeJIGgsoMjN7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Oct 2018 08:36:48 +0200
Received: by mail-wr1-x441.google.com with SMTP id x12-v6so445132wru.8
        for <linux-mips@linux-mips.org>; Mon, 08 Oct 2018 23:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f1LE+fuCOHL7G05Gu6dofBOQSogK/95XhyKefcWmaQE=;
        b=S9ekYKVYBqkNHnV9uSe6leKpkrnidTgKHiwypc89ea30D6CJ1GaLdZjQHhK9xnPBWS
         4HFPSE7rsosTaa1hEPsfFEmn9pYbpravqBXw8UZXM+966BUUtbHU3qxrw+Qaz4uG5VTL
         Xmc4YF0JYAJx1yu0QwSD23OyyBsyIqPmJXR8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f1LE+fuCOHL7G05Gu6dofBOQSogK/95XhyKefcWmaQE=;
        b=Bz0EX+t5Jgbfdp2pmdMsR2IcUMcxoL7/6ND6GF0gCjwE0qYpu9D5msvgavgfJ6sfdM
         5GgeZ2mqJmPrSd80X5ZuCxD+neNlGeEdlcq9GjDuF8nrf8I3wx9yyU74cOgn9sQfx3tv
         qlEkelJDE0KWz0djFbSubfdHSGeoJR+Cd2Z9EJWDLk3O5v8/AnBrgxAVB5yzNjstDo9R
         u8q6wtzN50TZzpqKZpekjiSab/A93ct6T2xASGz+A5/fFAcy5nYEVk6RGxXPMSuSgAYI
         vqWh9fUdvgVAwvO74DzpQIyL48+XW601wHUsBV4ksImLQq4m5Gc45xILuwZKB/aUd9uK
         lzow==
X-Gm-Message-State: ABuFfohRq4HFUFbBY0kbET1fh98kN0Fo27vc9gySrIBNfSfgkPpJ0rXR
        zb7QIjWWDGGQt4tLMFzjgdmTKw==
X-Google-Smtp-Source: ACcGV61IMrL1QQF4r6gLj40Ih2wDHHUO7PqKVSbYEGKfTyNLfUkFuuv6b+GRg75OQUzyNY7Vq5K0VA==
X-Received: by 2002:adf:b64e:: with SMTP id i14-v6mr19715990wre.14.1539067003223;
        Mon, 08 Oct 2018 23:36:43 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id c21-v6sm927144wmh.26.2018.10.08.23.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 23:36:42 -0700 (PDT)
Date:   Mon, 8 Oct 2018 23:36:40 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        robh@kernel.org, linux-mips@linux-mips.org,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU drivers
Message-ID: <20181009063640.GB32033@dell>
References: <5bb4c6ad.1c69fb81.42bb.93ecSMTPIN_ADDED_MISSING@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bb4c6ad.1c69fb81.42bb.93ecSMTPIN_ADDED_MISSING@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <lee.jones@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lee.jones@linaro.org
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

On Wed, 03 Oct 2018, Paul Cercueil wrote:
> Le 3 oct. 2018 3:02 PM, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit :
> > On 03/10/2018 14:51, Paul Cercueil wrote: 
> > > 
> > > Le 3 oct. 2018 2:47 PM, Daniel Lezcano <daniel.lezcano@linaro.org> a 
> > > écrit : 
> > >> 
> > >> On 03/10/2018 12:32, Paul Cercueil wrote: 
> > >>> 
> > >>> Le 1 oct. 2018 10:48, Daniel Lezcano <daniel.lezcano@linaro.org> 
> > >>> a écrit : 
> > >>>> 
> > >>>> On 31/07/2018 00:01, Paul Cercueil wrote: 
> > >>>> 
> > >>>> [ ... ] 

Paul,

I think there is something wrong with your mailer since your replies
are being scattered across my inbox un-threaded, making conversations
very difficult to follow.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
