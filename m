Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 23:49:18 +0100 (CET)
Received: from mail.perches.com ([173.55.12.10]:4269 "EHLO mail.perches.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491894Ab1CXWtP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Mar 2011 23:49:15 +0100
Received: from [192.168.1.162] (unknown [192.168.1.162])
        by mail.perches.com (Postfix) with ESMTP id 1D47B24368;
        Thu, 24 Mar 2011 14:49:03 -0800 (PST)
Subject: Re: [PATCH 0/2] Fix resource size miscalculations
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-fbdev@vger.kernel.org
In-Reply-To: <cover.1300909445.git.joe@perches.com>
References: <cover.1300909445.git.joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 24 Mar 2011 15:49:05 -0700
Message-ID: <1301006945.29444.15.camel@Joe-Laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips

On Wed, 2011-03-23 at 12:55 -0700, Joe Perches wrote:
> Use resource_size a few places

Perhaps this relatively common error is too common.
It seems to be poor style.  A possible better style for
struct resource uses could be inline function(s) like:

static inline void __iomem *resource_ioremap(struct resource *r)
{
	return ioremap(r->start, resource_size(r));
}

and maybe

static inline struct resource *
resource_request_region(struct resource *r, const char *name)
{
	return __request_region(&ioport_resource, r->start, resource_size(r), name, 0);
}
