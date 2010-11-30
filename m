Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2010 04:21:28 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:34820 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491008Ab0K3DVZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 30 Nov 2010 04:21:25 +0100
Received: by iwn36 with SMTP id 36so906224iwn.36
        for <multiple recipients>; Mon, 29 Nov 2010 19:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZQo9YNrpa7dnmtWWoUZn1I2wnrXUU8xjYyDeHMT1fgU=;
        b=VKaOmMAR07MnllZI2dT90oajj7oja51Y0tqtoJA5HMn7dbWqKSqQ2RH0bEoBsiQz6c
         vJNHnmHJnqoxax02x6kYsPgcWm/LIB9a1v16CAqa+qZZIlAFRixJ1RDGZhq04xUvRkmK
         Zee/Hqaw/rXr/UckhPnTZr/xKqAwlShH2tVxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Brin27mT2wE/UXO08I+X0igdvXNe4RDKtM4SGo+s8L0HhOujByXCtDvwSTpbkJEvmJ
         NcMMEbw/ydQDN86CPyilRabYP2z/XHRuAaXiEhbBj76/kMHSbZTbppBoR7htqerwNh7p
         G7Plj48/3z+6chR2vivhCYSF5Ab5p/AJskKgg=
MIME-Version: 1.0
Received: by 10.231.34.3 with SMTP id j3mr6579342ibd.100.1291087282740; Mon,
 29 Nov 2010 19:21:22 -0800 (PST)
Received: by 10.231.8.135 with HTTP; Mon, 29 Nov 2010 19:21:22 -0800 (PST)
In-Reply-To: <4CF46741.9060902@paralogos.com>
References: <AANLkTi=yHm72=sM=QwLpm=aDRnxVf7ZM5=W6eNzgVoTN@mail.gmail.com>
        <20101122034141.GA13138@linux-mips.org>
        <4CEAE1EE.9020406@paralogos.com>
        <AANLkTimuJLxG2KoibRxzcHkX3LoKsTWqJSF_e=ouFi+b@mail.gmail.com>
        <4CEE877C.7020309@paralogos.com>
        <AANLkTinUSjvjwHVJoRW-Fr75WDfheq3hSM_hEBMsEUXK@mail.gmail.com>
        <4CF46741.9060902@paralogos.com>
Date:   Mon, 29 Nov 2010 19:21:22 -0800
Message-ID: <AANLkTikb32T_c7iu6aa0mXDDqC4ncsV9iQAqyVKHy1_y@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ASID conflict after CPU hotplug
From:   Maksim Rayskiy <maksim.rayskiy@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <maksim.rayskiy@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksim.rayskiy@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Nov 29, 2010 at 6:53 PM, Kevin D. Kissell <kevink@paralogos.com> wrote:
> Having done surgery in the past to the ASID management code, this sounds
> like
> a much more rational explanation of the observed problem.  Your proposed mod
> sounds like it might work, but local_flush_tlb_mm() is implemented in terms
> of
> drop_mmu_context(), which only does what you want if the CPU executing the
> code is *not* one of the CPUs participating in the memory map.  Otherwise,
> instead of clearing the ASID in the table, it allocates a new one.  I have a
> concern
> that this may re-randomize things in a way that will solve your problem
> *most*
> of the time, but not always.
>

Actually, if you call this function late enough, specifically when
cpu_online(cpu) is 0, it does exactly what I want from it - that is
clears ASID in the context.
I am calling it from play_dead() which is platform specific, but there
might be a place for it in platform-independent code as well.
Another option would be not to use drop_mmu_context() but rather clear
the context directly, since we know exactly what we want to do at this
point.

> Now that we have a better understanding of the failure, your initial notion
> of *not* restarting the ASID sequence on a hotplug insertion doesn't seem
> as crazy - it's certainly the zen "doing by doing nothing" way to go,
> without
> the iterative overhead of walking the full process table.  But as we
> discussed,
> it has the downside of requiring new state infrastructure for tracking
> hotplugs,
> and we'd want to be sure that it's well behaved in the case where we have a
> post-initial-boot hotplug event that brings a CPU online that has never been
> initialized.  To take that tack, we'd need a per-CPU-slot bit which says "I
> have
> a valid ASID sequence, thank you", which is checked in per_cpu_trap_init()
> (or some other appropriate hook), and the ASID "cache" is initialized only
> if it's needed, which *might* be on a hotplug.

You are talking about adding this bit to cpuinfo_mips, correct?

Maksim.

>
> /K.
>
