Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 19:44:10 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:50935 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S1122958AbSIDRoK>;
	Wed, 4 Sep 2002 19:44:10 +0200
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA23039;
	Wed, 4 Sep 2002 10:44:01 -0700
Message-ID: <3D7643BA.6090807@mvista.com>
Date: Wed, 04 Sep 2002 10:32:42 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
References: <20020904155645.A31893@linux-mips.org> <Pine.GSO.3.96.1020904160219.10619G-100000@delta.ds2.pg.gda.pl> <20020904163101.C32519@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 84
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips



Ralf Baechle wrote:
> On Wed, Sep 04, 2002 at 04:14:13PM +0200, Maciej W. Rozycki wrote:
> 
> The primary problem is the differnet calling sequence for o32 and N64.
> As it looks we'll be able to use either the o32 function or the native
> syscall to implement all of the necessary N32 syscalls.

For 64bit kernel, do we intend to have one syscall table that support o32, n32 
and n64 altogether?  Or we will have multiple tables for them?

> 
> The question is if we want to reserve another 1000 entries in our already
> huge syscall table for N32 or if we got a better solution ...
>

It seems n32 can be naturally implemented through n64 syscalls, although I am 
sure there are some nasty details to work out.

Where can I find n32/n64 spec?

Jun
