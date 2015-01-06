Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2015 13:47:21 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:55583 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025953AbbAFMrIBEHmZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jan 2015 13:47:08 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id C68611538A; Tue,  6 Jan 2015 12:47:00 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH, RFC] MIPS: jz4740: use dma filter function
References: <22569458.nE7JkNNnz3@wuerfel> <54ABBCE6.8060904@metafoo.de>
Date:   Tue, 06 Jan 2015 12:47:00 +0000
In-Reply-To: <54ABBCE6.8060904@metafoo.de> (Lars-Peter Clausen's message of
        "Tue, 06 Jan 2015 11:45:58 +0100")
Message-ID: <yw1xtx04f54r.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

Lars-Peter Clausen <lars@metafoo.de> writes:

> On 01/05/2015 11:39 PM, Arnd Bergmann wrote:
>> As discussed on the topic of shmobile DMA today, jz4740 is the only
>> user of the slave_id field in dma_slave_config besides shmobile. This
>> use is really incompatible with the way that other drivers use the
>> dmaengine API, so we should get rid of it.
>
> Do you have a link to that discussion?
>
>>
>> This adds a trivial filter function that uses the filter param to
>> pass the dma type, and uses that in both drivers.
>
> In my opinion that's just from bad to worse. Using filter functions
> isn't that great in the first place. And using them to pass data from
> the consumer to the DMA provider is just a horrible abuse of the API.

It seems to me the only sane way to use the dmaengine API is in
conjunction with DT.

-- 
Måns Rullgård
mans@mansr.com
