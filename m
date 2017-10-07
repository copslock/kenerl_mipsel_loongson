Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Oct 2017 10:59:14 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:53565
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990422AbdJGI7HYt1qL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Oct 2017 10:59:07 +0200
Received: by mail-wm0-x242.google.com with SMTP id q132so12334382wmd.2;
        Sat, 07 Oct 2017 01:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4FcjhsYSOKWP6+9NIQoq0X+RrVTSOwU0Q4pKqDenGPY=;
        b=qRdIDEzK2xpatirGY7bYh0LMOyiAhfDAWP7g53KsbnCU4mRejf/a2c6JAc431G1ot4
         1Ye95HvancSEdjQ/LSd/k6x34UtM+FQI4Ddgp6gsOXD1+Ol5aDqY1ttHKgE052BsiVnc
         /cRyBzdNI1xuPiVykmCS1yYBA5wGu5oORUC9MmoavgGPWoCC0PnTB4fYrGJXuM1Jdflz
         oOIvftUng69GADUVJsL5XdeaMvCVzsBGuESAzXWEwMSpE9SBlZhNQfJkfp+AZT5x7OMd
         wh5RFAOed10ogGbunJyhepHwLLvHqN84WlRugsKmJzrbI9EmvF9cpdy5LlbpdE4xaUkm
         Vhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4FcjhsYSOKWP6+9NIQoq0X+RrVTSOwU0Q4pKqDenGPY=;
        b=M1jg6zGsdKtE/0/ZkkhE2v0E7t8dVKKCWJBjE/wkWszyAPMYJJeb/yp6lwimSHp62r
         6C6aUgv/17r+nIqrXtMS4Ai6IwDpyTmbGINrGDQHjnlMcAZCM9sDU1GXvrk57nMZmdrz
         g44qpv3AveQMKVJPr20qZ5KdaMkjPVZVQww24un7+LGL0FjBkhjgws/pUx/ujq7Gxsda
         vTLyTDjU2QvykDI3Q2XTXIG5Mn+4YvqKD0gNIFTB3dbkCS78XCkqC43q3qfWAgk+lzuP
         gSq7Uh9rfOJpyl3l+TPqmncXofE9A2mP1k0YYKZPVTX2qdcQOy+mBPS9tLrY/PlmPK7f
         98tw==
X-Gm-Message-State: AMCzsaWY0dCb502BhgqgYKrkSMxpGPVawfeZsl8g+pw+UKjt9YLQAAq3
        9E4ImeXYP8DDh/pvLZIgdRM=
X-Google-Smtp-Source: AOwi7QDTvOhmOV0fQXJ5HgamluIM+SxDKJZZn+0TI7AMtGT6GJX7VaTy2fHmqOoAQ9jUmIOpZn4HZw==
X-Received: by 10.28.128.212 with SMTP id b203mr3429162wmd.82.1507366742056;
        Sat, 07 Oct 2017 01:59:02 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j4sm1492434wrg.11.2017.10.07.01.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Oct 2017 01:59:01 -0700 (PDT)
Date:   Sat, 7 Oct 2017 10:58:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Howells <dhowells@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-am33-list@redhat.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-xtensa@linux-xtensa.org, Mikael Starvik <starvik@axis.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
        linux-parisc@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 0/4] PCI: Cleanup unused stuff
Message-ID: <20171007085858.hjjowcgm457wo3cg@gmail.com>
References: <20171005201939.18300.25690.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171005201939.18300.25690.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Bjorn Helgaas <helgaas@kernel.org> wrote:

> Sorry for the long cc list.  These are pretty trivial; they just remove
> some unnecessary declarations across several arches.
> 
> ---
> 
> Bjorn Helgaas (4):
>       PCI: Remove redundant pcibios_set_master() declarations
>       PCI: Remove redundant pci_dev, pci_bus, resource declarations
>       PCI: Remove unused declarations
>       alpha/PCI: Make pdev_save_srm_config() static
> 
> 
>  arch/alpha/include/asm/pci.h            |    5 -----
>  arch/alpha/kernel/pci.c                 |   11 ++++++++++-
>  arch/alpha/kernel/pci_impl.h            |    8 --------
>  arch/cris/include/asm/pci.h             |    9 ---------
>  arch/frv/include/asm/pci.h              |    4 ----
>  arch/ia64/include/asm/pci.h             |    4 ----
>  arch/mips/include/asm/pci.h             |    4 ----
>  arch/mn10300/include/asm/pci.h          |    4 ----
>  arch/mn10300/unit-asb2305/pci-asb2305.h |    3 ---
>  arch/parisc/include/asm/pci.h           |    8 --------
>  arch/powerpc/include/asm/pci.h          |    2 --
>  arch/sh/include/asm/pci.h               |    4 ----
>  arch/sparc/include/asm/pci_32.h         |    2 --
>  arch/x86/include/asm/pci.h              |    2 --
>  arch/xtensa/include/asm/pci.h           |    2 --
>  15 files changed, 10 insertions(+), 62 deletions(-)

Nice cleanups! For the whole series:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
