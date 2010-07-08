Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2010 16:02:50 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:62683 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492278Ab0GHOCq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jul 2010 16:02:46 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id AB7207BC;
        Thu,  8 Jul 2010 16:02:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id iZEVjPZkbeqm; Thu,  8 Jul 2010 16:02:39 +0200 (CEST)
Received: from [172.31.16.228] (d078161.adsl.hansenet.de [80.171.78.161])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id D94C47BB;
        Thu,  8 Jul 2010 16:02:38 +0200 (CEST)
Message-ID: <4C35DA6C.2060405@metafoo.de>
Date:   Thu, 08 Jul 2010 16:02:20 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     dedekind1@gmail.com
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 17/26] MTD: Nand: Add JZ4740 NAND driver
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>  <1276924111-11158-18-git-send-email-lars@metafoo.de>    <1278569214.12733.38.camel@localhost>  <4C35D084.7050605@metafoo.de> <1278595142.20321.26.camel@localhost>
In-Reply-To: <1278595142.20321.26.camel@localhost>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

Artem Bityutskiy wrote:
> On Thu, 2010-07-08 at 15:20 +0200, Lars-Peter Clausen wrote:
>> On the other hand I'm wondering where on would put headers for non platform specific
>> drivers?
> 
> If we are talking about MTD, then drivers/mtd ?
> 
No, what I meant was header defining platform data structs and such.
And what I wanted to get at is an answer to why driver header files are put in
different directories while the driver files themselves are all keep in the same
directory. (drivers of the same subsystem that is)

- Lars
