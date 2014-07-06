Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jul 2014 13:19:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50293 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6856571AbaGFLTqIrBxK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Jul 2014 13:19:46 +0200
Date:   Sun, 6 Jul 2014 12:19:46 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Jonas Gorski <jogo@openwrt.org>
cc:     Emil Goode <emilgoode@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        John Crispin <blogic@openwrt.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] MIPS: Remove incorrect NULL check in
 local_flush_tlb_page()
In-Reply-To: <CAOiHx==kyY9ce5jjv5m36OXpG9Vk4NsPa9m+nfWuYWjxOnMisA@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1407061218090.15455@eddie.linux-mips.org>
References: <1404602638-16447-1-git-send-email-emilgoode@gmail.com> <CAOiHx==kyY9ce5jjv5m36OXpG9Vk4NsPa9m+nfWuYWjxOnMisA@mail.gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Sun, 6 Jul 2014, Jonas Gorski wrote:

> On Sun, Jul 6, 2014 at 1:23 AM, Emil Goode <emilgoode@gmail.com> wrote:
> > We check that the struct vm_area_struct pointer vma is NULL and then
> > dereference it a few lines below. The intent was to make sure vma is
> > not NULL but this is not necessary since the bug pre-dates GIT history
> > and seem to never have caused a problem. The tlb-4k and tlb-8k versions
> > of local_flush_tlb_page() don't bother checking if vma is NULL, also
> > vma is dereferenced before being passed to local_flush_tlb_page(),
> > thus it is safe to remove this NULL check.
> >
> > Signed-off-by: Emil Goode <emilgoode@gmail.com>
> 
> Looks good.
> 
> Reviewed-by: Jonas Gorski <jogo@openwrt.org>

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

(as per the observations at the previous version).

  Maciej
