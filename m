Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 18:53:33 +0100 (BST)
Received: from fw.osdl.org ([IPv6:::ffff:65.172.181.6]:20625 "EHLO
	mail.osdl.org") by linux-mips.org with ESMTP id <S8225254AbUJTRx0>;
	Wed, 20 Oct 2004 18:53:26 +0100
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i9KHqI923373;
	Wed, 20 Oct 2004 10:52:18 -0700
Date: Wed, 20 Oct 2004 10:50:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, discuss@x86-64.org,
	sparclinux@vger.kernel.org, linuxppc64-dev@ozlabs.org,
	linux-m68k@vger.kernel.org, linux-sh@m17n.org,
	linux-arm-kernel@lists.arm.linux.org.uk,
	parisc-linux@parisc-linux.org, linux-ia64@vger.kernel.org,
	linux-390@vm.marist.edu, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add key management syscalls to non-i386 archs
Message-Id: <20041020105027.54bf9e89.akpm@osdl.org>
In-Reply-To: <20041020152957.GA21774@infradead.org>
References: <3506.1098283455@redhat.com>
	<20041020152957.GA21774@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

Christoph Hellwig <hch@infradead.org> wrote:
>
> > Hi Linus, Andrew,
>  > 
>  > The attached patch adds syscalls for almost all archs (everything barring
>  > m68knommu which is in a real mess, and i386 which already has it).
>  > 
>  > It also adds 32->64 compatibility where appropriate.
> 
>  Umm, that patch added the damn multiplexer that had been vetoed multiple
>  times.  Why did this happen?

Fifteen new syscalls was judged excessive and the keyfs interface was
judged slow and bloaty.
