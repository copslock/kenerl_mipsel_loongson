Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Aug 2004 19:02:32 +0100 (BST)
Received: from the-village.bc.nu ([IPv6:::ffff:81.2.110.252]:62856 "EHLO
	localhost.localdomain") by linux-mips.org with ESMTP
	id <S8224948AbUHaSCU>; Tue, 31 Aug 2004 19:02:20 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11) with ESMTP id i7VH0KAa000769;
	Tue, 31 Aug 2004 18:00:20 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id i7VH0IXj000768;
	Tue, 31 Aug 2004 18:00:18 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [parisc-linux] [PATCH] New error codes for Alpha, MIPS,
	PA-RISC, Sparc & Sparc64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, rth@twiddle.net,
	linux-mips@linux-mips.org,
	HPPA List <parisc-linux@parisc-linux.org>,
	sparclinux@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <13071.1093965134@redhat.com>
References: <20040830232445.0b5aad79.akpm@osdl.org>
	 <13071.1093965134@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093971614.599.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 31 Aug 2004 18:00:15 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Maw, 2004-08-31 at 16:12, David Howells wrote:
> The attached patch adds the new error codes I added for key-related errors to
> those archs that don't make use of <asm-generic/errno.h>, including Alpha,
> MIPS, PA-RISC, Sparc and Sparc64. This is required to compile with CONFIG_KEYS
> on those platforms.

The patch seems to be mixing the fixups for remapping these error codes
into sparc, hpux, osf/1 and other compatibility layers on the platforms
