Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2009 15:31:15 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:43500 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21365323AbZBEPbM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Feb 2009 15:31:12 +0000
Received: from localhost (p6114-ipad308funabasi.chiba.ocn.ne.jp [123.217.192.114])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D07A4A109; Fri,  6 Feb 2009 00:31:04 +0900 (JST)
Date:	Fri, 06 Feb 2009 00:31:13 +0900 (JST)
Message-Id: <20090206.003113.118974140.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	dvomlehn@cisco.com, ddaney@caviumnetworks.com, msundius@cisco.com,
	linux-mips@linux-mips.org, msundius@sundius.com
Subject: Re: memcpy and prefetch
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090204212746.GB13138@linux-mips.org>
References: <20090129155854.GC29521@linux-mips.org>
	<FF038EB85946AA46B18DFEE6E6F8A2898237E1@xmb-rtp-218.amer.cisco.com>
	<20090204212746.GB13138@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Fri_Feb__6_00_31_13_2009_361)--"
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

----Next_Part(Fri_Feb__6_00_31_13_2009_361)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 4 Feb 2009 21:27:46 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > If this makes sense, we might be able to sign up to do the work. Anyone
> > have a good, caching-aware memcpy test?
> 
> Testing memcpy is an interesting little project.  Correctness is one
> thing but a good implementation needs to do a few performance tradeoffs
> which are best meassure with real world, not synthetic workloads.

For correctness test, drivers/dma/dmatest.c might be a good template.

For speed test, test_cipher_speed in crypt/tcrypt.c can be used as a
template.  Attached is a test module I wrote based on it, when I
implemented an asm version of csum_partial_copy_nocheck, etc.  It will
show something like this:

# insmod /tmp/testspeed.ko mode=1

testing speed of csum_partial_copy_nocheck
test 0 (32 byte): 2051560 operations in 1 seconds (65649920 bytes)
test 1 (96 byte): 823512 operations in 1 seconds (79057152 bytes)
test 2 (256 byte): 329124 operations in 1 seconds (84255744 bytes)
test 3 (512 byte): 167739 operations in 1 seconds (85882368 bytes)
...
testing speed of gen_csum_partial_copy_nocheck
test 0 (32 byte): 1555953 operations in 1 seconds (49790496 bytes)
test 1 (96 byte): 700025 operations in 1 seconds (67202400 bytes)
test 2 (256 byte): 293716 operations in 1 seconds (75191296 bytes)
test 3 (512 byte): 151770 operations in 1 seconds (77706240 bytes)
...
insmod: error inserting '/tmp/testspeed.ko': -1 Resource temporarily unavailable

Feel free to hack it ;)


----Next_Part(Fri_Feb__6_00_31_13_2009_361)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="testspeed.c"

/*
 * Quick & dirty speed testing module.  (Based on tcrypt).
 *
 * This file is subject to the terms and conditions of the GNU General Public
 * License.  See the file "COPYING" in the main directory of this archive
 * for more details.
 */

#include <linux/init.h>
#include <linux/module.h>
#include <linux/mm.h>
#include <linux/slab.h>
#include <linux/moduleparam.h>
#include <linux/jiffies.h>
#include <net/checksum.h>

static unsigned int sec = 1;
static int mode;

/* non-optimized version of csum_partial_copy_nocheck */
static unsigned int gen_csum_partial_copy_nocheck(const void *src,
	void *dst, int len, unsigned int sum)
{
	sum = csum_partial(src, len, sum);
	memcpy(dst, src, len);
	return sum;
}

/* non-optimized version of csum_partial_copy_from_user */
static unsigned int gen_csum_partial_copy_from_user(const void __user *src,
	void *dst, int len, unsigned int sum, int *err_ptr)
{
	might_sleep();
	if (__copy_from_user(dst, src, len))
		*err_ptr = -EFAULT;
	return csum_partial(dst, len, sum);
}

#define loop_while_sec(start, end, sec, count) \
	for (start = jiffies, end = start + sec * HZ, count = 0; \
	     time_before(jiffies, end); count++)

