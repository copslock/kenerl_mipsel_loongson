Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 10:59:05 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:24331 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133631AbWBTK42 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 10:56:28 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1KB1Gwl005775;
	Mon, 20 Feb 2006 11:01:24 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1JGqjlf021793;
	Sun, 19 Feb 2006 16:52:45 GMT
Date:	Sun, 19 Feb 2006 16:52:45 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, jblache@debian.org
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060219165245.GD21416@linux-mips.org>
References: <20060217225824.GE20785@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217225824.GE20785@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 17, 2006 at 10:58:24PM +0000, Martin Michlmayr wrote:

> When you try to shutdown or reboot an IP22 with 2.6.15 or 2.6.16-rc2,
> you see that the TERM signal is sent but then nothing happens.  At the
> beginning, the light on the Indy is green but after about 20 seconds
> it turns red.  Nothing happens on the console and the machine doesn't
> turn off.  Seen on Indy and Indigo2.
> 
> Anyone got a fix?

No.  Do you know when this problems started?

  Ralf
