Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2013 19:50:47 +0200 (CEST)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33018 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827336Ab3JQRulaN5qC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Oct 2013 19:50:41 +0200
Received: by mail-ob0-f169.google.com with SMTP id wp4so2211189obc.28
        for <multiple recipients>; Thu, 17 Oct 2013 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=esZGPg0OqIg44zyvKjb99LkEVhI5vt16Gbfz/ZqZJjM=;
        b=yp1r4e74+rcK4jRLwGyKXnrQsYJkUefmPK16nQKVWN9OTCXv1X7RtjMd+qoVoRIAWA
         coXGCF/STPbayio6xG7lmiDjtQc/HK/GvMVAz6s8a8geMZSO/p12F0BfeIvts2RvoJEJ
         R+Oj1WzQd+NFSabfgZvyYNw34M9E/trTBSKpwuUzr4GB4rnm/Auij7yjnGQXvKffqwTw
         FeuE6oHP6Mo0Wiuas6KxvzDUth1f2Y2Hqf4XQmexF7GVBmntW8nm9ZBA6D7s041XBDn/
         8qb/rOrQHukve9w3I6kiau3LPIjN1YbvzHDOuva5HR6qVHjVzvzeZFafAIx/PHsPN9g9
         FFXA==
X-Received: by 10.182.117.195 with SMTP id kg3mr15645275obb.17.1382032235223;
        Thu, 17 Oct 2013 10:50:35 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id hs4sm76609378obb.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 10:50:34 -0700 (PDT)
Message-ID: <52602368.3000901@gmail.com>
Date:   Thu, 17 Oct 2013 10:50:32 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 6/6] MIPS: APRP: Code formatting clean-ups.
References: <1381976070-8413-1-git-send-email-Steven.Hill@imgtec.com> <1381976070-8413-7-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1381976070-8413-7-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/16/2013 07:14 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@imgtec.com>
>
> Clean-up code according to the 'checkpatch.pl' script.

This should probably be the first patch, so you don't end up making 
poorly formatted additions, and then later clean them up.

Also the change log text is not at all true, please make it reflect reality.

>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> Reviewed-by: Qais Yousef <Qais.Yousef@imgtec.com>
> ---
>   arch/mips/include/asm/amon.h     |   15 ++-
>   arch/mips/include/asm/rtlx.h     |    5 +-
>   arch/mips/include/asm/vpe.h      |   19 +--
>   arch/mips/kernel/rtlx.c          |  134 ++++++++------------
>   arch/mips/kernel/vpe-mt.c        |    6 +-
>   arch/mips/kernel/vpe.c           |  252 +++++++++++++++++---------------------
>   arch/mips/mti-malta/malta-amon.c |   24 ++--
>   arch/mips/mti-malta/malta-int.c  |  115 +++++++++--------
>   8 files changed, 250 insertions(+), 320 deletions(-)
>
> diff --git a/arch/mips/include/asm/amon.h b/arch/mips/include/asm/amon.h
> index 3bd6e76..3cc03c6 100644
> --- a/arch/mips/include/asm/amon.h
> +++ b/arch/mips/include/asm/amon.h
> @@ -1,7 +1,12 @@
>   /*
> - * Amon support
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2013 Imagination Technologies Ltd.
> + *
> + * Arbitrary Monitor Support (AMON)

Reflowing white space doesn't really count as the type of modification 
that allows you to assert copyright.


>    */
> -
> -int amon_cpu_avail(int);
> -int amon_cpu_start(int, unsigned long, unsigned long,
> -		   unsigned long, unsigned long);
> +int amon_cpu_avail(int cpu);
> +int amon_cpu_start(int cpu, unsigned long pc, unsigned long sp,
> +		   unsigned long gp, unsigned long a0);
> diff --git a/arch/mips/include/asm/rtlx.h b/arch/mips/include/asm/rtlx.h
> index fa86dfd..c102065 100644
> --- a/arch/mips/include/asm/rtlx.h
> +++ b/arch/mips/include/asm/rtlx.h
> @@ -1,8 +1,11 @@
>   /*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *

This is hot a checkpatch.pl related change.  So it should not be in this 
patch.

>    * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
>    * Copyright (C) 2013 Imagination Technologies Ltd.
>    */
> -
>   #ifndef __ASM_RTLX_H_
>   #define __ASM_RTLX_H_
>
> diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
> index becd555..e0684f5 100644
> --- a/arch/mips/include/asm/vpe.h
> +++ b/arch/mips/include/asm/vpe.h
> @@ -1,22 +1,11 @@
>   /*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
>    * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
>    * Copyright (C) 2013 Imagination Technologies Ltd.
> - *
> - *  This program is free software; you can distribute it and/or modify it
> - *  under the terms of the GNU General Public License (Version 2) as
> - *  published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope it will be useful, but WITHOUT
> - *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> - *  for more details.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> - *
>    */

