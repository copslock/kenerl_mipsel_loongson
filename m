Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Oct 2008 21:16:06 +0100 (BST)
Received: from sj-iport-3.cisco.com ([171.71.176.72]:14555 "EHLO
	sj-iport-3.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20756325AbYJFUP5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Oct 2008 21:15:57 +0100
X-IronPort-AV: E=Sophos;i="4.33,369,1220227200"; 
   d="scan'208,223";a="106782030"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-3.cisco.com with ESMTP; 06 Oct 2008 20:15:49 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id m96KFngo032521
	for <linux-mips@linux-mips.org>; Mon, 6 Oct 2008 13:15:49 -0700
Received: from sausatlsmtp2.sciatl.com ([192.133.217.159])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m96KFm6u006794
	for <linux-mips@linux-mips.org>; Mon, 6 Oct 2008 20:15:48 GMT
Received: from default.com ([192.133.217.159]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Oct 2008 16:15:48 -0400
Received: from sausatlbhs02.corp.sa.net ([192.133.216.42]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Oct 2008 16:15:46 -0400
Received: from CUPLXSUNDISM01.corp.sa.net ([64.101.21.60]) by sausatlbhs02.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Oct 2008 16:15:45 -0400
Message-ID: <48EA71F0.3060003@sciatl.com>
Date:	Mon, 06 Oct 2008 13:15:44 -0700
From:	C Michael Sundius <Michael.sundius@sciatl.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Andy Whitcroft <apw@shadowen.org>
CC:	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	linux-mips@linux-mips.org, me94043@yahoo.com,
	"VomLehn, David" <dvomlehn@cisco.com>
Subject: Re: Have ever checked in your mips sparsemem code into mips-linux
 tree?
References: <48A4AC39.7020707@sciatl.com> <1218753308.23641.56.camel@nimitz> <48A4C542.5000308@sciatl.com> <20080826090936.GC29207@brain>
In-Reply-To: <20080826090936.GC29207@brain>
Content-Type: multipart/mixed;
 boundary="------------040706090500010903010809"
X-OriginalArrivalTime: 06 Oct 2008 20:15:45.0751 (UTC) FILETIME=[50C54670:01C927F0]
X-ST-MF-Message-Resent:	10/6/2008 16:15
Authentication-Results:	sj-dkim-4; header.From=Michael.sundius@sciatl.com; dkim=neutral
Return-Path: <michael.sundius@sciatl.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Michael.sundius@sciatl.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040706090500010903010809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

John wrote:


> Hi Michael,
>
> After I read this link, noticed that you have the following patch, but when I check up the mips-linux, the patch is not there.
>
> I wonder if you could explain to me a little bit?
>
> Thank you!
>
> John
> P.S.: I also worked at SciAtl a few years ago in IPTV division.
>   
John,

I *think* I got tentative signoff from Dave and Any below as per the 
copied snipits below.
I made the modifications that they suggested. please see the attached 
for two patches:
a) the code
b) the sparsemem.txt doc

not sure if the mips powers that be were ok w/ it. pardon my ignorance, 
not sure if I am
required to do anymore. There was some comment to try this out w/ the 
CONFIG_SPARSEMEM_VMEMMAP
which I believe should "just work", but we've never tried it as of yet, 
so by my rule I can't
say it is so.. (has anyone tried that?)

Mike

====================================================


Dave Hansen wrote:

Looks great to me.  I can't test it, of course, but I don't see any
problems with it.

Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>

-- Dave


Andy Whitcroft wrote:
>
>
> Otherwise it looks good to me.  I see from the rest of the thread that
> there is some discussion over the sizes of these, with that sorted.
>
> Acked-by: Andy Whitcroft <apw@shadowen.org>
>
> -apw
>   
adding patch 1 containing code only:





     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
--------------040706090500010903010809
Content-Type: text/x-patch;
 name="0001-mips-sparsemem-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-mips-sparsemem-support.patch"
