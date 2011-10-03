Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2011 07:46:59 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:57089 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491142Ab1JCFqv convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Oct 2011 07:46:51 +0200
Received: by wyi11 with SMTP id 11so3579596wyi.36
        for <multiple recipients>; Sun, 02 Oct 2011 22:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=B3kH5w8m1x19xBpyvNUdel9KeWwwoPxxWU1meVHo8mU=;
        b=YvC8Qxh90tybaVZPz1WNq/OajpzewZyi0xZSzPFgl4lXvuhW5WZMMVvOtV8Iz848PP
         1vmX5YOIWxV+5FaAgQVEi2VqCQXGBpWLEbwtXTd2nGq0uCDXO1oHGoOCy31pOo3KpwZ1
         egoPRAZM1Q3Jg2OUAW158wd9mLIdpwvSFAPyw=
MIME-Version: 1.0
Received: by 10.216.230.2 with SMTP id i2mr2891191weq.28.1317620806260; Sun,
 02 Oct 2011 22:46:46 -0700 (PDT)
Received: by 10.216.73.193 with HTTP; Sun, 2 Oct 2011 22:46:46 -0700 (PDT)
In-Reply-To: <20111002083044.GA23668@jayachandranc.netlogicmicro.com>
References: <CAJd=RBAc8Zv1JZfrAx2Ajj7fdJv=oA+eYHVBLfcFNOoZNyG7fg@mail.gmail.com>
        <20111002083044.GA23668@jayachandranc.netlogicmicro.com>
Date:   Mon, 3 Oct 2011 13:46:46 +0800
Message-ID: <CAJd=RBBt0xNgUrz9XnU0TcHo443t3j323zYg8jMPYRjXsV=EHw@mail.gmail.com>
Subject: Re: [RFC] mark Netlogic XLR chip as SMT capable
From:   Hillf Danton <dhillf@gmail.com>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 798

On Sun, Oct 2, 2011 at 4:30 PM, Jayachandran C.
<jayachandranc@netlogicmicro.com> wrote:
> On Sun, Oct 02, 2011 at 03:26:14PM +0800, Hillf Danton wrote:
>> Netlogic XLR chip has multiple cores. Each core includes four integrated
>> hardware threads, and they share L1 data and instruction caches.
>>
>> If XLR chip is marked to be SMT capable, linux scheduler then could do more,
>> say idle load balancing.
>>
>> Any comment is welcom, thanks.
>
> I may be missing something here, but how about just setting cpu_data[].core in
> the init_secondary method?  That would avoid the change to kernel/smp.c.
>

Got and thanks. It is re-prepared as the following:)

Hillf
----------------------------------------------------------------------------
Subject: [RFC] Mark Netlogic XLR chip to be SMT capable

Netlogic XLR chip has multiple cores. Each core includes four integrated
hardware threads, and they share L1 data and instruction caches.

If XLR chip is marked to be SMT capable, scheduler then could do more, say,
idle load balancing.

According to JC's comment changes are now confined only to the code of XLR.

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
+	cpu = smp_processor_id();
+	core_id = (cpu >> 2) & 0x7;
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
