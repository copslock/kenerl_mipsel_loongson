Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jan 2017 10:53:56 +0100 (CET)
Received: from mail-wj0-f194.google.com ([209.85.210.194]:36700 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993064AbdABJxt2Ct6c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Jan 2017 10:53:49 +0100
Received: by mail-wj0-f194.google.com with SMTP id j10so68020381wjb.3
        for <linux-mips@linux-mips.org>; Mon, 02 Jan 2017 01:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1qNxZjKg7pDhpiXMYnzrxs2ofOammPoo16PBcb1sz/8=;
        b=wN9183a3Z3W4zEN/ttkTGnqvOGG0YbJawt0ilBCzUNVDoAjTpDpE/AdZsXT1HdYZMq
         099p0qWRTcUEAoIWJKDNGnGshGjU4tS81LucSynzWnOSAIh1pcGgP5DOrdQYOuUYhhu+
         B67l9N6rV+BbRh5DPpFykWBS8O9zbIT/gXG5SZRXxY1sfqggiGuobPf3XTvEFdIiLqYj
         W8JnGd0ckZ1H6hNQVgU2ixSE/Pi1nU+hd/CyCx7PGGOmA6X9oFgE0oBzAvsh34dsNBBx
         Tg3Fk+U160aTGF9Ep9s0ghUfWrfEIbsYKXjYXQzIZhqfVTOThcZmC4I3osgz9Z4RDXnt
         KtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1qNxZjKg7pDhpiXMYnzrxs2ofOammPoo16PBcb1sz/8=;
        b=RFn2roLyCNWYY6vomKARy63cIO0Zp04khn26YbzMc+a24zRybY3ecyLlkRt/l90m+/
         HtlwYD16J3qK6PP7YfVnU/0Vg7CqJkpHj9TCe3MOcKdsAnSOvadcint3IXTJMbvuVVVI
         ahOkKUYG4PCvNr5Y56BkcGEa3wwCmf3q644PNu3cEQ9BpNqB5E10TwfKlTRRgtab2M3D
         nvRGD/+WFb4oWE/HzChTC1AyR3/V4sbY8k3oPGhygUuzb9vDTUSZ49qo92UZAQIX/unZ
         b5z8T2MZsRjsLaHolt94iGoYG8sb7YN6fDz/DZWlilLHEd6Jh4XEAFgco6cxmD5TI75i
         Esvw==
X-Gm-Message-State: AIkVDXI3I9mpNP5btZNdvo8UqSlMg31P0OApFHD1L+8si3Z4UwXzaKebWSXvm906OEt3CA==
X-Received: by 10.194.173.228 with SMTP id bn4mr47197543wjc.161.1483350824037;
        Mon, 02 Jan 2017 01:53:44 -0800 (PST)
Received: from node.shutemov.name ([93.85.148.225])
        by smtp.gmail.com with ESMTPSA id j6sm87114194wjk.25.2017.01.02.01.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jan 2017 01:53:43 -0800 (PST)
Received: by node.shutemov.name (Postfix, from userid 1000)
        id 711DB648C170; Mon,  2 Jan 2017 12:53:42 +0300 (+03)
Date:   Mon, 2 Jan 2017 12:53:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dmitry Safonov <dsafonov@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org
Subject: Re: [RFC 1/4] mm: remove unused TASK_SIZE_OF()
Message-ID: <20170102095342.GD30735@node.shutemov.name>
References: <20161230155634.8692-1-dsafonov@virtuozzo.com>
 <20161230155634.8692-2-dsafonov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161230155634.8692-2-dsafonov@virtuozzo.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Return-Path: <kirill@shutemov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kirill@shutemov.name
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

On Fri, Dec 30, 2016 at 06:56:31PM +0300, Dmitry Safonov wrote:
> All users of TASK_SIZE_OF(tsk) have migrated to mm->task_size or
> TASK_SIZE_MAX since:
> commit d696ca016d57 ("x86/fsgsbase/64: Use TASK_SIZE_MAX for
> FSBASE/GSBASE upper limits"),
> commit a06db751c321 ("pagemap: check permissions and capabilities at
> open time"),
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>

I've noticed this too.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
