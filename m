Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Feb 2005 08:34:50 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:23637 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8224806AbVBVIee>;
	Tue, 22 Feb 2005 08:34:34 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j1M8XrH26414;
	Tue, 22 Feb 2005 09:33:53 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j1M8Xqc19910;
	Tue, 22 Feb 2005 09:33:53 +0100
Message-ID: <421AEE70.6060108@schenk.isar.de>
Date:	Tue, 22 Feb 2005 09:33:52 +0100
From:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Richard Sandiford <rsandifo@redhat.com>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] SMP/TLB problems with 64-bit kernels
References: <87r7jbdnba.fsf@firetop.home>
In-Reply-To: <87r7jbdnba.fsf@firetop.home>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:
> A 64-bit SB1 SMP kernel built from current 2.6 CVS sources will
> hang when trying to run init.  This is probably the same as the
> bug reported here:
> 
>   http://www.linux-mips.org/archives/linux-mips/2005-01/msg00086.html
> 

It is indeed.

> Please apply if OK.
> 

I second that. I have tested the patch on my Yosemite board
and it makes a 64-bit SMP kernel work again (as long as I do not
have more than 512 MB of memory).

Thanks
Rojhalat Ibrahim
