Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 18:20:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47016 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824764Ab3IQQT6SlGsw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Sep 2013 18:19:58 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8HGJvsQ001654;
        Tue, 17 Sep 2013 18:19:57 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8HGJvvV001653;
        Tue, 17 Sep 2013 18:19:57 +0200
Date:   Tue, 17 Sep 2013 18:19:57 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [MIPS] CP0 PRId and CP1 FPIR register access masks
Message-ID: <20130917161957.GH22468@linux-mips.org>
References: <alpine.LFD.2.03.1309171641260.5967@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309171641260.5967@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Sep 17, 2013 at 04:58:10PM +0100, Maciej W. Rozycki wrote:

> Replace hardcoded CP0 PRId and CP1 FPIR register access masks throughout.  
> The change does not touch places that use shifted or partial masks.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> Ralf,
> 
>  Please apply.  I think the places ignored by this change should be 
> further reviewed, especially the shifted masks that can likely remove the 
> shifts and rely on compiler optimisation instead.  I decided to make this 
> change as straightforward as possible to avoid accidental breakage in code 
> I have no way to test.  Also partial masks are probably better handled 
> with macros rather than hardcoded constants scattered throughout.  I can 
> see steps have been taken towards this already (PRID_REV_ENCODE_*).

Looks ok, queud for 3.13.

But while it's cleaner, I think the idiom read_c0_prid() & some_MASK is
so common that maybe something like

  #define read_c0_prid_imp()	(read_c0_prid() & PRID_IMP_MASK)
  #define read_c0_prid_rev()	(read_c0_prid() & PRID_REV_MASK)
  #define read_c0_prid_comp()	(read_c0_prid() & PRID_COMP_MASK)

should be introduced as a next step.

  Ralf
