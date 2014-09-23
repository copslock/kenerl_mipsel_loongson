Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2014 23:09:47 +0200 (CEST)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:56732 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009643AbaIWVJpui1-N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2014 23:09:45 +0200
Received: by mail-ig0-f171.google.com with SMTP id hn15so5381445igb.16
        for <linux-mips@linux-mips.org>; Tue, 23 Sep 2014 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WALyKzb3L+te2PU/Iz08V3AI0bosoxZwzCKnMPxmobc=;
        b=X1En0iZq7qWOEy2v1IEWpj0mhfLcVnK4HAzLYa5cxEmQ6TKLHgQ+Kg9Yb5m+sysI5I
         AV15UnjLPTbSz05+5NAEf1NXUGxWNQUeCk+UtrPlDHruuXA3kdbwSe9V1eKVdgQe5xkM
         MlFDWLf/+xBMJmKzptsVL/wO+gg4t+JQiUBeO9PwaukXLH/isWY8fSjzlowBMTIYZFr9
         ql7QPmzK36p+Ad/mHFrNbtKoVf1CY327XRx3zRBdYJqHYVfWn70nVgy6fSZtOZrPlPoV
         +sXPKc5s/JXILD4uEz0xUhwNnFA71FipZJC9TBH0wqSNtchD7wREPJeXfx3uEx8mIUCi
         T5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WALyKzb3L+te2PU/Iz08V3AI0bosoxZwzCKnMPxmobc=;
        b=DGwKjrGL8fKM95QWWc1JnB6jgtmpPn8LHAuo9hqhlq9hYRdBlYdnMrlPiYHejZYXn9
         lgM72QCTQqxUgNRNzt8EYvRdOCmpjwGn/XSLM1H/3PUQ/1kyvRpUlhkR3ZeOobZiirDe
         xDQVnuyNDsmCYC6kHQUfeUz6Ro6qzm91AEsi3zfPvjnqkyJ/U+5DQm7s491lgxPynDAt
         3fubKoq7KGh7y/NNYSYx3ik6lUck9U8pWuKGJSwd61KlqaU8zZs5zxSP15LWIoEX7Bft
         VdzBnjbL4bokbjavkv3kX5p9TS8uicCcOjQw1X17yceCZMjcxTooPmwSS2XzxkDx6p8D
         MCJA==
X-Gm-Message-State: ALoCoQkl8Zc25XSgp7Lhj+LJ/onkRrfCq8E9tdRqOD+KNTzzBsFWYOWQbjsKoInF5U+y/z+E8nzi
X-Received: by 10.50.72.43 with SMTP id a11mr6874168igv.23.1411506579499;
        Tue, 23 Sep 2014 14:09:39 -0700 (PDT)
Received: from google.com ([172.16.50.66])
        by mx.google.com with ESMTPSA id ik8sm2795488igb.0.2014.09.23.14.09.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Sep 2014 14:09:38 -0700 (PDT)
Date:   Tue, 23 Sep 2014 15:09:36 -0600
From:   Bjorn Helgaas <bhelgaas@google.com>
To:     Yijing Wang <wangyijing@huawei.com>
Cc:     Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arch@vger.kernel.org, arnab.basu@freescale.com,
        Bharat.Bhushan@freescale.com, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v1 00/21] Use MSI chip to configure MSI/MSI-X in all
 platforms
Message-ID: <20140923210936.GC27117@google.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Fri, Sep 05, 2014 at 06:09:45PM +0800, Yijing Wang wrote:
> This series is based Bjorn's pci-next branch + Alexander Gordeev's two patches
> "Remove arch_msi_check_device()" link: https://lkml.org/lkml/2014/7/12/41
> 
> Currently, there are a lot of weak arch functions in MSI code.
> Thierry Reding Introduced MSI chip framework to configure MSI/MSI-X in arm.
> This series use MSI chip framework to refactor MSI code across all platforms
> to eliminate weak arch functions. It has been tested fine in x86(with or without
> irq remap).

I see you plan some updates, so I'll look for a v2 posting after v3.17 releases.
It will be great to get rid of some of those weak functions!

Bjorn
