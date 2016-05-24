Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 17:15:19 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36515 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033532AbcEXPPRpJuCw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 17:15:17 +0200
Received: by mail-pa0-f68.google.com with SMTP id fg1so2377097pad.3
        for <linux-mips@linux-mips.org>; Tue, 24 May 2016 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5opGiEu2F62uoXpvn+zLXwdGjbmclZPq+AP2iLY4IA=;
        b=R0K5iXD/E6RyznPJY3g6N+uHFVd1o+x3+6aYiiDxNcSiAW3ywEB1vEc6zTBuV0c2I2
         S7Yv29e23h78ZAAzV6d56qHlTWWYqqRcrrIhSEBW9jB+FIFXSpjKg0UX/RjDM1W29hGa
         oR1COSbdvyfomwkbDsSlPolm0eRe0dhAZmglPPOkluj6mDgilIPN24hoVSBO77GkSpmU
         xQy0XpP0QryTITnRhGm1xYJs0B1ijoypLsk/Q/C9YMmCiSAoVoYQBrgjtasrxBzby9LO
         ma+SQMvaiT2fNU9hOfKbYQAGU52rflmBKwCk5HxLoxC1Upx7WuxF4WcyTZ9/xjsbD5p/
         deuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5opGiEu2F62uoXpvn+zLXwdGjbmclZPq+AP2iLY4IA=;
        b=UHQjIcC17IV3kK0UdYshj/gS3hRNjbLGTC7CFmc2G+tMmPQ8fsd/z9eKTyidmHC5Hw
         RF599Gpa5pKl6b51ZwPWjbHT3lvLH5JmzZPqLwaQY3GDirkieTK2gFbtXjKc4B9aTmKK
         RNEhBg+WGPlwsDLFoPnAwdsagFi8TJI8AKhUXjSoLkuzldOu12mKe9NplfL+vt7eKmQU
         3psokISZGETT/M2rgK+yTajDa368ZPHv2mlJaAqP9yLvnet1TAoeejnnfUnYuD2k4F0x
         QKQOJgp7ne+sXL6Bj+f4pkbw8ScF2q9h/HQ5RJeVcqQw8Z/1QBfqmSh8dwHvSLLZS5kc
         qgAg==
X-Gm-Message-State: ALyK8tLbKAJuQoLf3VTX4u4PFui6JW9DkiDKzMSI/LMx3g6OKyzmvNq62BvLTnTlvqWuVQ==
X-Received: by 10.66.43.143 with SMTP id w15mr7830655pal.76.1464102911509;
        Tue, 24 May 2016 08:15:11 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:f573:6891:973c:b422? ([2601:645:c200:33:f573:6891:973c:b422])
        by smtp.gmail.com with ESMTPSA id q20sm55132870pfa.90.2016.05.24.08.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 May 2016 08:15:10 -0700 (PDT)
Message-ID: <1464102907.27173.23.camel@chimera>
Subject: Re: [RFC PATCH] Re: Adding support for device tree and command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        Jonas Gorski <jogo@openwrt.org>,
        Mathias Kresin <openwrt@kresin.me>
Date:   Tue, 24 May 2016 08:15:07 -0700
In-Reply-To: <20160524142711.58a6bf90f3adbe18a28973b3@gmail.com>
References: <574372CD.1060201@hauke-m.de> <5743777F.9060801@hauke-m.de>
         <1464041521.5475.18.camel@chimera> <1464067930.27173.7.camel@chimera>
         <20160524142711.58a6bf90f3adbe18a28973b3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Tue, 2016-05-24 at 14:27 +0300, Antony Pavlov wrote:
> We have too many 0xd00dfeed.
> Can we introduce some macro aliases, like
> arch/arm/kernel/head-common.S does?
> Something like this
> 
> #define OF_DT_MAGIC 0xd00dfeed

And exactly where would you propose to put that? Having the same #define
in multiple places is no better than just using the value…
