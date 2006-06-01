Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2006 01:44:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:17301 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133810AbWFAXoh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2006 01:44:37 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k51NiWGD018444;
	Fri, 2 Jun 2006 00:44:32 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k51NiVJT018443;
	Fri, 2 Jun 2006 00:44:31 +0100
Date:	Fri, 2 Jun 2006 00:44:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Location of PCI setup code
Message-ID: <20060601234430.GA16607@linux-mips.org>
References: <200606012246.17864.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606012246.17864.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 01, 2006 at 10:46:17PM +0200, Thomas Koeller wrote:

> the PCI setup code for a platform is conventionally located in arch/mips/pci. 
> I fail to see the benefits of separating this particular part of a platform's 
> setup from the rest. The PCI setup code will in general contain references to 
> platform-specific information, such as the overall address space layout, of 
> which the PCI memory and I/O pages are a part. If the PCI setup code were in 
> the platform subdirectory, sharing this information by means of a 
> platform-local header file would be easy. But with the PCI code in 
> arch/mips/pci, this becomes more difficult. The platform header could be 
> located somewhere outside the platform's directory, maybe under 
> 'include' (where?), or referenced via an ugly relative path like 
> '../../vendor/platform/platform.h'. All this seems rather clumsy to me. No 
> other part of a platform's initialization is separated from the rest in a 
> similar way, so what is so special about PCI setup that it cannot be in the 
> platform directory, thereby avoiding all these annoyances? 

The per-platform PCI code used to live in the per-platform directories.
It turned into a giant mess, very little code was being shared, it was
hard to uniformly perform any kind of modification or fixes - and more
of that kind of changes will be needed before the PCI codes really
shines.

  Ralf
