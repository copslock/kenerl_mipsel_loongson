Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 18:42:47 +0200 (CEST)
Received: from mail.kmu-office.ch ([178.209.48.102]:35910 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860995AbaGHQmlBwRKp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Jul 2014 18:42:41 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.kmu-office.ch (Postfix) with ESMTP id 63DB1440A9D
        for <linux-mips@linux-mips.org>; Tue,  8 Jul 2014 18:35:32 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at kmu-office.ch
Received: from mail.kmu-office.ch ([127.0.0.1])
        by localhost (mail.kmu-office.ch [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U-eT+f8nioVN for <linux-mips@linux-mips.org>;
        Tue,  8 Jul 2014 18:35:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.kmu-office.ch (Postfix) with ESMTP id 84D59440AF8
        for <linux-mips@linux-mips.org>; Tue,  8 Jul 2014 18:35:31 +0200 (CEST)
Received: from webmail.kmu-office.ch (unknown [178.209.48.103])
        (Authenticated sender: stefan@agner.ch)
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 5E438440A40;
        Tue,  8 Jul 2014 18:35:31 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Jul 2014 18:41:16 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     lars@metafoo.de
Cc:     linux-mips@linux-mips.org
Subject: dma: jz4740: Null pointer dereference
Message-ID: <82522335fb2ef700d5a94f9217cbdff6@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.0.1
Return-Path: <stefan@agner.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan@agner.ch
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

Hi Lars,

While looking through different DMA drivers, just stumbled upon this
inside jz4740_dma_chan_irq:

if (chan->next_sg == chan->desc->num_sgs) {
	chan->desc = NULL;
	vchan_cookie_complete(&chan->desc->vdesc);
                                         ^ null pointer dereference
}

I'm not sure what the correct fix is, hence I thought I report it to you
as author of the driver.

--
Stefan
