Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 23:10:46 +0200 (CEST)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:46872 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012166AbaJVVKo4b8sP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 23:10:44 +0200
Received: by mail-ig0-f170.google.com with SMTP id hn18so1688223igb.3
        for <multiple recipients>; Wed, 22 Oct 2014 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2gd3BfxOUDj9fh2KbbLVC+Ivuy8fDIurItRs35d/UQ0=;
        b=HA5d0GzGubeZ6PPFu5vc4gxbZTBy2He4sFCaWl3gzB7S0G0GnqXohhx8w4FfznINSr
         moQP66wA9eYI2D56k5E7UV425pFDZ1tL0VR+uId6HvwJj00LnvCDCFu0+BWwgPO2xQVZ
         FZ5XrdbE9BA3SJaTshDGJwLMwNK8wQ4zJj912ZTRPDY2sfH2pp2dVabMoKpzaqV/IkFO
         H9CUnWiargqZcWGz79dfV7dlbXoY+5PLtENGDv5bNRIzreC2sBa3cImTVkEgApuiXU3z
         ZZOC3fRV3y6mUOZbA/pT/zM2BcoZnzvgoP5vbF7KreqL/RrejpUAzFJA1o2pYm2vtyJu
         Yb3A==
X-Received: by 10.107.158.80 with SMTP id h77mr677237ioe.41.1414012238725;
        Wed, 22 Oct 2014 14:10:38 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id x9sm1288560igl.10.2014.10.22.14.10.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 Oct 2014 14:10:38 -0700 (PDT)
Message-ID: <54481D4C.5090602@gmail.com>
Date:   Wed, 22 Oct 2014 14:10:36 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Single MIPS kernel
References: <20141022083437.GB18581@linux-mips.org> <5447EFB5.4090009@gmail.com> <20141022190515.GC12502@linux-mips.org> <alpine.LFD.2.11.1410222010280.21390@eddie.linux-mips.org> <20141022204209.GE12502@linux-mips.org>
In-Reply-To: <20141022204209.GE12502@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/22/2014 01:42 PM, Ralf Baechle wrote:
> On Wed, Oct 22, 2014 at 08:19:07PM +0100, Maciej W. Rozycki wrote:
>
>>>> Another reason is that the protocol between the bootloader and the kernel
>>>> varies by platform.  So you would have to have several different entry
>>>> points, one for each booting protocol.
>>>>
>>>> I am not sure how the bootloaders would know which entry point to use.
>>>
>>> That's where I foresaw the needs for the ISA style platform probe right
>>> at the kernel entry point before fanning out to a platform-specific
>>> entry point.
>>>
>>> Since we already support compressed kernels I'm wondering if relocation
>>> might also be performed by the compression wrapper along with the
>>> hardware probe.  That would leave the vmlinux itself untouched and
>>> the wrapper could be installed on the target.
>>
>>   Wouldn't it make sense to make a unified kernel virtually mapped?  That
>> would avoid the issue with RAM being present at different locations across
>> systems and also if big pages were used, that I believe are available
>> almost universally across the MIPS family, any performance hit would be
>> minimal.  There would be hardly any increase in the binary image size too.
>> Run-time mappings such as `kmalloc' or `ioremap' could continue using
>> unmapped segments.
>
> I think some MIPS III CPUs were restricted to just 4MB max. page size.
> NEC VR4xxx I think.  Still a pair would map 8MB which on the affected
> small memory systems should suffice.  16MB, 64MB are more typical sizes.
>
> R3000 is a different kettle.  To 4k or not to 4k is not a question ;-)
>
> Now mapping the kernel alone wouldn't solve the security issue mentioned
> by David.  The image would still lie around in KSEG0 / XKPHYS for whatever
> wants to run over so that should ideally also be a flexible address.
>
> Otoh the mapped kernel certainly would have the lowest size overhead.
> I have faint memories of restrictions for TLB instructions or was it
> TLB exception handlers into mapped space, would have to do some rtfming
> on that topic.
>
> Years ago I did test the impact of one less available TLB entry with
> lmbench; the loss was around 2%.  That was on a CPU with 64 entries.
>

We have a private patch that does exactly this, the main motivation was 
to place the kernel in the same virtual address 256MB region as the 
modules, so that a direct calling sequence can be used in modules.

The resulting module code is much faster, so depending on the work load 
it may be a performance win.  We see things like IPv6 forwarding 
improving something like 6% when IPv6 is built as a module.

Also we have many more TLB entries (128, or 256) so losing one is not a 
big deal.

David Daney
