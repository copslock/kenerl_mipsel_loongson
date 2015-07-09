Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 13:03:21 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:35907 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009933AbbGILDTZwor3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 13:03:19 +0200
Received: by lagc2 with SMTP id c2so240907759lag.3
        for <linux-mips@linux-mips.org>; Thu, 09 Jul 2015 04:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=8EljwLgnkOHyC4FMXTJPbF0ihBlwHR1hcCO2wDMjo/4=;
        b=bvB3OqCvGx7h/oe1S+OwhqRZ+QaHzY98G+2/xqfKDa2D8F0/cEM8YlNSTHjulax9mD
         R7dC9MuY8GM+RHqf9dIvdO9AASIcipz9msg4hkUArm9h1abXwE5jlB8LwbTOGGyQBB8R
         ru0btVDR7fKtnooihxabiCgSKt+iS1pKDQcyehVxT92vwIeBhYTvCLNQVUdqyEb+4D4A
         zQgOgXSoWgzu480TS8w3wLXgKEP7mvQSlgDFqC5ZwBnikGr/K+kaC3Qochr9qJ9rlg3Y
         dck9ZdYdLpRcUCWYBKyd1dJdz4vQ0QwgZBQNBoRBqA0PQ/fr9rQKns9H8pjEVIELorZc
         q0pQ==
X-Gm-Message-State: ALoCoQl/he6zXT8qBRcZTCwITP8FWx9rSP0w846rhufSRVShNMAXFu9d0TOax4EauXpqasS2FEDj
X-Received: by 10.152.21.5 with SMTP id r5mr14120631lae.24.1436439793932;
        Thu, 09 Jul 2015 04:03:13 -0700 (PDT)
Received: from [192.168.3.154] (ppp17-200.pppoe.mtu-net.ru. [81.195.17.200])
        by smtp.gmail.com with ESMTPSA id jp6sm1329943lab.18.2015.07.09.04.03.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 04:03:12 -0700 (PDT)
Subject: Re: [RFC Patch V1 02/12] MIPS, PCI: Use for_pci_msi_entry() to access
 MSI device list
To:     Jiang Liu <jiang.liu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Grant Likely <grant.likely@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stuart Yoder <stuart.yoder@freescale.com>,
        Yijing Wang <wangyijing@huawei.com>,
        Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
 <1436428847-8886-3-git-send-email-jiang.liu@linux.intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <559E54EE.7090504@cogentembedded.com>
Date:   Thu, 9 Jul 2015 14:03:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <1436428847-8886-3-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 7/9/2015 11:00 AM, Jiang Liu wrote:

> Use accessor for_pci_msi_entry() to access MSI device list, so we could

     Maybe for_each_pci_msi_entry()?

> easily move msi_list from struct pci_dev into struct device later.

> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>   arch/mips/pci/msi-octeon.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
> index cffaaf4aae3c..2a5bb849b10e 100644
> --- a/arch/mips/pci/msi-octeon.c
> +++ b/arch/mips/pci/msi-octeon.c
> @@ -200,7 +200,7 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>   	if (type == PCI_CAP_ID_MSI && nvec > 1)
>   		return 1;
>
> -	list_for_each_entry(entry, &dev->msi_list, list) {
> +	for_each_pci_msi_entry(entry, dev) {
>   		ret = arch_setup_msi_irq(dev, entry);
>   		if (ret < 0)
>   			return ret;

WBR, Sergei
