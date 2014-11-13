Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 16:29:16 +0100 (CET)
Received: from www.sr71.net ([198.145.64.142]:51087 "EHLO blackbird.sr71.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013612AbaKMP3OZ7Ic3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Nov 2014 16:29:14 +0100
Received: from [127.0.0.1] (c-76-115-204-134.hsd1.or.comcast.net [76.115.204.134])
        (Authenticated sender: dave)
        by blackbird.sr71.net (Postfix) with ESMTPSA id AF7EDFA897;
        Thu, 13 Nov 2014 07:29:06 -0800 (PST)
Message-ID: <5464CE41.2090601@sr71.net>
Date:   Thu, 13 Nov 2014 07:29:05 -0800
From:   Dave Hansen <dave@sr71.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     hpa@zytor.com, mingo@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        qiaowei.ren@intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 10/11] x86, mpx: cleanup unused bound tables
References: <20141112170443.B4BD0899@viggo.jf.intel.com> <20141112170512.C932CF4D@viggo.jf.intel.com> <alpine.DEB.2.11.1411131541520.3935@nanos>
In-Reply-To: <alpine.DEB.2.11.1411131541520.3935@nanos>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <dave@sr71.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@sr71.net
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

On 11/13/2014 06:55 AM, Thomas Gleixner wrote:
> On Wed, 12 Nov 2014, Dave Hansen wrote:
>> +/*
>> + * Get the base of bounds tables pointed by specific bounds
>> + * directory entry.
>> + */
>> +static int get_bt_addr(struct mm_struct *mm,
>> +			long __user *bd_entry, unsigned long *bt_addr)
>> +{
>> +	int ret;
>> +	int valid;
>> +
>> +	if (!access_ok(VERIFY_READ, (bd_entry), sizeof(*bd_entry)))
>> +		return -EFAULT;
>> +
>> +	while (1) {
>> +		int need_write = 0;
>> +
>> +		pagefault_disable();
>> +		ret = get_user(*bt_addr, bd_entry);
>> +		pagefault_enable();
>> +		if (!ret)
>> +			break;
>> +		if (ret == -EFAULT)
>> +			ret = mpx_resolve_fault(bd_entry, need_write);
>> +		/*
>> +		 * If we could not resolve the fault, consider it
>> +		 * userspace's fault and error out.
>> +		 */
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	valid = *bt_addr & MPX_BD_ENTRY_VALID_FLAG;
>> +	*bt_addr &= MPX_BT_ADDR_MASK;
>> +
>> +	/*
>> +	 * When the kernel is managing bounds tables, a bounds directory
>> +	 * entry will either have a valid address (plus the valid bit)
>> +	 * *OR* be completely empty. If we see a !valid entry *and* some
>> +	 * data in the address field, we know something is wrong. This
>> +	 * -EINVAL return will cause a SIGSEGV.
>> +	 */
>> +	if (!valid && *bt_addr)
>> +		return -EINVAL;
>> +	/*
>> +	 * Not present is OK.  It just means there was no bounds table
>> +	 * for this memory, which is completely OK.  Make sure to distinguish
>> +	 * this from -EINVAL, which will cause a SEGV.
>> +	 */
>> +	if (!valid)
>> +		return -ENOENT;
> 
> So here you have the extra -ENOENT return value, but at the
> direct/indirect call sites you ignore -EINVAL or everything.

I've gone and audited the call sites and cleaned this up a bit.

>> +static int mpx_unmap_tables(struct mm_struct *mm,
>> +		unsigned long start, unsigned long end)
> 
>> +	ret = unmap_edge_bts(mm, start, end);
>> +	if (ret == -EFAULT)
>> +		return ret;
> 
> So here you ignore EINVAL despite claiming that it will cause a
> SIGSEGV. So this should be:
> 
> 	switch (ret) {
> 	case 0:
> 	case -ENOENT:	break;
> 	default:	return ret;
> 	}
> 
>> +	for (bd_entry = bde_start + 1; bd_entry < bde_end; bd_entry++) {
>> +		ret = get_bt_addr(mm, bd_entry, &bt_addr);
>> +		/*
>> +		 * If we encounter an issue like a bad bounds-directory
>> +		 * we should still try the next one.
>> +		 */
>> +		if (ret)
>> +			continue;
> 
> You ignore all error returns. 

That was somewhat intentional with the idea that if we have a problem in
the middle of a large unmap we should attempt to complete the unmap.
But, I've changed my mind.  If we have any kind of validity issue, we
should just SIGSEGV and not attempt to keep unmapping things.  I've
updated the patch.
