Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 15:29:41 +0100 (CET)
Received: from smtp-out-012.synserver.de ([212.40.185.12]:1101 "EHLO
        smtp-out-009.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010481AbbAGO3jHx4h6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 15:29:39 +0100
Received: (qmail 13795 invoked by uid 0); 7 Jan 2015 14:29:38 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 13578
Received: from p4fde6231.dip0.t-ipconnect.de (HELO ?192.168.2.103?) [79.222.98.49]
  by 217.119.54.96 with AES128-SHA encrypted SMTP; 7 Jan 2015 14:29:37 -0000
Message-ID: <54AD42D0.4070402@metafoo.de>
Date:   Wed, 07 Jan 2015 15:29:36 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>
CC:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH, RFC] MIPS: jz4740: use dma filter function
References: <22569458.nE7JkNNnz3@wuerfel> <54ABBCE6.8060904@metafoo.de> <2633187.PyovTNc8DC@wuerfel>
In-Reply-To: <2633187.PyovTNc8DC@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45003
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

On 01/06/2015 02:48 PM, Arnd Bergmann wrote:
> On Tuesday 06 January 2015 11:45:58 Lars-Peter Clausen wrote:
>> On 01/05/2015 11:39 PM, Arnd Bergmann wrote:
>>> As discussed on the topic of shmobile DMA today, jz4740 is the only
>>> user of the slave_id field in dma_slave_config besides shmobile. This
>>> use is really incompatible with the way that other drivers use the
>>> dmaengine API, so we should get rid of it.
>>
>> Do you have a link to that discussion?
>
> http://www.spinics.net/lists/linux-mmc/msg30069.html

I'm really not comfortable with this patch, since it is a step back. But I 
guess the end justify the means. So if it helps to get rid of slave_id I'm 
ok with it, sooner or later jz4740 will be converted to DT so once that's 
done the filter function can be removed again. But please put the filter 
function in a non arch specific header so we can still compile test things. 
And maybe note in the commit message that this is meant as a temporary hack.

- Lars
