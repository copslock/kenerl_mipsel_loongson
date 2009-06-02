Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 21:14:06 +0100 (WEST)
Received: from waste.org ([66.93.16.53]:46555 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022117AbZFBUN4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Jun 2009 21:13:56 +0100
Received: from [192.168.1.100] ([10.0.0.101])
	(authenticated bits=0)
	by waste.org (8.13.8/8.13.8/Debian-3) with ESMTP id n52KDAnN001074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Jun 2009 15:13:11 -0500
Subject: Re: [PATCH] hwrng: Add TX4939 RNG driver (v2)
From:	Matt Mackall <mpm@selenic.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
In-Reply-To: <1243954462-18149-1-git-send-email-anemo@mba.ocn.ne.jp>
References: <1243954462-18149-1-git-send-email-anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Date:	Tue, 02 Jun 2009 15:13:04 -0500
Message-Id: <1243973584.22069.182.camel@calx>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new
Return-Path: <mpm@selenic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpm@selenic.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-06-02 at 23:54 +0900, Atsushi Nemoto wrote:
> This patch adds support for the integrated RNG of the TX4939 SoC.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Acked-by: Matt Mackall <mpm@selenic.com>

-- 
http://selenic.com : development and support for Mercurial and Linux
