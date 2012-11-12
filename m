Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2012 12:55:24 +0100 (CET)
Received: from mail-vb0-f49.google.com ([209.85.212.49]:47013 "EHLO
        mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823018Ab2KLLzXIoSIl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2012 12:55:23 +0100
Received: by mail-vb0-f49.google.com with SMTP id fo1so6063372vbb.36
        for <linux-mips@linux-mips.org>; Mon, 12 Nov 2012 03:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FIoKwVAriuVEPBZki2KlHe2/bEXlLRqasoza8Wi9Z2k=;
        b=X/wrrWjMGp+ryzvCSHNaRsJ/6V0FI5drkG1OWWzTGZ8D/9zTQKlR04KZc6ZyHtB3gF
         BPkOb1nwJ2WKBoCg5ykVmAA0P+IAN5tSoWE8hFHkjp673dKe81tiORgNrTo8q2T/4XEs
         Yubum63cjbHKVZD3WRZhCQNjXKiyO61maNWLtxKHcRzcNe8fduYXPYDbELWRyL26/Key
         RVtKUX0LB9Hq1lOrChLoabvy0PCRQO0IUd9LBYpUy0MhHdld4yKj9g4YufvuWCLi5n8H
         rqe0XLIVw/6YShdrCfOeGwjMTu5asLCARhvNhN/c8/z+26c3dceSU7n/O/QerB7RBbe+
         b0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=FIoKwVAriuVEPBZki2KlHe2/bEXlLRqasoza8Wi9Z2k=;
        b=Ue4TsXgkVkFL+xY5udGdqh17+DQbHwyTdsjXcx7toxvi6BA8vVuvGxme1ZEnqQu1qN
         tElcQd8Lg1W7o6qsroaWfjQ1vnnvJcfFMbNC73+435Pg6DNPyBX7YpNvLS3RsaRFbAkQ
         nwrz+6bRtgQRKZE/Sr9xqgPXHPudtRLhrbZV1QKV/77DMMuqJ95XoQmXs6endIokrLc4
         Tx4RWKh9FZxH1xWJn5ctgXhJtzPRbPfiHcvybuWfXQBmsrgsBeE1dykNvoH3dP4ZfrMA
         r7FvgjNR30Vl6rhL3E5Ymu8qQ4zN1Te7oalWvJHpCtbun0GCIW9FPq8wav+yHLo5AuMz
         0JfQ==
MIME-Version: 1.0
Received: by 10.58.143.12 with SMTP id sa12mr19712000veb.43.1352721316759;
 Mon, 12 Nov 2012 03:55:16 -0800 (PST)
Received: by 10.58.6.235 with HTTP; Mon, 12 Nov 2012 03:55:16 -0800 (PST)
In-Reply-To: <509D0F86.30607@gmail.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
        <1352155633-8648-4-git-send-email-walken@google.com>
        <509D0F86.30607@gmail.com>
Date:   Mon, 12 Nov 2012 03:55:16 -0800
Message-ID: <CANN689E4jXT-VA3j54h_MBgCCc9YK0o_E7PY326NnvdiHmAgFQ@mail.gmail.com>
Subject: Re: [PATCH 03/16] mm: check rb_subtree_gap correctness
From:   Michel Lespinasse <walken@google.com>
To:     Sasha Levin <levinsasha928@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        William Irwin <wli@holomorphy.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Dave Jones <davej@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQleoHVT1cvlCzhe/UX1oN6RG51g4nQGhunUslyft0g1TWOAyJkMsRSM63SL7ptiuSFuAnWRnbYM2FAm1ol2zEG42LCXOIO3+iyk6u9kcMhMLqsOLNIwiZttcubIdePrnAADwj6uTPred43C4adGLksncw6Rqtu170dVnc70tLUaTvYY6pdnUzJNF6oghIskNVViEOEXNVotGHQVlnrgWUIZXrbxTw==
X-archive-position: 34970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: walken@google.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Nov 9, 2012 at 6:13 AM, Sasha Levin <levinsasha928@gmail.com> wrote:
> While fuzzing with trinity inside a KVM tools (lkvm) guest, using today's -next
> kernel, I'm getting these:
>
> [  117.007714] free gap 7fba0dd1c000, correct 7fba0dcfb000
> [  117.019773] map_count 750 rb -1
> [  117.028362] ------------[ cut here ]------------
> [  117.029813] kernel BUG at mm/mmap.c:439!
>
> Note that they are very easy to reproduce.

Thanks for the report. I had trouble reproducing this on Friday, but
after Hugh came up with an easy test case I think I have it figured
out. I sent out a proposed fix as "[PATCH 0/3] fix missing
rb_subtree_gap updates on vma insert/erase". Let's follow up the
discussion there if necessary.

Cheers,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
