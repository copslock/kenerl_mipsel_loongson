Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 11:32:34 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43003 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491196Ab1HBJcb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Aug 2011 11:32:31 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p729Od5m018421;
        Tue, 2 Aug 2011 10:24:39 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p729OcD6018417;
        Tue, 2 Aug 2011 10:24:38 +0100
Date:   Tue, 2 Aug 2011 10:24:38 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jesper Juhl <jj@chaosbits.net>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/7] MIPS: static should be at beginning of declaration
Message-ID: <20110802092438.GA18229@linux-mips.org>
References: <alpine.LNX.2.00.1107092304160.25516@swampdragon.chaosbits.net>
 <alpine.LNX.2.00.1107092311190.25516@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LNX.2.00.1107092311190.25516@swampdragon.chaosbits.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1172

On Sat, Jul 09, 2011 at 11:12:35PM +0200, Jesper Juhl wrote:

> Make sure that the 'static' keywork is at the beginning of declaration
> for arch/mips/include/asm/mach-jz4740/gpio.h
> 
> This gets rid of warnings like
>   warning: ‘static’ is not at beginning of declaration
> when building with -Wold-style-declaration (and/or -Wextra which also
> enables it).
> Also a few tiny whitespace changes.

> - const static struct jz_gpio_bulk_request i2c_pins[] = {
> + static const struct jz_gpio_bulk_request i2c_pins[] = {

Quite surprising - but that still was valid C - just type for example:

int typedef (*func(const char op))(int a, int b[static const a = 3]);

  Ralf
