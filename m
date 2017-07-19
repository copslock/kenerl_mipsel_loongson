Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2017 16:21:22 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37192 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992274AbdGSOVIDoijk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jul 2017 16:21:08 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v6JEL5Hi028779;
        Wed, 19 Jul 2017 16:21:05 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v6JEL5ND028778;
        Wed, 19 Jul 2017 16:21:05 +0200
Date:   Wed, 19 Jul 2017 16:21:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     "Steven J. Hill" <steven.hill@cavium.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Fix broken EDAC driver.
Message-ID: <20170719142105.GE5852@linux-mips.org>
References: <1496251247-27123-1-git-send-email-steven.hill@cavium.com>
 <20170719093919.GR31455@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170719093919.GR31455@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59146
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

On Wed, Jul 19, 2017 at 10:39:19AM +0100, James Hogan wrote:
> Date:   Wed, 19 Jul 2017 10:39:19 +0100
> From: James Hogan <james.hogan@imgtec.com>
> To: "Steven J. Hill" <steven.hill@cavium.com>
> CC: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
> Subject: Re: [PATCH] MIPS: Octeon: Fix broken EDAC driver.
> Content-Type: multipart/signed; micalg=pgp-sha256;
>         protocol="application/pgp-signature"; boundary="y2MHPAl/EzyWgzIZ"
> 
> On Wed, May 31, 2017 at 12:20:47PM -0500, Steven J. Hill wrote:
> > From: "Steven J. Hill" <Steven.Hill@cavium.com>
> > 
> > Commit 15f6847 "MIPS: Octeon: Remove unused L2C types and macros."
> 
> Please use 12 nibbles of hash and I think brackets around the subject is
> common style, i.e.
> 
> Commit 15f6847923a8 ("MIPS: Octeon: Remove unused L2C types and
> macros.") broke the EDAC driver...
> 
> > broke the EDAC driver. Bring back 'cvmx-l2d-defs.h' file and the
> > missing types for L2C.
> > 
> 
> Lets add:
> Fixes: 15f6847923a8 ("MIPS: Octeon: Remove unused L2C types and macros.")
> 
> > Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> 
> I suppose we need this too now that 4.12 is out:
> Cc: <stable@vger.kernel.org> # 4.12+
> 
> (Maybe Ralf can fix that stuff up when applying?)

I think the Cc: to stable is not necessary with the Fixes: tag.

> The patch looks correct based on the definitions removed in the patch it
> fixes, and it does indeed fix the build errors, so:
> 
> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> 
> Though this warning persists:
> 
> drivers/edac/octeon_edac-lmc.c In function ‘octeon_lmc_edac_poll_o2’:
> drivers/edac/octeon_edac-lmc.c:87:24: warning: ‘((long unsigned int*)&int_reg)[0]’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   if (int_reg.s.sec_err || int_reg.s.ded_err) {

Steven, can you sort this?  Thanks,

  Ralf
