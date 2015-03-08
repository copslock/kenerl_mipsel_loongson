Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Mar 2015 23:48:46 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.13]:54494 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007561AbbCHWspcKjIL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Mar 2015 23:48:45 +0100
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0Lmel1-1XwEOC2UGx-00aDV6; Sun, 08 Mar
 2015 23:48:23 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Aleksey Makarov <aleksey.makarov@auriga.com>
Cc:     linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Vinita Gupta <vgupta@caviumnetworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] SATA: OCTEON: support SATA on OCTEON platform
Date:   Sun, 08 Mar 2015 23:48:21 +0100
Message-ID: <2264145.MknHxHLvY7@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1425567540-31572-1-git-send-email-aleksey.makarov@auriga.com>
References: <1425567540-31572-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:qfmyRC6L0a+OVHROUVCDYK30Y81hwF09fF1QiGxB/WT1XKM+a+t
 fZjP8WsO3VIRabsTf0pnmt98KyJikU6Wnwd334p6PaGbdJcDIfsV823mcWu1hbj9W4U78/H
 dMQHNh/NvAG+pIs8miSqqJ0PL6PJSIOJybTcUSUGs9WwjkuPFmpQtOzTbX6txtWbLtNrNxT
 m2XG6CP72GbftYhaCnnYg==
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thursday 05 March 2015 17:58:58 Aleksey Makarov wrote:
> +       ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +       if (ret)
> +               return ret;
> 

Don't do this, instead you should set the dma-ranges of the parent
bus correctly so that dma_set_mask_and_coherent succeeds.

dma_coerce_mask_and_coherent() was introduced as a hack to
annotate broken drivers that were overriding the dma_mask pointer
themselves.

	Arnd
