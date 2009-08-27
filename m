Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2009 13:46:59 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41331 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492138AbZH0Lqw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Aug 2009 13:46:52 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n7RBlqco003937;
	Thu, 27 Aug 2009 12:47:52 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n7RBlpYM003935;
	Thu, 27 Aug 2009 12:47:51 +0100
Date:	Thu, 27 Aug 2009 12:47:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH 2/2] Alchemy: timer: support multiple SYS_BASE addresses
Message-ID: <20090827114751.GC29984@linux-mips.org>
References: <1250957401-14447-1-git-send-email-manuel.lauss@gmail.com> <1250957401-14447-2-git-send-email-manuel.lauss@gmail.com> <1250957401-14447-3-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1250957401-14447-3-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Aug 22, 2009 at 06:10:01PM +0200, Manuel Lauss wrote:

I had a a large reject on arch/mips/alchemy/common/time.c when applying
this.  I fixed it up but could you verify that things are ok?  Patch is
now also in the queue.  Thanks!

  Ralf
