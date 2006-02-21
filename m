Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 12:59:32 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:50436 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133411AbWBUM6q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Feb 2006 12:58:46 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1LD5eiq018985;
	Tue, 21 Feb 2006 13:05:44 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1L1k8tf000564;
	Tue, 21 Feb 2006 01:46:08 GMT
Date:	Tue, 21 Feb 2006 01:46:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Rojhalat Ibrahim <imr@rtschenk.de>,
	Mark E Mason <mark.e.mason@broadcom.com>,
	linux-mips@linux-mips.org
Subject: Re: Tracking down exception in sched.c
Message-ID: <20060221014608.GD30856@linux-mips.org>
References: <7E000E7F06B05C49BDBB769ADAF44D0773A636@NT-SJCA-0750.brcm.ad.broadcom.com> <43F9B168.6090105@rtschenk.de> <43F9C58E.4020606@mips.com> <43F9D215.3090506@rtschenk.de> <003c01c6362d$53ea4c90$10eca8c0@grendel> <43FA263B.9030601@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FA263B.9030601@mips.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 20, 2006 at 09:27:39PM +0100, Kevin D. Kissell wrote:

> But apparently current sources no longer even invoke prom_build_cpu_map(),
> having merged that functionality with prom_prepare_cpus(). It looks to me
> as if calling prom_prepare_cpus() from smp_prepare_boot_cpu() as in the
> patch below, should do the right thing in all current cases, but it *is*
> standing the SMP  startup  logic a bit on its head.  Maybe this is why
> prom_build_cpu_map() had a separate existence in the first place...

Primarily historic reasons actuall.  In 2.4 mips and mips64 used to be
separate and evolution did diverge a bit in the SMP area and this is the
radioactive fallout from it ;-)

> @@ -251,6 +250,8 @@ void __devinit smp_prepare_boot_cpu(void
>         cpu_set(0, phys_cpu_present_map);
>         cpu_set(0, cpu_online_map);
>         cpu_set(0, cpu_callin_map);
> +       /* This is done early to populate phys_cpu_present_map for 
> sched_init */
> +       prom_prepare_cpus(max_cpus);
>  }

Which won't compile because smp_prepare_boot_cpu doesn't define max_cpus.

Anyway, prom_prepare_cpus was running very late and in the past that
was causing problems with firmware which relies on it's mappings still
being alive while the machine had already been taken over by Linux.  The
patch which I cooked up - and haven't yet been able to test yet since my
barrel of midnight oil is about to run out - is calling it from
setup_arch().

  Ralf
