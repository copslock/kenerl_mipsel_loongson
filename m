Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Apr 2013 18:00:33 +0200 (CEST)
Received: from mail-wg0-f51.google.com ([74.125.82.51]:46739 "EHLO
        mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816285Ab3DQQAbgIMg3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Apr 2013 18:00:31 +0200
Received: by mail-wg0-f51.google.com with SMTP id b13so1752242wgh.6
        for <linux-mips@linux-mips.org>; Wed, 17 Apr 2013 09:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:subject:to:cc:in-reply-to:references:date
         :message-id:x-gm-message-state;
        bh=t3oVUqRhOYNqsB3cPHxP1nheOSmp9VlTNn0DiwRFyxg=;
        b=GKCKSBLJ3mvAAIMqtF1L7JjH5E47u9Jc9y/J6elPTzZbwZTcKluXzKoKofyJyfKA4h
         O9XFB4gMsKWJLHjHINdFiQ07puHukJvtjs0Gn9wl1nfKXyhRI7QUDA29ekN3BPvCilE1
         uXzwxgDPfCokI+NoYIECCSOzeb7aityf14K3n3I2WcK9GbMXpS/nrMtUF7FlIzp2jMJg
         jY3tS4heh+Cm1NSnuYe4h7sUR7IhjVCUbpJShio7DhpYDu/jMZHT6cHIx8XTpj2q9uYZ
         DM51O5GEyohF8bNZCPl1dKX1Yiu/+dVw/h2MXKpl0I6pkVl3yGgIiRjJQRA8hD9DFBGe
         JdWA==
X-Received: by 10.194.89.169 with SMTP id bp9mr12437072wjb.57.1366214422980;
        Wed, 17 Apr 2013 09:00:22 -0700 (PDT)
Received: from localhost (host31-54-169-16.range31-54.btcentralplus.com. [31.54.169.16])
        by mx.google.com with ESMTPS id du2sm26381874wib.0.2013.04.17.09.00.16
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 09:00:18 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 777453E2B73; Wed, 17 Apr 2013 17:00:15 +0100 (BST)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 1/3] of/pci: Unify pci_process_bridge_OF_ranges from Microblaze and PowerPC
To:     Andrew Murray <andrew.murray@arm.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "jg1.han@samsung.com" <jg1.han@samsung.com>,
        "jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
        "thomas.abraham@linaro.org" <thomas.abraham@linaro.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
        "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "thomas.petazzoni@free-electrons.com" 
        <thomas.petazzoni@free-electrons.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "suren.reddy@samsung.com" <suren.reddy@samsung.com>
In-Reply-To: <20130416103005.GB12726@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com> <1366107508-12672-2-git-send-email-Andrew.Murray@arm.com> <20130416103005.GB12726@arm.com>
Date:   Wed, 17 Apr 2013 17:00:15 +0100
Message-Id: <20130417160015.777453E2B73@localhost>
X-Gm-Message-State: ALoCoQk/n561b6ooXvXN5yAAuYnvc61gzL5wVa+iKp8PqjjlFEQHUzmpBoy5fxJZ1MubAuxiQEYk
Return-Path: <grant.likely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36252
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

On Tue, 16 Apr 2013 11:30:06 +0100, Andrew Murray <andrew.murray@arm.com> wrote:
> On Tue, Apr 16, 2013 at 11:18:26AM +0100, Andrew Murray wrote:
> > The pci_process_bridge_OF_ranges function, used to parse the "ranges"
> > property of a PCI host device, is found in both Microblaze and PowerPC
> > architectures. These implementations are nearly identical. This patch
> > moves this common code to a common place.
> > 
> > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> > Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Michal Simek <monstr@monstr.eu>
> > ---
> >  arch/microblaze/include/asm/pci-bridge.h |    5 +-
> >  arch/microblaze/pci/pci-common.c         |  192 ----------------------------
> >  arch/powerpc/include/asm/pci-bridge.h    |    5 +-
> >  arch/powerpc/kernel/pci-common.c         |  192 ----------------------------
> 
> Is there anyone on linuxppc-dev/linux-mips that can help test this patchset?
> 
> I've tested that it builds on powerpc with a variety of configs (some which
> include fsl_pci.c implementation). Though I don't have hardware to verify that
> it works.
> 
> I haven't tested this builds or runs on MIPS.
> 
> You shouldn't see any difference in behaviour or new warnings and PCI devices
> should continue to operate as before.

I've got through a line-by-line comparison between powerpc, microblaze,
and then new code. The differences are purely cosmetic, so I have
absolutely no concerns about this patch. I've applied it to my tree.

g.
