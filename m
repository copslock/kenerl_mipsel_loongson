Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 11:01:50 +0000 (GMT)
Received: from bender.bawue.de ([193.7.176.20]:28803 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133895AbWCXLBk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2006 11:01:40 +0000
Received: from lagash (unknown [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 153BB448E7; Fri, 24 Mar 2006 12:11:43 +0100 (MET)
Received: from ths by lagash with local (Exim 4.60)
	(envelope-from <ths@networkno.de>)
	id 1FMkDF-0002aC-8E; Fri, 24 Mar 2006 11:12:13 +0000
Date:	Fri, 24 Mar 2006 11:12:13 +0000
To:	Gowri Satish Adimulam <gowri@bitel.co.kr>
Cc:	linux-mips@linux-mips.org
Subject: Re: compilartion error   : label at end of compound statement
Message-ID: <20060324111213.GA7829@networkno.de>
References: <20060216.234519.82087885.anemo@mba.ocn.ne.jp> <20060324.131809.115639866.nemoto@toshiba-tops.co.jp> <1143184072.3249.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143184072.3249.26.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

On Fri, Mar 24, 2006 at 04:07:52PM +0900, Gowri Satish Adimulam wrote:
> Hi ,
> Iam trying to compile simple application with mips cross compiler ,
> Iam getting the below error , 
> i tried to google but unable to find relavent solution
> 
> any pointers will be helpful , 
> 
> ===============error==========
> 
> mipsel-linux-uclibc-gcc -Wall    -c -o ls.o ls.c
> ls.c: In function `donlist':
> ls.c:591: error: label at end of compound statement
> 
> ==============end of error============

The compiler got pickier about such empty statements some years
ago, you'll have to update your source from .e.g.

	switch (.....) {
	case 1:
		.....
		break;

	default:
	}

to

	switch (.....) {
	case 1:
		.....
		break;

	default:
		break;
	}


Thiemo
