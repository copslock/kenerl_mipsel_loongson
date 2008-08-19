Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:07:06 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43500 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20029147AbYHSNG6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Aug 2008 14:06:58 +0100
Received: from [127.0.0.1] ([38.98.147.130])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7JD6Qtp006368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Aug 2008 06:06:28 -0700
Message-ID: <48AAC54D.8020609@linux-foundation.org>
Date:	Tue, 19 Aug 2008 08:06:21 -0500
From:	Christoph Lameter <cl@linux-foundation.org>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	David VomLehn <dvomlehn@cisco.com>
CC:	Randy Dunlap <rdunlap@xenotime.net>,
	C Michael Sundius <Michael.sundius@sciatl.com>,
	Dave Hansen <dave@linux.vnet.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>
Subject: Re: sparsemem support for mips with highmem
References: <48A4AC39.7020707@sciatl.com>	<1218753308.23641.56.camel@nimitz>	<48A4C542.5000308@sciatl.com>	<20080815080331.GA6689@alpha.franken.de>	<1218815299.23641.80.camel@nimitz>	<48A5AADE.1050808@sciatl.com>	<20080815163302.GA9846@alpha.franken.de>	<48A5B9F1.3080201@sciatl.com>	<1218821875.23641.103.camel@nimitz>	<48A5C831.3070002@sciatl.com> <20080818094412.09086445.rdunlap@xenotime.net> <48A9E89C.4020408@linux-foundation.org> <48A9F047.7050906@cisco.com>
In-Reply-To: <48A9F047.7050906@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <cl@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cl@linux-foundation.org
Precedence: bulk
X-list: linux-mips

David VomLehn wrote:

> On MIPS processors, the kernel runs in unmapped memory, i.e. the TLB
> isn't even
> used, so I don't think you can use that trick. So, this comment doesn't
> apply to
> all processors.

In that case you have a choice between the overhead of sparsemem lookups in
every pfn_to_page or using TLB entries to create a virtually mapped memmap
which may create TLB pressure.

The virtually mapped memmap results in smaller code and is typically more
effective since the processor caches the TLB entries.
