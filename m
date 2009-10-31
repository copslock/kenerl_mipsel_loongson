Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Oct 2009 17:10:44 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41515 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493684AbZJaQKk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 31 Oct 2009 17:10:40 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9VGC11G020178;
	Sat, 31 Oct 2009 17:12:02 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9VGC0QC020176;
	Sat, 31 Oct 2009 17:12:00 +0100
Date:	Sat, 31 Oct 2009 17:12:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v3] MIPS: fixes and cleanups for the compressed kernel
	support
Message-ID: <20091031161200.GA24160@linux-mips.org>
References: <1256866524-26863-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1256866524-26863-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 30, 2009 at 09:35:24AM +0800, Wu Zhangjin wrote:

> 
> This patch indents the instructions in the delay slot of the file which
> has a ".set noreorder" added.
> 
> and also, the "addu a0, 4" instruction is replaced by "addiu a0, a0, 4".
> 
> (This is against the commit
> c6adcc73663a71f2aa9e66796a9bd57fcb6a349a(MIPS: add support for

No point in mentioning commit ids for linux-queue - they're volatile, the
tree is rebased all the time!

> gzip/bzip2/lzma compressed kernel images) in the mips-for-linux-next
> branch of Ralf's
> http://www.linux-mips.org/git?p=upstream-sfr.git;a=summary
> 
> This -v3 revision incorporates the feedback from "Maciej W. Rozycki"
> <macro@linux-mips.org> and David Daney <ddaney@caviumnetworks.com>
> 
> Hi, Ralf, could you please merge it into you mips-for-linux-next
> branch?)

linux-queue you mean :)  Done!

  Ralf
