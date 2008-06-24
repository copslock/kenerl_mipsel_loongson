Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2008 00:07:40 +0100 (BST)
Received: from ozlabs.org ([203.10.76.45]:60593 "EHLO ozlabs.org")
	by ftp.linux-mips.org with ESMTP id S20045291AbYFXXHi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2008 00:07:38 +0100
Received: by ozlabs.org (Postfix, from userid 1003)
	id 63FC8DE340; Wed, 25 Jun 2008 09:07:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18529.29291.150197.168137@cargo.ozlabs.ibm.com>
Date:	Wed, 25 Jun 2008 08:17:15 +1000
From:	Paul Mackerras <paulus@samba.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
	rmk@arm.linux.org.uk, cooloney@kernel.org, dev-etrax@axis.com,
	dhowells@redhat.com, gerg@uclinux.org,
	yasutake.koichi@jp.panasonic.com, linux-parisc@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-sh@vger.kernel.org,
	chris@zankel.net, linux-mips@linux-mips.org,
	ysato@users.sourceforge.jp,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
In-Reply-To: <20080623174809.GE4756@cs181140183.pp.htv.fi>
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
X-Mailer: VM 8.0.9 under Emacs 22.1.1 (i486-pc-linux-gnu)
Return-Path: <paulus@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulus@samba.org
Precedence: bulk
X-list: linux-mips

Adrian Bunk writes:

> This patch contains the following cleanups for the asm/ptrace.h 
> userspace headers:

Acked-by: Paul Mackerras <paulus@samba.org>
