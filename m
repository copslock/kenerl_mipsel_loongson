Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2010 15:20:45 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:59242 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491091Ab0GHNUi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jul 2010 15:20:38 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 9D468542;
        Thu,  8 Jul 2010 15:20:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 936RspPOJi+4; Thu,  8 Jul 2010 15:20:31 +0200 (CEST)
Received: from [172.31.16.228] (d078161.adsl.hansenet.de [80.171.78.161])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id C061853A;
        Thu,  8 Jul 2010 15:20:22 +0200 (CEST)
Message-ID: <4C35D084.7050605@metafoo.de>
Date:   Thu, 08 Jul 2010 15:20:04 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     dedekind1@gmail.com
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 17/26] MTD: Nand: Add JZ4740 NAND driver
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>         <1276924111-11158-18-git-send-email-lars@metafoo.de> <1278569214.12733.38.camel@localhost>
In-Reply-To: <1278569214.12733.38.camel@localhost>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

Artem Bityutskiy wrote:
> On Sat, 2010-06-19 at 07:08 +0200, Lars-Peter Clausen wrote:
>> diff --git a/include/linux/mtd/jz4740_nand.h b/include/linux/mtd/jz4740_nand.h
>> new file mode 100644
>> index 0000000..379f9b6
>> --- /dev/null
>> +++ b/include/linux/mtd/jz4740_nand.h
>> @@ -0,0 +1,34 @@
>> +/*
>> + *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
>> + *  JZ4740 SoC NAND controller driver
>> + *
>> + *  This program is free software; you can redistribute	 it and/or modify it
>> + *  under  the terms of	 the GNU General  Public License as published by the
>> + *  Free Software Foundation;  either version 2 of the	License, or (at your
>> + *  option) any later version.
>> + *
>> + *  You should have received a copy of the  GNU General Public License along
>> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
>> + *  675 Mass Ave, Cambridge, MA 02139, USA.
>> + *
>> + */
>> +
>> +#ifndef __JZ_NAND_H__
>> +#define __JZ_NAND_H__
>> +
>> +#include <linux/mtd/nand.h>
>> +#include <linux/mtd/partitions.h>
>> +
>> +struct jz_nand_platform_data {
>> +	int			num_partitions;
>> +	struct mtd_partition	*partitions;
>> +
>> +	struct nand_ecclayout	*ecc_layout;
>> +
>> +	unsigned int busy_gpio;
>> +
>> +	void (*ident_callback)(struct platform_device *, struct nand_chip *,
>> +				struct mtd_partition **, int *num_partitions);
>> +};
>> +
>> +#endif
> 
> Do you really have to add your platform data strucutre to
> "inlculde/mtd" ? That is quite global namespace, and ideally only things
> like user-space interface and "public" interface of the MTD subsystem
> should live there.
> 
> Can you keep this somewhere in mips architecture directory?

Hi

Hm, ok, I see. I'll move it to arch/mips/include/asm/mach-jz4740/ then.
But I guess I should move the headers for all the other jz4740 driver to the same
directory as well.

On the other hand I'm wondering where on would put headers for non platform specific
drivers?

- Lars
