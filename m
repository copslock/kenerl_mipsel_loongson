Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2015 15:15:06 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007221AbbE0NPDgsSsC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2015 15:15:03 +0200
Date:   Wed, 27 May 2015 14:15:03 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
Subject: [PATCH 0/3] MIPS: tlb-r3k: TLB handling fixes
Message-ID: <alpine.LFD.2.11.1505261431090.11225@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47689
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

Hi Ralf,

 This is a bunch of fixes for R3k TLB handlers the need for which I 
discovered while testing James's recent `dump_tlb' improvements.  
Especially 1/3 is important as it corrects an initialisation issue that 
may be lethal in some cases; it may be worth backporting.

 Please apply.

 Thanks,

  Maciej
