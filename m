Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Apr 2004 03:39:33 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:46804 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8224923AbUDRCjb>; Sun, 18 Apr 2004 03:39:31 +0100
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1BF2Cy-0000JZ-00; Sat, 17 Apr 2004 21:39:00 -0500
Message-ID: <4081EA5F.5000802@realitydiluted.com>
Date: Sat, 17 Apr 2004 22:39:27 -0400
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: "Bradley D. LaRonde" <brad@laronde.org>, linux-mips@linux-mips.org,
	Eric Christopher <echristo@redhat.com>,
	Daniel Jacobowitz <dan@debian.org>
Subject: Re: [PATCH] gcc 3.4 drops "accum" clobber, replace with "hi" intime.c
References: <Pine.GSO.4.10.10404122244110.8735-100000@helios.et.put.poznan.pl> <20040412231309.GA702@linux-mips.org> <03f301c420e7$d8de2d70$8d01010a@prefect> <048e01c420f1$ad4ae3b0$8d01010a@prefect> <1081818125.19719.14.camel@dzur.sfbay.redhat.com> <04d501c420f3$6c836a30$8d01010a@prefect> <20040413010732.GA7560@nevyn.them.org> <04f501c420f4$5563f620$8d01010a@prefect> <053c01c420f5$ec230190$8d01010a@prefect> <Pine.LNX.4.55.0404131451200.15949@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0404131451200.15949@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> 
>  There are more places this should be dealt with and I have the following 
> preliminary patch for this, but I'm unsure about removal of "accum" being 
> completely safe for older compilers.
> 
Works fine for gcc-3.1.1 and my Swarm board boots just fine with this
change and it seems stable. I vote for you to go ahead and commit the
fixes to CVS. Thanks Maciej.

-Steve
