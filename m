Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2004 15:56:24 +0100 (BST)
Received: from sorrow.cyrius.com ([IPv6:::ffff:65.19.161.204]:25356 "EHLO
	sorrow.cyrius.com") by linux-mips.org with ESMTP
	id <S8225201AbUHQO4H>; Tue, 17 Aug 2004 15:56:07 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 35E8264D40; Tue, 17 Aug 2004 14:56:01 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 58F1AFECE; Tue, 17 Aug 2004 15:55:50 +0100 (BST)
Date: Tue, 17 Aug 2004 15:55:50 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Kaj-Michael Lang <milang@tal.org>
Cc: linux-mips@linux-mips.org
Subject: Re: O2 arcboot 32-bit kernel boot fix
Message-ID: <20040817145550.GB32393@deprecation.cyrius.com>
References: <001401c483b8$51d289f0$54dc10c3@amos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001401c483b8$51d289f0$54dc10c3@amos>
User-Agent: Mutt/1.5.6+20040803i
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Kaj-Michael Lang <milang@tal.org> [2004-08-16 20:41]:
> Played with arcboot today and fixed (for me atleast) loading of 32-bit
> kernels.
...
> http://fairytale.tal.org/pub/talinux/patches/arcboot-O2boot-and-progress.patch
> The fix was quite simple, arcboot was loading the kernel over itself, the

It has previously been suggested that the kernel needs to be patched
but your patch is against arcboot.  Who has to change?
-- 
Martin Michlmayr
tbm@cyrius.com
