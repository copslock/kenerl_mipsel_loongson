Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2015 13:51:55 +0100 (CET)
Received: from smtp-out-106.synserver.de ([212.40.185.106]:1066 "EHLO
        smtp-out-099.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025953AbbAFMvxxx0il (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jan 2015 13:51:53 +0100
Received: (qmail 7873 invoked by uid 0); 6 Jan 2015 12:51:53 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 7690
Received: from ppp-88-217-3-222.dynamic.mnet-online.de (HELO ?192.168.178.23?) [88.217.3.222]
  by 217.119.54.73 with AES128-SHA encrypted SMTP; 6 Jan 2015 12:51:51 -0000
Message-ID: <54ABDA66.7040002@metafoo.de>
Date:   Tue, 06 Jan 2015 13:51:50 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
MIME-Version: 1.0
To:     =?windows-1252?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
CC:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH, RFC] MIPS: jz4740: use dma filter function
References: <22569458.nE7JkNNnz3@wuerfel> <54ABBCE6.8060904@metafoo.de> <yw1xtx04f54r.fsf@unicorn.mansr.com>
In-Reply-To: <yw1xtx04f54r.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 01/06/2015 01:47 PM, Måns Rullgård wrote:
> Lars-Peter Clausen <lars@metafoo.de> writes:
>
>> On 01/05/2015 11:39 PM, Arnd Bergmann wrote:
>>> As discussed on the topic of shmobile DMA today, jz4740 is the only
>>> user of the slave_id field in dma_slave_config besides shmobile. This
>>> use is really incompatible with the way that other drivers use the
>>> dmaengine API, so we should get rid of it.
>>
>> Do you have a link to that discussion?
>>
>>>
>>> This adds a trivial filter function that uses the filter param to
>>> pass the dma type, and uses that in both drivers.
>>
>> In my opinion that's just from bad to worse. Using filter functions
>> isn't that great in the first place. And using them to pass data from
>> the consumer to the DMA provider is just a horrible abuse of the API.
>
> It seems to me the only sane way to use the dmaengine API is in
> conjunction with DT.

At the moment yes. For non DT we need something like the gpiod lookup tables 
that allow you to specify the assignment of the DMA channel in the machine 
driver.

- Lars
