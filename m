Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jul 2010 05:03:46 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:32901 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491130Ab0GXDDl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jul 2010 05:03:41 +0200
Received: by vws11 with SMTP id 11so1011484vws.36
        for <multiple recipients>; Fri, 23 Jul 2010 20:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=CEIkfw1BQbGDuWI9+wVfh3ob859x3lHwUJZe5ipc1Q0=;
        b=TwH40I6NqkvWmSZABUqVid30R0nCgnDEWhta2s3jvQuqf++6PO4IKM7t92cE7jPWMf
         QAb4eGZ/Z0WBhFItNk0v0ibJS2hm9bWGJBz9g9C3TdtvPZAPPXgwBs7OBISer8xVQQ8W
         TmvHtBBSotzLf1wiug9W3dpi9aAGwBWDNnSu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lkrdSl75xt8SvqbjaKBRFU552znB11lemIcGa9rrsHZux6Z3b2YaJ+aLl5VuUhBmHa
         Sr7Pg/6zC3SGaVQ4dLo3hr1t01aOdNnyAgBr9E1wfEYxDqlPRJzNrL0l6kvfdathWgOs
         pmVY8J00D+FNUh9bXaVzYmPN/jb5TkpHzfJ1c=
MIME-Version: 1.0
Received: by 10.220.161.203 with SMTP id s11mr2375654vcx.195.1279940614695; 
        Fri, 23 Jul 2010 20:03:34 -0700 (PDT)
Received: by 10.220.85.211 with HTTP; Fri, 23 Jul 2010 20:03:34 -0700 (PDT)
In-Reply-To: <20100724014314.GA29846@dediao-lnx2.corp.sa.net>
References: <20100724014314.GA29846@dediao-lnx2.corp.sa.net>
Date:   Fri, 23 Jul 2010 20:03:34 -0700
Message-ID: <AANLkTinBb3SN1DRL9Zt8Mu1fAYgsx9VRm4FwBz4oNfdq@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Apply kmap_high_get on DMA functions.
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Dezhong Diao <dediao@cisco.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, dvomlehn@cisco.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Jul 23, 2010 at 6:43 PM, Dezhong Diao <dediao@cisco.com> wrote:
> I don't recommend to do that in such a way (such as ARM does). In MIPS, we normally setup the mapping before
> the dma function is invoked. That means there is something wrong if addr is 0.

I don't understand the HIGHMEM / VM code well enough yet to
intelligently comment on this assumption.  And it looks like the ARM
developers are still trying to sort out whether their code is doing
the right thing in all circumstances:

http://www.spinics.net/lists/arm-kernel/msg89465.html

But if the (addr == 0) condition should never occur on a properly
functioning system, I would rather see an error message than be forced
to debug a mysterious coherency problem caused by missing flushes.

Any chance you could add a BUG() in the else clause?

BTW: are you supporting DMA directly to high memory?

Thanks.
