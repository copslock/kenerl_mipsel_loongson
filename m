Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 17:33:56 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:38673 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20024719AbXHXQds (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Aug 2007 17:33:48 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 834B0D8D3; Fri, 24 Aug 2007 16:33:12 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 644E75437A; Fri, 24 Aug 2007 18:32:52 +0200 (CEST)
Date:	Fri, 24 Aug 2007 18:32:52 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: kobject_add failed for vcs1 with -EEXIST
Message-ID: <20070824163252.GF7029@deprecation.cyrius.com>
References: <20070824162044.GB7029@deprecation.cyrius.com> <20070824173819.15032660@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070824173819.15032660@the-village.bc.nu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Alan Cox <alan@lxorguk.ukuu.org.uk> [2007-08-24 17:38]:
> I see this on x86 with all kernels newer than about 2.6.20, but at
> random and only rarely. I'd love to know what is going on and if the
> mips is a reproducable case thata good news.

Hmm, indeed, doesn't look reproducible here either, but I'll let you
know in case I'll find a way to reproduce it.
-- 
Martin Michlmayr
http://www.cyrius.com/
