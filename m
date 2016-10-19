Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 13:11:01 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:51591 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992078AbcJSLKwtufFg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Oct 2016 13:10:52 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 3szTkv0BYkz9sCg;
        Wed, 19 Oct 2016 22:10:47 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org
Cc:     linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, linux-sh@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org, Hugh Dickins <hughd@google.com>, linux-media@vger.kernel.org, Rik van Riel <riel@redhat.com>, intel-gfx@lists.freedesktop.org, adi-buildroot-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lorenzo Stoakes <lstoakes@gmail.com>, linux-cris-kernel@axis.com, Linus Torvalds <torvalds@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@te
 chsingularity.net>
Subject: Re: [PATCH 10/10] mm: replace access_process_vm() write parameter with gup_flags
In-Reply-To: <20161013002020.3062-11-lstoakes@gmail.com>
References: <20161013002020.3062-1-lstoakes@gmail.com> <20161013002020.3062-11-lstoakes@gmail.com>
User-Agent: Notmuch/0.21 (https://notmuchmail.org)
Date:   Wed, 19 Oct 2016 22:10:46 +1100
Message-ID: <87twc84mrt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

Lorenzo Stoakes <lstoakes@gmail.com> writes:

> diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
> index f52b7db3..010b7b3 100644
> --- a/arch/powerpc/kernel/ptrace32.c
> +++ b/arch/powerpc/kernel/ptrace32.c
> @@ -74,7 +74,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
>  			break;
>  
>  		copied = access_process_vm(child, (u64)addrOthers, &tmp,
> -				sizeof(tmp), 0);
> +				sizeof(tmp), FOLL_FORCE);
>  		if (copied != sizeof(tmp))
>  			break;
>  		ret = put_user(tmp, (u32 __user *)data);

LGTM.

> @@ -179,7 +179,8 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
>  			break;
>  		ret = 0;
>  		if (access_process_vm(child, (u64)addrOthers, &tmp,
> -					sizeof(tmp), 1) == sizeof(tmp))
> +					sizeof(tmp),
> +					FOLL_FORCE | FOLL_WRITE) == sizeof(tmp))
>  			break;
>  		ret = -EIO;
>  		break;

If you're respinning this anyway, can you format that as:

		if (access_process_vm(child, (u64)addrOthers, &tmp, sizeof(tmp),
				      FOLL_FORCE | FOLL_WRITE) == sizeof(tmp))
  			break;

I realise you probably deliberately didn't do that to make the diff clearer.

Either way:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


cheers
