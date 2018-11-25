Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2018 05:00:15 +0100 (CET)
Received: from mail-ed1-x541.google.com ([IPv6:2a00:1450:4864:20::541]:33678
        "EHLO mail-ed1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990392AbeKYD7Req2kf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Nov 2018 04:59:17 +0100
Received: by mail-ed1-x541.google.com with SMTP id r27so13136405eda.0;
        Sat, 24 Nov 2018 19:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+VbIPcUA0nJnu19TEKgDmZfhoeqvq+Zc/bRRQahK3k=;
        b=ocdTkfBE5AFtLyhSSV8CuyIFXHG7GlsaOSO2j0zy3JdpMsb0At1PKZh1bBgvl+syDO
         lx45TU5Phwa8H6BdHwH+Bf6IJPf7HRQ/yOAe7fZjbM8U51f6xAyBZi8Po1l7EBMRCzXq
         zhCEziYoT2r3r1dgupyt6RCI4LoeiJ0GexBWvcivKlOZZzLssK2SAjLMwh0svjbJdzxw
         cvwHa4m9XqlCttALqA20+fJbDiTTaX7Pa7FnMBLyJZCAeKGWLPMbuN6ZU1K3cOxPMaBp
         W40LpbtMifYMNHlQ6g7X4/cSupZ5xareMupm50/a4TGfR3zSOJJjJ5JoV+UbmSWqYB6N
         oloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+VbIPcUA0nJnu19TEKgDmZfhoeqvq+Zc/bRRQahK3k=;
        b=L5klx0LIVDFZVuC+WHbpiymG4E6GCxPWqJX9OVbV1uhoL5ei6+xzxJ2lyG2MOLuKjD
         zXFcr72oi1CR2Rn1lqxE4a+LMj0TPusaUEoRWJqtOSvT+9v3OJ+xND83wCsgVaoIsN5W
         11fULQjsbtuMSZqLaKs5arQ29uGLIWMZGRQWvrWPSnExp/6jDXt2O/jxQzOk9aausrBY
         LPtWAX4BKwmi5N2B5nr1Ol0CTNtWdnDBOOQtSBiCHY7//bx/YLtlirMWb/eVTj1F9vF0
         ZqqptoEaw8Y3qj8tBsErkbH91JB1S0R7Hh8TGSv6hImeI4o96QM//dkUVB8nXhBDrPOy
         bRsw==
X-Gm-Message-State: AGRZ1gLY4yYT8YvRyoJDaa9yEDPUyR2ZUkWiGGiADaDKZ8+JuAOsG5hG
        snuYXyRG2JG2wixkM0YlmBXcYV9/YoiSSe6Omis=
X-Google-Smtp-Source: AJdET5fP384hUZ9MCTMYcaTg+4qb4i0FIO8NdOS/IfPbEZfc1J9ZA3JA647zCPwROOGuZcyrIWGP021BQcn7w8N3H5Q=
X-Received: by 2002:a17:906:4a4b:: with SMTP id a11-v6mr16244194ejv.68.1543118357002;
 Sat, 24 Nov 2018 19:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com> <20181124022035.17519-3-deepa.kernel@gmail.com>
In-Reply-To: <20181124022035.17519-3-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 22:58:39 -0500
Message-ID: <CAF=yD-KfxXK=Ta=+a8UYMcmUYzN=UokotfzSno2-xi=JeS6=0g@mail.gmail.com>
Subject: Re: [PATCH 2/8] sockopt: Rename SO_TIMESTAMP* to SO_TIMESTAMP*_OLD
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Helge Deller <deller@gmx.de>,
        David Howells <dhowells@redhat.com>, jejb@parisc-linux.org,
        ralf@linux-mips.org, rth@twiddle.net,
        linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <willemdebruijn.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: willemdebruijn.kernel@gmail.com
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

On Sat, Nov 24, 2018 at 3:58 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> SO_TIMESTAMP, SO_TIMESTAMPNS and SO_TIMESTAMPING options, the
> way they are currently defined, are not y2038 safe.
> Subsequent patches in the series add new y2038 safe versions
> of these options which provide 64 bit timestamps on all
> architectures uniformly.
> Hence, rename existing options with OLD tag suffixes.

Why do the existing interfaces have to be renamed when new interfaces are added?
