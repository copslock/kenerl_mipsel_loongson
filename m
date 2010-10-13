Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Oct 2010 20:01:15 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:35541 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491141Ab0JMSBM convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Oct 2010 20:01:12 +0200
Received: by qyk4 with SMTP id 4so3898803qyk.15
        for <multiple recipients>; Wed, 13 Oct 2010 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6fb890Jexd9WrUutBXPJyIPL9LP9J7fpEcuhukLSZOc=;
        b=IXqIZ5beazV+lZ86AtugcvjxMTcbkBPhtD3Ib2FoLHiFBNoY6v/G2nEX/NNiS0OsJ6
         o8d0nb8ujodUdzMFjqL0inHZr1/kl5ZgBnyfQQMTRYusmosBe0+OZnLGol0WWGmvbGDV
         XorK8yjMiFi1byfEmn86DrY8nQz3Iqm8JbIyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v+7W9HKWWe+fT5v+48FzjkuZyG56hiXoJh5Ov0F+B1AR/bR4geOcn6VAoZvDOdeocj
         AfO/S0o64mvNVSDw77QwXU/rx/Fy02ydca7CBRuLJY/3vX8vgnGpthz83Z9EhfL4yXGP
         ivLuUD2Jv4OL6yB0oz3OEyF/xRzAxOKBY6Ukw=
MIME-Version: 1.0
Received: by 10.224.215.199 with SMTP id hf7mr7203233qab.269.1286992866271;
 Wed, 13 Oct 2010 11:01:06 -0700 (PDT)
Received: by 10.224.67.8 with HTTP; Wed, 13 Oct 2010 11:01:06 -0700 (PDT)
In-Reply-To: <20101013075346.GA24052@linux-mips.org>
References: <f3f140ca90dc9dac2f645748bc3a0150@localhost>
        <20101013075346.GA24052@linux-mips.org>
Date:   Wed, 13 Oct 2010 11:01:06 -0700
Message-ID: <AANLkTikinkyEu-ozyiHOhr1D4ZLwv0jZwbk=4jq_YM9J@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] MIPS: HIGHMEM DMA on noncoherent MIPS32 processors
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Nicolas Pitre <nico@fluxnic.net>, Gary King <gking@nvidia.com>
Cc:     dediao@cisco.com, ddaney@caviumnetworks.com, dvomlehn@cisco.com,
        sshtylyov@mvista.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Oct 13, 2010 at 12:53 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> It's this disabling of interrupts which I don't like.  It's easy to get
> around it by having one kmap type for each of process, softirq and
> interrupt context.

I am curious as to why ARM opted for the "pte push/pop" strategy
(kmap_high_l1_vipt()) instead of something along these lines?

Is there a reason why using 3 kmap types to solve the "interrupted
flush problem" would work for MIPS, but is not a good solution on ARM?

> The good news is that Peter Zijlstra has rewritten kmap to make the need
> for manually allocated kmap types go away and his patches are queued to
> be merged for 2.6.37.  So I'd like to put this patch on hold until after
> his patches are merged.

OK, I'll take a look at that.  Thanks for the pointer.

> Does your system have both highmem and cache aliases?

This system has HIGHMEM + SMP, no cache aliases.
