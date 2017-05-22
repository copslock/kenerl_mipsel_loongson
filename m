Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 07:38:19 +0200 (CEST)
Received: from mail-oi0-x229.google.com ([IPv6:2607:f8b0:4003:c06::229]:32887
        "EHLO mail-oi0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990510AbdEVFiKkpVlg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2017 07:38:10 +0200
Received: by mail-oi0-x229.google.com with SMTP id w10so148596058oif.0
        for <linux-mips@linux-mips.org>; Sun, 21 May 2017 22:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=84eA0v7NjkZcVapbph9FV2OZwCgkFtzhcHgHRnZePS8=;
        b=ORoB4PfrAz3SCkYVOoXCwsaDD5l24RFbmbgqSxy6zAd6SFFh6r3PtZTOziVCNxePWH
         lZT42UTpOyJ7PttJ9pbYnO/+54m7XOwtUguCRhQ+cR2Z7hNnL2nZBHtdtkA+MlSrWbyu
         +z+skldJZxi7NtrV00XZEWj8sdmhVzMTfGfluHQFtM79D/LmaLCjwu5ixGV4JuiQuGR7
         twDHSajpsJYv/OJ8J0ZBgrJ3zlMdXIQ6uAAnbfx2HKg7gZupGuDm+p70wboYSFWHKmMm
         xpXJz4BP6gucOEg+Ukuyp84pwrKsX9ZkIb1NabYySmkXePVDCbg39vkg/PySvfF8gAB5
         f48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=84eA0v7NjkZcVapbph9FV2OZwCgkFtzhcHgHRnZePS8=;
        b=bvzoVkze3RCQn5OXFg+aRNuN94Q2xVWH6ZRLe18jbNagqm01TKaG6DT7dmy9kzo5Zx
         5qGPAuojZofCdlEzrogyRVAf2nyTo22ijh4GDRay6/gsXr84JRvw7niRZSSaxfEAvr5k
         IlG54dovcJgGT2f7WYX2n9248N0ItoyLgy5p2zaFvdCtbyD9nPS3wTV/vphfol+Y65GS
         7+cKiSMTPH9cxP/qC6MkKeJMIFQWdpgyiuOjLw7+9dzXmqaGsYpsBgwO32g7xxlE7kxr
         3HjcWEdxXBwYXJk1JWbJT2PJfI4PalQzXCFrkwT2TBh8MUjQ1jWB3ZiSLCT+eLCGcHY0
         C5TQ==
X-Gm-Message-State: AODbwcB05pNvBRT8x1d6fS+3ANDAO+hXljAep37q2/pHlDz+yLs+GggJ
        4ZWshEjQSfRw2bzM6lmOBDZqS9IhAQ==
X-Received: by 10.202.56.212 with SMTP id f203mr10545255oia.146.1495431484739;
 Sun, 21 May 2017 22:38:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.252.130 with HTTP; Sun, 21 May 2017 22:38:04 -0700 (PDT)
In-Reply-To: <20170518193002.GA8186@guitar.localdomain>
References: <20170518193002.GA8186@guitar.localdomain>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Mon, 22 May 2017 07:38:04 +0200
Message-ID: <CACna6rx2NbH1t=cJp7_F7-G_NGrFDJ+C+ojvhZx0-wtHc9Qj3Q@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Fix LED inversion for WRT54GSv1
To:     Mirko Parthey <mirko.parthey@web.de>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 18 May 2017 at 21:30, Mirko Parthey <mirko.parthey@web.de> wrote:
> The WLAN LED on the Linksys WRT54GSv1 is active low, but the software
> treats it as active high. Fix the inverted logic.
>
> Signed-off-by: Mirko Parthey <mirko.parthey@web.de>

Looks OK, thanks!
