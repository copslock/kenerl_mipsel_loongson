Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2016 10:47:43 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32783 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbcJUIrgsUpCg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2016 10:47:36 +0200
Received: by mail-pf0-f196.google.com with SMTP id i85so8057400pfa.0;
        Fri, 21 Oct 2016 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=PqayG1krtDwGeqKKVh1XS0Xcc3FiidRkaIcpFxVXkFE=;
        b=0CF1Kw6bklqgHfc1VFjsVdTrO7lpc140ZnBRpeE0jwsjjMrryuEAehinVuMa/EJN9Y
         eS1A+U7h3JGSDXmyGvzofhIamuT44XqFflpv8OlmoSMgNOq0qr4DK1JXDewY0nsDlrKH
         hbkE+UXDYDD1CEK0pCIQINYd5fq0EvxrQCf7NfsUbd0TKzJPif6V0mXioMEywfe5PN4j
         N2ONuKZR8b/ScKmVaXyZSLIuE8se0zBZxLZ7CYMH03ee9hvzr2Jp0sy5DlOgsDw3Slbl
         c1xlOR9iS0Ae3bMz464+g+3xsVree0eU4ayRu/8h8AK76PWusn9keZm41LorBY82mEPy
         1KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=PqayG1krtDwGeqKKVh1XS0Xcc3FiidRkaIcpFxVXkFE=;
        b=Gy63+pFvOp39//5t6Kx+k07MX+64W7ND0vMHc4uCwrku/saWsyyCjPSRWaZ+JC3N4E
         nB7JJICXwkvzNJyTbURW1dfXY5+ID5bNhZIEKc2ZPIkVXhlXyOqxTHMn88wwHP8NpvTU
         MIuEEql7njUfkJul3Z0IQyN7eU8QCJZyzvLRBTB5BATSEtf+7nTjglI/WEb6wvBSWVUy
         QjLCvYqGUjVNnzuJ4frC1IO1ypD+eGPt197/dXy6L5FDHT0zCa3Xgrddw16FeDave4L4
         3C6QpSK3utMsVhZ2gHLRt3m7VZX5++MhCBYCXQjLBu5TUs7S0Jx2BJYoMwW3IT9RyyVL
         VlWA==
X-Gm-Message-State: AA6/9RnAPEBQ2w8TDhIC6qHD63QRi8vldWlReQb2wBrL1zIlYpVgBk2+M5E9yspKIqf3SA==
X-Received: by 10.98.149.74 with SMTP id p71mr9430569pfd.126.1477039650710;
        Fri, 21 Oct 2016 01:47:30 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id w67sm3085048pfd.36.2016.10.21.01.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Oct 2016 01:47:30 -0700 (PDT)
Date:   Fri, 21 Oct 2016 19:47:18 +1100
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/6] MIPS: Use thin archives & dead code elimination
Message-ID: <20161021194718.2cd4b93e@roar.ozlabs.ibm.com>
In-Reply-To: <1724594.nvOo2qz5cT@np-p-burton>
References: <20161020202705.3783-1-paul.burton@imgtec.com>
        <20161021115147.0f6eea51@roar.ozlabs.ibm.com>
        <1724594.nvOo2qz5cT@np-p-burton>
Organization: IBM
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <npiggin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: npiggin@gmail.com
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

On Fri, 21 Oct 2016 08:45:47 +0100
Paul Burton <paul.burton@imgtec.com> wrote:

> Hi Nick,
> 
> On Friday, 21 October 2016 11:51:47 BST Nicholas Piggin wrote:
> > Paul Burton <paul.burton@imgtec.com> wrote:  
> > > This series fixes a few issues with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> > > and then enables it, along with CONFIG_THIN_ARCHIVES, for MIPS. This
> > > 
> > > leads to a typical generic kernel build becoming ~5% smaller:
> > >   add/remove: 0/3028 grow/shrink: 1/14 up/down: 18/-457362 (-457344)
> > >   ...
> > >   Total: Before=9001030, After=8543686, chg -5.08%
> > > 
> > > Applies atop v4.9-rc1.  
> > 
> > Very nice, and thanks for the kbuild fixes, I think they all look sane.
> > 
> > Let's try to get those kbuild fixes in through the kbuild tree first
> > (which has some other fixes required for 4.9). I can take them and send
> > them to kbuild maintainer if you like.  
> 
> That sounds great :)
> 
> > On powerpc we'll likely provide an option to select these manually for
> > 4.9 because there has been the odd toolchain issue come up, so that's
> > something to consider.  
> 
> I imagine the MIPS bits will probably be v4.10 material, but hopefully Ralf 
> can get them into -next as soon as possible after the kbuild bits are in, 
> which should give us some time to discover any toolchain issues.

Okay, whatever works for you.


> > For your linker script, you may consider putting the function sections
> > into the same input as other text. TEXT_TEXT does not include .text.*,
> > so mips's .text.* below it will catch those.
> > 
> > You may just open-code your TEXT_TEXT, and have:
> > 
> > *(.text.hot .text .text.fixup .text.unlikely .text.[0-9a-zA-Z_]*)
> > 
> > or similar.  
> 
> Ah, so are you saying that would give the linker more scope for discarding 
> things?

I don't think discarding, but it will allow those sections to be placed
together with more scope for reordering. This can reduce the amount of
branch trampolines required.

Aside from that, it just gives less change in behaviour. Without
-ffunction-sections, those functions would be placed in .text section,
so you ideally want to keep them there when enabling it.

Thanks,
Nick
