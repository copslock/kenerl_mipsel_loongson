Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 21:05:00 +0100 (BST)
Received: from 66-122-194-201.ded.pacbell.net ([IPv6:::ffff:66.122.194.201]:18049
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8224802AbTFEUE6>; Thu, 5 Jun 2003 21:04:58 +0100
Received: from localhost.localdomain (greglaptop [127.0.0.1])
	by localhost.localdomain (8.12.8/8.12.5) with ESMTP id h55K6WOW001670
	for <linux-mips@linux-mips.org>; Thu, 5 Jun 2003 13:06:32 -0700
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.8/8.12.8/Submit) id h55K6W9m001668
	for linux-mips@linux-mips.org; Thu, 5 Jun 2003 13:06:32 -0700
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Thu, 5 Jun 2003 13:06:32 -0700
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
Message-ID: <20030605200632.GA1513@greglaptop.internal.keyresearch.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20030604153930.H19122@mvista.com> <20030604231547.GA22410@linux-mips.org> <20030604164652.J19122@mvista.com> <20030605001232.GA5626@linux-mips.org> <20030604183836.B25414@mvista.com> <16094.64161.12926.645512@doms-laptop.algor.co.uk> <20030605084852.GA25712@linux-mips.org> <20030605095348.C25414@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605095348.C25414@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Thu, Jun 05, 2003 at 09:53:48AM -0700, Jun Sun wrote:

> 1) yes, it is always possible to use some external system-wide
> timer source, if available, to solve this problem.  However, that could
> get tricky too, and I wanted to do something generic which is hopefully 
> applicable to more systems.

Such sources are generally both much lower resolution, and they take a
long time to read. But a _consistent_ but higher overhead, lower
resolution number is better than an inconsistent number.

greg
