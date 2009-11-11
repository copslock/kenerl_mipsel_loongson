Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 14:44:32 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51733 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492756AbZKKNo3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Nov 2009 14:44:29 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nABDiTMu012462;
	Wed, 11 Nov 2009 14:44:30 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nABDiPe9012460;
	Wed, 11 Nov 2009 14:44:25 +0100
Date:	Wed, 11 Nov 2009 14:44:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Make local arrays with CL_SIZE static __initdata
Message-ID: <20091111134425.GA12249@linux-mips.org>
References: <1257614437-8632-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257614437-8632-1-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 08, 2009 at 02:20:37AM +0900, Atsushi Nemoto wrote:

> Since commit 22242681 ("MIPS: Extend COMMAND_LINE_SIZE"), CL_SIZE is
> 4096 and local array variables with this size will cause an build
> failure with default CONFIG_FRAME_WARN settings.
> 
> Although current users of such array variables are all early bootstrap
> code and might not cause real stack overflow (thread_info corruption),
> it would be safe to declare these arrays static with __initdata.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Applied, thanks!

  Ralf
