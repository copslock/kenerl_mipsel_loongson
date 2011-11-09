Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 10:55:29 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40097 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903552Ab1KIJzY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 10:55:24 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA99sG1g023396;
        Wed, 9 Nov 2011 09:54:16 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA99sE5t023359;
        Wed, 9 Nov 2011 09:54:14 GMT
Date:   Wed, 9 Nov 2011 09:54:14 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Michal Marek <mmarek@suse.cz>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Arnaud Lacombe <lacombar@gmail.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Daney, David" <David.Daney@caviumnetworks.com>
Subject: Re: [PATCH] Kbuild: append missing-syscalls to the default target
 list
Message-ID: <20111109095414.GA15438@linux-mips.org>
References: <1314234210-11090-1-git-send-email-lacombar@gmail.com>
 <4E69FEC9.2080204@suse.cz>
 <CACqU3MUFyn_jh2pN4GLENqcGVUzAwcMJUR_WLY2EtqOhMheceQ@mail.gmail.com>
 <20111101232233.GA32441@sepie.suse.cz>
 <20111107204448.GA9949@linux-mips.org>
 <20111107211900.GB6264@sepie.suse.cz>
 <20111107233330.GA26705@linux-mips.org>
 <4EB8E75D.1010706@suse.cz>
 <4EB97333.1050403@gmail.com>
 <4EB9AD98.3010404@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EB9AD98.3010404@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7603

On Tue, Nov 08, 2011 at 11:30:48PM +0100, Michal Marek wrote:

> On 8.11.2011 19:21, David Daney wrote:
> > The problem is that compiler options meant to be used only for the 
> > compiling done by scripts/checksyscalls.sh are now leaking into the 
> > compilation of other parts of the kernel (asm-offsets.c), where they 
> > wreak havoc.
> > 
> > Something like the attached is what I think needs to be done.
> 
> Ah, right. That makes a lot of sense now. Ralf, does the patch at
> https://lkml.org/lkml/2011/11/8/312 work for you?

Yes, it does - and unlike David's first version this one also looks
reasonably elegant.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
