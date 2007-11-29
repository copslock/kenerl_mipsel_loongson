Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2007 15:06:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:21148 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28575704AbXK2PGO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Nov 2007 15:06:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lATF62jM027903;
	Thu, 29 Nov 2007 15:06:02 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lATF618L027902;
	Thu, 29 Nov 2007 15:06:01 GMT
Date:	Thu, 29 Nov 2007 15:06:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Thomas Koeller <thomas@koeller.dyndns.org>,
	linux-mips@linux-mips.org
Subject: Re: git problem
Message-ID: <20071129150601.GA17764@linux-mips.org>
References: <200711281950.46472.thomas@koeller.dyndns.org> <474EA356.3070303@gmail.com> <20071129130903.GB14655@linux-mips.org> <474ECEF1.3090206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474ECEF1.3090206@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 29, 2007 at 03:38:41PM +0100, Franck Bui-Huu wrote:

> Ralf Baechle wrote:
> > Back to the original topic - git describe fails even with some of the
> > very old commits of the lmo tree which are known to be tagged so there
> > is something wrong.
> 
> Your issue seems different from Thomas' one. In your case:
> 
> 	$ git cat-file -t refs/tags/linux-1.3.0
> 	commit
> 
> So the tag you mentioned is a _lightweight_ tag. These are not
> considered by git-describe by default.

Ah, thanks solving that miracle.

The lightweight tags were all created by the git to CVS converter two years
ago.  I was planning to replace those with signed tags anyway, another
reason to do so.

  Ralf
