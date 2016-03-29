Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2016 03:38:27 +0200 (CEST)
Received: from mail-oi0-f44.google.com ([209.85.218.44]:32794 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007881AbcC2BiZuId7j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2016 03:38:25 +0200
Received: by mail-oi0-f44.google.com with SMTP id d205so2335669oia.0;
        Mon, 28 Mar 2016 18:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ZmWQH34/xpImXocnhP4n2pI294qJyBKZqlDO1Uooxps=;
        b=IlD+Q1QSs22jYZdsLogZiLXpgs3l2X9zILnBwIKx28NhMQSS1nn3bvcI+7lqIQHN+j
         ZMfYppfXBhHaha+hF8EVqsU9OKnEf6mNq9yWAo2EdxUpT7f7F4OVNtrWnSIvSxmjFy6r
         zBemf+SWExV7wKFJb0Z9gNZS0QgOiadimKJQhsRXW8IaF7i8YMMXHzmDV05p8Ikb5FNX
         t+kntm3qflIN8Sn/2/YDCfVX9xihYWis2/GkDeTDt5/mkGQALRCJagLVwZ4+JM4c0tOq
         AH/F5g/rOgHaDpnUDcNCty0xzJnYATs6y4M+asV7LCa8LUqwfx7jsJxP4N6eYX4I/qR+
         DB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ZmWQH34/xpImXocnhP4n2pI294qJyBKZqlDO1Uooxps=;
        b=cJ27RXt7L6QCjzCmsmD/FaD2VebLujrVBp4NZTTIbQobnRVFWqkmoeEJwG4BJx6mr3
         1XDikJ964R9FIpIYWlH1DI4bhIe43uFz9ToAHL7P9spw+QE9us2ZcW6x4I3Y8s5e1S4E
         PP55xb3ebPcTPE2nKL7XXBZaNhJfWGyPd02ENslLtPrBi1Qd6uOJenTlaLmo7QCIJpoG
         RBV6OcuhHLH2uK92foMnlRh9JmnSvwaF3AWKzb7Bui++E2iwbxg1EkCmr6kozQUJFeL7
         Xk539vJqVaZHrTgZufEhdej3Ne9CYFNpGTsGAqVh79+WLusy0pWfIaQIWwnzaed/cZwc
         UKEQ==
X-Gm-Message-State: AD7BkJIq37iSQLaK/lJoEXjs9DddFd6vThckSmHW3nVAk24ft1YcoHetjSQRYmFt/FMXJw==
X-Received: by 10.157.29.143 with SMTP id y15mr14104180otd.114.1459215500004;
        Mon, 28 Mar 2016 18:38:20 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:2903:38c6:7796:9ae1? ([2001:470:d:73f:2903:38c6:7796:9ae1])
        by smtp.googlemail.com with ESMTPSA id tr6sm8853137obb.18.2016.03.28.18.38.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2016 18:38:19 -0700 (PDT)
Subject: Re: [PATCH 0/6] MIPS: BMIPS: RIXI and workarounds support
To:     linux-mips@linux-mips.org
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, pgynther@google.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56F9DC8A.5080802@gmail.com>
Date:   Mon, 28 Mar 2016 18:38:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52717
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

Le 09/02/2016 12:55, Florian Fainelli a écrit :
> Hi all,
> 
> This patch series contains some workarounds for some bug with pref30 on
> Broadcom BMIPS5000 CPUs in 7344, 7346 and 7425 chips, and some other changes
> to allow the use of RIXI/rotr on BMIPS4380 and BMIPS5000.
> 
> Finally, the last patch adds a debugfs entry for current_cpu_data.options since
> it might be useful to debug that at a time where we set on the final CPU
> options.
> 
> This is on top of mips-for-linux-next as of
> a13d2abd8e617a96d235c0a528a742b347650853 ("MIPS: highmem: Turn
> flush_cache_kmaps into a no-op.")

Ralf, patches 2-5 have been marked accepted in patchwork, but I am not
able to find them in mips-for-linux-next, have they been merged some
place else? Thanks

> 
> Thanks!
> 
> Florian Fainelli (6):
>   MIPS: BMIPS: Disable pref 30 for buggy CPUs
>   MIPS: BMIPS: Add early CPU initialization code
>   MIPS: Allow RIXI to be used on non-R2 or R6 cores
>   MIPS: Move RIXI exception enabling after vendor-specific cpu_probe
>   MIPS: BMIPS: BMIPS4380 and BMIPS5000 support RIXI
>   MIPS: Expose current_cpu_data.options through debugfs
> 
>  arch/mips/Kconfig                    |  7 +++
>  arch/mips/bmips/setup.c              | 17 +++++++
>  arch/mips/include/asm/bmips.h        |  1 +
>  arch/mips/include/asm/pgtable-bits.h | 11 ++---
>  arch/mips/kernel/cpu-probe.c         | 41 ++++++++++++-----
>  arch/mips/kernel/smp-bmips.c         | 87 ++++++++++++++++++++++++++++++++++++
>  arch/mips/mm/tlbex.c                 |  2 +-
>  7 files changed, 150 insertions(+), 16 deletions(-)
> 


-- 
Florian
