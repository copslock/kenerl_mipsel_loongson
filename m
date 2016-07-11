Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2016 16:56:18 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23993193AbcGKO4JsgmR9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jul 2016 16:56:09 +0200
Date:   Mon, 11 Jul 2016 15:56:09 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 01/12] MIPS: Fix definition of KSEGX() for 64-bit
In-Reply-To: <1467975211-12674-2-git-send-email-james.hogan@imgtec.com>
Message-ID: <alpine.LFD.2.20.1607111543480.12953@eddie.linux-mips.org>
References: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com> <1467975211-12674-2-git-send-email-james.hogan@imgtec.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54280
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

Hi James,

> This will help some MIPS KVM code handling 32-bit guest addresses to
> work on 64-bit host kernels, but will also affect KSEGX in
> dec_kn01_be_backend() on a 64-bit DECstation kernel, and the SiByte DMA
> page ops KSEGX check in clear_page() and copy_page() on 64-bit SB1
> kernels, neither of which appear to be designed with 64-bit segments in
> mind anyway.

 Thanks for the heads-up!

 This is not an issue however with `dec_kn01_be_backend', because the KN01 
baseboard used with the DECstation 2100 and 3100 computers has an R2000 
processor mounted in a permanent manner (no CPU daugthercard as with some 
later baseboards) and will therefore never run a 64-bit kernel.  In fact I 
think kn01-berr.c would best only be built in 32-bit configurations.  I 
never got to making such a clean-up though; I may look into it sometime as 
I have some 2100/3100 stuff outstanding.

 As to the SiByte platform I have no clue offhand; there's surely some 
stuff there across the port asking for a clean-up.  I reckon using the 
data mover for page ops is a kernel configuration option and I may have 
never enabled it myself.

  Maciej
