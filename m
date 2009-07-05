Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jul 2009 17:39:46 +0200 (CEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52529 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492203AbZGEPjj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 5 Jul 2009 17:39:39 +0200
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n65FWEvq031885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 5 Jul 2009 08:32:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n65FWCqI021796;
	Sun, 5 Jul 2009 08:32:12 -0700
Date:	Sun, 5 Jul 2009 08:32:12 -0700 (PDT)
From:	Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@localhost.localdomain
To:	Paul Mundt <lethal@linux-sh.org>
cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Krzysztof Helt <krzysztof.h1@wp.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, ???? <yanh@lemote.com>,
	zhangfx <zhangfx@lemote.com>
Subject: Re: [BUG] drivers/video/sis: deadlock introduced by "fbdev: add
 mutex for fb_mmap locking"
In-Reply-To: <20090705152557.GA10588@linux-sh.org>
Message-ID: <alpine.LFD.2.01.0907050831260.3210@localhost.localdomain>
References: <1246785112.14240.34.camel@falcon> <alpine.LFD.2.01.0907050715490.3210@localhost.localdomain> <20090705145203.GA8326@linux-sh.org> <alpine.LFD.2.01.0907050756280.3210@localhost.localdomain> <20090705150134.GB8326@linux-sh.org>
 <alpine.LFD.2.01.0907050816110.3210@localhost.localdomain> <20090705152557.GA10588@linux-sh.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <torvalds@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips



On Mon, 6 Jul 2009, Paul Mundt wrote:
>
> Ok, here is an updated version with an updated matroxfb and the sm501fb
> change reverted.

Wu Zhangjin, can you also confirm that this works for you (without your 
patch)?

		Linus
