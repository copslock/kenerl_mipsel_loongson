Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 00:03:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53153 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493671AbZJMWDQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Oct 2009 00:03:16 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9DM4R8K001116;
	Wed, 14 Oct 2009 00:04:29 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9DM4HbP001105;
	Wed, 14 Oct 2009 00:04:17 +0200
Date:	Wed, 14 Oct 2009 00:04:17 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-mips@linux-mips.org,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -v1] MIPS: fix pfn_valid() for FLATMEM
Message-ID: <20091013220417.GA32099@linux-mips.org>
References: <1255001548-30567-1-git-send-email-wuzhangjin@gmail.com> <200910082221.12649.rjw@sisk.pl> <20091008204447.GA14560@linux-mips.org> <1255054108.5810.74.camel@falcon> <1255104130.3658.122.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255104130.3658.122.camel@falcon>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 10, 2009 at 12:02:10AM +0800, Wu Zhangjin wrote:

> The above patch can not fix the problem when enabled FLATMEM in
> linux-2.6.32-rc3, the real problem should be that we need register the
> "pci memory space" as nosave pages, and also, the above "reserved"(not
> memory) pages should be registered as nosave pages. but the simpler
> solution should be the pfn_valid() I sent out in this E-mail thread, we
> just need to check whether they are "valid", if they are "System
> RAM"(BOOT_MEM_RAM or BOOT_MEM_ROM_DATA), they should be valid.
> 
> and what's more? should be register "pci memory space" as nosave pages
> for all architecture?

No.  You only see this problem because your PCI memory space is between
the lowest and the highest memory address.  Other systems don't have this
issue because they either use the discontig or sparse memory models.

Btw, for systems that actually have memory in the 90000000-bfffffff range
and are running a 64-bit kernel with 4k ages the flatmem memory model
will waste 28MB of RAM; with 16k pages it's still 7MB.

Time to say gooebye to flatmem?

  Ralf
