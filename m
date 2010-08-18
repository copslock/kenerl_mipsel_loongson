Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 16:40:07 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57579 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491168Ab0HROkD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Aug 2010 16:40:03 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o7IEdTx2028408;
        Wed, 18 Aug 2010 15:39:29 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o7IEdQgT028402;
        Wed, 18 Aug 2010 15:39:26 +0100
Date:   Wed, 18 Aug 2010 15:39:26 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        "Dezhong Diao (dediao)" <dediao@cisco.com>,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        David Daney <ddaney@caviumnetworks.com>,
        "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Subject: Re: [PATCH v2 1/2] MIPS: Add device tree support to MIPS
Message-ID: <20100818143926.GB2849@linux-mips.org>
References: <AANLkTi=74zoQziQTmAGo-cNtF9FAT77h+KZagsNEFjEf@mail.gmail.com>
 <7A9214B0DEB2074FBCA688B30B04400D013FA46D@XMB-RCD-208.cisco.com>
 <20100816204211.GA17571@angua.secretlab.ca>
 <20100817134039.fc1108c7.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100817134039.fc1108c7.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 17, 2010 at 01:40:39PM +1000, Stephen Rothwell wrote:

> On Mon, 16 Aug 2010 14:42:11 -0600 Grant Likely <grant.likely@secretlab.ca> wrote:
> >
> > I'll also make sure to start build testing on MIPS.  Ralf, any suggestions on defconfigs I should use?
> 
> Linux-next does defconfig, allnoconfig, allmodconfig (which has failed
> for a long time) and ip32_defconfig for mips and mipsel.  I am not sure
> if all these are still relevant.
>
> (http://kisskb.ellerman.id.au/kisskb/branch/9/)

Kconfig will pick the default machine which is an IP22 for allyesconfig
and allmodconfig.  The makefile will then pick the right flags for the
compiler based on machine, processor and endian selection.  so it'll
happily build a big endian kernel with a little endian compiler.  All
that's really different between those compilers are the defaults.  Building
more different defconfigs is a better investments of CPU cycles.

An issue with very large functionss for which I've posted a patch earlier
today used to break makeallconfig / makeallmodconfig on MIPS.  I'll sort
those out but right now I just don't have the CPU cycles to regularly
build such monster kernel configs.

A suggested set of kernel defconfigs to test:

bigsur_defconfig
cavium-octeon_defconfig
ip22_defconfig
ip27_defconfig
ip32_defconfig
malta_defconfig
allmodconfig

These cover a huge variety of features, UP, SMP & weirdo SMP, flatmem & NUMA,
32-bit, 64-bit, little and big endian.

  Ralf
