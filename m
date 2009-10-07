Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2009 17:37:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36914 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493146AbZJGPhK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Oct 2009 17:37:10 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n97FcF6c016038;
	Wed, 7 Oct 2009 17:38:16 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n97FcEWT016035;
	Wed, 7 Oct 2009 17:38:14 +0200
Date:	Wed, 7 Oct 2009 17:38:14 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH -queue] Alchemy: fix pb1100/pb1500 compile failures
Message-ID: <20091007153814.GA15076@linux-mips.org>
References: <1254929477-6697-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1254929477-6697-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 07, 2009 at 05:31:17PM +0200, Manuel Lauss wrote:

> forgot to remove inclusion of removed headers and add required ones.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Extends  "MIPS: Alchemy: devboards: wire up new PCMCIA driver" in
> Ralf's linux-queue tree.
> 
> Please apply or fold into the above mentioned patch!
> Thanks!

Done.
