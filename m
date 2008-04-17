Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2008 13:10:14 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:25262 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S28576837AbYDQMKL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2008 13:10:11 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3HC9LLU022210
	for <linux-mips@linux-mips.org>; Thu, 17 Apr 2008 05:09:24 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3HCA2Vl031265;
	Thu, 17 Apr 2008 13:10:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3HCA1kX031258;
	Thu, 17 Apr 2008 13:10:01 +0100
Date:	Thu, 17 Apr 2008 13:10:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Patches for 34K APRP
Message-ID: <20080417121001.GA30873@linux-mips.org>
References: <4805FFE6.5080903@mips.com> <48060258.8050904@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48060258.8050904@mips.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2008 at 03:42:48PM +0200, Kevin D. Kissell wrote:

> Sigh.  Some mailers (including Thunderbird for Windows)
> seem to be unable to handle the attachment of the patch
> files by Thunderbird.  So I attach them as a .tgz, which
> even Outlook should be able to deal with correctly.

With the kernel maintainers head hidden for a moment - the attachments
certainly were ok, I was able to feed them to patch and had no problems
applying them.

With the kernel maintainers hat firmly back on the head:

 o git will use the Subject: line followed by the body followed by the
   attachment's leading comment as the commit message for the patch.
   Anything after a "---" tearoff line such a signature will be dropped.
   For the submitter that means to ensure only things that are meant to
   go into the log should be before the tearoff line.
 o As the result of this method git will only be able to handle a single
   patch per email.  But that's not a problem anyway.  Patches are meant
   to be easily discussable by email and that's best done with a single
   patch per mail.

I'm going to send comments on the actual patch by separate email.

  Ralf
