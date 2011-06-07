Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 01:22:25 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2209 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491851Ab1FGXWT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jun 2011 01:22:19 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4deeb2ea0000>; Tue, 07 Jun 2011 16:23:22 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 7 Jun 2011 16:22:17 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 7 Jun 2011 16:22:17 -0700
Message-ID: <4DEEB2A8.8050302@caviumnetworks.com>
Date:   Tue, 07 Jun 2011 16:22:16 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David VomLehn <dvomlehn@cisco.com>
CC:     Grant Likely <grant.likely@secretlab.ca>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        "Dezhong Diao (dediao)" <dediao@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Converting MIPS to Device Tree
References: <20110606010753.GA16202@linux-mips.org> <BANLkTik1mRWTcX8WgO5s6mFrUGYwBRmSow@mail.gmail.com> <20110607230218.GA23552@dvomlehn-lnx2.corp.sa.net>
In-Reply-To: <20110607230218.GA23552@dvomlehn-lnx2.corp.sa.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2011 23:22:17.0193 (UTC) FILETIME=[BDBC4D90:01CC2569]
X-archive-position: 30288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6264

On 06/07/2011 04:02 PM, David VomLehn wrote:
> On Sun, Jun 05, 2011 at 11:41:10PM -0500, Grant Likely wrote:
>> On Sun, Jun 5, 2011 at 7:07 PM, Ralf Baechle<ralf@linux-mips.org>  wrote:
>>> Over the past few days I've started to convert arch/mips to use DT.
>>
>> Nice!
>>
>>>   So
>>> far none of the platforms (except maybe PowerTV?) seems to have a
>>> firmware that is passing a DT nor is there any 2nd stage bootloader that
>>> could do so.
>>
>> FWIW, U-Boot now has pretty generic support for manipulating and
>> passing a dtb at boot.  That doesn't do much good for existing
>> deployed systems though.
>
> I took a look at the issue of passing device trees to the kernel and started
> by surveying the methods currently in use for passing information from the
> bootloader to the kernel. I came up with the ten approaches:
>
> How MIPS Bootloaders Pass Information to the Kernel
> ---------------------------------------------------
> Apologies for any errors; this was meant more to be a quick survey
> rather than a detailed analysis.
>
[...]
>
> 5.	a0 - unused
> 	a1 - unused
> 	a2 - unused
> 	Boot descriptor in a3.
> 	Platforms: cavium-octeon
>

I have augmented the boot descriptor with a field that contains the 
*physical* address of the DTB.

[...]
> 10.	a0 - argc
> 	a1 - argv
> 	a2 - unused
> 	a3 - memory size
> 	The command line is assumed to already be a single string, pointed
> 	to by argv.
> 	Platforms: powertv
>
> It seems like everything ultimately does create a command line. We could then
> use a parameter like "devtree=<virtual-address>" on the command line, passed
> in any way the bootloader likes.

Some  u-boots for non-mips platforms pass it in the environment of the 
bootm protocol.

I would say to pass the pointer to the DTB in the environment, but not 
all platforms (like powertv) have an environment.  So I guess the 
command line has to do.

Also I think we should pass the physical address of the DTB, not the 
virtual address.  It would be the kernel's responsibility to figure out 
what the virtual address is.

David Daney

> In this case, the<virtual-address>  will be
> a kseg0 address so we don't have to set up any mappings. If we allow multiple
> device trees to be built in or appended to the end of the kernel, we can use
> the existing "dtb_compat" command line parameter to select which one to use.
> I would propose that "devtree" take precedence over "dtb_compat", but that's
> really just a desire to pick one over the other, whichever is the preferred
> one.
