Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 16:30:59 +0100 (BST)
Received: from phoenix.infradead.org ([IPv6:::ffff:81.187.226.98]:15369 "EHLO
	phoenix.infradead.org") by linux-mips.org with ESMTP
	id <S8225236AbUJTPay>; Wed, 20 Oct 2004 16:30:54 +0100
Received: from hch by phoenix.infradead.org with local (Exim 4.42 #1 (Red Hat Linux))
	id 1CKIPV-0005ff-TA; Wed, 20 Oct 2004 16:29:57 +0100
Date: Wed, 20 Oct 2004 16:29:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
	discuss@x86-64.org, sparclinux@vger.kernel.org,
	linuxppc64-dev@ozlabs.org, linux-m68k@vger.kernel.org,
	linux-sh@m17n.org, linux-arm-kernel@lists.arm.linux.org.uk,
	parisc-linux@parisc-linux.org, linux-ia64@vger.kernel.org,
	linux-390@vm.marist.edu, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add key management syscalls to non-i386 archs
Message-ID: <20041020152957.GA21774@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org,
	sparclinux@vger.kernel.org, linuxppc64-dev@ozlabs.org,
	linux-m68k@vger.kernel.org, linux-sh@m17n.org,
	linux-arm-kernel@lists.arm.linux.org.uk,
	parisc-linux@parisc-linux.org, linux-ia64@vger.kernel.org,
	linux-390@vm.marist.edu, linux-mips@linux-mips.org
References: <3506.1098283455@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3506.1098283455@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Return-Path: <SRS0+97a1f490ec9139208b82+423+infradead.org+hch@phoenix.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
Precedence: bulk
X-list: linux-mips

> Hi Linus, Andrew,
> 
> The attached patch adds syscalls for almost all archs (everything barring
> m68knommu which is in a real mess, and i386 which already has it).
> 
> It also adds 32->64 compatibility where appropriate.

Umm, that patch added the damn multiplexer that had been vetoed multiple
times.  Why did this happen?
