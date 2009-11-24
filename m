Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 01:09:24 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33026 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1493472AbZKXAJV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 01:09:21 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAO09UgO007670;
	Tue, 24 Nov 2009 00:09:30 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAO09ToD007668;
	Tue, 24 Nov 2009 00:09:29 GMT
Date:	Tue, 24 Nov 2009 00:09:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Stephen Rothwell <sfr@canb.auug.org.au>
Cc:	linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
Subject: Re: linux-next: failed to fetch the mips tree
Message-ID: <20091124000929.GA7223@linux-mips.org>
References: <20091124105303.512479aa.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091124105303.512479aa.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 24, 2009 at 10:53:03AM +1100, Stephen Rothwell wrote:

> git.linux-mips.org[0: 78.24.191.183]: errno=Connection refused
> fatal: unable to connect a socket (Connection refused)

Thanks.  I upgraded the machine from Fedora 10 to Fedora 12 and the
removal of the git "dash-commands" resulted in this failure.  Fixed.

> I will use the version from next-20091123 for today.

No problem; all changes can wait another day.

  Ralf
