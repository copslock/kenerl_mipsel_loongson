Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 15:53:12 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43330 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903830Ab1KPOxH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 15:53:07 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAGEqvL6020087;
        Wed, 16 Nov 2011 14:52:57 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAGEquO3020084;
        Wed, 16 Nov 2011 14:52:56 GMT
Date:   Wed, 16 Nov 2011 14:52:56 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hillf Danton <dhillf@gmail.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        "Jayachandran C." <jayachandranc@netlogicmicro.com>
Subject: Re: [RFC] Flush huge TLB
Message-ID: <20111116145256.GF11111@linux-mips.org>
References: <CAJd=RBBPd6frOA5zCg5juHuWdZ6wHzmOhhufgGhUCOc=rkNEzA@mail.gmail.com>
 <4E932897.9050301@cavium.com>
 <CAJd=RBA4c9Gs1jsftPCi9hd7UDa_UaO86-4qo=FHp4RB+m98kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJd=RBA4c9Gs1jsftPCi9hd7UDa_UaO86-4qo=FHp4RB+m98kQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13469

On Fri, Oct 14, 2011 at 09:09:37PM +0800, Hillf Danton wrote:

> Subject: Flush huge TLB
> From: Hillf Danton <dhillf@gmail.com>
> 
> When flushing TLB, if @vma is backed by huge page, we could flush huge TLB,
> due to that huge page is defined to be far from normal page.
> 
> Signed-off-by: Hillf Danton <dhillf@gmail.com>
> Acked-by: David Daney <david.daney@cavium.com>

I assume this 2nd version was actually meant to be applied, not just for RFC
so I've queued it for 3.3.  But you better remove that RFC from subject and
start a fresh mail thread when posting a patch to avoid confusion!

Thanks,

  Ralf
