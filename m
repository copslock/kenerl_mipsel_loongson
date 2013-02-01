Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Feb 2013 12:43:31 +0100 (CET)
Received: from mail-ee0-f51.google.com ([74.125.83.51]:57287 "EHLO
        mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823006Ab3BALnaRF5qA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Feb 2013 12:43:30 +0100
Received: by mail-ee0-f51.google.com with SMTP id d17so1953433eek.38
        for <multiple recipients>; Fri, 01 Feb 2013 03:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=uL9nf2wGosgLxRR+90O3khs/nH0F3kP8OJKLggGUJyM=;
        b=NIAd1Z6eUEhGt3PHmK9G9jHHChVWrJFhfBD2n2XsexEiWYplX9NYfPGeALWPl2HYTA
         YP66ekSZiqgzPhTdqkUZQPQrIi3/QTwdaIUZtbGWhZC8ppTjaGejjZ4vakiRfMpP77fx
         njroihDQeKAWkr1GbXTSbyiKFl5bAjt0H44vTkoIT1N2opQNXL6WwA/vfUdZt7bgcclO
         WlMMYfGpBv9Dahlf6zcLV2HOc+EDNj1gbbF+o6sy6D/J+YbV8Kr/d85RNzVyuu6w0ocA
         geQT+nb9NGgx9iRA3YqGcqxyoL6A5Is88Xw6DgPrjNSgEgedI0PwbrL7x4wkJHNzHX/6
         PlnA==
X-Received: by 10.14.1.195 with SMTP id 43mr38441280eed.31.1359719004135;
        Fri, 01 Feb 2013 03:43:24 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id q42sm2875303eem.14.2013.02.01.03.43.22
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Feb 2013 03:43:23 -0800 (PST)
Message-ID: <510BA9AF.9030905@openwrt.org>
Date:   Fri, 01 Feb 2013 12:40:31 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 00/10] MIPS: ralink: adds support for ralink platform
References: <1359633561-4980-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1359633561-4980-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35675
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

Hey John,

On 01/31/2013 12:59 PM, John Crispin wrote:
> This series adds support for the ralink SoC family. Currently RT305X type
> SoC is supported. RT2880/3883 are in my local queue already but require
> further testing.

One last thing, I think Ralf wants a defconfig for this new platform as 
well. Thanks!
--
Florian