static int test_csum_partial_copy_speed(int cachemiss)
{
	unsigned long start, end;
	unsigned int i;
	void *src, *dst;
	size_t sizes[] = {
		0x20, 0x60, 0x100, 0x200, 0x400,
		1460, /* ETH_DATA_LEN - 20(ip header) - 20(tcp header) */
		0x800, 0x1000,
	};
	size_t maxsize = sizes[ARRAY_SIZE(sizes) - 1];
	int ofs;
	int count;
	int err;
	int bufsize = 0x10000;

	src = kmalloc(bufsize, GFP_KERNEL);
	if (!src)
		return -ENOMEM;
	dst = kmalloc(bufsize, GFP_KERNEL);
	if (!dst) {
		kfree(src);
		return -ENOMEM;
	}
	memset(src, 0xff, maxsize);

	printk("\ntesting speed of csum_partial_copy_nocheck\n");

	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
		printk("test %u (%d byte): ", i, sizes[i]);

		ofs = 0;
		loop_while_sec(start, end, sec, count) {
			csum_partial_copy_nocheck(src + ofs, dst + ofs,
						  sizes[i], 0);
			if (cachemiss) {
				ofs += sizes[i];
				if (ofs + sizes[i] > bufsize)
					ofs = 0;
			}
		}

		printk("%d operations in %d seconds (%d bytes)\n",
		       count, sec, count * sizes[i]);
	}

	printk("\ntesting speed of csum_partial_copy_from_user\n");

	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
		printk("test %u (%d byte): ", i, sizes[i]);

		ofs = 0;
		loop_while_sec(start, end, sec, count) {
			csum_partial_copy_from_user((const void __force __user *)src + ofs,
						    dst + ofs,
						    sizes[i], 0, &err);
			if (cachemiss) {
				ofs += sizes[i];
				if (ofs + sizes[i] > bufsize)
					ofs = 0;
			}
		}

		printk("%d operations in %d seconds (%d bytes)\n",
		       count, sec, count * sizes[i]);
	}

	printk("\ntesting speed of gen_csum_partial_copy_nocheck\n");

	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
		printk("test %u (%d byte): ", i, sizes[i]);

		ofs = 0;
		loop_while_sec(start, end, sec, count) {
			gen_csum_partial_copy_nocheck(src + ofs, dst + ofs,
						      sizes[i], 0);
			if (cachemiss) {
				ofs += sizes[i];
				if (ofs + sizes[i] > bufsize)
					ofs = 0;
			}
		}

		printk("%d operations in %d seconds (%d bytes)\n",
		       count, sec, count * sizes[i]);
	}

	printk("\ntesting speed of gen_csum_partial_copy_from_user\n");

	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
		printk("test %u (%d byte): ", i, sizes[i]);

		ofs = 0;
		loop_while_sec(start, end, sec, count) {
			gen_csum_partial_copy_from_user((const void __force __user *)src + ofs,
							dst + ofs,
							sizes[i], 0, &err);
			if (cachemiss) {
				ofs += sizes[i];
				if (ofs + sizes[i] > bufsize)
					ofs = 0;
			}
		}

		printk("%d operations in %d seconds (%d bytes)\n",
		       count, sec, count * sizes[i]);
	}

	kfree(src);
	kfree(dst);
	return 0;
}

static int __init init(void)
{
	int ret = 0;
	switch (mode) {
	case 0:
		ret = test_csum_partial_copy_speed(0);
		break;
	case 1:
		ret = test_csum_partial_copy_speed(1);
		break;
	}
	if (ret)
		return ret;

	/* We intentionaly return -EAGAIN to prevent keeping the module. */
	return -EAGAIN;
}

static void __exit fini(void) {}

module_init(init);
module_exit(fini);

module_param(mode, int, 0);
module_param(sec, uint, 0);
MODULE_PARM_DESC(sec, "Length in seconds of speed tests (default 1)");

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Quick & dirty speed testing module");

----Next_Part(Fri_Feb__6_00_31_13_2009_361)----
