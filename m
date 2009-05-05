Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 May 2009 21:32:45 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52289 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023987AbZEEUci (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 May 2009 21:32:38 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n45KWXv1025465;
	Tue, 5 May 2009 21:32:33 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n45KWW48025463;
	Tue, 5 May 2009 21:32:32 +0100
Date:	Tue, 5 May 2009 21:32:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, florian@openwrt.org
Subject: Re: [PATCH] MIPS: Use force_sig when handling address errors.
Message-ID: <20090505203231.GA25433@linux-mips.org>
References: <1241552987-662-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1241552987-662-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 05, 2009 at 12:49:47PM -0700, David Daney wrote:

> When init is started it is SIGNAL_UNKILLABLE.  If it were to get an
> address error, we would try to send it SIGBUS, but it would be ignored
> and the faulting instruction restarted.  This results in an endless
> loop.
> 
> We need to use force_sig() instead so it will actually die and give us
> some useful information.
> 
> Reported-by: Florian Fainelli <florian@openwrt.org>
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Thanks!  Will apply.

  Ralf
