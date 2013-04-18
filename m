Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Apr 2013 15:45:48 +0200 (CEST)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:50796 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822444Ab3DRNpoJrbPq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Apr 2013 15:45:44 +0200
Received: by mail-wi0-f179.google.com with SMTP id l13so2505817wie.6
        for <linux-mips@linux-mips.org>; Thu, 18 Apr 2013 06:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:subject:to:cc:in-reply-to:references:date
         :message-id:x-gm-message-state;
        bh=yKsiYOzEyFtRvbI+mKEhmGlrSgKdBEHEjHdK8VOasmI=;
        b=TUx9hgAFQOZBG4rIvchPNlNqrQIxzLAzo3O4YCFDulMK5FfzV1cV4TMYYLcn7p407+
         RcFJaauUge2UI94qPtMqT0N+AmaQ/sxMVJcbwmEXkNmWiQu7zviFlTwHUngk+Nd2UuVi
         zrMpAhuNEPJC9hsO2L4wNQlBEr/rfJoMx7aEvhK5wMR8rg+dLXWpF7HdS8AzUss8hwR0
         4Dbjc1M8adLe2plAh1K5N6S/YA+ckGGCaRSQ+8Vx/ULNW0kl1LSsfXhC0yD/ewF+wKiq
         PeTGTbgIq0HtJfc5ehp6YTTugJGEo4toHcev+JORqjCXlu198kPm4mAnKNr7SbNbsKLU
         /r1g==
X-Received: by 10.194.8.99 with SMTP id q3mr18405210wja.34.1366292738767;
        Thu, 18 Apr 2013 06:45:38 -0700 (PDT)
Received: from localhost (host31-53-18-197.range31-53.btcentralplus.com. [31.53.18.197])
        by mx.google.com with ESMTPS id o3sm16268834wia.2.2013.04.18.06.45.35
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 06:45:37 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 5189E3E1319; Thu, 18 Apr 2013 14:45:35 +0100 (BST)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 3/3] of/pci: mips: convert to common of_pci_range_parser
To:     Andrew Murray <Andrew.Murray@arm.com>, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     rob.herring@calxeda.com, jgunthorpe@obsidianresearch.com,
        linux@arm.linux.org.uk, siva.kallam@samsung.com,
        linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        jg1.han@samsung.com, Liviu.Dudau@arm.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kgene.kim@samsung.com, bhelgaas@google.com,
        suren.reddy@samsung.com, linux-arm-kernel@lists.infradead.org,
        monstr@monstr.eu, benh@kernel.crashing.org, paulus@samba.org,
        thomas.petazzoni@free-electrons.com,
        thierry.reding@avionic-design.de, thomas.abraham@linaro.org,
        arnd@arndb.de, linus.walleij@linaro.org,
        Andrew Murray <Andrew.Murray@arm.com>
In-Reply-To: <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com> <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
Date:   Thu, 18 Apr 2013 14:45:35 +0100
Message-Id: <20130418134535.5189E3E1319@localhost>
X-Gm-Message-State: ALoCoQlW/hZ6T/ZqQjjOfj+0NDaAoi8HMFlg61+T9xUndVF0tStmdak9YEBNLgH69PLuywi68xHN
Return-Path: <grant.likely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
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

On Tue, 16 Apr 2013 11:18:28 +0100, Andrew Murray <Andrew.Murray@arm.com> wrote:
> This patch converts the pci_load_of_ranges function to use the new common
> of_pci_range_parser.
> 
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>

Looks okay to me, and thank you very much for doing the legwork to merge
the common code.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
