Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jun 2010 11:37:05 +0200 (CEST)
Received: from cantor.suse.de ([195.135.220.2]:54119 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491758Ab0F3Jg5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jun 2010 11:36:57 +0200
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTP id A66D593987;
        Wed, 30 Jun 2010 11:36:54 +0200 (CEST)
Date:   Wed, 30 Jun 2010 11:36:53 +0200 (CEST)
From:   Jiri Kosina <jkosina@suse.cz>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Christoph Egger <siccegge@cs.fau.de>,
        Gilles Espinasse <g.esp@free.fr>, Tejun Heo <tj@kernel.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        vamos@i4.informatik.uni-erlangen.de
Subject: Re: [PATCH 3/9] Removing dead CONFIG_SIBYTE_BCM1480_PROF
In-Reply-To: <20100628134959.GC29229@linux-mips.org>
Message-ID: <alpine.LNX.2.00.1006301133400.13809@pobox.suse.cz>
References: <cover.1275925108.git.siccegge@cs.fau.de> <c217f4530c057f4b8030bd14459a0cb2856decde.1275925108.git.siccegge@cs.fau.de> <alpine.LNX.2.00.1006161800290.12271@pobox.suse.cz> <20100628134959.GC29229@linux-mips.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 27279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jkosina@suse.cz
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                
X-UID: 20072

On Mon, 28 Jun 2010, Ralf Baechle wrote:

> > > CONFIG_SIBYTE_BCM1480_PROF doesn't exist in Kconfig, therefore removing all
> > > references for it from the source code.
> > 
> > The patch isn't present in linux-next as of today. I have applied it to my 
> > tree, thanks.
> 
> Nack.  This only need to be rewired to use the ZBus profiler just like
> the SB1250 already does.  It's the virtually same hardware after all!

Well, still it's dead code guarded by ifdef depending on non-exsiting 
symbol ... I have just quickly tried to get a grip on the zbus thing, but

	arch/mips/configs/bigsur_defconfig:CONFIG_SIBYTE_HAS_ZBUS_PROFILING=y
	arch/mips/configs/sb1250-swarm_defconfig:CONFIG_SIBYTE_HAS_ZBUS_PROFILING=y
	1arch/mips/sibyte/Kconfig:       select SIBYTE_HAS_ZBUS_PROFILING
	arch/mips/sibyte/Kconfig:       select SIBYTE_HAS_ZBUS_PROFILING
	arch/mips/sibyte/Kconfig:       select SIBYTE_HAS_ZBUS_PROFILING
	arch/mips/sibyte/Kconfig:       select SIBYTE_HAS_ZBUS_PROFILING
	arch/mips/sibyte/Kconfig:       select SIBYTE_HAS_ZBUS_PROFILING
	arch/mips/sibyte/Kconfig:       select SIBYTE_HAS_ZBUS_PROFILING
	arch/mips/sibyte/Kconfig:       select SIBYTE_HAS_ZBUS_PROFILING
	arch/mips/sibyte/Kconfig:       depends on SIBYTE_HAS_ZBUS_PROFILING
	arch/mips/sibyte/Kconfig:config SIBYTE_HAS_ZBUS_PROFILING

seem to be the only occurences in the whole tree. Another unused symbol?

So I'll revert that patch in my tree as it has been nacked by maintainer, 
but the feeling that cleanup is needed is still there.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
