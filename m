Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2006 12:15:43 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:35542 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133492AbWGULPe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Jul 2006 12:15:34 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id A0C1E46034; Fri, 21 Jul 2006 13:15:33 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1G3sEi-0003Lb-E9; Fri, 21 Jul 2006 11:28:00 +0100
Date:	Fri, 21 Jul 2006 11:28:00 +0100
To:	pulsar@kpsws.com
Cc:	linux-mips@linux-mips.org
Subject: Re: reserved pages and zero pages question
Message-ID: <20060721102800.GA4456@networkno.de>
References: <1153414322.20352.268.camel@sakura.staff.proxad.net> <20060720191836.GA22361@linux-mips.org> <15360.194.171.252.100.1153474088.squirrel@mail.kpsws.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15360.194.171.252.100.1153474088.squirrel@mail.kpsws.com>
User-Agent: Mutt/1.5.12-2006-07-14
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

pulsar@kpsws.com wrote:
> Hi,
> 
> In my kernel startup I see the memory usage printed as:
> 
> Memory: 125312k/131072k available (1977k kernel code, 5648k reserved, 287k
> data, 1664k init, 0k highmem)
> 
> I wonder where the reserved pages are used for and how we can minimize it
> for small memory systems.

Most of that is the ramdisk you included. :-)  It normally given back
once the ramdisk is decompressed.

> In my search I see that in arcm/mips/mm/init.c there are zero-pages
> allocated and put to reserved.
> 
> Where are the zero pages used for and can we do without ?

They provide a clean zeroed page which gets mapped read-only (probably
for copy-on-write). You can't do without.


Thiemo
