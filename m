Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Mar 2004 17:53:01 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:16768 "EHLO
	tibook.embeddededge.com") by linux-mips.org with ESMTP
	id <S8225219AbUCORxA>; Mon, 15 Mar 2004 17:53:00 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.embeddededge.com (8.11.1/8.11.1) with ESMTP id i2FHsBl00934;
	Mon, 15 Mar 2004 12:54:11 -0500
Message-ID: <4055EDC3.3040800@embeddededge.com>
Date: Mon, 15 Mar 2004 12:54:11 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tahoma Toelkes <tahoma@nshore.com>
CC: linux-mips@linux-mips.org
Subject: Re: zboot patch and linux_2_4 branch [was Re: Linux Boot Issue in
 Au1550]
References: <20040312074402.6BE522B2B58@ws5-7.us4.outblaze.com> <4051D48F.5080300@embeddededge.com> <405232DB.5050902@nshore.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Tahoma Toelkes wrote:

> ... When I try to apply the zboot patch, it rejects the chunk for 
> 'arch/mips/Makefile'.  However, upon inspection, I am unable to 
> determine why it isn't happy with the patch.  Any suggestions?

The Makefiles have been recently updated and the change is obvious
and trivial.  You can download a new patch from
http://embeddededge.com/downloads/amd-alchemy/zboot-2.4.25.patch
It's just the cost of wanting to play with the latest public
sources, sometimes the patches aren't exactly up to date.

I you don't want to use the CDs provided by AMD with their kits
and wish to continue to use the public sources, there are other
things to download from this directory as well.  The README
file explanins all, please read and follow it.

Thanks.


	-- Dan
