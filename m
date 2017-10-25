Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Oct 2017 02:23:47 +0200 (CEST)
Received: from mail-qk0-x233.google.com ([IPv6:2607:f8b0:400d:c09::233]:50492
        "EHLO mail-qk0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991025AbdJYAXgdS65m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Oct 2017 02:23:36 +0200
Received: by mail-qk0-x233.google.com with SMTP id o187so28542691qke.7;
        Tue, 24 Oct 2017 17:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0FFOMrKxTSMxXKX6xdXnqYFva2I+RDrpPr2sNivCAVg=;
        b=udn9NRHKmir/gKntJk7X3uwGQn3XdoskvYHeOuUoDt98XwqbQRTtHzUODqz67/tzKQ
         kgLLUvlu4UhOMynkjuvLMFY/nrmiwitmOc2qbQH/vIzq1KpDUGcNF1luo+09PoTQYxke
         8nE4dJKrDeLL0iexBiI6iWG2VLWgLVofgoJTTOzDrfqm2RgiDNkwYaZcESeIW+pOL3SN
         q66BscxczwLOquv1wjpkRzOOKutr5WNsS4JjgSxGnnSd2s0P1zHWV1cl/dWZCQju+j8E
         IP6bEyRiwlLOAmeGh1Jx1amtX26kGMFnrLSCIE8OBU6rfYlRWGjbNfNgv/I5jkFtVfQO
         ZKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0FFOMrKxTSMxXKX6xdXnqYFva2I+RDrpPr2sNivCAVg=;
        b=rHdfyJdsom1ztcHTjZKn/LFAci9iFGWYIs27sMvi8SMGV/p/SRBE12/p4IXudqpr3y
         1PLS9vEiUlk0uf0x3R5hva15MlT0nhjYOMAIcolVd0kbZuvc3u5dUcvydr06H3n+iCLJ
         DQ+SU0o++mJAXWXZ1ycgbBllQL2gv2qJbVXgRq6OM76kmLSLWBE/P92IVeck706Ctfwc
         P9yhkdKurB7OIlaHrf1/jglnUM7gPLgXlRBMnHVaSz0PHGX4zrCLAmDWp/9vc4jpXssa
         Tgs9Ohl+Dp5X2En9FTF8elXPtKUXiyeE5gmX4MRGy+gyHoljCkB15zIyWnlc5fpOiHYo
         XEqA==
X-Gm-Message-State: AMCzsaVo9MPDo6vmq4TjbmUvT/AYlecFd1T44VVo1RRfY0cfcRNfbWEk
        iQ8T/iJBqsQYv2j/9PwWL9bIOqkO
X-Google-Smtp-Source: ABhQp+Ql5YpjZFKNSrWvf2GlT/Ed4iYDB13Q4ZHNC2dpCZBYDb4Lt4GwzoY8E5RvR1ThhsMcf+oIUw==
X-Received: by 10.55.197.20 with SMTP id p20mr597475qki.229.1508891009958;
        Tue, 24 Oct 2017 17:23:29 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id o27sm1102092qkh.80.2017.10.24.17.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Oct 2017 17:23:28 -0700 (PDT)
Subject: Re: [PATCH 1/8] SOC: brcmstb: add memory API
To:     Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-2-git-send-email-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a83617d0-8506-7fe4-2870-d9dbd9ffdb3f@gmail.com>
Date:   Tue, 24 Oct 2017 17:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1508868949-16652-2-git-send-email-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hi Jim,

On 10/24/2017 11:15 AM, Jim Quinlan wrote:
> +#elif defined(CONFIG_MIPS)
> +int brcmstb_memory_phys_addr_to_memc(phys_addr_t pa)
> +{
> +	/* The logic here is fairly simple and hardcoded: if pa <= 0x5000_0000,
> +	 * then this is MEMC0, else MEMC1.
> +	 *
> +	 * For systems with 2GB on MEMC0, MEMC1 starts at 9000_0000, with 1GB
> +	 * on MEMC0, MEMC1 starts at 6000_0000.
> +	 */
> +	if (pa >= 0x50000000ULL)
> +		return 1;
> +	else
> +		return 0;
> +}
> +#endif

We may be missing an EXPORT_SYMBOL_GPL(brcmstb_memory_phys_to_addr_memc)
here?

Thanks!
-- 
Florian
