Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2009 14:43:15 +0000 (GMT)
Received: from smtp.ultrahosting.com ([74.213.174.254]:6028 "EHLO
	smtp.ultrahosting.com") by ftp.linux-mips.org with ESMTP
	id S21365847AbZAUOnL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Jan 2009 14:43:11 +0000
Received: from localhost (smtp.ultrahosting.com [127.0.0.1])
	by smtp.ultrahosting.com (Postfix) with ESMTP id ACEB182C46B
	for <linux-mips@linux-mips.org>; Wed, 21 Jan 2009 09:44:17 -0500 (EST)
X-Virus-Scanned: amavisd-new at ultrahosting.com
Received: from smtp.ultrahosting.com ([74.213.174.254])
	by localhost (smtp.ultrahosting.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oCsyhwPfuJne for <linux-mips@linux-mips.org>;
	Wed, 21 Jan 2009 09:44:17 -0500 (EST)
Received: from qirst.com (unknown [74.213.171.31])
	by smtp.ultrahosting.com (Postfix) with ESMTP id D967382C46D
	for <linux-mips@linux-mips.org>; Wed, 21 Jan 2009 09:44:16 -0500 (EST)
Received: from cl (helo=localhost)
	by qirst.com with local-esmtp (Exim 4.69)
	(envelope-from <cl@linux-foundation.org>)
	id 1LPeFC-0003UH-RE; Wed, 21 Jan 2009 09:39:50 -0500
Date:	Wed, 21 Jan 2009 09:39:50 -0500 (EST)
From:	Christoph Lameter <cl@linux-foundation.org>
X-X-Sender: cl@qirst.com
To:	Michael Sundius <msundius@cisco.com>
cc:	Dave Hansen <dave@linux.vnet.ibm.com>,
	Randy Dunlap <rdunlap@xenotime.net>,
	"Sundius, Michael" <Michael.sundius@sciatl.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>,
	msundius@sundius.com
Subject: Re: sparsemem support for mips with highmem
In-Reply-To: <4971002D.2090907@cisco.com>
Message-ID: <alpine.DEB.1.10.0901210938120.7424@qirst.com>
References: <48A4AC39.7020707@sciatl.com> <1218753308.23641.56.camel@nimitz>  <48A4C542.5000308@sciatl.com> <20080815080331.GA6689@alpha.franken.de>  <1218815299.23641.80.camel@nimitz> <48A5AADE.1050808@sciatl.com>  <20080815163302.GA9846@alpha.franken.de>
 <48A5B9F1.3080201@sciatl.com>  <1218821875.23641.103.camel@nimitz> <48A5C831.3070002@sciatl.com>  <20080818094412.09086445.rdunlap@xenotime.net>  <48A9E89C.4020408@linux-foundation.org> <1219094865.23641.118.camel@nimitz> <48A9EAA9.1080909@linux-foundation.org>
 <4971002D.2090907@cisco.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <cl@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cl@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Fri, 16 Jan 2009, Michael Sundius wrote:

> you said that the simplest configuration is to use vmalloc for the populate
> function.
> could you expand on that? (i didn't see that the populate function used
> vmalloc or maybe
> we are talking about a different populate function).

If you place the vmemmap in the vmalloc area then its easy to reserve
virtual space for the vmemmap. You can use the vmalloc populate functions
to populate the vmemmap.

> this work w/ mips which i understand uses only 2 levels can I just take out
> the part of
> the function that sets up the middle level table?

Sure. Hoever, the vmemmap populate stuff will do that automagically for
you.
