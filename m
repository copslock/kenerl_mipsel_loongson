Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 12:43:46 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:59928 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133488AbWAYMn3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 12:43:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0PCldkN004677;
	Wed, 25 Jan 2006 12:47:39 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0PCld8U004676;
	Wed, 25 Jan 2006 12:47:39 GMT
Date:	Wed, 25 Jan 2006 12:47:39 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Message-ID: <20060125124738.GA3454@linux-mips.org>
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 25, 2006 at 10:36:46AM +0100, Franck wrote:

> Here is a little patch to optimize swab operations by using "wsbh"
> instruction available on mips revision 2 cpus. I do not know what
> condition I should use to compile this only for mips r2 cpu though.
> 
> Comments ?

Looks good aside of the one issue you've already raised yourself:

> +/* FIXME: MIPS_R2 only */

  Ralf
