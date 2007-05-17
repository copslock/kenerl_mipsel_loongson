Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2007 15:04:22 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:24075 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20023467AbXEQOEU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 17 May 2007 15:04:20 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E61DDD8E1; Thu, 17 May 2007 14:03:42 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id B3813543E0; Thu, 17 May 2007 16:03:27 +0200 (CEST)
Date:	Thu, 17 May 2007 16:03:27 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	guido.zeiger@mailprocessor.de, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: Segmentation Fault from MP3-Player with Etch on Qube2
Message-ID: <20070517140327.GA3586@deprecation.cyrius.com>
References: <8FBE82E8-F399-426A-A263-E0EA85095A08@mailprocessor.de> <20070510.011348.25233649.anemo@mba.ocn.ne.jp> <20070516142849.GD19816@deprecation.cyrius.com> <20070517.201214.15246811.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070517.201214.15246811.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Atsushi Nemoto <anemo@mba.ocn.ne.jp> [2007-05-17 20:12]:
> Did the 2.4 kernel use ALSA or OSS?  I think ALSA for kernel 2.4 had
> same problem.

Yes, that was with OSS, sorry.

> And this is a minimal patch for current git tree.  But I'm not sure if
> this patch really fixes the reported segfault.

Gudio, can you try this patch or should I compile a kernel for you
with it?
-- 
Martin Michlmayr
http://www.cyrius.com/
