Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 09:08:13 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:2449 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20023857AbXHGIIK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2007 09:08:10 +0100
Received: from anguille.univ-lyon1.fr ([134.214.4.207])
	by hall.aurel32.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1IIK3h-0008PU-Mx; Tue, 07 Aug 2007 10:04:53 +0200
Message-ID: <46B8279F.1050404@aurel32.net>
Date:	Tue, 07 Aug 2007 10:04:47 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: IceDove 1.5.0.10 (X11/20070329)
MIME-Version: 1.0
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
CC:	mb@bu3sch.de, akpm@osdl.org, linux-mips@linux-mips.org,
	wbx@openwrt.org, nbd@openwrt.org, jolt@tuxbox.org
Subject: Re: [PATCH -mm 2/4] MIPS: BCM947xx support (v2)
References: <20070806150900.GG24308@hall.aurel32.net>	<200708062005.29657.mb@bu3sch.de>	<20070806183316.GB32465@hall.aurel32.net>	<200708062037.05995.mb@bu3sch.de>	<20070806191712.GA2019@hall.aurel32.net> <20070807094045.2c6eaa38.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070807094045.2c6eaa38.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Yoichi Yuasa a écrit :
> On Mon, 6 Aug 2007 21:17:12 +0200
> Aurelien Jarno <aurelien@aurel32.net> wrote:
> 
>> The patch below against 2.6.23-rc1-mm2 adds support for BCM947xx CPUs.
>> It originally comes from the OpenWrt patches.
> <snip>
>> --- a/arch/mips/bcm947xx/prom.c
>> +++ b/arch/mips/bcm947xx/prom.c
>> @@ -0,0 +1,58 @@
>> +/*
>> + *  Copyright (C) 2004 Florian Schirmer <jolt@tuxbox.org>
>> + *
>> + *  This program is free software; you can redistribute  it and/or modify it
>> + *  under  the terms of  the GNU General  Public License as published by the
>> + *  Free Software Foundation;  either version 2 of the  License, or (at your
>> + *  option) any later version.
>> + *
>> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
>> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
>> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
>> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
>> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
>> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
>> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
>> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
>> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
>> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>> + *
>> + *  You should have received a copy of the  GNU General Public License along
>> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
>> + *  675 Mass Ave, Cambridge, MA 02139, USA.
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/mm.h>
>> +#include <linux/sched.h>
>> +#include <linux/bootmem.h>
>> +
>> +#include <asm/addrspace.h>
>> +#include <asm/bootinfo.h>
>> +#include <asm/pmon.h>
>> +
>> +const char *get_system_type(void)
>> +{
>> +	return "Broadcom BCM947xx";
>> +}
>> +
>> +void __init prom_init(void)
>> +{
>> +	unsigned long mem;
>> +
>> +	mips_machgroup = MACH_GROUP_BRCM;
>> +	mips_machtype = MACH_BCM947XX;
> 
> If you don't have a plan using mips_machgroup/mips_machtype,
> it is not a must. 

It is not used in other parts of the code, so we can remove that part. I
will update my patch.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
