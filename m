Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2008 11:19:46 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:53683 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S28604729AbYCRLTn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Mar 2008 11:19:43 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id E3A6148916;
	Tue, 18 Mar 2008 12:19:36 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JbZqd-0004Er-1I; Tue, 18 Mar 2008 11:19:15 +0000
Date:	Tue, 18 Mar 2008 11:19:15 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS prelink question
Message-ID: <20080318111914.GH26619@networkno.de>
References: <20080318.154701.74743177.kaminaga@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080318.154701.74743177.kaminaga@sm.sony.co.jp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hiroki Kaminaga wrote:
> 
> Hi!
> 
> I'm not sure if this is the right ML to ask, but since I've found
> discussion about MIPS prelink here, I'm posting here...

The binutils list would be a better place.

> In the below thread, patch for MIPS prelink was posted.
> http://www.linux-mips.org/archives/linux-mips/2006-11/msg00034.html
> 
> I've tried this patch, but I got below error when I tried to do prelink.
> 
> 	No space in ELF segment table to add new ELF segment

A bit more of the output would help with isolating the problem.
Anyway, IIRC there are two effects which cause this error:
 - Linking in binary objects which were built by a toolchain without
   prelink support, probably one of the compiler-internal startup files.
 - Use of an older version on binutils (from the time when the prelink
   patches went in), which still had a few issues with handling the
   additional segment.

> On the montavista pro 5.0 note, I found that they have fixed above
> prelink error, but I could not find the patch. Could someone give
> me pointer to address this issue?

I believe binutils 2.18 works fine WRT prelinking. I don't remember
the particular patches to watch out for, though.


Thiemo
