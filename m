Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 15:31:50 +0100 (CET)
Received: from mail-la0-f49.google.com ([209.85.215.49]:40677 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823690Ab2LLObuP71QP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 15:31:50 +0100
Received: by mail-la0-f49.google.com with SMTP id r15so660471lag.36
        for <multiple recipients>; Wed, 12 Dec 2012 06:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=L2ALDhU5foDbrLvL5LCUIbcMqDf5lZAe2Fk2Ul1YaeA=;
        b=S/PKhJYJNwFRTRYadm/ajD8QRySJJT3yU+ECi47XRMCXOKRuS6mkVVJfKhOUxXjXY+
         wrjFeoh/Nr96pNCv4YeXv9Lf8otuoOXJ2DZOfpuNykjCPPCCuh5zKbi8UwuMXjbuIvue
         jeuYaj6kA70P/hdm3i0JH/VXf1yMAPOlJGSwPk4mLcM+9BnZP6KJqS3pKLFGku6CYvrF
         I4o/Z+I4rk1WTcedkc73PwOnQWDtHfYUjFaqBZd7B5dFGNi72dJoReo/AykftF4UxYRQ
         aDk2srF7tWqvhH492+FfVRSCcm34iOcdi/9W+R5FreLAeKcCx+LqOW9ThikrwYUr1BXk
         C7xA==
Received: by 10.152.108.48 with SMTP id hh16mr1225514lab.25.1355322704645;
        Wed, 12 Dec 2012 06:31:44 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id v6sm10790757lbf.11.2012.12.12.06.31.43
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 06:31:44 -0800 (PST)
Message-ID: <50C894D4.4090008@openwrt.org>
Date:   Wed, 12 Dec 2012 15:29:40 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] OF: MIPS: sead3: Implement OF support.
References: <1354857297-28863-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1354857297-28863-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35260
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

Hello Steven,

Le 12/07/12 06:14, Steven J. Hill a écrit :
[snip]

> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "mips,sead-3";
> +
> +	cpus {
> +		cpu@0 {
> +			compatible = "mips,mips14Kc,mips14KEc";
> +		};

You probably want this the other way around:

mips14KEc,mips14Kc,mips

you should always have the left-most string being the most descriptive 
about the hardware and the last one being the less descriptive and thus 
less "specializing" in order to be backward compatible.

> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS1,38400 rootdelay=10 root=/dev/sda3";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x08000000>;
> +	};
> +};
>
