Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 11:24:50 +0100 (BST)
Received: from mx1.redhat.com ([66.187.233.31]:27881 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S20023260AbYFXKYn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2008 11:24:43 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5OANobG028481;
	Tue, 24 Jun 2008 06:23:50 -0400
Received: from pobox.devel.redhat.com (pobox.devel.redhat.com [10.11.255.8])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5OANodX010058;
	Tue, 24 Jun 2008 06:23:50 -0400
Received: from warthog.cambridge.redhat.com (devserv.devel.redhat.com [10.10.36.72])
	by pobox.devel.redhat.com (8.13.1/8.13.1) with ESMTP id m5OANmlw014518;
	Tue, 24 Jun 2008 06:23:48 -0400
Received: from [127.0.0.1] (helo=redhat.com)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KB5gi-000260-AU; Tue, 24 Jun 2008 11:23:48 +0100
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From:	David Howells <dhowells@redhat.com>
In-Reply-To: <20080623174809.GE4756@cs181140183.pp.htv.fi>
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	dhowells@redhat.com, Roland McGrath <roland@redhat.com>,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
	cooloney@kernel.org, dev-etrax@axis.com, gerg@uclinux.org,
	yasutake.koichi@jp.panasonic.com, linux-parisc@vger.kernel.org,
	paulus@samba.org, linuxppc-dev@ozlabs.org,
	linux-sh@vger.kernel.org, chris@zankel.net,
	linux-mips@linux-mips.org, ysato@users.sourceforge.jp,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
X-Mailer: MH-E 8.0.3+cvs; nmh 1.2-20070115cvs; GNU Emacs 23.0.50
Date:	Tue, 24 Jun 2008 11:23:48 +0100
Message-ID: <8058.1214303028@redhat.com>
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhowells@redhat.com
Precedence: bulk
X-list: linux-mips

Adrian Bunk <bunk@kernel.org> wrote:

> This patch contains the following cleanups for the asm/ptrace.h 
> userspace headers:
> - include/asm-generic/Kbuild.asm already lists ptrace.h, remove
>   the superfluous listings in the Kbuild files of the following
>   architectures:
> ...
>   - frv
> ...
> - don't expose function prototypes and macros to userspace:
> ...
>   - mn10300

Acked-by: David Howells <dhowells@redhat.com> (FRV and MN10300)
