Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 22:07:01 +0200 (CEST)
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993081AbeGaUG6jvNzj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jul 2018 22:06:58 +0200
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07A838197005;
        Tue, 31 Jul 2018 20:06:52 +0000 (UTC)
Received: from doriath (ovpn-116-231.phx2.redhat.com [10.3.116.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 586E61C701;
        Tue, 31 Jul 2018 20:06:42 +0000 (UTC)
Date:   Tue, 31 Jul 2018 16:06:40 -0400
From:   Luiz Capitulino <lcapitulino@redhat.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 00/11] hugetlb: Factorize hugetlb architecture
 primitives
Message-ID: <20180731160640.11306628@doriath>
In-Reply-To: <20180731060155.16915-1-alex@ghiti.fr>
References: <20180731060155.16915-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 31 Jul 2018 20:06:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 31 Jul 2018 20:06:52 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lcapitulino@redhat.com' RCPT:''
Return-Path: <lcapitulino@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lcapitulino@redhat.com
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

On Tue, 31 Jul 2018 06:01:44 +0000
Alexandre Ghiti <alex@ghiti.fr> wrote:

> [CC linux-mm for inclusion in -mm tree] 
> 
> In order to reduce copy/paste of functions across architectures and then
> make riscv hugetlb port (and future ports) simpler and smaller, this
> patchset intends to factorize the numerous hugetlb primitives that are
> defined across all the architectures.

[...]

>  15 files changed, 139 insertions(+), 382 deletions(-)

I imagine you're mostly interested in non-x86 review at this point, but
as this series is looking amazing:

Reviewed-by: Luiz Capitulino <lcapitulino@redhat.com>
