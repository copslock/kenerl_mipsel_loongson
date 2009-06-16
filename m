Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jun 2009 12:27:55 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58176 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492782AbZFPK1r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jun 2009 12:27:47 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5GAKZQ0022949;
	Tue, 16 Jun 2009 11:20:35 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5GAKYMA022947;
	Tue, 16 Jun 2009 11:20:34 +0100
Date:	Tue, 16 Jun 2009 11:20:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, wli@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] Enable hugetlbfs for more systems.
Message-ID: <20090616102034.GC13622@linux-mips.org>
References: <4A1DDED7.3020306@caviumnetworks.com> <1243471666-27915-4-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1243471666-27915-4-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 27, 2009 at 05:47:45PM -0700, David Daney wrote:
> From: David Daney <ddaney@caviumnetworks.com>
> Date: Wed, 27 May 2009 17:47:45 -0700
> To: linux-mips@linux-mips.org, ralf@linux-mips.org
> Cc: wli@holomorphy.com, David Daney <ddaney@caviumnetworks.com>

Holomorphy.com is unreachable since like a year.  Use wli@kernel.org.

> Subject: [PATCH 4/5] Enable hugetlbfs for more systems.
> 
> As part of adding hugetlbfs support for MIPS, I am adding a new
> kconfig variable 'SYS_SUPPORTS_HUGETLBFS'.  Since some mips cpu
> varients don't yet support it, we can enable selection of HUGETLBFS on
> a system by system basis from the arch/mips/Kconfig.
> 
> CC: William Irwin <wli@holomorphy.com>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  fs/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 9f7270f..c36d63b 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -124,7 +124,7 @@ config TMPFS_POSIX_ACL
>  config HUGETLBFS
>  	bool "HugeTLB file system support"
>  	depends on X86 || IA64 || PPC64 || SPARC64 || (SUPERH && MMU) || \
> -		   (S390 && 64BIT) || BROKEN
> +		   (S390 && 64BIT) || SYS_SUPPORTS_HUGETLBFS || BROKEN

I'm ok with this patch but it's really crying for some follup patch to
convert all the other architectures to use SYS_SUPPORTS_HUGETLBFS.

  Ralf
