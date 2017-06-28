Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 06:46:14 +0200 (CEST)
Received: from mail-oi0-x22d.google.com ([IPv6:2607:f8b0:4003:c06::22d]:36380
        "EHLO mail-oi0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990507AbdF1EqIMAHkr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jun 2017 06:46:08 +0200
Received: by mail-oi0-x22d.google.com with SMTP id p187so33133887oif.3;
        Tue, 27 Jun 2017 21:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P+5VutI8069Shola2m15CEXrtTsZzYut++aP7GOT8YM=;
        b=vYTn2DJ+dkM6j8b/nF+Z+3oEIdbl5rkg5PSWH0omJoWcnEblb7fF1UP3ZhBfjnVjOT
         4OUGPkI2kk0wmXbVKohH3JldPBmWnnOFhvFTiknFe/wOTh8is4QJbyTT6gyGiXZkxl84
         wGSiXpf+FOFvHWsnvXx00jMCwuLZ1Ck4SVAteeVwwJbLAr+I/ItjeNTIuZa60ZU7w8S/
         3Tnv+JH3cApMkJDDSNNLKywZd65RyMAmU8MCp4v5w6TACxCLpBfXXDKX4df90V0kFP4q
         KuHMOYC6rmASK24FJm6X2iaq4FzNEjecZgBSgFRX2XCZMdwr5YdeNroj8Tp2F1z34z0e
         hhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P+5VutI8069Shola2m15CEXrtTsZzYut++aP7GOT8YM=;
        b=fcymaiN/4/alaz8w1Q5K3AvjN1wxVt6aeaK1BMextEA994lWi+2vA25jL+6fEHfyKD
         nRQG27oQCIuWeeTGgFuMFgP96E7+zt1cPgDSevbrX1d1OjRjQHt9+LRF9YhegzH8HE7c
         ZZ/29hC2PKTxJueNWxHl8f+WI6sTyW1nPg/+/f0+ziDmwIv6Yg2VEHjs2JL0JBIjTfBT
         CdSW9RlkcXlaBCFqK76cizbK6vA9dmvPirpxtHupDLblr1y6KDHfavxgypMwY4lbNdu0
         aMiyyMDOHyg+6dv0gjrXQoa/LFEsSJsJJVicNqonFf9blxjKJ5s8Mpp0H847tN0nbmrs
         N98g==
X-Gm-Message-State: AKS2vOwR94b+itQPE/HEE0oEr2uZhvOSDS+HPbjnQ8lLlwcKDcxBieUq
        C3oTUidC8dTRbg==
X-Received: by 10.202.72.201 with SMTP id v192mr5933672oia.131.1498625162363;
        Tue, 27 Jun 2017 21:46:02 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:f0ca:11e0:f71b:a806? ([2001:470:d:73f:f0ca:11e0:f71b:a806])
        by smtp.googlemail.com with ESMTPSA id o8sm1629518oig.7.2017.06.27.21.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 21:46:01 -0700 (PDT)
Subject: Re: BC47xx build errors
To:     Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
References: <20170627231629.GA5049@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0acf4ff1-c5b8-adb7-14c1-75a3c56b5164@gmail.com>
Date:   Tue, 27 Jun 2017 21:46:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170627231629.GA5049@linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58843
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

On 27/06/2017 16:16, Ralf Baechle wrote:
> A less than smart build test system has flagged the following build error:
> 
>   CC      arch/mips/bcm47xx/irq.o
> In file included from arch/mips/bcm47xx/irq.c:32:0:
> ./arch/mips/include/asm/mach-bcm47xx/bcm47xx.h:34:1: error: expected identifier
> +before
> +‘}’ token
>  };
> 
> I don't have any .config or anything for this error.  While trying to
> reproduce this error I tried to build bcm47xx_defconfig but with
> CONFIG_BCM47XX_SSB and CONFIG_BCM47XX_BCMA disabled.  That resulted in
> the following build error:

I am not sure if we should define an invalid bus type enum value just to
avoid creating an empty enum or simply making sure that neither
CONFIG_BCM47XX_SSB nor CONFIG_BCM47XX_BCMA can be disabled with
CONFIG_BCM47XX, as clearly this would not result in a functioning
kernel, Rafal, Hauke, thoughts?

> 
>   CC	  arch/mips/bcm47xx/irq.o
> In file included from arch/mips/bcm47xx/irq.c:32:0:
> ./arch/mips/include/asm/mach-bcm47xx/bcm47xx.h:34:1: error: empty enum is
> +invalid
>  };
>  ^
> scripts/Makefile.build:302: recipe for target 'arch/mips/bcm47xx/irq.o' failed
> make[1]: *** [arch/mips/bcm47xx/irq.o] Error 1
> Makefile:1663: recipe for target 'arch/mips/bcm47xx/irq.o' failed
> 
>   Ralf
> 
