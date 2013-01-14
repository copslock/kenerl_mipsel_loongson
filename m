Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 17:50:06 +0100 (CET)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:55916 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831958Ab3ANQuFfYfXW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jan 2013 17:50:05 +0100
Received: by mail-lb0-f180.google.com with SMTP id gj3so3112438lbb.11
        for <linux-mips@linux-mips.org>; Mon, 14 Jan 2013 08:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=Vo0S6UhJzSGACyZsohm+5buZhF/rynbvYb68CUtlhmU=;
        b=b0jlCGm5n0EzCMrKNYFpZulOX8QKc+Hkjtit2Ijua4AiXjnvvaJ8SGXJvr+14jzEl+
         NACvddCMYOQ6zmdr6+QMD2n5l4bfZbIR+8LcLt2h7GEvrZrfa8auXizuWD/ARVlK1E63
         caPV2hSDhcGmZOwiER2Eo7wmmwdL7GyM5q2HDg8HX4hjt/aYiM9/5d6etkx4piH9ji2n
         lytXSpL8RGO/Ad4a/PiKNYVtjwKFcRGqABDkg2rlRcVs853Wgvlm2STa06cz1SdJ8MHf
         MN7zoURqlMa1jqEODP8hvO/Dl6p1NXNGHauVs7o1AUMBpcEK0ldZg1yxcYAUcGUy1p3c
         +/NQ==
X-Received: by 10.112.11.33 with SMTP id n1mr36050558lbb.18.1358182199651;
        Mon, 14 Jan 2013 08:49:59 -0800 (PST)
Received: from wasted.dev.rtsoft.ru (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id v7sm5682909lbj.13.2013.01.14.08.49.57
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jan 2013 08:49:58 -0800 (PST)
Message-ID: <50F444DC.1010307@mvista.com>
Date:   Mon, 14 Jan 2013 20:48:12 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 03/10] MIPS: PCI: Byteswap not needed in little-endian
 mode
References: <1358179922-26663-1-git-send-email-jchandra@broadcom.com> <1358179922-26663-4-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1358179922-26663-4-git-send-email-jchandra@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnTq5n/MS1uSt8yTgMMunrCZgnunyAQfbmHhIw0x9C94+NEAmijjixXQXlb6Hcpxe/vInRx
X-archive-position: 35429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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

Hello.

On 01/14/2013 07:11 PM, Jayachandran C wrote:

> Wrap the xlp_enable_pci_bswap() function and its call with
> '#ifdef __BIG_ENDIAN'. On Netlogic XLP, the PCIe initialization code
> to setup to byteswap is needed only in big-endian mode.

> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  arch/mips/pci/pci-xlp.c |    4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
> index 140557a..fe435fc 100644
> --- a/arch/mips/pci/pci-xlp.c
> +++ b/arch/mips/pci/pci-xlp.c
> @@ -191,6 +191,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +#ifdef __BIG_ENDIAN
>  static int xlp_enable_pci_bswap(void)
>  {
>  	uint64_t pciebase, sysbase;
> @@ -224,6 +225,7 @@ static int xlp_enable_pci_bswap(void)
>  	}
>  	return 0;
>  }
> +#endif
>  
>  static int __init pcibios_init(void)
>  {
> @@ -235,7 +237,9 @@ static int __init pcibios_init(void)
>  	ioport_resource.start =  0;
>  	ioport_resource.end   = ~0;
>  
> +#ifdef __BIG_ENDIAN
>  	xlp_enable_pci_bswap();
> +#endif

   Define empty inline function for the non-BE case instead. That's what
Documentation/SubmittingPatches tells us to do.

WBR, Sergei
