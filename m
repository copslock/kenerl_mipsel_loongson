Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 12:42:13 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:40263 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6818472Ab3EBKmLVWngo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 May 2013 12:42:11 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1UXqxl-0003nL-JA; Thu, 02 May 2013 12:42:09 +0200
Date:   Thu, 2 May 2013 12:42:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jonas Gorski <jogo@openwrt.org>
cc:     eunb.song@samsung.com, "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: mips; boot fail after merge 3.9+
In-Reply-To: <CAOiHx=mBPHmDse4EwL-+Fgmpz0=XhcgF_0nWdyvErFO4NU7E0Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1305021241040.3972@ionos>
References: <20522420.158691367384219315.JavaMail.weblogic@epml17> <CAOiHx=mBPHmDse4EwL-+Fgmpz0=XhcgF_0nWdyvErFO4NU7E0Q@mail.gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36312
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

On Thu, 2 May 2013, Jonas Gorski wrote:

> On Wed, May 1, 2013 at 6:57 AM, EUNBONG SONG <eunb.song@samsung.com> wrote:
> >
> > Hello.
> > After merge cavium board boots fail, boot log messages are as follows.
> > I enabled initcall_debug for debugging.
> 
> I can confirm that MIPS does not seem to finish to boot after using
> the generic idle loop, I have the same problem on a different platform
> (bcm63xx), and bisecting showed the same commit.
> 
> (snip)
> 
> > I found this issue after cdbedc61c8d0122ad682815936f0d11df1fe5f57.
> > And i found something strange. I ran the git show for this commit.
> > As below "select GENERIC_IDLE_LOOP" is added for CONFIG_MIPS.
> > but the latest arch/mips/Kconfig file has not this one. I have tried to find when this is gone. but i can't find.
> > Is there any problem with this?
> 
> No, after all architectures were converted to use the generic idle
> loop the config symbol was removed, so it's now always on. The problem
> is rather that the generic idle loop does not seem to work on MIPS.
> Unfortunately due to limited knowledge in this area I can't really
> tell which part broke it.

Does the patch below fix your issue ?

Thanks,

	tglx

diff --git a/kernel/cpu/idle.c b/kernel/cpu/idle.c
index 8b86c0c..a8972fe 100644
--- a/kernel/cpu/idle.c
+++ b/kernel/cpu/idle.c
@@ -70,8 +70,10 @@ static void cpu_idle_loop(void)
 			check_pgt_cache();
 			rmb();
 
-			if (cpu_is_offline(smp_processor_id()))
+			if (cpu_is_offline(smp_processor_id())) {
 				arch_cpu_idle_dead();
+				continue;
+			}
 
 			local_irq_disable();
 			arch_cpu_idle_enter();
