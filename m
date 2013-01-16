Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 10:18:20 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:43073 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821310Ab3APJSTsJ9vC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2013 10:18:19 +0100
Received: by mail-lb0-f182.google.com with SMTP id gg6so230146lbb.13
        for <multiple recipients>; Wed, 16 Jan 2013 01:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=bPjldk2Q6/TXBHs2RiufpdaPr/lVvxMzkPENjUKF/es=;
        b=YmTaWxAAcWcvRS9uZ0QyquNyBSn1OuVz02ZTIlaoyJpukARD9gUls+uGnsS/6pCWWL
         Pc8Kmw8gk1HV/N356/aBdV1YrJw0qtpga75i+TirfgdNPiAsUB5sR+yWRShfqj7dcS/d
         jIOnmtSdKHaQaq0nrMUitiPtT4iQIJnvTLPWCni8Qd3R1Ns2xDfJ1/Sz+Vs7TUcLdIiE
         E7tmbhnW+CyKu2AUY3H6+tWCG9pWa1C+K4RlAOWZid2M/6cCGCk078w9rENS01vtA0mE
         RW3J/Ev32WBLpHSyZ+4n+8PNJjc7i3ItScSUeub4UOnlnPRpwH6m+6J/WN1iiKinpcwG
         +fFw==
X-Received: by 10.112.29.104 with SMTP id j8mr356181lbh.0.1358327894008;
        Wed, 16 Jan 2013 01:18:14 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id v7sm7728346lbj.13.2013.01.16.01.18.12
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jan 2013 01:18:13 -0800 (PST)
Message-ID: <50F66FB8.7030207@openwrt.org>
Date:   Wed, 16 Jan 2013 10:15:36 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@avionic-design.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PNX8550: Fix build failures
References: <1358320033-30032-1-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1358320033-30032-1-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/16/2013 08:07 AM, Thierry Reding wrote:
> The OHCI support code fails to build because the PCI_BASE and udelay()
> macros which are defined in pci.h and linux/time.h respectively. Adding
> corresponding includes fixes these build failures.
>
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Thanks for fixing this Thierry, I completely missed that when moving the 
OHCI code to platform.c

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>   arch/mips/pnx8550/common/platform.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/pnx8550/common/platform.c b/arch/mips/pnx8550/common/platform.c
> index 0a8faea..9782fde 100644
> --- a/arch/mips/pnx8550/common/platform.c
> +++ b/arch/mips/pnx8550/common/platform.c
> @@ -19,10 +19,12 @@
>   #include <linux/resource.h>
>   #include <linux/serial.h>
>   #include <linux/serial_pnx8xxx.h>
> +#include <linux/delay.h>
>   #include <linux/platform_device.h>
>   #include <linux/usb/ohci_pdriver.h>
>   
>   #include <int.h>
> +#include <pci.h>
>   #include <usb.h>
>   #include <uart.h>
>   
