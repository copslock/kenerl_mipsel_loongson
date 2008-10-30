Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 18:46:15 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:58523 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22756735AbYJ3SqC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Oct 2008 18:46:02 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490a00d40000>; Thu, 30 Oct 2008 14:45:40 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Oct 2008 11:45:40 -0700
Received: from [192.168.162.106] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Oct 2008 11:45:40 -0700
Message-ID: <490A00D3.50003@caviumnetworks.com>
Date:	Thu, 30 Oct 2008 11:45:39 -0700
From:	Chad Reese <kreese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.14eol) Gecko/20070505 Iceape/1.0.9 (Debian-1.0.13~pre080323b-0etch3)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	David Daney <ddaney@caviumnetworks.com>,
	Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 06/36] Add Cavium OCTEON processor CSR definitions
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <20081029184552.GB32500@lst.de> <4908B717.3010603@caviumnetworks.com> <20081030111354.GF26256@linux-mips.org>
In-Reply-To: <20081030111354.GF26256@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2008 18:45:40.0132 (UTC) FILETIME=[B4AF4640:01C93ABF]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kreese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> You see, everything was defined twice.  And gcc even recent gccs tend to
> do silly stuff with bitfields when combined with volatile:

Nobody should be using volatile anyway. It doesn't supply anywhere close
to the needed control for a register access. C would be a better
language if the volatile keyword was removed.

> The Linux programming programming model relies on accessor functions like
> readl, ioread32 etc.  Those take addresses as arguments - but bitfields
> don't have addresses in C ...

It is not valid on Octeon to access parts of CSR registers. You must do
a 64bit access, change whatever fields you want, and store the new
value. For this model bitfields work very well. GCC converts the
bitfield operations into bit insert and extract for mips64r2. It also
automatically combines multiple field sets into a single immediate load.

> So exec summary: bitfields bad for such low-level stuff.

Having spent a few years programming Octeon in various ways, bitfields
work really well for it.

Chad
