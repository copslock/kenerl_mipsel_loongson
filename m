Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2017 03:42:43 +0100 (CET)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:35519
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993920AbdBACmgA2UaG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2017 03:42:36 +0100
Received: by mail-pg0-x244.google.com with SMTP id 204so32689474pge.2;
        Tue, 31 Jan 2017 18:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=JXRbVUlc1enZwOV2cxef4Ots7xV6DDQmuOMSsxIgZtM=;
        b=oGPaQndq14aBNKkov964UfG1egttdGOfsNi37o+sRI8Qq29YXRAO++lZ+tbB43CDbr
         1ORi0YXjrzJ7PYFyKA93MgIacTn7hZMpt5hXlrjnKJcCyHQU/lv0/FNXPtJ69PoapqkD
         wFsWw1LjnJR0bJev7UjOY7Wmh0qYPF30R9XEfwHlKiMeNrxWFDrOXnrLe8u2xJTcD0qP
         CnvNBFd/9ZQsNqHWVstp4+/fB6+eclVd2A4KI6I54g6eQSQQaOgzzsdhG0SIBuG87XxD
         zfQmP5rzC+Re+nzVMkGBkryDNtpmh/7itMkpCHccAxb88n3z+uxquvCLQmHKRInTfClM
         xMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=JXRbVUlc1enZwOV2cxef4Ots7xV6DDQmuOMSsxIgZtM=;
        b=BoOLAnCGAiEXNtAKwcsmALGqRS7J+kTEqhbpIEqnbS+jZu/I6UmDOYRKP/Lp8vZ1zy
         TbdWN93ULRMr1/fYUSExYtEhqHl8A+Fr4AOAW7tbSjdCWXQ91rR2y4CSMSD1KhaXPxq4
         zz9dzV5NcjHwoDgPXqkCmkjsZDeVeXeQnKUH4wLOc8L12yqkBuMbH8OKlbX1kUgGxuzm
         KBE7ZbIz2Ydg+cPBogt5CCHYJrSaIA1qdNsp8G0zpavqcNI3RV1EqQaEzZf99Z4VBN3W
         UoiJg68aHp6x/a53lH3LgJm/aXOLtRkty4rFDF/7Dr9I8upWQuAoDQy5VF/+pTdWpiDW
         aCPA==
X-Gm-Message-State: AIkVDXIxYu4lcUTw5aznCA19u+HEqgLLAnze04KmEyY5POfQQMuZ0hePvXEbjKuZ8tPrIA==
X-Received: by 10.99.164.18 with SMTP id c18mr769516pgf.40.1485916950054;
        Tue, 31 Jan 2017 18:42:30 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id w25sm44655859pge.9.2017.01.31.18.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jan 2017 18:42:29 -0800 (PST)
Subject: Re: [PATCH 4.10-rc3 00/13] net: dsa: remove unnecessary phy.h include
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-mips@linux-mips.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20170118001403.GJ27312@n2100.armlinux.org.uk>
 <20170131191704.GA8281@n2100.armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jiri Slaby <jirislaby@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Timur Tabi <timur@codeaurora.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <woojung.huh@microchip.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <cf02354e-bec8-4429-9db4-bb20e262a2e8@gmail.com>
Date:   Tue, 31 Jan 2017 18:42:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170131191704.GA8281@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56568
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

On 01/31/2017 11:17 AM, Russell King - ARM Linux wrote:
> Including phy.h and phy_fixed.h into net/dsa.h causes phy*.h to be an
> unnecessary dependency for quite a large amount of the kernel.  There's
> very little which actually requires definitions from phy.h in net/dsa.h
> - the include itself only wants the declaration of a couple of
> structures and IFNAMSIZ.
> 
> Add linux/if.h for IFNAMSIZ, declarations for the structures, phy.h to
> mv88e6xxx.h as it needs it for phy_interface_t, and remove both phy.h
> and phy_fixed.h from net/dsa.h.
> 
> This patch reduces from around 800 files rebuilt to around 40 - even
> with ccache, the time difference is noticable.
> 
> In order to make this change, several drivers need to be updated to
> include necessary headers that they were picking up through this
> include.  This has resulted in a much larger patch series.
> 
> I'm assuming the 0-day builder has had 24 hours with this series, and
> hasn't reported any further issues with it - the last issue was two
> weeks ago (before I became ill) which I fixed over the last weekend.
> 
> I'm hoping this doesn't conflict with what's already in net-next...

For the entire series:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks a lot for doing that.

> 
>  arch/mips/cavium-octeon/octeon-platform.c             | 4 ----
>  drivers/net/dsa/mv88e6xxx/mv88e6xxx.h                 | 1 +
>  drivers/net/ethernet/broadcom/bgmac.c                 | 2 ++
>  drivers/net/ethernet/cadence/macb.h                   | 2 ++
>  drivers/net/ethernet/cavium/liquidio/lio_main.c       | 1 +
>  drivers/net/ethernet/cavium/liquidio/lio_vf_main.c    | 1 +
>  drivers/net/ethernet/cavium/liquidio/octeon_console.c | 1 +
>  drivers/net/ethernet/freescale/fman/fman_memac.c      | 1 +
>  drivers/net/ethernet/marvell/mvneta.c                 | 1 +
>  drivers/net/ethernet/qualcomm/emac/emac-sgmii.c       | 1 +
>  drivers/net/usb/lan78xx.c                             | 1 +
>  drivers/net/wireless/ath/ath5k/ahb.c                  | 2 +-
>  drivers/target/iscsi/iscsi_target_login.c             | 1 +
>  include/net/dsa.h                                     | 6 ++++--
>  net/core/netprio_cgroup.c                             | 1 +
>  net/sunrpc/xprtrdma/svc_rdma_backchannel.c            | 1 +
>  16 files changed, 20 insertions(+), 7 deletions(-)
> 


-- 
Florian
