Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2011 12:48:40 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:39172 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491023Ab1JDKsb convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Oct 2011 12:48:31 +0200
Received: by wyi11 with SMTP id 11so421709wyi.36
        for <multiple recipients>; Tue, 04 Oct 2011 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mxfpB5gv2gHxW7ila+ZnxFT+ITcEz/4F7/5YrbfXoPc=;
        b=X6T5LePl551KrqKQa/Z8KgbaSEg70y9QQifk7Aor0tzeyP/3bbwYX2zloVbuqiswIP
         crbDKWUq3W1pJvf990qNXydsBRQqknnZqcHM5stp/O5RBfJQukjrJ6Pk3WHqLvFLnapi
         ZLClaqf5+ksi3G+BPed3tBHbNRbYQfZmyvT7Q=
MIME-Version: 1.0
Received: by 10.216.229.91 with SMTP id g69mr1312606weq.13.1317725305866; Tue,
 04 Oct 2011 03:48:25 -0700 (PDT)
Received: by 10.216.73.193 with HTTP; Tue, 4 Oct 2011 03:48:25 -0700 (PDT)
In-Reply-To: <20111003103935.GA6016@jayachandranc.netlogicmicro.com>
References: <CAJd=RBAc8Zv1JZfrAx2Ajj7fdJv=oA+eYHVBLfcFNOoZNyG7fg@mail.gmail.com>
        <20111002083044.GA23668@jayachandranc.netlogicmicro.com>
        <CAJd=RBBt0xNgUrz9XnU0TcHo443t3j323zYg8jMPYRjXsV=EHw@mail.gmail.com>
        <20111003103204.GC6038@linux-mips.org>
        <20111003103935.GA6016@jayachandranc.netlogicmicro.com>
Date:   Tue, 4 Oct 2011 18:48:25 +0800
Message-ID: <CAJd=RBC9Rdnx4H=ASfvbSrtPTZ+nqvFXoK-im1HzwHrp1pqBxg@mail.gmail.com>
Subject: Re: [RFC] mark Netlogic XLR chip as SMT capable
From:   Hillf Danton <dhillf@gmail.com>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1901

On Mon, Oct 3, 2011 at 6:39 PM, Jayachandran C.
<jayachandranc@netlogicmicro.com> wrote:
> On Mon, Oct 03, 2011 at 11:32:04AM +0100, Ralf Baechle wrote:
>> On Mon, Oct 03, 2011 at 01:46:46PM +0800, Hillf Danton wrote:
>>
>> > +   unsigned int cpu, core_id;
>> > +
>> > +   cpu = smp_processor_id();
>> > +   core_id = (cpu >> 2) & 0x7;
>> > +   cpu_data[cpu].core = core_id;
>>
>> This is going to break in setups where Linux is not being booted on
>> what the hardware considers CPU core 0.  Which is not uncommon in embedded
>> setups.  You may want to probe the hardware for the core ID rather than
>> relying on smp_processor_id() here.
>
> Yes, the function hard_smp_processor_id() from netlogic/mips-extns.h has to
> be used here.
>
> This also conflicts with the recent patch-set for XLP support, but I don't
> know the status of that yet.
>

Thanks JC and Ralf. Your comments are included in the following version.

Hillf
----------------------------------------------------------------------------
Subject: [RFC] Mark Netlogic XLR chip to be SMT capable

Netlogic XLR chip has multiple cores. Each core includes four integrated
hardware threads, and they share L1 data and instruction caches.

If the chip is marked to be SMT capable, scheduler then could do more, say,
idle load balancing.

Changes are now confined only to the code of XLR, and hardware is probed
to get core ID for correct setup.

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---

--- a/arch/mips/netlogic/xlr/smp.c	Sun Oct  2 14:15:28 2011
+++ b/arch/mips/netlogic/xlr/smp.c	Mon Oct  3 13:33:02 2011
@@ -104,6 +104,12 @@ void nlm_early_init_secondary(void)
  */
 static void __cpuinit nlm_init_secondary(void)
 {
+	unsigned int cpu, core_id;
+
+	cpu = hard_smp_processor_id();
+	core_id = (cpu >> 2) & 7;
+	cpu_data[cpu].core = core_id;
+
 	nlm_smp_irq_init();
 }

@@ -176,6 +182,8 @@ void __init nlm_smp_setup(void)

 void nlm_prepare_cpus(unsigned int max_cpus)
 {
+	/* declare we are SMT capable */
+	smp_num_siblings = 4;
 }

 struct plat_smp_ops nlm_smp_ops = {
