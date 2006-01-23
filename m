Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 20:49:03 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:21008 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3457351AbWAWUsp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 20:48:45 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 3314164D3D; Mon, 23 Jan 2006 20:52:21 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id D3FDC8D2D; Mon, 23 Jan 2006 20:51:54 +0000 (GMT)
Date:	Mon, 23 Jan 2006 20:51:54 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH]: Fix IP22 4k cache macro in cpu-feature-overrides.h
Message-ID: <20060123205154.GD15073@deprecation.cyrius.com>
References: <20060123203517.GC499@toucan.gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123203517.GC499@toucan.gentoo.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Kumba <kumba@gentoo.org> [2006-01-23 20:35]:
> In include/asm-mips/mach-ip22/cpu-feature-overrides.h, the macro to
> use R4K-style caches is mis-spelt.  This will cause IP22 systems to
> panic early in the boot due to no cache style being defined.  The
> attached patch corrects this.

"cpu_has_4kcache" is used in a number of other files too.
-- 
Martin Michlmayr
http://www.cyrius.com/
