Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2010 19:39:04 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:61698 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492049Ab0KVSi5 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Nov 2010 19:38:57 +0100
Received: by gyg8 with SMTP id 8so236245gyg.36
        for <multiple recipients>; Mon, 22 Nov 2010 10:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Dg4wyOokvUfrWP3M1Y8b88c+WZO+V1NhrP0nmBdvRlE=;
        b=UKwS97ILb0C1wfkFnsBlWtDCUVaz2R2vm9FyR3kh3q1GB/hRgiYdvftn+arXZTsG8m
         KEcKJyzYwL72/HJ5ZaRR7N0MxpLt42mgz5aJUQKCC53u/8hNAs+6jOJh52VE4bageCy+
         8tt0C0NkYDic1nModiVXqRcK6YOoPQNPNWfjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wC0QCH+91AIDO3pAXg51Sv87dQVeqE7X2KlI6bC3fbXFL2FIasrfetLzeP4uoyADCW
         nYdjq2SGe40EzjVmyRT3L2Bohi+TTDvZfP7H6sofUcrXvVfLDeb+7pzJfcLv9cO+FYhZ
         MsITSoJnkh4NUPa7E5PEDnV4g400kuwj8wGGk=
MIME-Version: 1.0
Received: by 10.100.255.8 with SMTP id c8mr4338063ani.154.1290451130484; Mon,
 22 Nov 2010 10:38:50 -0800 (PST)
Received: by 10.100.209.10 with HTTP; Mon, 22 Nov 2010 10:38:50 -0800 (PST)
In-Reply-To: <20101122034141.GA13138@linux-mips.org>
References: <AANLkTi=yHm72=sM=QwLpm=aDRnxVf7ZM5=W6eNzgVoTN@mail.gmail.com>
        <20101122034141.GA13138@linux-mips.org>
Date:   Mon, 22 Nov 2010 10:38:50 -0800
Message-ID: <AANLkTin7GE+t6HLBq-JAt4=_+zu2U7TM3We=jccfY3Y=@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ASID conflict after CPU hotplug
From:   Maksim Rayskiy <maksim.rayskiy@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Kevin D. Kissell" <kevink@paralogos.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <maksim.rayskiy@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksim.rayskiy@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, Nov 21, 2010 at 7:41 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> Unfortunately I haven't yet found a BMIPS board or manual in my mailbox
> so I can't really give a definitate answer.  But let me describe how
> the MIPS34K handles it.
>
> The 34K supports two TLB modes, shared and split TLB.  The VSMP kernel
> uses the TLB in split mode in which half of the TLB entries is available
> to each of the two threads aka VPEs.  So with a 64 entry TLB that's 32
> entries per VPE then.  Each VPE (or rather TC but see further down) has
> it's own c0_entryhi register, thus it's own ASID.  So no ASID collisions
> possible, ever.  This is the same as on a conventional SMP system where
> TLB and ASID number space are also per CPU.
>
> The SMTC kernel model (usually) uses the shared model, that is all the 64
> entries are now available to all threads and the ASID space is shared.
> This means allocation of the same ASID to multiple TCs needs to be avoided.
>
> It seems BMIPS falls into the latter class?
>

No, each thread has a separate TLB and all TLB-related registers are
also per thread. The conflict I have found was the same ASID for two
different processes on the second TP.

I still do not understand all the details, but what I saw was after
the second TP is brought back online init process runs on (migrates to
?) it with entryHi=1. If it tries to spawn another process, the child
gets the same ASID, because current asid_cache value is 0 (well it is
actually 0x100, but only lower 8 bits matter).

> Need to think a little about potencial consequences of your suggested
> patch.  It seems ok.  Kevin, what do you think?
>
>  Ralf
>

Thanks,
Maksim.
