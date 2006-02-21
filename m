Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 12:28:27 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:542 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133394AbWBUM2T (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Feb 2006 12:28:19 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1LCYIcc007237;
	Tue, 21 Feb 2006 12:34:18 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1LCYGDa007236;
	Tue, 21 Feb 2006 12:34:16 GMT
Date:	Tue, 21 Feb 2006 12:34:16 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Domen Puncer <domen.puncer@ultra.si>
Cc:	Jordan Crouse <jordan.crouse@amd.com>, linux-mips@linux-mips.org
Subject: Re: [patch] au1xmmc: fix mmc_rsp_type typo
Message-ID: <20060221123416.GA3718@linux-mips.org>
References: <20060221093834.GA5120@domen.ultra.si> <20060221104619.GD5120@domen.ultra.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221104619.GD5120@domen.ultra.si>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 21, 2006 at 11:46:19AM +0100, Domen Puncer wrote:

> > Patch that added this suggests mmc_rsp_type should be mmc_resp_type.
> 
> Ouch, I thought I compile tested.
> Here's a fixed version:

Jordan?

  Ralf
