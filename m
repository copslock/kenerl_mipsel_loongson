Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Apr 2013 17:42:59 +0200 (CEST)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:37403 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816553Ab3DQPmz1gyso (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Apr 2013 17:42:55 +0200
Received: by mail-ie0-f169.google.com with SMTP id ar20so2082906iec.14
        for <linux-mips@linux-mips.org>; Wed, 17 Apr 2013 08:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=CkOqbwFc2NPvOour6nt5uVXs5eon/TZ5hHWw0XIFUGQ=;
        b=XcAhk/44zzu1PO/GhXVVx96x2Cb9tVsuRQ06JAk73s5h6ISkCs99d3h8U0Sux7d/4S
         eNk2hii3wBMyp+jKk1dVdgQHKRhk7nF1OvDqpeBBsaCD8aaqcI93vss5OM+peHNuglN8
         zxGC6EouJvRBkDIG+7xX+mN7WpCJE240dL6Nuv6C1/RgWmJWw924RvT2gGXVF51CVvnw
         CCBM/pimhq4Enfo8CzYhzF57Nw/t9CaKTIbvLAMsZz+dsy/ldXduwVZM6oOlFcR5SXiH
         km2U6vTCkT0noPr0s1fEfYqsjA3hBP2kzv8AwQA75Ch52ncSE/0p7iPFqsoAe/2BcRdR
         9lGg==
MIME-Version: 1.0
X-Received: by 10.50.136.231 with SMTP id qd7mr9704602igb.0.1366213369022;
 Wed, 17 Apr 2013 08:42:49 -0700 (PDT)
Received: by 10.42.109.209 with HTTP; Wed, 17 Apr 2013 08:42:48 -0700 (PDT)
In-Reply-To: <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
        <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
Date:   Wed, 17 Apr 2013 17:42:48 +0200
Message-ID: <CACRpkdbBaT1OKr5t8HW4+8y_wSDmGxmewAyVMekx8S-K9s3K8Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] of/pci: mips: convert to common of_pci_range_parser
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Andrew Murray <Andrew.Murray@arm.com>
Cc:     linux-mips@linux-mips.org,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        siva.kallam@samsung.com, linux-pci@vger.kernel.org,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Jingoo Han <jg1.han@samsung.com>, Liviu.Dudau@arm.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        suren.reddy@samsung.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQlmuGQ1bZfGHBhCWaNyjpeae+XWUjxBNSX1Kh8Tu7dRmkWeFoBPgridQIT7phK3cCostwfl
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36251
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

On Tue, Apr 16, 2013 at 12:18 PM, Andrew Murray <Andrew.Murray@arm.com> wrote:

> This patch converts the pci_load_of_ranges function to use the new common
> of_pci_range_parser.
>
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
