Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 18:49:27 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:16531 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225228AbUJTRtW>;
	Wed, 20 Oct 2004 18:49:22 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i9KHn5la012761
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Oct 2004 19:49:05 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i9KHn5LL012759;
	Wed, 20 Oct 2004 19:49:05 +0200
Date: Wed, 20 Oct 2004 19:49:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-mips@linux-mips.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2.6.9] Export phys_cpu_present_map
Message-ID: <20041020174905.GA12697@lst.de>
References: <20041020171626.GG12544@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020171626.GG12544@smtp.west.cox.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Wed, Oct 20, 2004 at 10:16:26AM -0700, Tom Rini wrote:
> In net/ipv6/icmp.c::icmpv6_init() there is a call to cpu_possible()
> which preprocesses down to "test_bit(((i)), (phys_cpu_present_map).bits)"
> If ipv6 is a module, phys_cpu_present_map (or cpu_possible_map which is
> defined t phys_cpu_present_map) needs to be exported.

The loop in there should be rewritten as for_each_cpu which doesn't need
this export.
