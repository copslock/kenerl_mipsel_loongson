Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2008 23:25:15 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:15552 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S23620859AbYKKXZN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Nov 2008 23:25:13 +0000
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id 77CD938F995C;
	Wed, 12 Nov 2008 00:25:07 +0100 (CET)
Date:	Wed, 12 Nov 2008 00:26:55 +0100
From:	Phil Sutter <n0-1@freewrt.org>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, florian@openwrt.org
Subject: Re: [PATCH] MIPS: rb532: fix bit swapping in rb532_set_bit()
Message-ID: <20081111232654.GA16299@nuty>
Mail-Followup-To: ralf@linux-mips.org, linux-mips@linux-mips.org,
	florian@openwrt.org
References: <1226445280-3676-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1226445280-3676-1-git-send-email-n0-1@freewrt.org>
User-Agent: Mutt/1.5.11
Return-Path: <n0-1@freewrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 12, 2008 at 12:14:40AM +0100, Phil Sutter wrote:
> This is a simplified version of the original fix, thanks to Atsushi Nemoto for
> the hint.

Shame on me, I got the wrong patch and so this is just a copy of the
mail sent before, but with a missing In-Reply-To header.

Sorry for that, Phil
