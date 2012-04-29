Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Apr 2012 20:55:06 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:50419 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903643Ab2D2Sy6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Apr 2012 20:54:58 +0200
Received: by lbbgg6 with SMTP id gg6so56225lbb.36
        for <linux-mips@linux-mips.org>; Sun, 29 Apr 2012 11:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=C5DG5+nuOLIs5jfaAuGsyHgUkWsdjQseBhg4P+xGVGI=;
        b=BKW6ZFx2Hq0OSRsn8oK33dIAn+S3RpmZA/J5mJ8NkbV2QfXtQR6YCerGXAkqz5i8VJ
         +6WeFy4W8S2Bx64dRu+yTEG7zNWQnWdSVJESDBNXiJ5VFbxrRNdmp50C9gHMrahaqK83
         VWfUBZQjK4EK3AQdWMPtl0zM6rPDOQnV74vG+1QE/2KX98NlUskKQNsq+LL04nhDhqJn
         kA80RlkV5BokOPaJPcnHaBCcMozyD9SwxTdYIEzjbTcK3cELoQZGUvdqaSlVongfnNu3
         Tz5CkKvCzoLY3xOlfcEgSHw/4RIsPnrYcc5qUzjKBpToCaXfidTBKEfWi3imsOF/aBwU
         hyPg==
Received: by 10.152.105.241 with SMTP id gp17mr3953178lab.21.1335725692506;
        Sun, 29 Apr 2012 11:54:52 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-86-166.pppoe.mtu-net.ru. [91.79.86.166])
        by mx.google.com with ESMTPS id lp15sm14059327lab.1.2012.04.29.11.54.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Apr 2012 11:54:50 -0700 (PDT)
Message-ID: <4F9D8E12.9090006@mvista.com>
Date:   Sun, 29 Apr 2012 22:53:06 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120420 Thunderbird/12.0
MIME-Version: 1.0
To:     Jayachandran C <jayachandranc@netlogicmicro.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Ganesan Ramalingam <ganesanr@broadcom.com>
Subject: Re: [PATCH 02/12] MIPS: Netlogic: MSI enable fix for XLS
References: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com> <1335618738-4679-3-git-send-email-jayachandranc@netlogicmicro.com>
In-Reply-To: <1335618738-4679-3-git-send-email-jayachandranc@netlogicmicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlY02Cep2UC624AyKMTwFGFCLxkXLAXSOY67Tl1HrOdx3vt5yvhsGsuLmlP47Qwqgvy3xUj
X-archive-position: 33078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 28-04-2012 17:12, Jayachandran C wrote:

> From: Ganesan Ramalingam<ganesanr@broadcom.com>

> MSI interrupts do not work on XLS after commit a776c49, because

    Please also specify that commit's summary in parens.

> the change disables MSI interrupts on the XLS PCIe bridges at boot-up.

> Fix this by enabling MSI interrupts on the bridge in the
> arch_setup_msi_irq() function. Earlier, this was done from firmware
> and we did not need to change the configuration in linux.

> Signed-off-by: Ganesan Ramalingam<ganesanr@broadcom.com>
> Signed-off-by: Jayachandran C<jayachandranc@netlogicmicro.com>
> ---
>   arch/mips/pci/pci-xlr.c |   30 +++++++++++++++++++++++++-----
>   1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
> index 50ff4dc..003e053 100644
> --- a/arch/mips/pci/pci-xlr.c
> +++ b/arch/mips/pci/pci-xlr.c
[...]
> @@ -168,17 +169,17 @@ static int get_irq_vector(const struct pci_dev *dev)
>   	if (dev->bus->self == NULL)
>   		return 0;
>
> -	switch	(dev->bus->self->devfn) {
> -	case 0x0:
> +	switch	(PCI_SLOT(dev->bus->self->devfn)) {
> +	case 0:
>   		return PIC_PCIE_LINK0_IRQ;
> -	case 0x8:
> +	case 1:
>   		return PIC_PCIE_LINK1_IRQ;
> -	case 0x10:
> +	case 2:
>   		if (nlm_chip_is_xls_b())
>   			return PIC_PCIE_XLSB0_LINK2_IRQ;
>   		else
>   			return PIC_PCIE_LINK2_IRQ;
> -	case 0x18:
> +	case 3:
>   		if (nlm_chip_is_xls_b())
>   			return PIC_PCIE_XLSB0_LINK3_IRQ;
>   		else

    This seems like un unrelated change...

WBR, Sergei
