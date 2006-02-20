Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 20:18:27 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:11226 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133598AbWBTUSS
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 20:18:18 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k1KKP47S021651;
	Mon, 20 Feb 2006 12:25:05 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k1KKP089024600;
	Mon, 20 Feb 2006 12:25:01 -0800 (PST)
Message-ID: <43FA263B.9030601@mips.com>
Date:	Mon, 20 Feb 2006 21:27:39 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@mips.com>
CC:	Rojhalat Ibrahim <imr@rtschenk.de>,
	Mark E Mason <mark.e.mason@broadcom.com>,
	linux-mips@linux-mips.org
Subject: Re: Tracking down exception in sched.c
References: <7E000E7F06B05C49BDBB769ADAF44D0773A636@NT-SJCA-0750.brcm.ad.broadcom.com> <43F9B168.6090105@rtschenk.de> <43F9C58E.4020606@mips.com> <43F9D215.3090506@rtschenk.de> <003c01c6362d$53ea4c90$10eca8c0@grendel>
In-Reply-To: <003c01c6362d$53ea4c90$10eca8c0@grendel>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
>> The behavior of the two loops is not the same because sched_init
>> is called long before smp_prepare_cpus. Therefore for_each_cpu
>> only loops once for CPU 0. I know this is not a great fix.
>> I simply reverted the code to what's worked before.
> 
> It's certainly the code that I'm still using!  ;o)  So prom_build_cpu_map
> needs to be called earlier (as in maybe from smp_prepare_boot_cpu?).

OK, when I wrote the above, I was blinded by the fact that I'm personally
doing my SMP (SMTC) work on a downrev development tree, where prom_build_cpu_map()
is still invoked explicitly from smp_prepare_cpus(), just before prom_prepare_cpus().
In those sources, I was able to do what I describe and have the for_each_cpu()
in sched_init() work fine.

But apparently current sources no longer even invoke prom_build_cpu_map(),
having merged that functionality with prom_prepare_cpus(). It looks to me
as if calling prom_prepare_cpus() from smp_prepare_boot_cpu() as in the
patch below, should do the right thing in all current cases, but it *is*
standing the SMP  startup  logic a bit on its head.  Maybe this is why
prom_build_cpu_map() had a separate existence in the first place...

		Regards,

		Kevin K.

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 5e18986..7ec9579 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -236,7 +236,6 @@ void __init smp_prepare_cpus(unsigned in
         init_new_context(current, &init_mm);
         current_thread_info()->cpu = 0;
         smp_tune_scheduling();
-       prom_prepare_cpus(max_cpus);
  }

  /* preload SMP state for boot cpu */
@@ -251,6 +250,8 @@ void __devinit smp_prepare_boot_cpu(void
         cpu_set(0, phys_cpu_present_map);
         cpu_set(0, cpu_online_map);
         cpu_set(0, cpu_callin_map);
+       /* This is done early to populate phys_cpu_present_map for sched_init */
+       prom_prepare_cpus(max_cpus);
  }

  /*
