Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Mar 2003 00:08:23 +0000 (GMT)
Received: from p508B652B.dip.t-dialin.net ([IPv6:::ffff:80.139.101.43]:62698
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225258AbTC2AIW>; Sat, 29 Mar 2003 00:08:22 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2T08J126207;
	Sat, 29 Mar 2003 01:08:19 +0100
Date: Sat, 29 Mar 2003 01:08:19 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: cswitch not defined if !CONFIG_VT
Message-ID: <20030329010819.A20657@linux-mips.org>
References: <m21y0sb9et.fsf@neno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m21y0sb9et.fsf@neno.mitica>; from quintela@mandrakesoft.com on Fri, Mar 28, 2003 at 01:51:38AM +0100
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 28, 2003 at 01:51:38AM +0100, Juan Quintela wrote:

> 	cswitch is only used when CONFIG_VT is defined.

Applied,

  Ralf
