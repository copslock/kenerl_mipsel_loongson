Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Aug 2012 02:19:35 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:39291 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903551Ab2HRAT3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Aug 2012 02:19:29 +0200
Received: by ggnm2 with SMTP id m2so4781866ggn.36
        for <multiple recipients>; Fri, 17 Aug 2012 17:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=HeVSCK6a9vbgDbfGTnRJ0yIeIit422Pz1EDCxaYFeuw=;
        b=VyYZ85RXKPhEJwAIwKYjW62Pa4eJbwPML4MdZND+dHoZ4K4Jyl5t5JYzwc8VFd6tou
         P1NbITETPtsB4K1k3EQ72oVt1MCAjXOUHKJtFxdkmD87lmd1KBlF2crd/SYK8LOcNcll
         Z1MXmh+nGMbHzgz2yqlpMQy2eeFkVNUy6l2M6UdJoJx5sGr/GybmM2r80DwN9XW/j4lM
         sLV9Wy0INmI0Gxk2j36BKPKw93tqTjuxKnJ9G7c+Vb9mCtEDtJavy6Uged8+GrPd20Ts
         w6uDTULWZ5G2rZYbAIk7krctFTSaTso/heHPYswh1/4x/85swGh9J1ZDtuKxzMKCE1I0
         rUDg==
Received: by 10.236.110.209 with SMTP id u57mr11245637yhg.101.1345249163358;
        Fri, 17 Aug 2012 17:19:23 -0700 (PDT)
Received: from bd.yyz.us ([2001:4830:1603:2:21c:c0ff:fe79:c8c2])
        by mx.google.com with ESMTPS id y13sm8280801anj.5.2012.08.17.17.19.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 17:19:22 -0700 (PDT)
Message-ID: <502EDF87.4070402@pobox.com>
Date:   Fri, 17 Aug 2012 20:19:19 -0400
From:   Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     ralf@linux-mips.org, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/2] ata: Updates for pata_octeon_cf driver.
References: <1345247673-25086-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1345247673-25086-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
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

On 08/17/2012 07:54 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> The main update is conversion to device tree.  Now the the OCTEON
> device tree prerequisites are upstream, we can convert the
> pata_octeon_cf driver.
>
> The second change allows the driver to function when the kernel is
> built for little-endian operation.
>
> The only real change in the MIPS portion of the tree is deletion of
> crap.
>
> There is a dependence on patches Ralf has queued in linux-next so it
> may be best to merge via the MIPS tree (as pata_octeon_cf only exists
> in MIPS based OCTEON SOCs).  But the ata tree would be fine by me too.
> In any even we may need some cross sub-system Acked-bys.
>
> David Daney (2):
>    MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.
>    ata: pata_octeon_cf: Use correct byte order for DMA in when built
>      little-endian.
>
>   arch/mips/cavium-octeon/octeon-irq.c           |   1 -
>   arch/mips/cavium-octeon/octeon-platform.c      | 102 ------
>   arch/mips/include/asm/mach-cavium-octeon/irq.h |   1 -
>   arch/mips/include/asm/octeon/octeon.h          |   7 -
>   drivers/ata/pata_octeon_cf.c                   | 423 +++++++++++++++++--------
>   5 files changed, 288 insertions(+), 246 deletions(-)

patches 1 and 2 are

Acked-by: Jeff Garzik <jgarzik@redhat.com>
