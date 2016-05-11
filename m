Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 13:41:22 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52126 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028934AbcEKLlTY5u4Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 May 2016 13:41:19 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4BBfHtW016825;
        Wed, 11 May 2016 13:41:17 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4BBfHOJ016824;
        Wed, 11 May 2016 13:41:17 +0200
Date:   Wed, 11 May 2016 13:41:17 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     "Steven J. Hill" <Steven.Hill@caviumnetworks.com>,
        LMO <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Fix type and FCSR mask.
Message-ID: <20160511114117.GK16402@linux-mips.org>
References: <57322408.5060702@caviumnetworks.com>
 <alpine.DEB.2.00.1605111200200.6794@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1605111200200.6794@tp.orcam.me.uk>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53360
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

On Wed, May 11, 2016 at 12:16:13PM +0100, Maciej W. Rozycki wrote:

> On Tue, 10 May 2016, Steven J. Hill wrote:
> 
> > The FCSR register is always 32-bits regardless if the platform is
> > 32 or 64-bits. Change the type from 'long' to 'int' to reflect this.
> > The entire upper half-word of the FCSR register orginally set all
> > the bits to 1. Some platforms like the Octeon III simulator will
> > actually fault if ones are written to the reserved and/or the FPU
> > bits. Correct the mask to avoid this.
> 
>  This change is broken, see the description of commit 9b26616c8d9d ("MIPS: 
> Respect the ISA level in FCSR handling") where this code comes from.  The 
> very purpose is to probe for the writability of bits 31:18, in particular 
> NAN2008 and ABS2008 stuff, but it applies to vendor bits too.  An accurate 
> identification of writable bits is required for the correct presentation 
> of FCSR via ptrace(2) for programs like GDB.
> 
>  You need to fix your simulator instead, the architecture does not permit 
> trapping on optional FCSR bits (there are no reserved bits there anymore 
> with the current architecture revision) especially as access to this 
> register is unprivileged.  I don't think we can support arbitrary 
> non-compliant architecture implementations -- if you need to handle an 
> erratum, then please do it on a PRId by PRId basis.
> 
>  As to changing the data type, I'm fine in principle, but then please do 
> so across all our source base where CP1 control registers are handled.  
> Here the `long' type is used for consistency with the rest of code, so 
> changing just this single place seems gratuitous to me.
> 
>  Ralf, please discard this change until it has been corrected.

Using a 32 bit variable made sufficient sense to me to apply the patch
to me.  However I agree, that the simulator's behaviour is overzealous.
While in violation of the architecture specification this is probably
similar in spirit as the mode of MIPSsim that was keeping every bit of
the system as a tristate (0, 1 and uninitialized) which indeed cought a
number of issues.

  Ralf
