Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 15:10:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52607 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007502AbbFENK4dDKOF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jun 2015 15:10:56 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t55DAmmg004352;
        Fri, 5 Jun 2015 15:10:48 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t55DAlPp004351;
        Fri, 5 Jun 2015 15:10:47 +0200
Date:   Fri, 5 Jun 2015 15:10:47 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, macro@linux-mips.org
Cc:     linux-mips@linux-mips.org, benh@kernel.crashing.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        markos.chandras@imgtec.com, Steven.Hill@imgtec.com,
        alexander.h.duyck@redhat.com, davem@davemloft.net
Subject: Re: [PATCH 1/3] MIPS: R6: Use lightweight SYNC instruction in smp_*
 memory barriers
Message-ID: <20150605131046.GD26432@linux-mips.org>
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
 <20150602000934.6668.43645.stgit@ubuntu-yegoshin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150602000934.6668.43645.stgit@ubuntu-yegoshin>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47886
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

On Mon, Jun 01, 2015 at 05:09:34PM -0700, Leonid Yegoshin wrote:

Leonid,

to me the biggest technical problem with this patch is that the new Kconfig
option is user visible.  This is the kind of deeply technical options
which exceeds the technical knowledge of most users, so it should probably
be driven by a select.

We probably also want to enquire how old CPUs from before the invention
of the stype field are behaving.  If those as I hope for all treat an
stype != 0 as stype 0 we could simply drop the option.  But we might
simply be out of luck - dunno.

Maciej,

do you have an R4000 / R4600 / R5000 / R7000 / SiByte system at hand to
test this?  I think we don't need to test that SYNC actually works as
intended but the simpler test that SYNC <stype != 0> is not causing a
illegal instruction exception is sufficient, that is if something like

int main(int argc, charg *argv[])
{
	asm("	.set	mips2		\n"
	"	sync	0x10		\n"
	"	sync	0x13		\n"
	"	sync	0x04		\n"
	"	.set	mips 0		\n");

	return 0;
}

doesn't crash we should be ok.

The kernel's SYNC emulation should already be ok.  We ignore the stype
field entirely and for a uniprocessor R2000/R3000 that should be just
the right thing.

  Ralf
