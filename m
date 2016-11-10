Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 02:48:04 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:59212 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993001AbcKJBr5iNzBL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2016 02:47:57 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 90787ffa
        for <linux-mips@linux-mips.org>;
        Thu, 10 Nov 2016 01:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=cftwH8d/dQj1PrGgibTszCS2MBk=; b=rLPwua
        gsLehyX3CtGf30tISQ2KznStDfh+MPRDusYk0LoqrXIQ5I5NYzaIzbz3oO6fMR4W
        3cYNF2sx9+ln100QB2VGdtJRVgr+AaJbZ4Y3QG9VL5s0ZNFdyyPNfp+xMdAlh6We
        Pkw2opCJeauG3abbFTv17Uv/P5KwVYD2+1g+s+prsBQvIy8HRT7ohXPWLOeUkesX
        DfyhXXP4DAiAPTwmkeBcXFuxm9I8VBd1HjUtIYTnkgwPbZrfocwBmuWaVLNdMvHv
        hamcDMtdDoZWn0t+nLLsz8dYl1wCX95P8NLCmyMsYEJIdztOi7zTiXZN1UOIqGk8
        6Z1LC/D7Q4HK6F7w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id af59f300 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Thu, 10 Nov 2016 01:45:47 +0000 (UTC)
Received: by mail-lf0-f50.google.com with SMTP id c13so178148497lfg.0
        for <linux-mips@linux-mips.org>; Wed, 09 Nov 2016 17:47:49 -0800 (PST)
X-Gm-Message-State: ABUngve3S4I6zCcl+O+9/gE26v5TpGna0e7qQ/WXnEuowjAiUWCAX24/OKLWdg6XJ33WV6aTqu8h2YX65t/kVQ==
X-Received: by 10.25.99.12 with SMTP id x12mr1086828lfb.174.1478742468140;
 Wed, 09 Nov 2016 17:47:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.208.80 with HTTP; Wed, 9 Nov 2016 17:47:47 -0800 (PST)
In-Reply-To: <5823BCA3.2020202@caviumnetworks.com>
References: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com>
 <5823BCA3.2020202@caviumnetworks.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 10 Nov 2016 02:47:47 +0100
X-Gmail-Original-Message-ID: <CAHmME9oXsRrABzCjCQ_+O+QJmMgWyoyj73igHLaJKNfbf-brDQ@mail.gmail.com>
Message-ID: <CAHmME9oXsRrABzCjCQ_+O+QJmMgWyoyj73igHLaJKNfbf-brDQ@mail.gmail.com>
Subject: Re: Proposal: HAVE_SEPARATE_IRQ_STACK?
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>,
        k@vodka.home.kg
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
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

On Thu, Nov 10, 2016 at 1:17 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> Easiest thing to do would be to select 16K page size in your .config, I
> think that will give you a similar sized stack.

I didn't realize that was possible...

I'm mostly concerned about the best way to deal with systems that have
a limited stack size on architectures without support for separate irq
stacks. Part of this I assume involves actually detecting with a
processor definition that the current architecture has a deceptively
small stack.
