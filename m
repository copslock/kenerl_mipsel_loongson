Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Sep 2013 22:28:40 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:39882 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6826007Ab3IBU2fsDDdZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Sep 2013 22:28:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id D7C995A6F1A;
        Mon,  2 Sep 2013 23:28:34 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id PbR3X4603S-J; Mon,  2 Sep 2013 23:28:29 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id F3A8A5BC003;
        Mon,  2 Sep 2013 23:28:28 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Mon, 02 Sep 2013 23:28:24 +0300
Date:   Mon, 2 Sep 2013 23:28:24 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: irq 117 on ubiquiti edge router lite
Message-ID: <20130902202824.GA29249@blackmetal.musicnaut.iki.fi>
References: <CAHmME9ppVfYd6u+9iMFeTO1s11okAJ7Jm=hp+iE3FdLTTcCNJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9ppVfYd6u+9iMFeTO1s11okAJ7Jm=hp+iE3FdLTTcCNJA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Mon, Sep 02, 2013 at 05:12:49PM +0200, Jason A. Donenfeld wrote:
> [83817.191824] irq 117: nobody cared (try booting with the "irqpoll" option)
[...]
> [83817.192109] handlers:
> [83817.192115] [<ffffffff815a88d8>] 0xffffffff815a88d8
> [83817.192120] Disabling IRQ #117

Confirmed. The handler is cvm_oct_rgmii_rml_interrupt(). This happens
with fast network cable unplug/replug/unplug/replug. It seems there's
some kind of race and the interrupt won't get acked properly and there
is a huge flood of them:

117:     100000          0       CIU  46  RGMII

A.
