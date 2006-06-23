Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 14:54:51 +0100 (BST)
Received: from coderock.org ([193.77.147.115]:35267 "EHLO trashy.coderock.org")
	by ftp.linux-mips.org with ESMTP id S8133511AbWFWNym (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2006 14:54:42 +0100
Received: by trashy.coderock.org (Postfix, from userid 780)
	id 6DC8D1470; Fri, 23 Jun 2006 15:54:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id DE968146F;
	Fri, 23 Jun 2006 15:54:39 +0200 (CEST)
Received: from localhost (coderock.org [193.77.147.115])
	by trashy.coderock.org (Postfix) with ESMTP id 442EC13E;
	Fri, 23 Jun 2006 15:54:37 +0200 (CEST)
Date:	Fri, 23 Jun 2006 15:54:36 +0200
From:	Domen Puncer <domen@coderock.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Domen Puncer <domen.puncer@ultra.si>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch 1/8] au1xxx: psc fixes + add au1200 adresses
Message-ID: <20060623135436.GB9098@nd47.coderock.org>
References: <20060623095703.GA30980@domen.ultra.si> <20060623095831.GA31017@domen.ultra.si> <449BE538.5030203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449BE538.5030203@ru.mvista.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <domen@coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips

On 23/06/06 16:57 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Domen Puncer wrote:
> >Based on Jordan Crusoe's i2c patch:
> >- fix PSC3_BASE_ADDR to match au1550 databook
> >- fix PSC_SMBTXRX_RSR
> >- add PSC addresses for au1200
> 
>    That was my patch, originally. And (surprise!) it just went from the -mm 
> tree to Linus. Congrats, now we're going to have a patch conflict. :-)

Oh... sorry.

I guess waiting sometimes does solve the problem :-)


	Domen
