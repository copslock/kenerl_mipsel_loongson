Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2008 12:33:36 +0000 (GMT)
Received: from NaN.false.org ([208.75.86.248]:59032 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S28604810AbYCRMde (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2008 12:33:34 +0000
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id D0F13983BF;
	Tue, 18 Mar 2008 12:33:32 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id 7EC489802B;
	Tue, 18 Mar 2008 12:33:32 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.69)
	(envelope-from <drow@caradoc.them.org>)
	id 1Jbb0U-0004hL-Vj; Tue, 18 Mar 2008 08:33:31 -0400
Date:	Tue, 18 Mar 2008 08:33:30 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS prelink question
Message-ID: <20080318123330.GA18036@caradoc.them.org>
References: <20080318.154701.74743177.kaminaga@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080318.154701.74743177.kaminaga@sm.sony.co.jp>
User-Agent: Mutt/1.5.17 (2007-12-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 18, 2008 at 03:47:01PM +0900, Hiroki Kaminaga wrote:
> 
> Hi!
> 
> I'm not sure if this is the right ML to ask, but since I've found
> discussion about MIPS prelink here, I'm posting here...
> 
> In the below thread, patch for MIPS prelink was posted.
> http://www.linux-mips.org/archives/linux-mips/2006-11/msg00034.html
> 
> I've tried this patch, but I got below error when I tried to do prelink.
> 
> 	No space in ELF segment table to add new ELF segment
> 
> On the montavista pro 5.0 note, I found that they have fixed above
> prelink error, but I could not find the patch. Could someone give
> me pointer to address this issue?

It should be in their prelink source package.  Or here:

  http://sourceware.org/ml/prelink/2007-q4/msg00001.html

-- 
Daniel Jacobowitz
CodeSourcery
