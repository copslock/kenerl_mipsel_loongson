Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2009 16:56:42 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:32964 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492965AbZH0O4f (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Aug 2009 16:56:35 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n7REuvmL015634;
	Thu, 27 Aug 2009 15:56:57 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n7REuvtL015633;
	Thu, 27 Aug 2009 15:56:57 +0100
Date:	Thu, 27 Aug 2009 15:56:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Herbert Xu <herbert@gondor.apana.org.au>
Cc:	David Daney <ddaney@caviumnetworks.com>, mpm@selenic.com,
	linux-mips@linux-mips.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hw_random: Add hardware RNG for Octeon SOCs.
Message-ID: <20090827145657.GG29984@linux-mips.org>
References: <4A8DBB17.5020301@caviumnetworks.com> <1250802623-6526-2-git-send-email-ddaney@caviumnetworks.com> <20090824074745.GB32067@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090824074745.GB32067@gondor.apana.org.au>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 24, 2009 at 05:47:45PM +1000, Herbert Xu wrote:

> On Thu, Aug 20, 2009 at 02:10:23PM -0700, David Daney wrote:
> > Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Queued for 2.6.32 after fixing the space followed by tab mess in Kconfig.

Thanks,

  Ralf
