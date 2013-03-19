Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Mar 2013 16:05:36 +0100 (CET)
Received: from zeniv.linux.org.uk ([195.92.253.2]:50816 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834883Ab3CSPFbXUKIg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Mar 2013 16:05:31 +0100
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.76 #1 (Red Hat Linux))
        id 1UHy6U-0003FF-Ly; Tue, 19 Mar 2013 15:05:30 +0000
Date:   Tue, 19 Mar 2013 15:05:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-mips@linux-mips.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Fix breakage in MIPS siginfo handling
Message-ID: <20130319150530.GH21522@ZenIV.linux.org.uk>
References: <20130319150053.32135.61438.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130319150053.32135.61438.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viro@ZenIV.linux.org.uk
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 19, 2013 at 03:00:53PM +0000, David Howells wrote:
> MIPS's siginfo handling has been broken since this commit:
> 
> 	commit 574c4866e33d648520a8bd5bf6f573ea6e554e88
> 	Author: Al Viro <viro@zeniv.linux.org.uk>
> 	Date:   Sun Nov 25 22:24:19 2012 -0500
> 	consolidate kernel-side struct sigaction declarations
> 
> for 64-bit BE MIPS CPUs.
> 
> The UAPI variant looks like this:
> 
> 	struct sigaction {
> 		unsigned int	sa_flags;
> 		__sighandler_t	sa_handler;
> 		sigset_t	sa_mask;
> 	};
> 
> but the core kernel's variant looks like this:
> 
> 	struct sigaction {
> 	#ifndef __ARCH_HAS_ODD_SIGACTION
> 		__sighandler_t	sa_handler;
> 		unsigned long	sa_flags;
> 	#else
> 		unsigned long	sa_flags;
> 		__sighandler_t	sa_handler;
> 	#endif
> 	#ifdef __ARCH_HAS_SA_RESTORER
> 		__sigrestore_t sa_restorer;
> 	#endif
> 		sigset_t	sa_mask;
> 	};
> 
> The problem is that sa_flags has been changed from an unsigned int to an
> unsigned long.
> 
> Fix this by making sa_flags unsigned int if __ARCH_HAS_ODD_SIGACTION is
> defined.
> 
> Whilst we're at it, rename __ARCH_HAS_ODD_SIGACTION to
> __ARCH_HAS_IRIX_SIGACTION.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Al Viro <viro@ZenIV.linux.org.uk>
> cc: Ralf Baechle <ralf@linux-mips.org>
> cc: linux-mips@linux-mips.org
> cc: stable@vger.kernel.org

ACKed-by: Al Viro <viro@zeniv.linux.org.uk>

but I think it should go via mips tree (or straight to Linus, for that
matter).  I can apply it in signal.git and push it to Linus today, though...
