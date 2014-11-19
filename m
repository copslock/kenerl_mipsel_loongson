Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 10:27:39 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34832 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011234AbaKSJ1iTZ08w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Nov 2014 10:27:38 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAJ9RZ1V007517;
        Wed, 19 Nov 2014 10:27:35 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAJ9RZra007516;
        Wed, 19 Nov 2014 10:27:35 +0100
Date:   Wed, 19 Nov 2014 10:27:35 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@codesourcery.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: jump_label.c: Handle the microMIPS J
 instruction encoding
Message-ID: <20141119092734.GA7358@linux-mips.org>
References: <alpine.DEB.1.10.1411170524070.2881@tp.orcam.me.uk>
 <alpine.DEB.1.10.1411170530220.2881@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1411170530220.2881@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44285
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

On Mon, Nov 17, 2014 at 04:10:32PM +0000, Maciej W. Rozycki wrote:

> +	if (IS_ENABLED(CONFIG_CPU_MICROMIPS)) {
> +		insn_p->halfword[0] = insn.word >> 16;
> +		insn_p->halfword[1] = insn.word;
> +	} else
> +		*insn_p = insn;

I think the IS_ENABLED() should be replaced with cpu_has_mmips?

  Ralf
