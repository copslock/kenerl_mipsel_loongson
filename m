Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2003 17:51:59 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:37618 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225296AbTH0Qv4>;
	Wed, 27 Aug 2003 17:51:56 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h7RGpRY08844;
	Wed, 27 Aug 2003 09:51:27 -0700
Date: Wed, 27 Aug 2003 09:51:27 -0700
From: Jun Sun <jsun@mvista.com>
To: Adeel Malik <AdeelM@avaznet.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Information required
Message-ID: <20030827095127.D8701@mvista.com>
References: <10C6C1971DA00C4BB87AC0206E3CA38262718E@1aurora.enabtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <10C6C1971DA00C4BB87AC0206E3CA38262718E@1aurora.enabtech>; from AdeelM@avaznet.com on Wed, Aug 27, 2003 at 07:30:26PM +0500
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Aug 27, 2003 at 07:30:26PM +0500, Adeel Malik wrote:
> Hi All,
>            I am involved in Embedded Linux Development for MIPS Processor. I
> need to write a device driver for a MIPS Target Platform. When I insmod the
> driver.o file, the linux bash script running on the target hardware gives me
> the error message like ;
> 1. unable to resolve the printk function
> 2. unable to resolve the register_chardev function
> etc.
> Can you plz give me the direction as to how to proceed to tackle this
> situation.

Make sure your kernel compiled with module option turned on.
Does it use module version (CONFIG_MODVERSIONS)?
If so, add -DMODVERSIONS -include $(KERNEL_PATH)/include/linux/modversions.h
to your CFLAGS.

Jun
