Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 09:11:29 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:55272 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20028983AbZCaIL1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2009 09:11:27 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2V8BL5V018533;
	Tue, 31 Mar 2009 10:11:23 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2V8BHX1018529;
	Tue, 31 Mar 2009 10:11:17 +0200
Date:	Tue, 31 Mar 2009 10:11:13 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	=?utf-8?B?5p6X5bu65a6J?= <colin@realtek.com.tw>,
	linux-mips@linux-mips.org
Subject: Re: The impact to change page size to 16k for cache alias
Message-ID: <20090331081113.GA17934@linux-mips.org>
References: <9BDA961341E843F29C1C1ECDB54FD0CF@realtek.com.tw> <20090330082414.GA4797@adriano.hkcable.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090330082414.GA4797@adriano.hkcable.com.hk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 30, 2009 at 04:24:15PM +0800, Zhang Le wrote:

> > Hi all,
> > We are willing to use 16k page size to avoid cache alias problem.
> > The Linux version we use is 2.6.12. If we just upgrade mm system to 
> > support 16k page size, what else problems will happen?
> > There is already one thing we know that applications of ELF format  
> > applications should be transformed to be 16k alignment.
> > Another one, we think, highly suspected to be problematic is that many  
> > drivers will be ok for 4k page size but fails for 16k.
> > That is because 4k page size had been seemed to be natural for a very 
> > long long time.
> > Any other problem that shall happen for 16k page size?
> 
> Linux on Loongson 2E and 2F uses 16k page size to avoid cache alias problem, too.
> However, I haven't encountered any problem on Linux kernel itself due to 16k page
> size.
> 
> Anyway, I am not 100% familiar with Loongson patches, so I am not sure whether
> the page size problem is already been taken care of in the patch. If you are
> interested to find out yourself, you can get the whole source here:
> http://repo.or.cz/w/linux-2.6/linux-loongson.git

I've got a report that Fulong is currently only working with 16k pages.  So
4k is no longer the bullet proof choice for all cases :)

  Ralf
