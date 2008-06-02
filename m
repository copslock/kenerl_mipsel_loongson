Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2008 17:07:49 +0100 (BST)
Received: from p549F5CCF.dip.t-dialin.net ([84.159.92.207]:38583 "EHLO
	p549F5CCF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20021677AbYFBQHr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Jun 2008 17:07:47 +0100
Received: from yx-out-1718.google.com ([74.125.44.155]:51528 "EHLO
	yx-out-1718.google.com") by lappi.linux-mips.net with ESMTP
	id S525977AbYFBQGI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Jun 2008 18:06:08 +0200
Received: by yx-out-1718.google.com with SMTP id 36so74630yxh.24
        for <linux-mips@linux-mips.org>; Mon, 02 Jun 2008 09:05:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PVaRdja2mkx32MMyluimCzLHxRHHYxW3TBjgtP3Vro4=;
        b=pqcJIEtZkul3OnPZGmS63oFubYOCB8zeKzARs7oc1eadDdCQ3NMcPvaj59/0EtYldRy+ER3xeQpY3FxfLsQU95XNBpGaTB763UQJiuo/5xDj49Ezn2TMQaEBYZ8SCElDc1xftDzkQZWqpi4eoBATncWQaFH+WsDkfdCz3g5kzsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R6s2WQK7WH/I8wucKhxrLhLRVF5X/20ilTT39MMOvI33v4BLVImEEd2M0RxEYc3zaNh0TD4jIaxmfRjCnbug57AwgAk4KPpfbJ/UGnRUoF6hKU2sECfI77nhApCqGzi/Kg1aAnwtbDQTCpACLFTTsyFfVLOB12jHI9YcqhNwtdg=
Received: by 10.151.155.21 with SMTP id h21mr4663643ybo.142.1212421217947;
        Mon, 02 Jun 2008 08:40:17 -0700 (PDT)
Received: by 10.150.140.6 with HTTP; Mon, 2 Jun 2008 08:40:17 -0700 (PDT)
Message-ID: <90edad820806020840m2e9f5588x81f8c387aef23c6c@mail.gmail.com>
Date:	Mon, 2 Jun 2008 18:40:17 +0300
From:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
To:	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: Re: Malta build errors with 2.6.26-rc1
Cc:	"Martin Michlmayr" <tbm@cyrius.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
In-Reply-To: <20080529200506.GA27783@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080512163107.GA19052@deprecation.cyrius.com>
	 <90edad820805121246o328d1cdaide88594ce9d328b7@mail.gmail.com>
	 <20080528071240.GB10393@deprecation.cyrius.com>
	 <20080528085033.GA6250@alpha.franken.de>
	 <20080528151025.GA15325@deprecation.cyrius.com>
	 <20080529200506.GA27783@alpha.franken.de>
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

2008/5/29 Thomas Bogendoerfer <tsbogend@alpha.franken.de>:
> On Wed, May 28, 2008 at 05:10:25PM +0200, Martin Michlmayr wrote:
>> * Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2008-05-28 10:50]:
>> > I didn't fix the problems above. The change to traps.c only fixes
>> > traps.c for 64bit builds and it's a totally different issue. Looking
>> > at the warning/errors someone needs to fix some data types and use
>> > CKSEG0ADDR(). I don't have the hardware, so I could only provide an
>> > untested patch, if no one else steps forward...
>>
>> QEMU emulates Malta, so I (or someone else here) should be able to
>> test the patch.
>
>
> Fix 64bit Malta by using CKSEG0ADDR and correct casts
>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>
>  arch/mips/mips-boards/generic/amon.c |    4 ++--
>  include/asm-mips/gic.h               |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/mips-boards/generic/amon.c b/arch/mips/mips-boards/generic/amon.c
> index b7633fd..96236bf 100644
> --- a/arch/mips/mips-boards/generic/amon.c
> +++ b/arch/mips/mips-boards/generic/amon.c
> @@ -28,7 +28,7 @@
>
>  int amon_cpu_avail(int cpu)
>  {
> -       struct cpulaunch *launch = (struct cpulaunch *)KSEG0ADDR(CPULAUNCH);
> +       struct cpulaunch *launch = (struct cpulaunch *)CKSEG0ADDR(CPULAUNCH);
>
>        if (cpu < 0 || cpu >= NCPULAUNCH) {
>                pr_debug("avail: cpu%d is out of range\n", cpu);
> @@ -53,7 +53,7 @@ void amon_cpu_start(int cpu,
>                    unsigned long gp, unsigned long a0)
>  {
>        volatile struct cpulaunch *launch =
> -               (struct cpulaunch  *)KSEG0ADDR(CPULAUNCH);
> +               (struct cpulaunch  *)CKSEG0ADDR(CPULAUNCH);
>
>        if (!amon_cpu_avail(cpu))
>                return;
> diff --git a/include/asm-mips/gic.h b/include/asm-mips/gic.h
> index 3a492f2..954807d 100644
> --- a/include/asm-mips/gic.h
> +++ b/include/asm-mips/gic.h
> @@ -24,8 +24,8 @@
>
>  #define MSK(n) ((1 << (n)) - 1)
>  #define REG32(addr)            (*(volatile unsigned int *) (addr))
> -#define REG(base, offs)                REG32((unsigned int)(base) + offs##_##OFS)
> -#define REGP(base, phys)       REG32((unsigned int)(base) + (phys))
> +#define REG(base, offs)                REG32((unsigned long)(base) + offs##_##OFS)
> +#define REGP(base, phys)       REG32((unsigned long)(base) + (phys))
>
>  /* Accessors */
>  #define GIC_REG(segment, offset) \

My test was performed using a Malta 4Kc board. I was able to boot the
target up to the shell prompt with this patch applied to the current
Linus tree.

So, you might want to add

Tested-by: Dmitri Vorobiev <dmtiri.vorobiev@movial.fi>
