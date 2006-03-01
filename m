Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 10:00:38 +0000 (GMT)
Received: from daemon.nethack.at ([213.235.236.206]:41092 "EHLO
	daemon.nethack.at") by ftp.linux-mips.org with ESMTP
	id S8133385AbWCAKAa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 10:00:30 +0000
Received: (qmail 30636 invoked by uid 1000); 1 Mar 2006 11:08:18 +0100
Date:	Wed, 1 Mar 2006 11:08:18 +0100
From:	Michael Dosser <mic@nethack.at>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS kernel status as of 2.6.16-rc5
Message-ID: <20060301100817.GB928@nethack.at>
References: <20060228214144.GA6615@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228214144.GA6615@deprecation.cyrius.com>
Organization: Nethack.at
X-Operating-System: Debian GNU/Linux mips
X-PGP-Key: http://mic.priv.at/mic.asc
X-PGP-Public-Key: 1024D/5D872C06
X-PGP-Fingerprint: 2A21 7A7D BB77 8A41 B645  88BC 941A 80E8 5D87 2C06
X-RIPE-Handle: MD254-RIPE
X-sig-random-gen: http://cfml.sourceforge.net/perl/chsig.tar.gz
User-Agent: mutt-ng/devel-r655 (Debian)
Return-Path: <mic@daemon.nethack.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mic@nethack.at
Precedence: bulk
X-list: linux-mips

Hi,

* On 2006-02-28 22:41 <tbm@cyrius.com> wrote:

>  - IP22: Indigo2 with > 256 MB fails to boot (regression from 2.4;
>    while 2.4 would only see 256 MB, it would at least boot)

Is there a chance, that even if it would boot with > 256 MB linux could
actually use all 384 MB of RAM? If not, does anybody know why and can
explain it (I am no kernel developer and know only very little about the
I2 hardware)?

Thanks,
bye mic

-- 
Postmodernism is german romanticism with better special effects.
