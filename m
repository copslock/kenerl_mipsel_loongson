Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 02:07:42 +0200 (CEST)
Received: from smtp101.biz.mail.bf1.yahoo.com ([98.139.221.60]:23440 "EHLO
        smtp101.biz.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010143AbbCaAHkb9t-n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 02:07:40 +0200
Received: (qmail 461 invoked from network); 31 Mar 2015 00:07:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1427760453; bh=qtstzBgYYHv1UiTHJQhqh9Fhklo1MGjzwLVxidnribI=; h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding; b=UfqbV+F2WhDXISXJ0onptAS68mu9UrNu2gIh0inreO5utxnDTa1WcftlhUogz4L5fTa3rAqWVTqS9AJ0KchfvACc0HCepmCoBHHybeOCQirtOw6l1tv1BF1aUBCjwWS73mMPveO/t6xFp+BK5Z9eq34EolQ/XuPfz9ddzLXJ5gs=
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: AsmQvyMVM1nkmXVgd_ak6Jeq2stBynH3Hg10nFwGb7Gxtir
 siX1KbY16EOwzcV6Cl9A21or3dlspeggZWZ1g3IYBCyvqjM.ctKBc.doi.Dz
 3jRGZshtGFYcuAQTWLyagI2PM.Wc699yOO5HY.9w2KIRI151AshHLL.jChB_
 giGaxlji2r8AQOmUvB2y_2pW_B7RDGKp.OvaOg0mnMCTIcnrp28SwJy8m6DY
 nYzrX_UhpIuHTn1EqOb0d6t_LPuEfthIkhmQNGBvpq43wx7gt6HzmGvm_IYF
 EDxufe9LnOO1EQNspzqX9wA7Ozi.ucE5v3.ggFDn6AS8oJ8q6ZGhN6VULvtJ
 gEhqFtG7Yonz.pmmrwktlgzFC4RGRp2bxzlsM6HpiDpLDtNFSUiHzpqHtAoz
 s7svNF3qO4.KfcSVHp9CDCSO0ueOTjeO9JuIO1.nl1wTx11utot6ChkGmFFW
 V20379OAAzEV7Zl98ClHmp9FkhZlqk4ysWewW2BwJRe0fHhe36Lr0ibShZwx
 a.3.2DnM-
X-Yahoo-SMTP: OIJXglSswBDfgLtXluJ6wiAYv6_cnw--
Message-ID: <5519E53B.5040504@schaufler-ca.com>
Date:   Mon, 30 Mar 2015 17:07:23 -0700
From:   Casey Schaufler <casey@schaufler-ca.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-omap@vger.kernel.org,
        kvm-ppc@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ide@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, alsa-devel@alsa-project.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, patches@opensource.wolfsonmicro.com
CC:     linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/25] treewide: Use bool function return values of true/false
 not 1/0
References: <cover.1427759009.git.joe@perches.com>
In-Reply-To: <cover.1427759009.git.joe@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <casey@schaufler-ca.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: casey@schaufler-ca.com
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

