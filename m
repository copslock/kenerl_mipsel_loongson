Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 20:13:09 +0100 (CET)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36148 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010921AbcARTNDH-u5a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 20:13:03 +0100
Received: by mail-oi0-f52.google.com with SMTP id o124so170760963oia.3;
        Mon, 18 Jan 2016 11:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=W29P92vNqxG/T5tt1NRRw/NyDOH/7AP2pd/jvhdwIC8=;
        b=j+BQH/VcZ/Bba0KPXyeMCpix6qw+O8xeXcZbQ1yVIwEMqmHpOYhQHu3ihjkmLihKkX
         cCq3A6+R7RXgvUaHsviAxmN+Rm/tyTZV3943kyTNh+AH9/hxrq7i8ZK6+PiXzFOHUxH8
         heqLHASvAj5uGxX65R1RnD/0MBKJo5pLYvcGPpU+law2Z6UDcuBgod3EBygNJeD7kNO3
         ktzU1a1olf8HAU/040bAvEFvQl+02f5P6tlc0D1MS5v26bTbnIuCov6Y67ZzMHjSL7H4
         FMpBuyuvM3w9mi4TGy0YK/tKNIengxBfGUkaM2pMS2iP9ehSa056Dbn6h+qVQCyy3SIE
         VeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=W29P92vNqxG/T5tt1NRRw/NyDOH/7AP2pd/jvhdwIC8=;
        b=ZvUhKBSQEutUONepO4p8py0yijXX7IrI75+VfUZo/XeyUGYqb8azK5ADeVLaFr5+x1
         sO7dOwDSC0Bc5ol3jLjS+wJyG5XYpB5YmhK0KpG8ZejIsQccoA7WDvtaKKe3AhI1x3C5
         CgMw/FCyAnMOQHS74hih9MIoVqjLCC4wyEmvVBNXet2iCP1kh0IFmUcoEiPhC36fBMKm
         6xzSkSxpT/cE/vVfr6+2e+MibTz6IzF3qTeTDH87jbmf438FYTeIZf3EQ+JOMkzLSWYC
         RGCJeALtO4n/FAKhiC58skH3xIHqScOVv3ehMVZK247nio4Z/V4bnFbgwWU4Z31fXmfL
         Ln9Q==
X-Gm-Message-State: ALoCoQlT8z6VQAjqbSEpHZFasojjjvgyhtyYqKVmf+zRAGyEhOnwHTpm1LyTsflfdOrPrpFe91e2beik+GVVpGBreCzN9JfV7g==
X-Received: by 10.202.94.67 with SMTP id s64mr19447464oib.65.1453144376780;
        Mon, 18 Jan 2016 11:12:56 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:3518:aff0:c491:7d67? ([2001:470:d:73f:3518:aff0:c491:7d67])
        by smtp.googlemail.com with ESMTPSA id z190sm13576707oig.25.2016.01.18.11.12.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jan 2016 11:12:56 -0800 (PST)
Subject: Re: [PATCH 2/2] bmips: improve BCM6368 device tree
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jogo@openwrt.org, cernekee@gmail.com
References: <1453024955-13570-2-git-send-email-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <569D3937.9000808@gmail.com>
Date:   Mon, 18 Jan 2016 11:12:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1453024955-13570-2-git-send-email-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51202
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

Le 17/01/2016 02:02, Álvaro Fernández Rojas a écrit :
> Adds brcm,bcm6358-leds node to bcm6368.dtsi
> Adds reboot support (syscon-reboot as defined in BCM6328)
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
