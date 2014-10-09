Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 18:19:39 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:37278 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010966AbaJIQThx-tER (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 18:19:37 +0200
Received: by mail-la0-f49.google.com with SMTP id q1so1565260lam.36
        for <linux-mips@linux-mips.org>; Thu, 09 Oct 2014 09:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aLweDzXD5YgHEZQMGoSoZZwhf7Bt0D4pMdCKOk7Pzjg=;
        b=aOipowSjx04mQdLQcQyRRUH4H5k9/Gnt3TlQDNPZrMLk9ejIH5UMNECe3aQlWmUrPJ
         aKNZCO36tygOudQ9g8yPt/6CwkMIzUcJfkDWb33+IV9wajSPReHt29pmfDTPysmq4ZDu
         +CanjUORs9wa+8S/5T1R2sroLhSQ96JZJZ0Qm0bE9p585Jo+/+X76So/fgBMcEOKv0v0
         sR0dtczsjfEmJGFj89BBhMELL7iYUqlA7EafyKPiPyb3xIzXAgcNbpBNN8Qi9u7nvAN1
         Wxi4QkQ0On8wrI0+YaK0/iTXLbji4mCY+H2g54oIHrMqFINfn2ebA6gIZ2Der/xgQUcz
         2E3Q==
X-Gm-Message-State: ALoCoQlMeRWRrD1NTL2JHmf6cQrMmMDPh1cmHYPil1P+3bCuDAjKQDxEeD5+Rmp3YpG5Fn7S3Eej
X-Received: by 10.112.135.42 with SMTP id pp10mr18621711lbb.17.1412871571845;
        Thu, 09 Oct 2014 09:19:31 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp17-169.pppoe.mtu-net.ru. [81.195.17.169])
        by mx.google.com with ESMTPSA id p5sm1092720lag.1.2014.10.09.09.19.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 09:19:31 -0700 (PDT)
Message-ID: <5436B591.3000008@cogentembedded.com>
Date:   Thu, 09 Oct 2014 20:19:29 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 05/10] MIPS: ralink: add illegal access driver
References: <1412812385-64820-1-git-send-email-blogic@openwrt.org> <1412812385-64820-6-git-send-email-blogic@openwrt.org>
In-Reply-To: <1412812385-64820-6-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43150
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

On 10/09/2014 03:53 AM, John Crispin wrote:

> These SoCs have a special irq that fires upon an illegal memmory access.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/mips/ralink/Makefile  |    2 +
>   arch/mips/ralink/ill_acc.c |   87 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 89 insertions(+)
>   create mode 100644 arch/mips/ralink/ill_acc.c

[...]
> diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
> new file mode 100644
> index 0000000..e20b02e
> --- /dev/null
> +++ b/arch/mips/ralink/ill_acc.c
> @@ -0,0 +1,87 @@
[...]
> +static const char * const ill_acc_ids[] = {
> +	"cpu", "dma", "ppe", "pdma rx", "pdma tx", "pci/e", "wmac", "usb",
> +};
> +
> +static irqreturn_t ill_acc_irq_handler(int irq, void *_priv)
> +{
> +	struct device *dev = (struct device *) _priv;
> +	u32 addr = rt_memc_r32(REG_ILL_ACC_ADDR);
> +	u32 type = rt_memc_r32(REG_ILL_ACC_TYPE);
> +
> +	dev_err(dev, "illegal %s access from %s - addr:0x%08x offset:%d len:%d\n",
> +		(type & ILL_ACC_WRITE) ? ("write") : ("read"),

    Hm, why these () around string literals? Not that the ones before ? are 
needed too...

WBR, Sergei
