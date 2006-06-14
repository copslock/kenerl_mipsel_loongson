Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2006 12:53:56 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:10183 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133500AbWFNLxr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Jun 2006 12:53:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5EBrHP4004795;
	Wed, 14 Jun 2006 12:53:17 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5EBrGRs004794;
	Wed, 14 Jun 2006 12:53:16 +0100
Date:	Wed, 14 Jun 2006 12:53:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Roman Mashak <mrv@corecom.co.kr>
Cc:	linux-mips@linux-mips.org
Subject: Re: "undefined symbol" on 2.6.14
Message-ID: <20060614115316.GA4515@linux-mips.org>
References: <003401c68fa0$b60f4070$9d0ba8c0@mrv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003401c68fa0$b60f4070$9d0ba8c0@mrv>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 14, 2006 at 07:53:01PM +0900, Roman Mashak wrote:

> I compiled driver as a module (for our own device) for MIPS target. At 
> loading time get:
> 
> unresolved symbol 'mips_hpt_frequency'
> 
> Modules.symvers which contains symbols doesn't have reference for 
> 'mips_hpt_frequency'. Doesn it mean it's supposed to be exported with 
> EXPORT_SYMBOL or my problem's reason lies on another layer?

The symbol isn't export simply because it wasn't considered useful to
export it.  The expected use of mips_hpt_frequency is to initialize it
in the platform code as system startup time to the counter frequency,
then not look at it again.

I wonder how you're using it in your module?

Any export I would add - as per general policy for the kernel - an
EXPORT_SYMBOL_GPL btw.

  Ralf
