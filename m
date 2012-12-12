Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 15:28:20 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:47264 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823690Ab2LLO2UCT1Tn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 15:28:20 +0100
Received: by mail-lb0-f177.google.com with SMTP id n10so687229lbo.36
        for <multiple recipients>; Wed, 12 Dec 2012 06:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZO80q6H/TycvM7quSLIZGrZ8Az43BzdUC+OnBkV56Fg=;
        b=jeb+8Rer72WLHklfLTnfoG+zXJq5As2QJVH4T8MgrpdmksgmSWbrG7f1/YERZcxUk0
         U6JWvheA2WOe7CMKsXQkDfR6Bl2V/UE0ivTtTMqmTkKoeQXzjPVOFMGxrxwOxzuOAgPR
         WoOhlZ7yYxK3nDcW+A6FrxjC7VdSFpNW+EHcG1wUtsgvT2Kt+dKSJYPdMN2gg6nJOJv5
         mrHHoXgUt23GVFxfV6qKCwt1kt3kJY4xTHQsGywh48VYedc++9bNQklEJbk3pFh/r0M0
         xWT2oLzVwdfIPzIFvTRMwO61Wjxhl8f57jeCw/evEE0hmXQY3bQjfXZnMGW6rohWdJEE
         +RFQ==
Received: by 10.112.23.234 with SMTP id p10mr535181lbf.35.1355322494212;
        Wed, 12 Dec 2012 06:28:14 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id pg5sm9306249lab.6.2012.12.12.06.28.13
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 06:28:13 -0800 (PST)
Message-ID: <50C89401.70705@openwrt.org>
Date:   Wed, 12 Dec 2012 15:26:09 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Make CP0 config registers readable via sysfs.
References: <1354858280-29576-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1354858280-29576-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35259
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

Le 12/07/12 06:31, Steven J. Hill a écrit :

[snip]

> +
> +#define __BUILD_CP0_SYSFS(reg)					\
> +static DEFINE_PER_CPU(unsigned int, cpu_config##reg);		\
> +static ssize_t show_config##reg(struct device *dev,		\
> +		struct device_attribute *attr, char *buf)	\
> +{								\
> +	struct cpu *cpu = container_of(dev, struct cpu, dev);	\
> +	int n = snprintf(buf, PAGE_SIZE-2, "%x\n",		\
> +		per_cpu(cpu_config##reg, cpu->dev.id));		\
> +	return n;						\
> +}								\
> +static DEVICE_ATTR(config##reg, 0444, show_config##reg, NULL);
> +
> +__BUILD_CP0_SYSFS(0)
> +__BUILD_CP0_SYSFS(1)
> +__BUILD_CP0_SYSFS(2)
> +__BUILD_CP0_SYSFS(3)
> +__BUILD_CP0_SYSFS(4)
> +__BUILD_CP0_SYSFS(5)
> +__BUILD_CP0_SYSFS(6)
> +__BUILD_CP0_SYSFS(7)
> +
> +static void read_c0_registers(void *arg)
> +{
> +	struct device *dev = get_cpu_device(smp_processor_id());
> +	struct cpu *cpu;
> +	int ok;
> +
> +	if (dev != NULL) {
> +		cpu = container_of(dev, struct cpu, dev);
> +		per_cpu(cpu_config0, cpu->dev.id) = read_c0_config();
> +		device_create_file(dev, &dev_attr_config0);
> +		ok = per_cpu(cpu_config0, cpu->dev.id) & MIPS_CONF_M;
> +	} else

Is there any reason you are not using a macro here too?
--
Florian
