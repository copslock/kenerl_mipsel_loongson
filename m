Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 17:36:46 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58071 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491193Ab0HRPgi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Aug 2010 17:36:38 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o7IFaPKB029874;
        Wed, 18 Aug 2010 16:36:25 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o7IFaP1o029872;
        Wed, 18 Aug 2010 16:36:25 +0100
Date:   Wed, 18 Aug 2010 16:36:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        "Dezhong Diao (dediao)" <dediao@cisco.com>,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        David Daney <ddaney@caviumnetworks.com>,
        "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Subject: Re: [PATCH v2 1/2] MIPS: Add device tree support to MIPS
Message-ID: <20100818153625.GA29740@linux-mips.org>
References: <AANLkTi=74zoQziQTmAGo-cNtF9FAT77h+KZagsNEFjEf@mail.gmail.com>
 <7A9214B0DEB2074FBCA688B30B04400D013FA46D@XMB-RCD-208.cisco.com>
 <20100816204211.GA17571@angua.secretlab.ca>
 <20100817134039.fc1108c7.sfr@canb.auug.org.au>
 <20100818143926.GB2849@linux-mips.org>
 <20100819011856.bfef5f65.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100819011856.bfef5f65.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 19, 2010 at 01:18:56AM +1000, Stephen Rothwell wrote:

> > A suggested set of kernel defconfigs to test:
> > 
> > bigsur_defconfig
> > cavium-octeon_defconfig
> > ip22_defconfig
> > ip27_defconfig
> > ip32_defconfig
> > malta_defconfig
> > allmodconfig
> > 
> > These cover a huge variety of features, UP, SMP & weirdo SMP, flatmem & NUMA,
> > 32-bit, 64-bit, little and big endian.
> 
> OK, I will adjust the MIPS builds tomorrow.  Thanks for the suggestions.
> Just be clear, I only need to build with one compiler (presumably what
> gcc/binutils produces when I ask for a "mips" toolchain) and can drop the
> other ("mipsel"), correct?

Yes, that's entirely correct.

For the sake of others reading this I should mention that some GCC version
apparently had a bug which resulted in bad code generation for the
non-default ABI.  I don't know which versions were affected but for
just doing build tests it really doesn't matter.

  Ralf
