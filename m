Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 17:35:38 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33832 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024431AbZEFQfc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 May 2009 17:35:32 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n46GZKh3019688;
	Wed, 6 May 2009 17:35:21 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n46GZIl2019686;
	Wed, 6 May 2009 17:35:18 +0100
Date:	Wed, 6 May 2009 17:35:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David VomLehn <dvomlehn@cisco.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] mips:powertv: Make kernel command line size
	configurable (resend)
Message-ID: <20090506163518.GA19624@linux-mips.org>
References: <20090504225719.GA22417@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090504225719.GA22417@cuplxvomd02.corp.sa.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 04, 2009 at 03:57:19PM -0700, David VomLehn wrote:

> Most platforms can get by perfectly well with the default command line size,
> but some platforms need more. This patch allows the command line size to
> be configured for those platforms that need it. The default remains 256
> characters.
> 
> Signed-off-by: David VomLehn <dvomlehn@cisco.com>

How big of a command line do you need?  For no scientific reason other
than there not being any obvious need for a larger size MIPS is using 256
and I think unless you're asking for a huge number it will be better to
just raise that constant.

  Ralf
