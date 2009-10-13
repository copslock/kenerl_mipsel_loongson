Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 22:53:02 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58026 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493431AbZJMUw7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Oct 2009 22:52:59 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9DKsH1E014902;
	Tue, 13 Oct 2009 22:54:17 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9DKsG5U014900;
	Tue, 13 Oct 2009 22:54:16 +0200
Date:	Tue, 13 Oct 2009 22:54:16 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Replace all usages of CL_SIZE by
	COMMAND_LINE_SIZE
Message-ID: <20091013205416.GA12198@linux-mips.org>
References: <1255466604-23560-1-git-send-email-dmitri.vorobiev@movial.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255466604-23560-1-git-send-email-dmitri.vorobiev@movial.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 13, 2009 at 11:43:24PM +0300, Dmitri Vorobiev wrote:

> The MIPS-specific macro CL_SIZE is merely aliasing the macro
> COMMAND_LINE_SIZE. Other architectures use the latter; also,
> COMMAND_LINE_SIZE is documented in kernel-parameters.txt, so
> let's use it, and remove the alias.

Thanks, also queued for 2.6.32.

  Ralf
