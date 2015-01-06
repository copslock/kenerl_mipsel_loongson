Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2015 11:46:00 +0100 (CET)
Received: from smtp-out-090.synserver.de ([212.40.185.90]:1057 "EHLO
        smtp-out-090.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025663AbbAFKp7hBKpW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jan 2015 11:45:59 +0100
Received: (qmail 31934 invoked by uid 0); 6 Jan 2015 10:45:59 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 31907
Received: from ppp-88-217-3-222.dynamic.mnet-online.de (HELO ?192.168.178.23?) [88.217.3.222]
  by 217.119.54.87 with AES128-SHA encrypted SMTP; 6 Jan 2015 10:45:58 -0000
Message-ID: <54ABBCE6.8060904@metafoo.de>
Date:   Tue, 06 Jan 2015 11:45:58 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>
CC:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH, RFC] MIPS: jz4740: use dma filter function
References: <22569458.nE7JkNNnz3@wuerfel>
In-Reply-To: <22569458.nE7JkNNnz3@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44968
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

On 01/05/2015 11:39 PM, Arnd Bergmann wrote:
> As discussed on the topic of shmobile DMA today, jz4740 is the only
> user of the slave_id field in dma_slave_config besides shmobile. This
> use is really incompatible with the way that other drivers use the
> dmaengine API, so we should get rid of it.

Do you have a link to that discussion?

>
> This adds a trivial filter function that uses the filter param to
> pass the dma type, and uses that in both drivers.

In my opinion that's just from bad to worse. Using filter functions isn't 
that great in the first place. And using them to pass data from the consumer 
to the DMA provider is just a horrible abuse of the API.

The patch also adds a platform dependency, so the drivers won't built with 
COMPILE_TEST anymore.

- Lars
