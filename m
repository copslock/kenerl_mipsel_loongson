Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jul 2009 16:26:45 +0200 (CEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33639 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492028AbZGEO0i (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 5 Jul 2009 16:26:38 +0200
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n65EJaKw026611
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 5 Jul 2009 07:19:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n65EJXbA003368;
	Sun, 5 Jul 2009 07:19:33 -0700
Date:	Sun, 5 Jul 2009 07:19:33 -0700 (PDT)
From:	Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@localhost.localdomain
To:	Wu Zhangjin <wuzhangjin@gmail.com>
cc:	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Krzysztof Helt <krzysztof.h1@wp.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	=?GB2312?B?6sy7qg==?= <yanh@lemote.com>,
	zhangfx <zhangfx@lemote.com>
Subject: Re: [BUG] drivers/video/sis: deadlock introduced by "fbdev: add
 mutex for fb_mmap locking"
In-Reply-To: <1246785112.14240.34.camel@falcon>
Message-ID: <alpine.LFD.2.01.0907050715490.3210@localhost.localdomain>
References: <1246785112.14240.34.camel@falcon>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <torvalds@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips



On Sun, 5 Jul 2009, Wu Zhangjin wrote:
> 
> then it works! so, I guess there is a deadlock introduced by the above
> commit.

Hmm. Perhaps more likely, the 'mm_lock' mutex hasn't even been initialized 
yet.  We appear to have had that problem with matroxfb and sm501fb, and it 
may be more common than that. See commit f50bf2b2.

That said, I do agree that the mm_lock seems to be causing more problems 
than it actually fixes, and maybe we should revert it. Krzysztof?

		Linus
