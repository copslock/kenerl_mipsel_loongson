Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 11:53:01 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:27154 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133385AbWCALwi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 11:52:38 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k21BxLmd004628;
	Wed, 1 Mar 2006 11:59:21 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k21BxLZe004627;
	Wed, 1 Mar 2006 11:59:21 GMT
Date:	Wed, 1 Mar 2006 11:59:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Mark E Mason <mark.e.mason@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Offer Sibyte IDE driver only on platforms that have IDE
Message-ID: <20060301115921.GB3779@linux-mips.org>
References: <20060301014723.GA16315@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301014723.GA16315@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 01, 2006 at 01:47:23AM +0000, Martin Michlmayr wrote:

> [PATCH] Offer Sibyte IDE driver only on platforms that have IDE
> 
> Currently Kconfig allows you to select the Sibyte IDE driver on
> any SB1 based SOC platform.  However, not all of them actually
> have IDE.  Nor do they import the correct files needed to compile
> the Sibyte (SWARM) IDE driver, leading to the compilation failure
> below on a SB1A 1480 board.
> 
> The situation can be improved by adding a SIBYTE_HAS_IDE Kconfig
> variable and change the dependency of the Sibyte IDE driver
> accordingly.

I would really prefer to see runtime probing etc. as step towards a
generic Sibyte kernel.

  Ralf
