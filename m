Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2009 18:37:34 +0200 (CEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57128 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492208AbZGFQh2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2009 18:37:28 +0200
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n66GTKuM014705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 6 Jul 2009 09:29:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n66GTHGd019004;
	Mon, 6 Jul 2009 09:29:18 -0700
Date:	Mon, 6 Jul 2009 09:29:17 -0700 (PDT)
From:	Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@localhost.localdomain
To:	Krzysztof Helt <krzysztof.h1@poczta.fm>
cc:	wuzhangjin@gmail.com, Paul Mundt <lethal@linux-sh.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Krzysztof Helt <krzysztof.h1@wp.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, ???? <yanh@lemote.com>,
	zhangfx <zhangfx@lemote.com>
Subject: Re: [BUG] drivers/video/sis: deadlock introduced by "fbdev: add
 mutex for fb_mmap locking"
In-Reply-To: <20090706165036.d21bfaaa.krzysztof.h1@poczta.fm>
Message-ID: <alpine.LFD.2.01.0907060927561.3210@localhost.localdomain>
References: <1246785112.14240.34.camel@falcon> <alpine.LFD.2.01.0907050715490.3210@localhost.localdomain> <20090705145203.GA8326@linux-sh.org> <alpine.LFD.2.01.0907050756280.3210@localhost.localdomain> <20090705150134.GB8326@linux-sh.org>
 <alpine.LFD.2.01.0907050816110.3210@localhost.localdomain> <20090705152557.GA10588@linux-sh.org> <20090705181808.93be24a9.krzysztof.h1@poczta.fm> <1246842791.29532.2.camel@falcon> <20090706165036.d21bfaaa.krzysztof.h1@poczta.fm>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <torvalds@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips



On Mon, 6 Jul 2009, Krzysztof Helt wrote:
> 
> Who should I send this patch to be included as a 2.6.31 regression fix?

Just send the patches to me. I've got the patch, but no changelog, and so 
I'd like to see them again, with changelogs and the proper "Acked-by:" or 
"Tested-by" lines etc.

		Linus