On 3/30/2015 4:45 PM, Joe Perches wrote:
> Joe Perches (25):
>   arm: Use bool function return values of true/false not 1/0
>   arm64: Use bool function return values of true/false not 1/0
>   hexagon: Use bool function return values of true/false not 1/0
>   ia64: Use bool function return values of true/false not 1/0
>   mips: Use bool function return values of true/false not 1/0
>   powerpc: Use bool function return values of true/false not 1/0
>   s390: Use bool function return values of true/false not 1/0
>   sparc: Use bool function return values of true/false not 1/0
>   tile: Use bool function return values of true/false not 1/0
>   unicore32: Use bool function return values of true/false not 1/0
>   x86: Use bool function return values of true/false not 1/0
>   virtio_console: Use bool function return values of true/false not 1/0
>   csiostor: Use bool function return values of true/false not 1/0
>   dcache: Use bool function return values of true/false not 1/0
>   nfsd: nfs4state: Use bool function return values of true/false not 1/0
>   include/linux: Use bool function return values of true/false not 1/0
>   sound: Use bool function return values of true/false not 1/0
>   rcu: tree_plugin: Use bool function return values of true/false not 1/0
>   sched: Use bool function return values of true/false not 1/0
>   ftrace: Use bool function return values of true/false not 1/0
>   slub: Use bool function return values of true/false not 1/0
>   bridge: Use bool function return values of true/false not 1/0
>   netfilter: Use bool function return values of true/false not 1/0
>   security: Use bool function return values of true/false not 1/0
>   sound: wm5100-tables: Use bool function return values of true/false not 1/0
>
>  arch/arm/include/asm/dma-mapping.h           |  8 ++--
>  arch/arm/include/asm/kvm_emulate.h           |  2 +-
>  arch/arm/mach-omap2/powerdomain.c            | 14 +++---
>  arch/arm64/include/asm/dma-mapping.h         |  2 +-
>  arch/hexagon/include/asm/dma-mapping.h       |  2 +-
>  arch/ia64/include/asm/dma-mapping.h          |  2 +-
>  arch/mips/include/asm/dma-mapping.h          |  2 +-
>  arch/powerpc/include/asm/dcr-native.h        |  2 +-
>  arch/powerpc/include/asm/dma-mapping.h       |  4 +-
>  arch/powerpc/include/asm/kvm_book3s_64.h     |  4 +-
>  arch/powerpc/sysdev/dcr.c                    |  2 +-
>  arch/s390/include/asm/dma-mapping.h          |  2 +-
>  arch/sparc/mm/init_64.c                      |  8 ++--
>  arch/tile/include/asm/dma-mapping.h          |  2 +-
>  arch/unicore32/include/asm/dma-mapping.h     |  2 +-
>  arch/x86/include/asm/archrandom.h            |  2 +-
>  arch/x86/include/asm/dma-mapping.h           |  2 +-
>  arch/x86/include/asm/kvm_para.h              |  2 +-
>  arch/x86/kvm/cpuid.h                         |  2 +-
>  arch/x86/kvm/vmx.c                           | 72 ++++++++++++++--------------
>  drivers/char/virtio_console.c                |  2 +-
>  drivers/scsi/csiostor/csio_scsi.c            |  4 +-
>  fs/dcache.c                                  | 12 ++---
>  fs/nfsd/nfs4state.c                          |  2 +-
>  include/linux/blkdev.h                       |  2 +-
>  include/linux/ide.h                          |  2 +-
>  include/linux/kgdb.h                         |  2 +-
>  include/linux/mfd/db8500-prcmu.h             |  2 +-
>  include/linux/mm.h                           |  2 +-
>  include/linux/power_supply.h                 |  8 ++--
>  include/linux/ssb/ssb_driver_extif.h         |  2 +-
>  include/linux/ssb/ssb_driver_gige.h          | 16 +++----
>  include/sound/soc.h                          |  4 +-
>  kernel/rcu/tree_plugin.h                     |  4 +-
>  kernel/sched/auto_group.h                    |  2 +-
>  kernel/sched/completion.c                    | 16 ++++---
>  kernel/trace/ftrace.c                        | 10 ++--
>  mm/slub.c                                    | 12 ++---
>  net/bridge/br_private.h                      |  2 +-
>  net/ipv4/netfilter/ipt_ah.c                  |  2 +-
>  net/netfilter/ipset/ip_set_hash_ip.c         |  8 ++--
>  net/netfilter/ipset/ip_set_hash_ipmark.c     |  8 ++--
>  net/netfilter/ipset/ip_set_hash_ipport.c     |  8 ++--
>  net/netfilter/ipset/ip_set_hash_ipportip.c   |  8 ++--
>  net/netfilter/ipset/ip_set_hash_ipportnet.c  |  8 ++--
>  net/netfilter/ipset/ip_set_hash_net.c        |  8 ++--
>  net/netfilter/ipset/ip_set_hash_netiface.c   |  8 ++--
>  net/netfilter/ipset/ip_set_hash_netport.c    |  8 ++--
>  net/netfilter/ipset/ip_set_hash_netportnet.c |  8 ++--
>  net/netfilter/xt_connlimit.c                 |  2 +-
>  net/netfilter/xt_hashlimit.c                 |  2 +-
>  net/netfilter/xt_ipcomp.c                    |  2 +-
>  security/apparmor/file.c                     |  8 ++--
>  security/apparmor/policy.c                   | 10 ++--
>  sound/soc/codecs/wm5100-tables.c             | 12 ++---

Why, and why these in particular?

>  55 files changed, 178 insertions(+), 176 deletions(-)
>
