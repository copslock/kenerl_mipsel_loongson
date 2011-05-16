Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 17:55:52 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41786 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491034Ab1EPPzs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 May 2011 17:55:48 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4GFvMUa028320;
        Mon, 16 May 2011 16:57:22 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4GFvLfj028319;
        Mon, 16 May 2011 16:57:21 +0100
Date:   Mon, 16 May 2011 16:57:21 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     linux-mips@linux-mips.org
Subject: Re: reference to non-existent CONFIG_HAVE_GPIO_LIB variable?
Message-ID: <20110516155721.GA27664@linux-mips.org>
References: <alpine.DEB.2.00.1105141904410.13343@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1105141904410.13343@localhost6.localdomain6>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, May 14, 2011 at 07:05:58PM -0400, Robert P. J. Day wrote:

>   the current kernel source contains a Makefile reference to the above
> Kconfig variable that does not appear to be defined anywhere.

Commit 7444a72effa632fcd8edc566f880d96fe213c73b ["gpiolib: allow user-
selection"] plus the fixups in commit
09cd9527d621640d4dd231dff77b681e711d8e4b ["gpiolib: fix HAVE_GPIO_LIB
leftovers in asm-generic/gpio.h"] and maybe others changed the symbol
name.  Somehow this instance was missed - maybe because the code was
merged around the same timeframe.

  Ralf
