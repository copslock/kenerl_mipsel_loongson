Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2010 15:31:15 +0200 (CEST)
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59125 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491175Ab0JSNbM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Oct 2010 15:31:12 +0200
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF3E8D1E25;
        Tue, 19 Oct 2010 09:31:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
        :date:from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=b9RXKaLqRDcA
        LYDQMCnIOlwgj7s=; b=eyLUwYrx38D4p/S1MMr6yN6XR5EaIINr6QM/FdkDdFUV
        T1M4YJQpRiqGcTrqvTdbolNcaOrAr+Jc1vlZntVfo3wBXSF8L5r3PHVqG89/GMLH
        X0WgbIfVpvq7geM9zkrQBH+Jo1b/h6KsEuwZtsfI2NGAZIUvm5jynikkTZfhK2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
        :from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ac0Pr8
        Rh87ly1OwU2v6YZEjXt9z5bqTzDOwi5Z4ft6Fo5FxhS0Z66uvt9huIOfHEQLeJjg
        cA3ETAro4JTUw7z3XZ23QdL9FZnpUaxRUTJbOfpr585nvUlL8AmMlichfphM/6/v
        lMNP/WamGTl7Udy4GezAWSl/C3+uB0eg0yAk4=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD3F3D1E24;
        Tue, 19 Oct 2010 09:31:02 -0400 (EDT)
Received: from Shinya-Kuribayashis-MacBook.local (unknown [180.12.66.33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits)) (No client certificate
 requested) by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F878D1E23;
 Tue, 19 Oct 2010 09:30:57 -0400 (EDT)
Message-ID: <4CBD9D8C.3080302@pobox.com>
Date:   Tue, 19 Oct 2010 22:30:52 +0900
From:   Shinya Kuribayashi <skuribay@pobox.com>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US;
 rv:1.9.1.14) Gecko/20101005 Thunderbird/3.0.9
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 5/9] MIPS: sync after cacheflush
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
 <17d8d27a2356640a4359f1a7dcbb3b42@localhost> <4CBC4F4E.5010305@pobox.com>
 <AANLkTinpry=XG-ZDgXJK-VB6QkBL2TO4-vrsV5Tc1eEs@mail.gmail.com>
 <4CBCE05E.20408@renesas.com>
 <AANLkTinTaW87RGUZ+o4TL8gzUPGkoR8=7C1e7aYWC9=b@mail.gmail.com>
In-Reply-To: <AANLkTinTaW87RGUZ+o4TL8gzUPGkoR8=7C1e7aYWC9=b@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 1E1DF384-DB85-11DF-B10A-89B3016DD5F0-47602734!b-pb-sasl-quonix.pobox.com
Return-Path: <skuribay@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@pobox.com
Precedence: bulk
X-list: linux-mips

On 10/19/10 9:51 AM, Kevin Cernekee wrote:
> Correct.  This particular system makes no guarantees that data flushed
> out through CACHE operations will not overtake subsequent uncached
> stores.

Thanks for the clarification, understood.  So we only need to take care
of the order of out-bound data write transactions at the processor end,
and preceding uncached load is not required here.   Sorry for the noise.

   Shinya
