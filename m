Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 May 2004 20:05:14 +0100 (BST)
Received: from MAIL.13thfloor.at ([IPv6:::ffff:212.16.62.51]:25253 "EHLO
	mail.13thfloor.at") by linux-mips.org with ESMTP
	id <S8225963AbUEXTFL>; Mon, 24 May 2004 20:05:11 +0100
Received: by mail.13thfloor.at (Postfix, from userid 1001)
	id 7C6D3510173; Mon, 24 May 2004 21:05:08 +0200 (CEST)
Date:	Mon, 24 May 2004 21:05:08 +0200
From:	Herbert Poetzl <herbert@13thfloor.at>
To:	ralf@gnu.org
Cc:	linux-mips@linux-mips.org
Subject: Re: linux-vserver syscall ...
Message-ID: <20040524190508.GC27481@MAIL.13thfloor.at>
References: <20040524182915.GA27481@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524182915.GA27481@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Return-Path: <herbert@13thfloor.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@13thfloor.at
Precedence: bulk
X-list: linux-mips

On Mon, May 24, 2004 at 08:29:15PM +0200, Herbert Poetzl wrote:
> 
> Hi Ralf!
> 
> obviously I forgot to ask you to reserve a
> syscall for linux-vserver, and I just discovered
> this as the currently used number (273) was used
> up by some other syscall (in 2.6.7-rc1) ...
> 
> so I'm asking you now, could you please reserve
> a syscall for this project, so that we do not
> need to change it on every new kernel release?
> 
> here is a list of currently reserved syscalls
> (for other archs) and some links to the project
> (in case you care)

hmm, "a brain, I need a brain for my master" ...

okay here are the promised links:

  http://www.linux-vserver.org/
  http://vserver.13thfloor.at/Stuff/PAPER-05.4.txt

best,
Herbert

>    arch     number maintainer               
> --------------------------------------------
>    x86_64   236    [Andi Kleen]             
>    s390     263    [Martin Schwidefsky]     
>    sparc/64 267    [David S.Miller]         
>    i386     273    [Rik/Linus/Andrew]       
>    sh3/sh4  273    [Kazumoto Kojima]        
>    ppc/64   257    [Benjamin Herrenschmidt] 
> 
> thanks in advance,
> Herbert
> 
