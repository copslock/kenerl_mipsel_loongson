Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:36:37 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:59914 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903611Ab2HUSga (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Aug 2012 20:36:30 +0200
Message-ID: <5033D4DC.6050902@phrozen.org>
Date:   Tue, 21 Aug 2012 20:35:08 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] spi: Add SPI master controller for OCTEON SOCs.
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com> <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com> <5033D22E.2050307@phrozen.org> <5033D48B.8050903@gmail.com>
In-Reply-To: <5033D48B.8050903@gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 21/08/12 20:33, David Daney wrote:
> On 08/21/2012 11:23 AM, John Crispin wrote:
>> On 11/05/12 23:34, David Daney wrote:
>>> From: David Daney <david.daney@cavium.com>
>>>
>>> Add the driver, link it into the kbuild system and provide device tree
>>> binding documentation.
>>>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>
>> Thanks, queued for 3.7.
>>
> 
> This cannot go in like this.
> 
> There were a bunch of requests by other maintainers that were never
> done.  Also since it is in a foreign subsystem, it at a minimum needs
> some additional Acked-bys

hmmm ... you are right about the Acked-by ... i forgot to merge add it ...

i did ask you about this on IRC and you said the driver was ok to be
merged like this. inside the thread linus wllej at some point says that
his comment was bogus if i am not mistaken ?

John
