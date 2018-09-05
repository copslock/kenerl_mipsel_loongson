Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 16:26:55 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:43534 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994615AbeIEO0vl3Nyp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Sep 2018 16:26:51 +0200
Subject: Re: [PATCH] MIPS: pci-rt2880: set pci controller of_node
To:     Mathias Kresin <dev@kresin.me>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Tobias Wolf <dev-NTEO@vplace.de>
References: <1536130286-32088-1-git-send-email-dev@kresin.me>
From:   John Crispin <john@phrozen.org>
Message-ID: <250cfc61-5584-0b0a-1b58-16d3ab6af234@phrozen.org>
Date:   Wed, 5 Sep 2018 16:26:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536130286-32088-1-git-send-email-dev@kresin.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 05/09/18 08:51, Mathias Kresin wrote:
> From: Tobias Wolf <dev-NTEO@vplace.de>
>
> Set the PCI controller of_node such that PCI devices can be
> instantiated via device tree.
>
> Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
> Signed-off-by: Mathias Kresin <dev@kresin.me>
Acked-by: John Crispin <john@phrozen.org>

> ---
>   arch/mips/pci/pci-rt2880.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/pci/pci-rt2880.c b/arch/mips/pci/pci-rt2880.c
> index 711cdcc..f376a1d 100644
> --- a/arch/mips/pci/pci-rt2880.c
> +++ b/arch/mips/pci/pci-rt2880.c
> @@ -246,6 +246,8 @@ static int rt288x_pci_probe(struct platform_device *pdev)
>   	rt2880_pci_write_u32(PCI_BASE_ADDRESS_0, 0x08000000);
>   	(void) rt2880_pci_read_u32(PCI_BASE_ADDRESS_0);
>   
> +	rt2880_pci_controller.of_node = pdev->dev.of_node;
> +
>   	register_pci_controller(&rt2880_pci_controller);
>   	return 0;
>   }
