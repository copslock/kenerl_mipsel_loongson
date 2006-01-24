Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 13:14:29 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:20750 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133479AbWAXNOM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 13:14:12 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0ODHfYS004572;
	Tue, 24 Jan 2006 13:17:41 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0ODHfCm004571;
	Tue, 24 Jan 2006 13:17:41 GMT
Date:	Tue, 24 Jan 2006 13:17:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH]: Add R14K Support (generic)
Message-ID: <20060124131741.GA3459@linux-mips.org>
References: <20060123230424.GA31197@toucan.gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123230424.GA31197@toucan.gentoo.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 23, 2006 at 11:04:24PM +0000, Kumba wrote:

> The attached patch essentially just copies what R12K does for R14K, and
should allow systems running an R14K CPU 
> actually boot.  Granted, no machine currently in git can actually use
R14K, but the patch is generic and 
> non-invaisive, so I thought I'd shoot it to the list anyways.  Minor
notes below.

Afaik it's not as trivial as this.  The R14000 has some changes to the FPU
which seem to require handling.  I unfortunately know no details.

  Ralf
