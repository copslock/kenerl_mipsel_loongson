Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2011 00:59:35 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52280 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491849Ab1JMW7b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Oct 2011 00:59:31 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p9DMxKqd002403;
        Thu, 13 Oct 2011 23:59:20 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p9DMxI4v002394;
        Thu, 13 Oct 2011 23:59:18 +0100
Date:   Thu, 13 Oct 2011 23:59:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Victor Kamensky <kamensky@cisco.com>
Cc:     David Daney <david.daney@cavium.com>, manesoni@cisco.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ananth@in.ibm.com
Subject: Re: [PATCH] MIPS Kprobes: Support branch instructions probing
Message-ID: <20111013225918.GA12513@linux-mips.org>
References: <20111013090749.GB16761@cisco.com>
 <4E971FD3.2020308@cavium.com>
 <20111013180714.GA7422@linux-mips.org>
 <Pine.GSO.4.58.1110131205410.7452@infra-view9.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.1110131205410.7452@infra-view9.cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9676

On Thu, Oct 13, 2011 at 12:16:27PM -0700, Victor Kamensky wrote:

> Yes, it does make a lot of sense. Don't you think we need to do
> EXPORT_SYMBOL for __compute_return_epc as well? So it could be used by
> klms.
> 
> Actually we have yet another copy of it in mips uprobes code, which
> normally is built as klm, if we refactor and export __compute_return_epc
> all three places could use the same function.

Nothing wrong with exporting __compute_return_epc() as long as there are
actually users of the exported symbol.  So far it's only used from the
kernel proper which is why it's not been exported.  However I'd prefer it
to be exported as EXPORT_SYMBOL_GPL().

  Ralf
