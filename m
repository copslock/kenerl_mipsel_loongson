Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 17:01:26 +0100 (CET)
Received: from [212.40.180.161] ([212.40.180.161]:46504 "EHLO
        smtp-out-039.synserver.de" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012393AbcBOQBZ0816N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 17:01:25 +0100
Received: (qmail 22495 invoked by uid 0); 15 Feb 2016 16:01:11 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 22422
Received: from p4fde6b68.dip0.t-ipconnect.de (HELO ?192.168.2.127?) [79.222.107.104]
  by 212.40.180.165 with AES128-SHA encrypted SMTP; 15 Feb 2016 16:01:11 -0000
Subject: Re: [PATCH 1/4] gpio: remove broken irq_to_gpio() interface
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <1455551208-2825510-1-git-send-email-arnd@arndb.de>
 <1455551208-2825510-2-git-send-email-arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56C1F645.1070405@metafoo.de>
Date:   Mon, 15 Feb 2016 17:01:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
MIME-Version: 1.0
In-Reply-To: <1455551208-2825510-2-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 02/15/2016 04:46 PM, Arnd Bergmann wrote:
> +static inline __deprecated int irq_to_gpio(unsigned int irq)
> +{
> +	/* this has clearly not worked for a long time */
> +	return -EINVAL;
> +}
> +
>  #define IRQ_TO_BIT(irq) BIT(irq_to_gpio(irq) & 0x1f)

The issue seems to be a fallout from commit 832f5dacfa0b ("MIPS: Remove all
the uses of custom gpio.h").

The irq_to_gpio() should be replaced with "(irq - JZ4740_IRQ_GPIO(0))".

- Lars
