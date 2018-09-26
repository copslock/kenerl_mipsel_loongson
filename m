Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2018 00:31:54 +0200 (CEST)
Received: from mail-wm1-x341.google.com ([IPv6:2a00:1450:4864:20::341]:33230
        "EHLO mail-wm1-x341.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993094AbeIZWbvB0Ewm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Sep 2018 00:31:51 +0200
Received: by mail-wm1-x341.google.com with SMTP id r1-v6so16110598wmh.0;
        Wed, 26 Sep 2018 15:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=csnNe32Mb1sBYL5xyHWNBq5X2DM3melVl9dy6kewzWI=;
        b=seCVIswUu8l5TNC0xeV0c20Z9kVszFD3eqe/vL2fvCML32ygrEHezfq3oXIeSVvtRw
         iwSF01Gd3D3rffO4RNFcTUUat0rN2Bbjov3tam2YH/tJXe0clGFj8mj5NmSHlwsopmJt
         wKGSGCtvq3KwVLFUX4p5K0RdOWHyLhhOvUJBp3lj7WfD0r0nhWlYRCxIgeuB/WBf3Rl4
         Q/QixX8csqcqF+6sh01LS8qyBizsBNiYL0WaGfG8eR3G7LTc0CqEH3rcWGk9lPQVZ20q
         nrKxYLGmWylKHrUL0zcY0zraBndmDjnTJxgVVWhNP2WNB8TQCr+SaZlyP2HebwKBagwd
         dN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=csnNe32Mb1sBYL5xyHWNBq5X2DM3melVl9dy6kewzWI=;
        b=jP1W+MSKThg/oBQaRiQvEoqxkAj2kSl0yqRFvRzTZV594WhpXf7Ry/3ZKwLEM81Lfp
         4BybTeix90t4Ppxj24RHM0GtN0KUsYjNQg4VG0tfwqE0QtTnezwWoTHR6YizgO+cijZn
         FengQicOjSvWKP9YWMzSfby2l2ErV7RLenpylNQUfoeu4JfX+V+m2C+xNREY2A+g89VT
         QzV0TMpUh+rfP+l88kJNsOCO1diyCnpNuByM1CT+6ipImwPHZxEBTUzP2BOLzKxP5Xmd
         zsM0L0SX06DKGcfBChwknAfVJeex816/QxKA6p+7D/pIfBKpsywKYOIm9af8L1sRDEGZ
         ML3w==
X-Gm-Message-State: ABuFfojUSyFeJME9vfX1/T5+N9aVE3j6Fy6g/lqXYULFyTixv4QfrrUY
        GT4MXcJqsY8KtObaGmp6Ebg=
X-Google-Smtp-Source: ACcGV608dCXvjSKw/NQqzefaG8Y58JhSskYKJpEesem0rD+vXdZIsM7NGHk3dh1uY35OVvgz+KXhhg==
X-Received: by 2002:a1c:448a:: with SMTP id r132-v6mr6040253wma.132.1538001105699;
        Wed, 26 Sep 2018 15:31:45 -0700 (PDT)
Received: from laptop ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id b138-v6sm558595wmb.1.2018.09.26.15.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:31:45 -0700 (PDT)
Message-ID: <7dfadae9a7896db71fabc71bc7c489791be27baa.camel@gmail.com>
Subject: Re: [PATCH v2 1/1] MIPS: Add Kconfig variable for CPUs with
 unaligned load/store instructions
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 27 Sep 2018 01:31:42 +0300
In-Reply-To: <20180926221815.jfh7uv52oyry2gmq@pburton-laptop>
References: <20180926111615.6780-1-yasha.che3@gmail.com>
         <20180926111615.6780-2-yasha.che3@gmail.com>
         <20180926221815.jfh7uv52oyry2gmq@pburton-laptop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66592
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

Hi Paul,

On Wed, 2018-09-26 at 22:18 +0000, Paul Burton wrote:
> Hi Yasha,
> 
> On Wed, Sep 26, 2018 at 02:16:15PM +0300, Yasha Cherikovsky wrote:
> > MIPSR6 CPUs do not support unaligned load/store instructions
> > (LWL, LWR, SWL, SWR and LDL, LDR, SDL, SDR for 64bit).
> > 
> > Currently the MIPS tree has some special cases to avoid these
> > instructions, and the code is testing for !CONFIG_CPU_MIPSR6.
> > 
> > This patch declares a new Kconfig variable:
> > CONFIG_CPU_HAS_LOAD_STORE_LR.
> > This variable indicates that the CPU supports these instructions.
> > 
> > Then, the patch does the following:
> > - Carefully selects this option on all CPUs except MIPSR6.
> > - Switches all the special cases to test for the new variable,
> >   and inverts the logic:
> >     '#ifndef CONFIG_CPU_MIPSR6' turns into
> >     '#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR'
> >     and vice-versa.
> > 
> > Also, when this variable is NOT selected (e.g. MIPSR6),
> > CONFIG_GENERIC_CSUM will default to 'y', to compile generic
> > C checksum code (instead of special assembly code that uses the
> > unsupported instructions).
> > 
> > This commit should not affect any existing CPU, and is required
> > for future Lexra CPU support, that misses these instructions too.
> > 
> > Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  arch/mips/Kconfig            | 35 +++++++++++++++++++++++++--
> >  arch/mips/kernel/unaligned.c | 47 ++++++++++++++++++------------------
> >  arch/mips/lib/memcpy.S       | 10 ++++----
> >  arch/mips/lib/memset.S       | 12 ++++-----
> >  4 files changed, 67 insertions(+), 37 deletions(-)
> 
> Thanks - applied to mips-next for 4.20.
> 
> Paul

Thanks!

Yasha
