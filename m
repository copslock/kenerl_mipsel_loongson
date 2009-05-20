Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 20:06:34 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51206 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20025111AbZETTG1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 May 2009 20:06:27 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4KJ6Bvu001697;
	Wed, 20 May 2009 20:06:11 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4KJ6Amm001696;
	Wed, 20 May 2009 20:06:10 +0100
Date:	Wed, 20 May 2009 20:06:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 0/2] Optimize TLB refill handler folding and cleanup.
Message-ID: <20090520190610.GA1656@linux-mips.org>
References: <4A144DFF.90602@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A144DFF.90602@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 20, 2009 at 11:37:51AM -0700, David Daney wrote:

> The first patch in the set is unchanged from that last time I sent it,
> but since it is a prerequisite for the second, I am sending it again.
> In it we add some documentation on the TLB refill handler folding and
> replace some magic numbers with symbolic constants.
>
> The second patch is the latest iteration on eliminating unnecessary
> branches from the refill handler.  We now use macro's patch rebased
> onto the first patch.

Thanks, I droped the whole series into -queue and my tree for -next.

  Ralf
