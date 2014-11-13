Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 15:55:28 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:57209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013511AbaKMOz0lYILD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 15:55:26 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Xovnl-0007lX-Hr; Thu, 13 Nov 2014 15:55:13 +0100
Date:   Thu, 13 Nov 2014 15:55:13 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave@sr71.net>
cc:     hpa@zytor.com, mingo@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        qiaowei.ren@intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 10/11] x86, mpx: cleanup unused bound tables
In-Reply-To: <20141112170512.C932CF4D@viggo.jf.intel.com>
Message-ID: <alpine.DEB.2.11.1411131541520.3935@nanos>
References: <20141112170443.B4BD0899@viggo.jf.intel.com> <20141112170512.C932CF4D@viggo.jf.intel.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Wed, 12 Nov 2014, Dave Hansen wrote:
> +/*
> + * Get the base of bounds tables pointed by specific bounds
> + * directory entry.
> + */
> +static int get_bt_addr(struct mm_struct *mm,
> +			long __user *bd_entry, unsigned long *bt_addr)
> +{
> +	int ret;
> +	int valid;
> +
> +	if (!access_ok(VERIFY_READ, (bd_entry), sizeof(*bd_entry)))
> +		return -EFAULT;
> +
> +	while (1) {
> +		int need_write = 0;
> +
> +		pagefault_disable();
> +		ret = get_user(*bt_addr, bd_entry);
> +		pagefault_enable();
> +		if (!ret)
> +			break;
> +		if (ret == -EFAULT)
> +			ret = mpx_resolve_fault(bd_entry, need_write);
> +		/*
> +		 * If we could not resolve the fault, consider it
> +		 * userspace's fault and error out.
> +		 */
> +		if (ret)
> +			return ret;
> +	}
> +
> +	valid = *bt_addr & MPX_BD_ENTRY_VALID_FLAG;
> +	*bt_addr &= MPX_BT_ADDR_MASK;
> +
> +	/*
> +	 * When the kernel is managing bounds tables, a bounds directory
> +	 * entry will either have a valid address (plus the valid bit)
> +	 * *OR* be completely empty. If we see a !valid entry *and* some
> +	 * data in the address field, we know something is wrong. This
> +	 * -EINVAL return will cause a SIGSEGV.
> +	 */
> +	if (!valid && *bt_addr)
> +		return -EINVAL;
> +	/*
> +	 * Not present is OK.  It just means there was no bounds table
> +	 * for this memory, which is completely OK.  Make sure to distinguish
> +	 * this from -EINVAL, which will cause a SEGV.
> +	 */
> +	if (!valid)
> +		return -ENOENT;

So here you have the extra -ENOENT return value, but at the
direct/indirect call sites you ignore -EINVAL or everything.

> +static int mpx_unmap_tables(struct mm_struct *mm,
> +		unsigned long start, unsigned long end)

> +	ret = unmap_edge_bts(mm, start, end);
> +	if (ret == -EFAULT)
> +		return ret;

So here you ignore EINVAL despite claiming that it will cause a
SIGSEGV. So this should be:

	switch (ret) {
	case 0:
	case -ENOENT:	break;
	default:	return ret;
	}

> +	for (bd_entry = bde_start + 1; bd_entry < bde_end; bd_entry++) {
> +		ret = get_bt_addr(mm, bd_entry, &bt_addr);
> +		/*
> +		 * If we encounter an issue like a bad bounds-directory
> +		 * we should still try the next one.
> +		 */
> +		if (ret)
> +			continue;

You ignore all error returns. 

		switch (ret) {
		case 0:		break;
		case -ENOENT:	continue;
		default:	return ret;
		}

Other than that, this all looks very reasonable now.

Thanks,

	tglx
