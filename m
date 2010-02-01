Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 11:08:43 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:56645 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492016Ab0BAKIh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Feb 2010 11:08:37 +0100
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1NbtCr-0007lS-8i
        for linux-mips@linux-mips.org; Mon, 01 Feb 2010 11:08:33 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Mon, 01 Feb 2010 11:08:33 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Mon, 01 Feb 2010 11:08:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH 1/3] MIPS: AR7 whitespace hacking
Date:   Mon, 1 Feb 2010 10:03:45 +0000
Message-ID: <1hli37-4t9.ln1@chipmunk.wormnet.eu>
References: <bq2h37-ch6.ln1@chipmunk.wormnet.eu> <1265005758.31984.8.camel@falcon>
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Wu Zhangjin <wuzhangjin@gmail.com> wrote:
>
>> +/*****************************************************************************
>> + * VLYNQ Bus
>> + ****************************************************************************/
> 
> Why not simply use:
> 
> /* VLYNQ Bus */
> 
> You have deleted lots of whitespaces, but added more *.
>
"good enough for ARM[1]" :)

Compromise on this instead?
----
/*
 * VLYNQ Bus
 */
---- 

>> @@ -70,7 +71,6 @@ console_initcall(ar7_init_console);
>>   * Initializes basic routines and structures pointers, memory size (as
>>   * given by the bios and saves the command line.
>>   */
>> -
>>  void __init plat_mem_setup(void)
>>  {
>>       unsigned long io_base;
>> @@ -88,6 +88,5 @@ void __init plat_mem_setup(void)
>>       prom_meminit();
>>  
>>       printk(KERN_INFO "%s, ID: 0x%04x, Revision: 0x%02x\n",
>> -                                     get_system_type(),
>> -             ar7_chip_id(), ar7_chip_rev());
>> +                     get_system_type(), ar7_chip_id(), ar7_chip_rev());
>>  }
> 
> Perhaps you can use pr_info() instead of printk(KERN_INFO) too, of
> course, if there are more printk(KERN_...), you can replace them by
> pr_xxx defined in include/linux/kernel.h
> 
I'm not responsible for that printk()...although the others I will admit 
to :)

I'll roll out a replacement later today hopefully.

Cheers

-- 
Alexander Clouter
.sigmonster says: Vini, vidi, Linux!
                  		-- Unknown source
