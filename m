Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2007 12:24:43 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:33040 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20024007AbXFKLYl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Jun 2007 12:24:41 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id B2CD2D8D1; Mon, 11 Jun 2007 11:24:34 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 62EC0544B2; Mon, 11 Jun 2007 13:17:08 +0200 (CEST)
Date:	Mon, 11 Jun 2007 13:17:08 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: -stable branches usage
Message-ID: <20070611111708.GA12814@deprecation.cyrius.com>
References: <20070529130833.GA4334@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070529130833.GA4334@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2007-05-29 14:08]:
> It's probably not a surprise when I'm saying that maintaining all
> the -stable branches of 2.6.16..2.6.21 for MIPS is a major effort
> and increasingly simply a huge pain in the ...  you know where due
> to the differences.  So before I actually deciede when and which of
> the branches I'm going to dump I would like to poll who actually
> uses these -stable branches.

For Debian, the 2.6.18 tree is useful since our stable kernel is based
on that release.  However, we can only put crucial fixes into a stable
release, so I wouldn't expect much to show up on the 2.6.18 branch.
-- 
Martin Michlmayr
http://www.cyrius.com/
