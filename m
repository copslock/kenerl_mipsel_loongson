Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 18:16:41 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39545 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012130AbaJVQQjp-7qu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 18:16:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9MGGclJ012536;
        Wed, 22 Oct 2014 18:16:38 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9MGGcWo012535;
        Wed, 22 Oct 2014 18:16:38 +0200
Date:   Wed, 22 Oct 2014 18:16:38 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Eunbong Song <eunb.song@samsung.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: add arch_trigger_all_cpu_backtrace() function
Message-ID: <20141022161637.GA12502@linux-mips.org>
References: <1669712409.167661413959996217.JavaMail.weblogic@epmlwas02b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669712409.167661413959996217.JavaMail.weblogic@epmlwas02b>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43495
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

On Wed, Oct 22, 2014 at 06:39:56AM +0000, Eunbong Song wrote:

Applying - but:

> +	if(regs)
         ^^^

There should be a blank between if and opening parenthesis.

  Ralf
