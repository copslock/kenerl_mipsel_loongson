Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 13:42:15 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27008083AbbFBLmLRbk04 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 13:42:11 +0200
Date:   Tue, 2 Jun 2015 12:42:11 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: R14000: Unexpected General Exception in
 cpu_set_fpu_fcsr_mask()
In-Reply-To: <20150602065122.GE26432@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1506021232540.22908@eddie.linux-mips.org>
References: <556943D9.7020502@gentoo.org> <alpine.LFD.2.11.1506010025410.22908@eddie.linux-mips.org> <556BCA01.1070208@gentoo.org> <alpine.LFD.2.11.1506011218590.22908@eddie.linux-mips.org> <556D378C.8060503@gentoo.org>
 <20150602065122.GE26432@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47786
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

On Tue, 2 Jun 2015, Ralf Baechle wrote:

> Maciej, I think the variables sr, mask, fcsr, fcsr0 and fcsr1 should
> become unsigned ints; they all represent 32 bit CPU registers.  Also
> read_32bit_cp1_register() return a signed int.  A signed int probably
> would make more sense here.

 The choice of types for `sr', `fcsr', etc. is I think mainly cosmetic, I 
considered it while implementing `cpu_set_fpu_fcsr_mask', but decided to 
follow prior art for consistency.  Cleaning up the whole of cpu-probe.c 
WRT these types seems reasonable to me.

 Again I think `read_32bit_cp1_register' returns a signed int for 
consistency with `__read_32bit_c0_register' that does too.  Perhaps an 
unsigned int would do for `read_32bit_cp1_register' and then two variants 
of `__read_32bit_c0_register', signed and unsigned, used on a case by case 
basis.

  Maciej
