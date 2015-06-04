Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 06:53:01 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:33737 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007129AbbFDEw7ST53b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 06:52:59 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NPE003QXLK4DYA0@mailout4.w1.samsung.com> for
 linux-mips@linux-mips.org; Thu, 04 Jun 2015 05:52:52 +0100 (BST)
X-AuditID: cbfec7f4-f79c56d0000012ee-46-556fd9a3c590
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 9F.92.04846.3A9DF655; Thu,
 4 Jun 2015 05:52:51 +0100 (BST)
Received: from [10.252.80.64] by eusync1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NPE00JMCLJWCF40@eusync1.samsung.com>; Thu,
 04 Jun 2015 05:52:51 +0100 (BST)
Message-id: <556FD9A1.5000406@samsung.com>
Date:   Thu, 04 Jun 2015 13:52:49 +0900
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.7.0
MIME-version: 1.0
To:     Jiang Liu <jiang.liu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kukjin Kim <kgene@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-metag@vger.kernel.org
Subject: Re: [RFT v2 46/48] genirq, irqchip: Kill the first parameter 'irq' of
 irq_flow_handler_t
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-47-git-send-email-jiang.liu@linux.intel.com>
In-reply-to: <1433391238-19471-47-git-send-email-jiang.liu@linux.intel.com>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHee69u7szB9ep+WBEsOhDRpbah4cw017ghhAWCeKH8qZXZzln
        mxNNRdPMkpViaTJUBpuvaOqmlebMdzPftaKJTkktxU0TC03IcpPIb79zzu+c/5dD4SIL4U5F
        x8Zz8lg2Rkw6EAPbfRPHtSZZ8ElVmS/6npGFI12GBK3Xb5PIqJkGaGulm48KG9zQSukiju7p
        JgikfvWWQMuLXih3bhlH5doFgCracgHSz33ioYmWYhJ9ncwmUF5BPh8NlfaRqGikDUNNeiOO
        xts1GLJOPSeQQV+AI8uomUCb9XM89KdxnfR3ZzaynhDMvH4MMM3qaT6j0SsZVfMgYAyVHoy2
        dQljVJb7PEZf/Yhk0ttHCGZleJjP9FTVYkxp/xXGoEtj1hYmCWa17SMZ5Bzq4BvBxUQncPIT
        fmEOktqiEV5cFS+xZlZNpoMKIgcIKEifgnXmPrDL++GouY60sYguA3DIuC8HOOzwAoCtpb12
        SUh7QMt4h50J+ggs0uhwG5O0DzRU6OzLrnQItE70Y7u+E9x8aiZsh1zo9wT8ttKE2wqc7sDg
        QuEDu+VMh8Ofjxv5u3E5AP7eeGcfCOhA+MH6ZoepnQ1PODPmYWvj9CFoqLHieYBW7wlR/7fU
        eywNwKuBK6cMj1PcjJJ6eSpYqUIZG+UZLpPqwe4P/HgNtL2nOwFNAbGjcLZLFizisQmKJGkn
        gBQudhFeHthpCSPYpLucXHZDrozhFJ3gAEWI3YQlLavXRHQUG8/d5rg4Tv5vilEC93RwVmmZ
        nVd9aWkI0M7w6Thvk+DCuulodkehLrIrWeXjHREylHlmzf+lp8R6uCY0kqoUptZRmVutyc+c
        AgxLd7Jx+efNiqudXn5hpp78c6LJEmNxSupgYnHgdvfwraBjWkn5RityFKddj79YMvUi9vzB
        sDoz5hb00HQpP4WlfwWKCYWE9fLA5Qr2LwL90Uv/AgAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
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

On 04.06.2015 13:13, Jiang Liu wrote:
> Now most IRQ flow handlers make no use of the first parameter 'irq'.
> And for those who do make use of 'irq', we could easily get the irq
> number through irq_desc->irq_data->irq. So kill the first parameter
> 'irq' of irq_flow_handler_t.
> 
> To ease review, I have split the changes into several parts, though
> they should be merge as one to support bisecting.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>  drivers/irqchip/exynos-combiner.c    |    4 ++--

For exynos:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
