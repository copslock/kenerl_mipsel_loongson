Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 02:32:21 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27026747AbbEPAcT06FST (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 02:32:19 +0200
Date:   Sat, 16 May 2015 01:32:19 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/9] MIPS: dump_tlb: Use tlbr hazard macros
In-Reply-To: <20150515151711.GC2322@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1505160122170.4923@eddie.linux-mips.org>
References: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com> <1431514255-3030-4-git-send-email-james.hogan@imgtec.com> <20150515151711.GC2322@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47426
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

On Fri, 15 May 2015, Ralf Baechle wrote:

> Only to repeat for the benefit of the mailing list readers what I already
> wrote on IRC recently.  The 7 NOPs sequence will send the uncached
> write-back buffer of the R4400 but not R4000 off-chip.

 Well, the R4000 doesn't have such a buffer, so there's simply nothing to 
send. :)  And in any case issuing a SYNC followed by a load operation is 
the proper architectural way to send any outstanding writes off the chip.

  Maciej
