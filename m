Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2005 10:19:27 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:16154 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226108AbVCNKTM>; Mon, 14 Mar 2005 10:19:12 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j2EAITQG009285;
	Mon, 14 Mar 2005 10:18:29 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j2EAISKL009284;
	Mon, 14 Mar 2005 10:18:28 GMT
Date:	Mon, 14 Mar 2005 10:18:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: multi-threaded core dump
Message-ID: <20050314101828.GA7759@linux-mips.org>
References: <20050314.155840.44100135.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050314.155840.44100135.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 14, 2005 at 03:58:40PM +0900, Atsushi Nemoto wrote:

> It seems linux-mips does not produce correct register dumps in core
> file for multi-threaded programs.  This patch tries to fix it.  Could
> you review it?  Thank you.

Thanks,  applied.

  Ralf
