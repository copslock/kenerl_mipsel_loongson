Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 01:19:54 +0200 (CEST)
Received: from mail-ob0-f173.google.com ([209.85.214.173]:32812 "EHLO
        mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025747AbcC2XTwnhKd4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 01:19:52 +0200
Received: by mail-ob0-f173.google.com with SMTP id x3so33760193obt.0;
        Tue, 29 Mar 2016 16:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0/nRHkgnKg5LbVXXVvoXbhoBbah5a7uVRdx2DcIGBmM=;
        b=w5o5t2wEZ2ZyjsXfW8Gvfgt+NhFKIUBrvGHz749XyiKF/zwRfvUEWv4N/HHoHXmgR9
         K74TCmaah+t/DG7oSI35SyYGzTpt/gw6mdREog135SilkrId6QGKnXEjeewbNMXshX20
         LHfE9vJv1ET93G8pMvQk+VkRqdr+c0Luq8ZS5UHstmJWcWWpyhoM65ogItaYPYYZ57YB
         +Rlu2n+2vLIfx1DgCMj/02jAD+C46WfD7uE16YKp1pEIFEQNPnRY1tBXhAe0yJLxbG89
         b0RDFGwvc45J5r9IJMFCsgDbTCA0UQ+GLU/ossMNjSktepty/mtBUHoQbreyXnELiBxw
         NntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0/nRHkgnKg5LbVXXVvoXbhoBbah5a7uVRdx2DcIGBmM=;
        b=fr57wE3ftgco9W8z0klyIqWxyJPaoQBhqsnECYi3zcvuulh8e56wY4fpGQUqwwELny
         FR78zpznRayjd8pWEBfkHmak7FvQejCl+0Mkx1PMJGgMFLGWUgLIpw8CUBI/JMYjOSZD
         MCrAHkKlh29VbMSbqFvUD3ZhAxzOSaE3QCdrMGjRFnapXy77S0BT6LGzKDIKqLhEEus1
         FVPLdZSUf/rrpL1sL3RjHnPLi2CX/fSWSNrFqwx3nJ6m2vsto511OIFC+vvJIn4De5+I
         bYZuqtcyqT8L3UYUPU4bdd3byhkAEpKzs8qlwGk45V6GMg2+EvjZMHeuxz/hL2a99ue+
         zmCQ==
X-Gm-Message-State: AD7BkJIWrp/iIoeXrF3uVfrr2I17HpU5x7waFHNYEKk7+Lep1PFqk29FnDnagy+EnPP0+g==
X-Received: by 10.60.142.230 with SMTP id rz6mr2649134oeb.5.1459293586673;
        Tue, 29 Mar 2016 16:19:46 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:df8:552c:372a:790f? ([2001:470:d:73f:df8:552c:372a:790f])
        by smtp.googlemail.com with ESMTPSA id y66sm376776oif.20.2016.03.29.16.19.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2016 16:19:45 -0700 (PDT)
Subject: Re: [PATCH v2 03/15] MIPS: PCI: Compatibility with ARM-like PCI host
 drivers
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
 <1454499045-5020-4-git-send-email-paul.burton@imgtec.com>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        Yijing Wang <wangyijing@huawei.com>,
        John Crispin <blogic@openwrt.org>,
        Yinghai Lu <yinghai@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56FB0D90.8000200@gmail.com>
Date:   Tue, 29 Mar 2016 16:19:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1454499045-5020-4-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52732
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

Le 03/02/2016 03:30, Paul Burton a écrit :
> Introduce support for struct hw_pci & the associated pci_common_init_dev
> function as used by the PCI drivers written for ARM platforms under
> drivers/pci. This is in preparation for reusing the xilinx-pcie driver
> on the MIPS Boston board.
> 
> Platforms that make use of this more generic code will need to select
> CONFIG_MIPS_GENERIC_PCI. Platforms which don't will continue to work as
> they have, with the intent that PCI drivers be migrated towards struct
> hw_pci & drivers/pci/ over time.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---

[snip]

> +		if (hw->preinit)
> +			hw->preinit();
> +
> +		ret = hw->setup(i, &ctl->sysdata);
> +		if (ret < 0) {

This needs to be ret <= 0 to be compliant with what ARM PCI host
controllers do, which is return 1 in case they could get hw->setup to
finish with success, and 0 or negative if they could not, see
arch/arm/kernel/bios32.c.
-- 
Florian
