Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 15:55:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60230 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825716Ab2LLOzsSnwmE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Dec 2012 15:55:48 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id qBCEtlWP005814;
        Wed, 12 Dec 2012 15:55:47 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id qBCEtjNp005813;
        Wed, 12 Dec 2012 15:55:45 +0100
Date:   Wed, 12 Dec 2012 15:55:45 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Florian Fainelli <florian@openwrt.org>,
        "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] OF: MIPS: sead3: Implement OF support.
Message-ID: <20121212145545.GC11791@linux-mips.org>
References: <1354857297-28863-1-git-send-email-sjhill@mips.com>
 <50C894D4.4090008@openwrt.org>
 <50C89A6C.705@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50C89A6C.705@metafoo.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Dec 12, 2012 at 03:53:32PM +0100, Lars-Peter Clausen wrote:

> This is one compatible string though, what you describe is for when use
> multiple compatible string. E.g.
> compatible = "mips14KEc", "mips14Kc", "mips";
> 
> The "mips" in Stevens patch is probably the vendor prefix. Maybe a more
> correct compatible would be.

How about using something like mti (for MIPS Technologies, Inc.) instead
of MIPS to differenciate the architecture from the company name?

  Ralf
