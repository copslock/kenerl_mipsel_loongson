Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Aug 2011 15:44:10 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:57183 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491183Ab1HENoD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Aug 2011 15:44:03 +0200
Received: by wyh11 with SMTP id 11so515613wyh.36
        for <multiple recipients>; Fri, 05 Aug 2011 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Gb0XDF/XT5kIHaXXGqcg89pop/MQJJLW4EA2DBLFA74=;
        b=nHOxuKSVoadNPjeLU8UyXb3iA0XelgnJA2TmrmVO0/b9FMRrGP7wtIO3fgsQr0Ht63
         NpZd/VCZUeHLHbJwp9bbSBIGhkJ8PPLv8q1h9IguZqmeQyi5hFvvOfxAYsBq689n9qsG
         7D8L4VaFhn/n90YfQAK3w9tyzeaOFlc4XivCg=
MIME-Version: 1.0
Received: by 10.216.80.14 with SMTP id j14mr2194232wee.9.1312551837449; Fri,
 05 Aug 2011 06:43:57 -0700 (PDT)
Received: by 10.216.46.136 with HTTP; Fri, 5 Aug 2011 06:43:57 -0700 (PDT)
In-Reply-To: <20110804185139.GA11724@jayachandranc.netlogicmicro.com>
References: <CAJd=RBDv1wsdVYmwdtr2BGOCuya1eKg4PeWeggPbz5u_5545ig@mail.gmail.com>
        <CA+7sy7B7-zTr4MojT+7C+AD4+ap4aiiJKX4u+fOPzR52yEJGJA@mail.gmail.com>
        <20110804185139.GA11724@jayachandranc.netlogicmicro.com>
Date:   Fri, 5 Aug 2011 21:43:57 +0800
Message-ID: <CAJd=RBC3-9nEwFd+d7RbbKp1aYbQyC9iPnqMvHDDH+kPYbSxcQ@mail.gmail.com>
Subject: Re: [RFC patch] MIPS/netlogic: dont setup boot CPU twice
From:   Hillf Danton <dhillf@gmail.com>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4155

On Fri, Aug 5, 2011 at 2:51 AM, Jayachandran C.
<jayachandranc@netlogicmicro.com> wrote:
> The nlm_cpu_ready[] entry is not set for the boot_cpu, it is set for only
> the secondary cpus in smpboot.S.  The code works as it is, but your patch
> makes it more explicit.
>
> My only commnet is that it might look better if you combine both the if checks.
>
Got and thanks. It is recooked as the following.

Hillf
------------------------------------------------------------------------------
Subject: [RFC patch] MIPS/netlogic: add comment for smp setup

It seems that BSP could be setup twice, but the nlm_cpu_ready array is only
set for ASPs in smpboot.S, not including BSP.

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---
 arch/mips/netlogic/xlr/smp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/netlogic/xlr/smp.c b/arch/mips/netlogic/xlr/smp.c
index b495a7f..b82667c 100644
--- a/arch/mips/netlogic/xlr/smp.c
+++ b/arch/mips/netlogic/xlr/smp.c
@@ -167,6 +167,10 @@ void __init nlm_smp_setup(void)

 	num_cpus = 1;
 	for (i = 0; i < NR_CPUS; i++) {
+		/*
+		 * BSP is not set in nlm_cpu_ready array, it is only for
+		 * ASPs (goto see smpboot.S)
+		 */
 		if (nlm_cpu_ready[i]) {
 			cpu_set(i, phys_cpu_present_map);
 			__cpu_number_map[i] = num_cpus;
