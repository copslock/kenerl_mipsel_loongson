Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 18:26:47 +0100 (CET)
Received: from mail-ee0-f44.google.com ([74.125.83.44]:34253 "EHLO
        mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834936Ab3CUR0qUORsB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Mar 2013 18:26:46 +0100
Received: by mail-ee0-f44.google.com with SMTP id l10so1927018eei.3
        for <multiple recipients>; Thu, 21 Mar 2013 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2YaqigO9zcOhaPBPxPHWbCNl+FM+klK6ASvzlrCNnl4=;
        b=Omo3kxJvBOJMXDfWe0qiy0YqdileoPYFaCOKiTkC8NL/E+m6f7SYLxP4VcLdqzckv1
         zEPOYZdIEol5mkS7zFGAam+Q1Wj016DM1HrWu2TUT3ImkFyNchlki3RSB6fjsncptXEm
         EJyX32km1aX5r2NpvaInHfWlKCqp7sq4QVNlUc0aMtdoOSif+6agEVUbsRmHzVdeDANY
         R3tZ2EOIWX3IDj5rLNRwa+ZQMKb3WAFFI927kR5B762g5zcRDLsrvMB7uUyv/2ry6dmI
         ehMZea/mIasntM8VmUahaOI0rF9VJKWSeKG5hAoZVHDnHZOzsCTzEnIGahA1RugBZLVJ
         RLGw==
X-Received: by 10.14.110.68 with SMTP id t44mr84289608eeg.25.1363886800845;
        Thu, 21 Mar 2013 10:26:40 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ec0d:4090:21c:f0ff:fe0c:2d8a? ([2a01:e34:ec0d:4090:21c:f0ff:fe0c:2d8a])
        by mx.google.com with ESMTPS id u44sm9685449eel.7.2013.03.21.10.26.38
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 10:26:39 -0700 (PDT)
Message-ID: <514B42CB.7020203@openwrt.org>
Date:   Thu, 21 Mar 2013 18:26:35 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 0/7] add basic support for BCM6362
References: <1363878001-4461-1-git-send-email-jogo@openwrt.org>
In-Reply-To: <1363878001-4461-1-git-send-email-jogo@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35937
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

Le 03/21/13 16:00, Jonas Gorski a écrit :
> This patchset adds basic support for BCM6362. BCM6362 includes a 9 port
> ethernet switch (4 FE PHYs, 2 RGMII ports), integrated wifi and one PCIe
> port.
>
> The first few patches do a bit of clean up first to allow the BCM6362
> support code to be as small as possible.
>
> Board definitions were left out as they are not really usable yet, and
> adding DT support is planned in the future. Most code added here will
> be also required with DT support.
>
> Jonas Gorski (7):
>    MIPS: BCM63XX: remove duplicate spi register definitions
>    MIPS: BCM63XX: fix revision ID width
>    MIPS: BCM63XX: rework chip detection
>    MIPS: BCM63XX: add basic BCM6362 support
>    MIPS: BCM63XX: enable SPI controller for BCM6362
>    MIPS: BCM63XX: enable pcie for BCM6362
>    MIPS: BCM63XX: add flash detection for BCM6362

For this serie:
Acked-by: Florian Fainelli <florian@openwrt.org>

Thanks Jonas!
--
Florian
