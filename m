Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2008 22:25:57 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:15052 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28600835AbYIRVZu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2008 22:25:50 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KgR0W-000804-00; Thu, 18 Sep 2008 23:25:48 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 16297C2CD7; Thu, 18 Sep 2008 23:25:46 +0200 (CEST)
Date:	Thu, 18 Sep 2008 23:25:46 +0200
To:	"Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: execve errno setting on MIPS
Message-ID: <20080918212545.GA23384@alpha.franken.de>
References: <7B7EF7F090B9804A830ACC82F2CDE95D53F553@insardxms01.ap.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D53F553@insardxms01.ap.sony.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Sep 18, 2008 at 05:09:35PM +0530, Sadashiiv, Halesh wrote:
> char e2BIG[ARG_MAX+1][10];
> char *envList[]={NULL};
>  
> int main(void)
> {
>   int ret,ind;
>  
>   for(ind = 0; ind < ARG_MAX+1; ind++)
>     strcpy(e2BIG[ind], "helloword");

this is broken and does cause an EFAULT on x86 as well (you should
take the warning from gcc about the second argument of execve serious).

Try:

char *e2BIG[ARG_MAX+1];
char *envList[]={NULL};

int main(void)
{
  int ret,ind;

    for(ind = 0; ind < ARG_MAX+1; ind++)
    	e2BIG[ind] = strdup("helloword");


And it looks like the ARG_MAX limit is bigger than my installed glibc
thinks, because it works at least on x86. When I increase the array two
2 * ARG_MAX I'll get the wanted E2BIG.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
