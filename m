Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 15:46:12 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57664 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904107Ab1KROqG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Nov 2011 15:46:06 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAIEk2Mo032118;
        Fri, 18 Nov 2011 14:46:02 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAIEk0pT032110;
        Fri, 18 Nov 2011 14:46:00 GMT
Date:   Fri, 18 Nov 2011 14:46:00 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hillf Danton <dhillf@gmail.com>
Cc:     David Daney <david.daney@cavium.com>,
        "Jayachandran C." <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Flush huge TLB
Message-ID: <20111118144600.GA12409@linux-mips.org>
References: <CAJd=RBBTx8zWrFfVQGMK=aj=iPO_+i6nvqkhGDfYp_9=d1hyEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJd=RBBTx8zWrFfVQGMK=aj=iPO_+i6nvqkhGDfYp_9=d1hyEw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15496

On Fri, Nov 18, 2011 at 09:15:39PM +0800, Hillf Danton wrote:

> When flushing TLB, if @vma is backed by huge page, we could flush huge TLB,
> due to that huge page is defined to be far from normal page.
> 
> Signed-off-by: Hillf Danton <dhillf@gmail.com>

It seems this patch is identical to
https://patchwork.linux-mips.org/patch/2825/ which I've already applied?

  Ralf