Another change not related to checkpatch.pl


> -
>   #ifndef _ASM_VPE_H
>   #define _ASM_VPE_H
>
> diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
> index cd78618..8053b4e 100644
> --- a/arch/mips/kernel/rtlx.c
> +++ b/arch/mips/kernel/rtlx.c
> @@ -1,46 +1,23 @@
>   /*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
>    * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
>    * Copyright (C) 2005, 06 Ralf Baechle (ralf@linux-mips.org)
> - *
> - *  This program is free software; you can distribute it and/or modify it
> - *  under the terms of the GNU General Public License (Version 2) as
> - *  published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope it will be useful, but WITHOUT
> - *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> - *  for more details.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> - *
> + * Copyright (C) 2013 Imagination Technologies Ltd.

And another.

>    */
> -
> -#include <linux/device.h>
>   #include <linux/kernel.h>
>   #include <linux/fs.h>
> -#include <linux/init.h>
> -#include <asm/uaccess.h>
> -#include <linux/list.h>
> -#include <linux/vmalloc.h>
> -#include <linux/elf.h>
> -#include <linux/seq_file.h>
>   #include <linux/syscalls.h>
>   #include <linux/moduleloader.h>
> -#include <linux/interrupt.h>
> -#include <linux/poll.h>
> -#include <linux/sched.h>
> -#include <linux/wait.h>
> +#include <linux/atomic.h>
>   #include <asm/mipsmtregs.h>
>   #include <asm/mips_mt.h>
> -#include <asm/cacheflush.h>
> -#include <linux/atomic.h>
> -#include <asm/cpu.h>
>   #include <asm/processor.h>
> -#include <asm/vpe.h>
>   #include <asm/rtlx.h>
>   #include <asm/setup.h>
> +#include <asm/vpe.h>
>
>   static int sp_stopping;
>   struct rtlx_info *rtlx;
> @@ -53,22 +30,22 @@ static void __used dump_rtlx(void)
>   {
>   	int i;
>
> -	printk("id 0x%lx state %d\n", rtlx->id, rtlx->state);
> +	pr_info("id 0x%lx state %d\n", rtlx->id, rtlx->state);
>
>   	for (i = 0; i < RTLX_CHANNELS; i++) {
>   		struct rtlx_channel *chan = &rtlx->channel[i];
>
> -		printk(" rt_state %d lx_state %d buffer_size %d\n",
> -		       chan->rt_state, chan->lx_state, chan->buffer_size);
> +		pr_info(" rt_state %d lx_state %d buffer_size %d\n",
> +			chan->rt_state, chan->lx_state, chan->buffer_size);
>
> -		printk(" rt_read %d rt_write %d\n",
> -		       chan->rt_read, chan->rt_write);
> +		pr_info(" rt_read %d rt_write %d\n",
> +			chan->rt_read, chan->rt_write);
>
> -		printk(" lx_read %d lx_write %d\n",
> -		       chan->lx_read, chan->lx_write);
> +		pr_info(" lx_read %d lx_write %d\n",
> +			chan->lx_read, chan->lx_write);
>
> -		printk(" rt_buffer <%s>\n", chan->rt_buffer);
> -		printk(" lx_buffer <%s>\n", chan->lx_buffer);
> +		pr_info(" rt_buffer <%s>\n", chan->rt_buffer);
> +		pr_info(" lx_buffer <%s>\n", chan->lx_buffer);
>   	}
>   }
>
> @@ -76,8 +53,7 @@ static void __used dump_rtlx(void)
>   static int rtlx_init(struct rtlx_info *rtlxi)
>   {
>   	if (rtlxi->id != RTLX_ID) {
> -		printk(KERN_ERR "no valid RTLX id at 0x%p 0x%lx\n",
> -			rtlxi, rtlxi->id);
> +		pr_err("no valid RTLX id at 0x%p 0x%lx\n", rtlxi, rtlxi->id);
>   		return -ENOEXEC;
>   	}
>
> @@ -93,7 +69,7 @@ void rtlx_starting(int vpe)
>   	sp_stopping = 0;
>
>   	/* force a reload of rtlx */
> -	rtlx=NULL;
> +	rtlx = NULL;
>
>   	/* wake up any sleeping rtlx_open's */
>   	for (i = 0; i < RTLX_CHANNELS; i++)
> @@ -118,30 +94,31 @@ int rtlx_open(int index, int can_sleep)
>   	int ret = 0;
>
>   	if (index >= RTLX_CHANNELS) {
> -		printk(KERN_DEBUG "rtlx_open index out of range\n");
> +		pr_debug("rtlx_open index out of range\n");
>   		return -ENOSYS;
>   	}
>
>   	if (atomic_inc_return(&channel_wqs[index].in_open) > 1) {
> -		printk(KERN_DEBUG "rtlx_open channel %d already opened\n",
> -		       index);
> +		pr_debug("rtlx_open channel %d already opened\n", index);
>   		ret = -EBUSY;
>   		goto out_fail;
>   	}
>
>   	if (rtlx == NULL) {
> -		if( (p = vpe_get_shared(tclimit)) == NULL) {
> -		    if (can_sleep) {
> -			__wait_event_interruptible(channel_wqs[index].lx_queue,
> -				(p = vpe_get_shared(tclimit)), ret);
> -			if (ret)
> +		p = vpe_get_shared(aprp_cpu_index());
> +		if (p == NULL) {
> +			if (can_sleep) {
> +				__wait_event_interruptible(
> +					channel_wqs[index].lx_queue,
> +					(p = vpe_get_shared(aprp_cpu_index())),
> +					ret);
> +				if (ret)
> +					goto out_fail;
> +			} else {
> +				pr_debug("No SP program loaded, and device opened with O_NONBLOCK\n");
> +				ret = -ENOSYS;
>   				goto out_fail;
> -		    } else {
> -			printk(KERN_DEBUG "No SP program loaded, and device "
> -					"opened with O_NONBLOCK\n");
> -			ret = -ENOSYS;
> -			goto out_fail;
> -		    }
> +			}
>   		}
>
>   		smp_rmb();
> @@ -163,24 +140,24 @@ int rtlx_open(int index, int can_sleep)
>   					ret = -ERESTARTSYS;
>   					goto out_fail;
>   				}
> -				finish_wait(&channel_wqs[index].lx_queue, &wait);
> +				finish_wait(&channel_wqs[index].lx_queue,
> +					    &wait);

Gratuitous uglification here.  Probably not a good idea.


>   			} else {
> -				pr_err(" *vpe_get_shared is NULL. "
> -				       "Has an SP program been loaded?\n");
> +				pr_err(" *vpe_get_shared is NULL. Has an SP program been loaded?\n");
>   				ret = -ENOSYS;
>   				goto out_fail;
>   			}
>   		}
>
>   		if ((unsigned int)*p < KSEG0) {
> -			printk(KERN_WARNING "vpe_get_shared returned an "
> -			       "invalid pointer maybe an error code %d\n",
> -			       (int)*p);
> +			pr_warn("vpe_get_shared returned an invalid pointer maybe an error code %d\n",
> +				(int)*p);
>   			ret = -ENOSYS;
>   			goto out_fail;
>   		}
>
> -		if ((ret = rtlx_init(*p)) < 0)
> +		ret = rtlx_init(*p);
> +		if (ret < 0)
>   			goto out_ret;
>   	}
>
> @@ -312,7 +289,7 @@ ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
>   	size_t fl;
>
>   	if (rtlx == NULL)
> -		return(-ENOSYS);
> +		return -ENOSYS;
>
>   	rt = &rtlx->channel[index];
>
> @@ -321,8 +298,8 @@ ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
>   	rt_read = rt->rt_read;
>
>   	/* total number of bytes to copy */
> -	count = min(count, (size_t)write_spacefree(rt_read, rt->rt_write,
> -							rt->buffer_size));
> +	count = min_t(size_t, count, write_spacefree(rt_read, rt->rt_write,
> +						     rt->buffer_size));
>
>   	/* first bit from write pointer to the end of the buffer, or count */
>   	fl = min(count, (size_t) rt->buffer_size - rt->rt_write);
> @@ -332,9 +309,8 @@ ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
>   		goto out;
>
>   	/* if there's any left copy to the beginning of the buffer */
> -	if (count - fl) {
> +	if (count - fl)
>   		failed = copy_from_user(rt->rt_buffer, buffer + fl, count - fl);
> -	}
>
>   out:
>   	count -= failed;
> @@ -360,7 +336,7 @@ static int file_release(struct inode *inode, struct file *filp)
>   	return rtlx_release(iminor(inode));
>   }
>
> -static unsigned int file_poll(struct file *file, poll_table * wait)
> +static unsigned int file_poll(struct file *file, poll_table *wait)
>   {
>   	int minor = iminor(file_inode(file));
>   	unsigned int mask = 0;
> @@ -382,21 +358,20 @@ static unsigned int file_poll(struct file *file, poll_table * wait)
>   	return mask;
>   }
>
> -static ssize_t file_read(struct file *file, char __user * buffer, size_t count,
> -			 loff_t * ppos)
> +static ssize_t file_read(struct file *file, char __user *buffer, size_t count,
> +			 loff_t *ppos)
>   {
>   	int minor = iminor(file_inode(file));
>
>   	/* data available? */
> -	if (!rtlx_read_poll(minor, (file->f_flags & O_NONBLOCK) ? 0 : 1)) {
> -		return 0;	// -EAGAIN makes cat whinge
> -	}
> +	if (!rtlx_read_poll(minor, (file->f_flags & O_NONBLOCK) ? 0 : 1))
> +		return 0;	/* -EAGAIN makes 'cat' whine */
>
>   	return rtlx_read(minor, buffer, count);
>   }
>
> -static ssize_t file_write(struct file *file, const char __user * buffer,
> -			  size_t count, loff_t * ppos)
> +static ssize_t file_write(struct file *file, const char __user *buffer,
> +			  size_t count, loff_t *ppos)
>   {
>   	int minor = iminor(file_inode(file));
>
> @@ -419,11 +394,11 @@ static ssize_t file_write(struct file *file, const char __user * buffer,
>
>   const struct file_operations rtlx_fops = {
>   	.owner =   THIS_MODULE,
> -	.open =	   file_open,
> +	.open =    file_open,
>   	.release = file_release,
>   	.write =   file_write,
> -	.read =	   file_read,
> -	.poll =	   file_poll,
> +	.read =    file_read,
> +	.poll =    file_poll,
>   	.llseek =  noop_llseek,
>   };
>
> @@ -433,4 +408,3 @@ module_exit(rtlx_module_exit);
>   MODULE_DESCRIPTION("MIPS RTLX");
>   MODULE_AUTHOR("Elizabeth Oldham, MIPS Technologies, Inc.");
>   MODULE_LICENSE("GPL");
> -
> diff --git a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
> index 323ca69..daccee4 100644
> --- a/arch/mips/kernel/vpe-mt.c
> +++ b/arch/mips/kernel/vpe-mt.c
> @@ -28,7 +28,7 @@ static int hw_tcs, hw_vpes;
>   int vpe_run(struct vpe *v)
>   {
>   	unsigned long flags, val, dmt_flag;
> -	struct vpe_notifications *n;
> +	struct vpe_notifications *notifier;
>   	unsigned int vpeflags;
>   	struct tc *t;
>
> @@ -141,8 +141,8 @@ int vpe_run(struct vpe *v)
>   	emt(dmt_flag);
>   	local_irq_restore(flags);
>
> -	list_for_each_entry(n, &v->notify, list)
> -		n->start(VPE_MODULE_MINOR);
> +	list_for_each_entry(notifier, &v->notify, list)
> +		notifier->start(VPE_MODULE_MINOR);
>
>   	return 0;
>   }
> diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
> index 61dfd5b..42d3ca0 100644
> --- a/arch/mips/kernel/vpe.c
> +++ b/arch/mips/kernel/vpe.c
> @@ -1,37 +1,22 @@
>   /*
> - * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
> - *
> - *  This program is free software; you can distribute it and/or modify it
> - *  under the terms of the GNU General Public License (Version 2) as
> - *  published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope it will be useful, but WITHOUT
> - *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> - *  for more details.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> - */
> -
> -/*
> - * VPE support module
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
>    *
> - * Provides support for loading a MIPS SP program on VPE1.
> - * The SP environment is rather simple, no tlb's.  It needs to be relocatable
> - * (or partially linked). You should initialise your stack in the startup
> - * code. This loader looks for the symbol __start and sets up
> - * execution to resume from there. The MIPS SDE kit contains suitable examples.
> + * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
> + * Copyright (C) 2013 Imagination Technologies Ltd.
>    *

More license frobbing, not checkpatch.pl related


.
.
.
