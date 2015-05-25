Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2015 15:10:08 +0200 (CEST)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33933 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012589AbbEYNKDYAMwH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2015 15:10:03 +0200
Received: by lbcmx3 with SMTP id mx3so51467014lbc.1
        for <linux-mips@linux-mips.org>; Mon, 25 May 2015 06:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=BgON4L4UExFYEYY0F8eh6dHuYIBfG8xcxvfQjnY6fPs=;
        b=P8aZ0Q+whejee8AS/g34GfmDdsGMCmWQX+HyI+toOU+VxErZA0K+AWzP44ppVSRyYv
         4w8PaL9coX6f0FWvdY4spgZDmWc5qzagk8ExGjzmzMpEc0gGFQEa/IRaIza6kriK1JPr
         fiOEBL8s+A1r2t8ZhE55Lji3oo0juMe5y8wVk3CwRE2z97hBDSCA6gPDUaKWBIdtJnG1
         4Mh6NQ2zR52qEMhI6RHS/jfT+YerRXQZLtPvRwpxjGtXCpxoasrWprpbhriYB4ndaz5N
         4J4u2+l7PlM4u7MEygnfKy6MhgNg93mHRWquIkDcdWnYxVXbkmOFiK2HnVGRYhv6WBlP
         sIWQ==
X-Gm-Message-State: ALoCoQl01s1dnKIyZehZLzCn/uk2JEgRRQaCzeo8I4F9kHolR25gBJzjiFJmFjaNB1S/QsiT54y0
X-Received: by 10.112.124.166 with SMTP id mj6mr18438014lbb.104.1432559400382;
        Mon, 25 May 2015 06:10:00 -0700 (PDT)
Received: from [192.168.3.154] (ppp31-148.pppoe.mtu-net.ru. [81.195.31.148])
        by mx.google.com with ESMTPSA id f4sm2360313lae.18.2015.05.25.06.09.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2015 06:09:59 -0700 (PDT)
Message-ID: <55631F26.6080108@cogentembedded.com>
Date:   Mon, 25 May 2015 16:09:58 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: MIPS: PCI: Add pre_enable hook, minor readability fixes
References: <5562B60D.3050507@gentoo.org>
In-Reply-To: <5562B60D.3050507@gentoo.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47649
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

On 5/25/2015 8:41 AM, Joshua Kinard wrote:

> From: Joshua Kinard <kumba@gentoo.org>

> This patch adds a hook "pre_enable", to the core MIPS PCI code.  It is
> used by the IP30 Port to setup the PCI resources prior to probing the
> BRIDGE and detecting available PCI devices.  It also adds some minor
> whitespace to improve readability.

> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
[...]

> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index b8a0bf5..af17c16 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
> @@ -261,14 +261,19 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
>   	u16 cmd, old_cmd;
>   	int idx;
>   	struct resource *r;
> +	struct pci_controller *hose = (struct pci_controller *)dev->sysdata;
>
>   	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>   	old_cmd = cmd;
> -	for (idx=0; idx < PCI_NUM_RESOURCES; idx++) {
> +	for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
>   		/* Only set up the requested stuff */
> -		if (!(mask & (1<<idx)))
> +		if (!(mask & (1 << idx)))
>   			continue;
>
> +		if(hose->pre_enable)
> +			if(hose->pre_enable(hose, dev, idx) < 0)

    Space required after *if*; please run your patches thru scripts/checkpatch.pl.

WBR, Sergei
