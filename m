Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 22:59:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34699 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493642AbZJMU7r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Oct 2009 22:59:47 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9DL122J016760;
	Tue, 13 Oct 2009 23:01:04 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9DL11L8016738;
	Tue, 13 Oct 2009 23:01:01 +0200
Date:	Tue, 13 Oct 2009 23:01:01 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Alchemy: remove dbdma compat macros
Message-ID: <20091013210101.GA16628@linux-mips.org>
References: <1255458155-14469-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255458155-14469-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 13, 2009 at 08:22:34PM +0200, Manuel Lauss wrote:

> Remove dbdma compat macros, move remaining users over to default
> queueing functions and -flags.
> 
> (Queueing function signature has changed in order to give
>  a build failure instead of silent functional changes due
>  to the no longer implicitly specified DDMA_FLAGS_IE flag)

Queued for 2.6.32.  Thanks,

  Ralf
