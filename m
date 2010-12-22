Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2010 14:03:16 +0100 (CET)
Received: from gateway11.websitewelcome.com ([69.41.245.3]:41025 "HELO
        gateway11.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491018Ab0LVNDN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Dec 2010 14:03:13 +0100
Received: (qmail 21349 invoked from network); 22 Dec 2010 13:11:52 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway11.websitewelcome.com with SMTP; 22 Dec 2010 13:11:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=JSGqu+v3HoFFzOnFa3Xs3F6Wv/9BVyVmBjAZ86ChBGSFtOru84MBWj4oV/vSwlKRhQONYtknFAtzCX5uJcs8HAv6yN0Z651yLUCL6qnBKKmMCymYkB8iOkoNkjjpSICT;
Received: from [88.123.214.42] (port=49250 helo=kkissell-macbookpro.local)
        by gator750.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PVOLQ-0008Av-EY; Wed, 22 Dec 2010 07:03:06 -0600
Message-ID: <4D11F707.8040205@paralogos.com>
Date:   Wed, 22 Dec 2010 05:03:03 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>,
        STUART VENTERS <stuart.venters@adtran.com>,
        linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB880@EXV1.corp.adtran.com>      <4D0A677C.6040104@paralogos.com> <4D0A6F63.8080206@paralogos.com>       <4D0BD7A0.1030504@paralogos.com>        <AANLkTikTn_Lw=vqtfUyDW7GXxq75ZYLGi8_MyVVyPkKt@mail.gmail.com>  <4D10F7A9.1020306@paralogos.com>        <A7DEA48C84FD0B48AAAE33F328C020140595D731@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>         <A7DEA48C84FD0B48AAAE33F328C020140595D732@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>         <4D11D28D.80501@paralogos.com> <1293017702.27661.36.camel@paanoop1-desktop>     <4D11E2E2.80809@paralogos.com> <1293018675.27661.40.camel@paanoop1-desktop>
In-Reply-To: <1293018675.27661.40.camel@paanoop1-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 12/22/10 3:51 AM, Anoop P A wrote:
> On Wed, 2010-12-22 at 03:37 -0800, Kevin D. Kissell wrote:
>> Thanks.  This is indeed strange.  The VPE0 Status and TC0 TCStatus/Cause
>> all indicate that interrupts are enabled and not inhibited at the per-TC
>> level, and the presumed timer interrupt, in the 0x4000 bit, is present
>> and not masked-off.  Logically, the system must be entering (and
>> exiting) the interrupt handler, yet the timer calibration isn't
>> completing.  That leaves more complex possible explanations for failure,
>> most of which would fall into two categories:
>>
>> 1)  The platform interrupt handler is failing to decode the event
>> properly as a timer event.
>> 2)  Despite there being only one TC active, the calibration code is
>> waiting for some handshake from another "CPU"
>>
>> To test the first, you might consider adding a kprintf() to the case of
>> a "spurious" timer-like interrupt being detected and ignored...
> I have tried it . only one interrupt is coming and platform handler
> detect it as timer interrupt and acknowledges properly . you can see a
> time stamp change in the logs.
That's really strange.  And your timer interrupt is definitely on the 
interrupt that corresponds to the 0x4000 mask?

I may have written the MT spec and the original SMTC code, but I don't 
have a copy of the spec, and it's been a few years, and I can't 
interpret the MVP and VPE control/config values. But I just don't see 
how the processor could not be taking more interrupts.  Stuart did 
decode the global/VPE state enough to observe that global multithreaded 
execution wasn't enabled, which is indeed strange - it shouldn't matter 
for single-TC execution, but I don't recall there being any special-case 
in the SMTC initialization that bypassed that enable.  That makes me 
suspect that maybe someone changed the initialization sequence in a way 
that bypasses one of the canonical initialization steps in a way that 
would break SMTC, but I don't know why that would result in the 
interrupt behavior you observe.

It might be yet another blind alley, but could you add/arm diagnostic 
output for each of the initialization functions in smtc.c?

Ah, yes, and one other thing.  You should add a dump of ErrorEPC to the 
MT register dump.  I did it for myself once upon a time when I was 
confronted with a similar mystery, but never filed a patch.  If you're 
breaking in with NMI, that could help identify more precisely where it's 
locking up.

You really ought to try to borrow an EJTAG probe.  It would save us both 
a lot of time.  And my time to trouble-shoot this with you is limited.

             Regards,

             Kevin K.
