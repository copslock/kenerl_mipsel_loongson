Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 13:50:06 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:41021 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011718AbbHGLuEYv61o (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Aug 2015 13:50:04 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D96F1AAC2;
        Fri,  7 Aug 2015 11:50:02 +0000 (UTC)
Subject: Re: [PATCH V6 4/6] mm: mlock: Add mlock flags to enable
 VM_LOCKONFAULT usage
To:     Eric B Munson <emunson@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1438184575-10537-1-git-send-email-emunson@akamai.com>
 <1438184575-10537-5-git-send-email-emunson@akamai.com>
Cc:     Michal Hocko <mhocko@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <55C49B69.9050805@suse.cz>
Date:   Fri, 7 Aug 2015 13:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1438184575-10537-5-git-send-email-emunson@akamai.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vbabka@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbabka@suse.cz
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

On 07/29/2015 05:42 PM, Eric B Munson wrote:
> The previous patch introduced a flag that specified pages in a VMA
> should be placed on the unevictable LRU, but they should not be made
> present when the area is created.  This patch adds the ability to set
> this state via the new mlock system calls.
>
> We add MLOCK_ONFAULT for mlock2 and MCL_ONFAULT for mlockall.
> MLOCK_ONFAULT will set the VM_LOCKONFAULT modifier for VM_LOCKED.
> MCL_ONFAULT should be used as a modifier to the two other mlockall
> flags.  When used with MCL_CURRENT, all current mappings will be marked
> with VM_LOCKED | VM_LOCKONFAULT.  When used with MCL_FUTURE, the
> mm->def_flags will be marked with VM_LOCKED | VM_LOCKONFAULT.  When used
> with both MCL_CURRENT and MCL_FUTURE, all current mappings and
> mm->def_flags will be marked with VM_LOCKED | VM_LOCKONFAULT.
>
> Prior to this patch, mlockall() will unconditionally clear the
> mm->def_flags any time it is called without MCL_FUTURE.  This behavior
> is maintained after adding MCL_ONFAULT.  If a call to
> mlockall(MCL_FUTURE) is followed by mlockall(MCL_CURRENT), the
> mm->def_flags will be cleared and new VMAs will be unlocked.  This
> remains true with or without MCL_ONFAULT in either mlockall()
> invocation.
>
> munlock() will unconditionally clear both vma flags.  munlockall()
> unconditionally clears for VMA flags on all VMAs and in the
> mm->def_flags field.
>
> Signed-off-by: Eric B Munson <emunson@akamai.com>
> Cc: Michal Hocko <mhocko@suse.cz>
> Cc: Vlastimil Babka <vbabka@suse.cz>

The logic seems ok, although the fact that apply_mlockall_flags() is 
shared by both mlockall and munlockall makes it even more subtle than 
before :)

Anyway, just some nitpicks below.

Acked-by: Vlastimil Babka <vbabka@suse.cz>

[...]

> +/*
> + * Take the MCL_* flags passed into mlockall (or 0 if called from munlockall)
> + * and translate into the appropriate modifications to mm->def_flags and/or the
> + * flags for all current VMAs.
> + *
> + * There are a couple of sublties with this.  If mlockall() is called multiple

                             ^ typo

> + * times with different flags, the values do not necessarily stack.  If mlockall
> + * is called once including the MCL_FUTURE flag and then a second time without
> + * it, VM_LOCKED and VM_LOCKONFAULT will be cleared from mm->def_flags.
> + */
>   static int apply_mlockall_flags(int flags)
>   {
>   	struct vm_area_struct * vma, * prev = NULL;
> +	vm_flags_t to_add = 0;
>
> -	if (flags & MCL_FUTURE)
> +	current->mm->def_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
> +	if (flags & MCL_FUTURE) {
>   		current->mm->def_flags |= VM_LOCKED;
> -	else
> -		current->mm->def_flags &= ~VM_LOCKED;
>
> -	if (flags == MCL_FUTURE)
> -		goto out;
> +		if (flags & MCL_ONFAULT)
> +			current->mm->def_flags |= VM_LOCKONFAULT;
> +
> +		/*
> +		 * When there were only two flags, we used to early out if only
> +		 * MCL_FUTURE was set.  Now that we have MCL_ONFAULT, we can
> +		 * only early out if MCL_FUTURE is set, but MCL_CURRENT is not.

Describing the relation to history of individual code lines in such 
detail is noise imho. The stacking subtleties is already described above.

> +		 * This is done, even though it promotes odd behavior, to
> +		 * maintain behavior from older kernels
> +		 */
> +		if (!(flags & MCL_CURRENT))
> +			goto out;
