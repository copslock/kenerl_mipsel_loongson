Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2004 15:44:31 +0100 (BST)
Received: from MAIL.13thfloor.at ([IPv6:::ffff:212.16.62.51]:23941 "EHLO
	mail.13thfloor.at") by linux-mips.org with ESMTP
	id <S8224829AbUFIOo1>; Wed, 9 Jun 2004 15:44:27 +0100
Received: by mail.13thfloor.at (Postfix, from userid 1001)
	id 9B65851026A; Wed,  9 Jun 2004 16:44:22 +0200 (CEST)
Date: Wed, 9 Jun 2004 16:44:22 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: linux-vserver syscall ...
Message-ID: <20040609144422.GA24002@MAIL.13thfloor.at>
References: <20040524182915.GA27481@MAIL.13thfloor.at> <20040608235400.GA31706@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040608235400.GA31706@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <herbert@13thfloor.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@13thfloor.at
Precedence: bulk
X-list: linux-mips

On Wed, Jun 09, 2004 at 01:54:00AM +0200, Ralf Baechle wrote:
> On Mon, May 24, 2004 at 08:29:15PM +0200, Herbert Poetzl wrote:
> 
> > obviously I forgot to ask you to reserve a
> > syscall for linux-vserver, and I just discovered
> > this as the currently used number (273) was used
> > up by some other syscall (in 2.6.7-rc1) ...
> > 
> > so I'm asking you now, could you please reserve
> > a syscall for this project, so that we do not
> > need to change it on every new kernel release?
> > 
> > here is a list of currently reserved syscalls
> > (for other archs) and some links to the project
> > (in case you care)
> 
> Not really - other than the fact that I'm reluctant to reserve syscall
> numbers for something that might never make it into the kernel so
> usually i386 reserving a syscall is what convinces me ...
> 
> Due to the three support ABIs you actually get 3 syscall numbers even.
> o32 gets 277, N64 236 and N32 240.  Patch is below.

thank you very much!

best,
Herbert

>   Ralf
