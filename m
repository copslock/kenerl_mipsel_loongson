Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 12:52:57 +0200 (CEST)
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36784 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990521AbcIAKwpaazDD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 12:52:45 +0200
Received: by mail-lf0-f47.google.com with SMTP id g62so57420841lfe.3
        for <linux-mips@linux-mips.org>; Thu, 01 Sep 2016 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=LDUxP3a0mzov0hTCIDAk6/+9mphDrvcYN1X6Mf9sRT4=;
        b=YFX1RBRNUHL5bBgVRpbMwXE9qwzHJf4IWd9hSMtQ6ibh7RW3SZditLBCnVKOfr/1O8
         C5NE0Cd/tfiPnetbWEBdGWBvY9Z/ZTxD//EHyOIZ/URM4cJM8LhSp8LlAT+YiaiK/7rT
         gnu8cl5d19xJjdxezL5S2EOVLN1kcx7ukCLiE47WP66DXtpSK57CVgaaY9nAXjLj0mm9
         oD49ExuU5ux77E9kl1BPECk8Y15qNxuAv5LjbDsW4x7E11RPOuN/gk1KFwK5W7QiZHjt
         RcLGP9ay0TZk+7oXG7GbbsSSsVcRwOHyWspB7hBm/FoUIWY+JXp2DJXM3KaVP3Kmmni4
         tvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=LDUxP3a0mzov0hTCIDAk6/+9mphDrvcYN1X6Mf9sRT4=;
        b=ANWT+j2nX6Hq+zb5Ml2MyZ+WjbmSGnSI1FWFb0Qng/sMCiNyrSzTPUeRJrdCCH6NLs
         Zh/Gz27V3qc2RxP+6oSDtenL/pwAzGmsl2KLgtknoHXSRdzdy5btF2dZWopNpYpr+P7q
         Qf2qy0Rt1FKd36l6Bvxz2rq0v/Ra28p3whfqjIaTaPWBUz5r3gKSEO4apoMnfMva9iWG
         XLr5C6uQ9eGdQFGmqoc304F2Cf1H/Kk/a2DLMDytHnshrSL4fUwdhgweyvg2AabIhNLE
         aIqqV/sJ9NDq8Hd7T5+b/r/Psw8VqE8Kjfk6aWgTAoevNit4yDV1uWQj6hvHtAmoroZl
         OtWQ==
X-Gm-Message-State: AE9vXwMejVYe5rcyGaQTJOgvQouOU3Vnak2Hw7sEd59hc4x8pDxf2UGdMCSwK7MN0hpVtA==
X-Received: by 10.25.215.220 with SMTP id q89mr998698lfi.30.1472727159902;
        Thu, 01 Sep 2016 03:52:39 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.81.49])
        by smtp.gmail.com with ESMTPSA id u70sm801394lja.15.2016.09.01.03.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 03:52:38 -0700 (PDT)
Subject: Re: [Patch v3 08/11] net: ethernet: xilinx: Generate random mac if
 none found
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com
References: <1472661352-11983-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472661352-11983-9-git-send-email-Zubair.Kakakhel@imgtec.com>
Cc:     soren.brinkmann@xilinx.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, michal.simek@xilinx.com,
        netdev@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <3e2dea83-ee59-2980-3a9d-50da04271158@cogentembedded.com>
Date:   Thu, 1 Sep 2016 13:52:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472661352-11983-9-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54917
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

On 8/31/2016 7:35 PM, Zubair Lutfullah Kakakhel wrote:

> At the moment, if the emaclite device doesn't find a mac address
> from any source, it simply uses 0x0 with a warning printed.
>
> Instead of using a 0x0 mac address, use a randomly generated one.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
[...]

> diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> index 3cee84a..22e5a5a 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> @@ -1134,8 +1134,10 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
>  	if (mac_address)
>  		/* Set the MAC address. */
>  		memcpy(ndev->dev_addr, mac_address, ETH_ALEN);
> -	else
> -		dev_warn(dev, "No MAC address found\n");
> +	else {
> +		dev_warn(dev, "No MAC address found. Generating Random one\n");
> +		eth_hw_addr_random(ndev);
> +	}

    All branches of the *if* statement should have {} if at least one has 
them, see Documentation/CodingStyle, chaoter 3.

[...]

MBR, Sergei
