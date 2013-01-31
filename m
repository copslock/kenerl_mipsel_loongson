Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 13:59:53 +0100 (CET)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57960 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823555Ab3AaM7wXmYAQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jan 2013 13:59:52 +0100
Received: by mail-wi0-f178.google.com with SMTP id hn3so2748473wib.11
        for <multiple recipients>; Thu, 31 Jan 2013 04:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=z232m/0O7xHKvfRjLEJ+X0rLc3wVtUmCSlRW3GS15Hc=;
        b=U7BSJIlpcD0FNWoyxC3WyX/pGvqpCycC72RxjyK8Wkycj3oCjH0xtqXDJa3hhYxlEC
         +MduSmjX2YWcerejHEtrrsETaj9nIGLwxNmWkAWQzT6MmZXD3dzZt2sdiQLaskhP963p
         RgyhRxPTMRK/qgmpWiEpABRy5Mpo+SIBC2hSeHidkFKzwjxZ+/ltHMx30JVVjjjo81jy
         ji7F81bLOnK67N7eZlf4W840ls4l8s3Yq4U5w1rZea5udnrTSIvC7SFaNzy/9+lKjAhq
         tRiM6KFteFQUKOw9pQdC7Q0sCMfSagLVEmUXEKL6s84+ewQ2eLTOULPiyh/tIgr0SygL
         QraA==
X-Received: by 10.194.59.40 with SMTP id w8mr15290843wjq.51.1359637187004;
        Thu, 31 Jan 2013 04:59:47 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id q13sm2994647wie.0.2013.01.31.04.59.45
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 04:59:46 -0800 (PST)
Message-ID: <510A6A17.5050003@openwrt.org>
Date:   Thu, 31 Jan 2013 13:56:55 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 10/10] MIPS: ralink: adds Kbuild files
References: <1359633561-4980-1-git-send-email-blogic@openwrt.org> <1359633561-4980-11-git-send-email-blogic@openwrt.org>
In-Reply-To: <1359633561-4980-11-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35654
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

Hello John,

On 01/31/2013 12:59 PM, John Crispin wrote:
[snip]
>
>   config MIPS_L1_CACHE_SHIFT
>   	int
> -	default "4" if MACH_DECSTATION || MIKROTIK_RB532 || PMC_MSP4200_EVAL
> +	default "4" if MACH_DECSTATION || MIKROTIK_RB532 || PMC_MSP4200_EVAL || RALINK_RT288X

I got slightly confused here because this is actually ok, RALINK_RT288X 
should have MIPS_L1_CACHE_SHIFT=4, but rt305x and rt3883 have 
MIPS_L1_CACHE_SHIFT=5. So I would drop this hunk until you add support 
for rt288x.
--
Florian
