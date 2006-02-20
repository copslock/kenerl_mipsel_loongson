Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 18:05:52 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:33798 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133596AbWBTSFm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 18:05:42 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5060064D3D; Mon, 20 Feb 2006 18:12:36 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id B76498DA8; Mon, 20 Feb 2006 18:12:27 +0000 (GMT)
Date:	Mon, 20 Feb 2006 18:12:27 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, jblache@debian.org
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060220181227.GA17439@deprecation.cyrius.com>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060219165245.GD21416@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219165245.GD21416@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2006-02-19 16:52]:
> > beginning, the light on the Indy is green but after about 20 seconds
> > it turns red.  Nothing happens on the console and the machine doesn't
> > turn off.  Seen on Indy and Indigo2.
> > Anyone got a fix?
> No.  Do you know when this problems started?

A long time ago, it seems.  I can trace it back to 2.6.9;
unfortunately I don't get any older kernel to run/compile, possibily
because my toolchain isn't old enough (I even installed the SDE that's
based on 3.3).

Here's what I got:

2.6.15 - broken
2.6.14 - broken
2.6.13 - broken
2.6.10 - broken
2.6.9 - broken
2.6.8 - hangs after download (SDE)
2.6.6 - hangs after download (SDE)
2.6.5 - hangs after download (SDE)
2.6.4 - hangs after download (SDE)
2.6.3 - fails to load with: Text start 0x8000000, size 0x25e998 doesn't
          fit in a FreeMemory area.
2.6.1 - doesn't compile

-- 
Martin Michlmayr
http://www.cyrius.com/
