Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 09:06:34 +0200 (CEST)
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:51243 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007004AbbFBHGcFztf4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 09:06:32 +0200
Received: from resomta-ch2-12v.sys.comcast.net ([69.252.207.108])
        by resqmta-ch2-10v.sys.comcast.net with comcast
        id bHX61q0022LrikM01HX6ma; Tue, 02 Jun 2015 05:31:06 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-12v.sys.comcast.net with comcast
        id bHX51q00C42s2jH01HX57U; Tue, 02 Jun 2015 05:31:06 +0000
Message-ID: <556D3F96.1070607@gentoo.org>
Date:   Tue, 02 Jun 2015 01:31:02 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP, Almost there?
References: <55597B21.4010704@gentoo.org> <556142C5.7090206@gentoo.org> <20150601193208.GA29986@linux-mips.org>
In-Reply-To: <20150601193208.GA29986@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433223066;
        bh=yPPcLuY27cp7CzkJYnOMjHByJSKXtWVtFgh4X2rYKyk=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=JJl5rDv/AQbHMuKnwJg6EnhCpyKL19o4x6ANOVSosepxZM8sWlKDbrCFHW8aG0ubc
         9DSKZHNcXX88MYX5ggERe0JK/16mwoiOZOyviJik8yjFDHUA8xQ6ljKPNfyNx8ZZCI
         wCisM3JJAZcCbV++Y3C9BjuLrJS4orFQKOdZfoZ2sKNogG54uV2XZ93g8zWvGmVFeo
         +k4wNHnSxhDSINIGWWttyBIUExOVXj9TZpapDp/TdjG4OzRuH18ZoOqAKYC8MALyp+
         rkmYhflp8Q1gdarIEnWb2DKUwuJ3L7+osGxtSjkUy5c+jaX3cz91lDGfSJBF03pk6l
         KK+7lP/2nRuqA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 06/01/2015 15:32, Ralf Baechle wrote:
> On Sat, May 23, 2015 at 11:17:25PM -0400, Joshua Kinard wrote:
> 
>> I even got the IRQs to be fanned out across both CPUs.  Well, primarily the
>> qla1280 drivers.  They randomly hop between both CPUs, but no ill effects so far.
>>
>> But if I boot that *same* working kernel on an R14000 dual module, I get handed
>> an IBE as soon as the userland mounts.  The only documented differences that I
>> can find on the R14000 is that it supports DDR memory, being able to do memory
>> operations on the rising edge and falling edge of each clock.  Not sure if that
>> matters to the kernel at all, but I know of nothing else that describes the
>> R14K's internals, such as if there's some new bit in CP0 config,
>> branch-diagnostic, status, etc, that might explain why these IBE's are happening.
>>
>> Guess I need to hunt down my old dual R10K module next and verify that works
>> fine...
>>
>> Also, is there a way to hardcode the cca=5 setting for IP30?  Maybe it needs to
>> be a hidden Kconfig item?.  I tried setting cpu->writecombine in cpu-probe.c,
>> but no dice there.  If I boot an SMP kernel on dual R12K's w/o cca=5, I'll get
>> one or two pretty-specific oopses.  The one I did grab complains about bad
>> spinlock magic in the core tty driver somewhere.  I can transcribe that oops
>> later on if interested.
> 
> Can you insert something like:
> 
>   printk("c0_config: %08x\n", read_c0_config());
> 
> into a kernel and boot it without cca=5?  I'm really curious what the
> startup CCA is.
> 
>   Ralf

It's cca=3 as the default.  Wasn't there a patch long ago that made that the
default?

                       D
              I   D    S     S   S  B S S  E   P  P C D   K
              C   C  0 D 0   C   S  E K B  C   M  E T N   0
             -----------------------------------------------
             xxx xxx x x xx xxx xxx x x x xxxx xx x x xx xxx
0x6c1ab3a3   011 011 0 0 00 011 010 1 0 1 1001 11 0 1 00 011    no cca
0x6c1ab3a5   011 011 0 0 00 011 010 1 0 1 1001 11 0 1 00 101    cca=5


I think cca=4 also works okay, but I have to test it a bit more.  Which is the
better one to stick with?

--J
