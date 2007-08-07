Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 01:46:54 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:19240 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021373AbXHGAqw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2007 01:46:52 +0100
Received: by mo.po.2iij.net (mo30) id l770ennS030777; Tue, 7 Aug 2007 09:40:49 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id l770ejVH022975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Aug 2007 09:40:46 +0900
Date:	Tue, 7 Aug 2007 09:40:45 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	yoichi_yuasa@tripeaks.co.jp, mb@bu3sch.de, akpm@osdl.org,
	linux-mips@linux-mips.org, wbx@openwrt.org, nbd@openwrt.org,
	jolt@tuxbox.org
Subject: Re: [PATCH -mm 2/4] MIPS: BCM947xx support (v2)
Message-Id: <20070807094045.2c6eaa38.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070806191712.GA2019@hall.aurel32.net>
References: <20070806150900.GG24308@hall.aurel32.net>
	<200708062005.29657.mb@bu3sch.de>
	<20070806183316.GB32465@hall.aurel32.net>
	<200708062037.05995.mb@bu3sch.de>
	<20070806191712.GA2019@hall.aurel32.net>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 6 Aug 2007 21:17:12 +0200
Aurelien Jarno <aurelien@aurel32.net> wrote:

> The patch below against 2.6.23-rc1-mm2 adds support for BCM947xx CPUs.
> It originally comes from the OpenWrt patches.
<snip>
> --- a/arch/mips/bcm947xx/prom.c
> +++ b/arch/mips/bcm947xx/prom.c
> @@ -0,0 +1,58 @@
> +/*
> + *  Copyright (C) 2004 Florian Schirmer <jolt@tuxbox.org>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/bootmem.h>
> +
> +#include <asm/addrspace.h>
> +#include <asm/bootinfo.h>
> +#include <asm/pmon.h>
> +
> +const char *get_system_type(void)
> +{
> +	return "Broadcom BCM947xx";
> +}
> +
> +void __init prom_init(void)
> +{
> +	unsigned long mem;
> +
> +	mips_machgroup = MACH_GROUP_BRCM;
> +	mips_machtype = MACH_BCM947XX;

If you don't have a plan using mips_machgroup/mips_machtype,
it is not a must. 

Yoichi
