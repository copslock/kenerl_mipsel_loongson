Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2006 10:29:55 +0000 (GMT)
Received: from frigate.technologeek.org ([62.4.21.148]:44941 "EHLO
	frigate.technologeek.org") by ftp.linux-mips.org with ESMTP
	id S8133484AbWBRK3q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 18 Feb 2006 10:29:46 +0000
Received: by frigate.technologeek.org (Postfix, from userid 1000)
	id 3BFC91474E01; Sat, 18 Feb 2006 11:36:19 +0100 (CET)
From:	Julien BLACHE <jblache@debian.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: IP22 doesn't shutdown properly
References: <20060217225824.GE20785@deprecation.cyrius.com>
	<43F67607.1030703@gentoo.org>
	<20060218012713.GJ20785@deprecation.cyrius.com>
Date:	Sat, 18 Feb 2006 11:36:19 +0100
In-Reply-To: <20060218012713.GJ20785@deprecation.cyrius.com> (Martin
	Michlmayr's message of "Sat, 18 Feb 2006 01:27:13 +0000")
Message-ID: <877j7trm1o.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.17 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jblache@debian.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jblache@debian.org
Precedence: bulk
X-list: linux-mips

Martin Michlmayr <tbm@cyrius.com> wrote:

Hi,

> By the way, Stephen Becker mentioned on IRC that he sees the same -
> but *only* when he uses serial console, not fb (sounds a bit odd to
> me, but maybe someone can make sense of this).

Same for me on my I2, hangs on serial console, works fine on fb
(shutdown, reboot not tested in this configuration).

JB.

-- 
 Julien BLACHE <jblache@debian.org>  |  Debian, because code matters more 
 Debian & GNU/Linux Developer        |       <http://www.debian.org>
 Public key available on <http://www.jblache.org> - KeyID: F5D6 5169 
 GPG Fingerprint : 935A 79F1 C8B3 3521 FD62 7CC7 CD61 4FD7 F5D6 5169 
