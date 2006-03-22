Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Mar 2006 11:54:58 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:37818 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133863AbWCVLyt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Mar 2006 11:54:49 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.5/8.13.4) with ESMTP id k2MC4fIR007857;
	Wed, 22 Mar 2006 12:04:41 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.5/8.13.5/Submit) id k2MC4fHJ007856;
	Wed, 22 Mar 2006 12:04:41 GMT
Date:	Wed, 22 Mar 2006 12:04:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
Cc:	Srinivas Kommu <kommu@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: how to get a process backtrace from kernel gdb?
Message-ID: <20060322120441.GA7677@linux-mips.org>
References: <4420940B.9030605@hotmail.com> <20060322105026.GA3129@linux-mips.org> <442130DA.8060407@ict.ac.cn> <20060322113203.GA4544@linux-mips.org> <442137B6.60705@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442137B6.60705@ict.ac.cn>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 22, 2006 at 07:40:38PM +0800, Fuxin Zhang wrote:

> >  a) Analyze the code with a simple frame unwinder along the lines of the
> >     get_wchan implementation.  Simple but possibly fragile as compilers
> >     continue to improve.
> >  b) Bite the bullet and use the DWARD 2 frame unwind info and code.  More
> >     complicated but will be a solid and correct solution albeit larger so
> >     not acceptable for small embedded devices.
> > 
> > I fear we may have to do both, 2) as the prefered solution and 1) as the
> > fallback solution.
> OK, thanks. I will have a look at IA64's implementation and port it if
> possible.

Thanks alot!

  Ralf
