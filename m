Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Sep 2010 05:57:12 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:34867 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490946Ab0IVD5J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Sep 2010 05:57:09 +0200
Received: by pvg12 with SMTP id 12so36280pvg.36
        for <multiple recipients>; Tue, 21 Sep 2010 20:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=DkFtJ5c7VTh35MXUu0BAePY+sOZReMzGm40rVe7kM7c=;
        b=gZvWGc0A96G9+FMsNNXjtuq4dliDwWKsoV5Gq5BvLRnq5xXHYv3rK+huUy6LN00033
         3OavRviVVnkIjMn7d193FfIQUeTR5+kHxoQmzFIbmVEqsGyXEOIa3AgLFiTQ9ao1MHPX
         g4QTmcDR9gL6H6a+HjFVEJneGLlyjgv2FLtdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=aq27OSPTaiKf7+LcsRVDpKsmDKj30BkAkoZx3cwUO9nwIkTKyuumcaVMTFBk67RcC3
         wbND0mcvN9rQbp6tYEgfxhIZ5luzwnjLvmXY2p4EvKoSyRUNRa7sRVPNVUr+zKG/uNt+
         vqQwN5JbzccevyrdSEITWgxwZ1RXyMJKo4mp8=
Received: by 10.114.60.3 with SMTP id i3mr13083487waa.88.1285127822374;
        Tue, 21 Sep 2010 20:57:02 -0700 (PDT)
Received: from [10.0.0.98] ([76.91.45.220])
        by mx.google.com with ESMTPS id d39sm16754924wam.16.2010.09.21.20.56.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 20:57:01 -0700 (PDT)
Message-ID: <4C997E94.8070407@gmail.com>
Date:   Tue, 21 Sep 2010 20:57:08 -0700
From:   "Justin P. Mattock" <justinmattock@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:2.0b5pre) Gecko/20100827 Thunderbird/3.2a1pre
MIME-Version: 1.0
To:     Finn Thain <fthain@telegraphics.com.au>
CC:     trivial@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-laptop@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 1/2 v3]Update broken web addresses.
References: <1285118957-24965-1-git-send-email-justinmattock@gmail.com> <alpine.LNX.2.00.1009221310500.4570@nippy.intranet>
In-Reply-To: <alpine.LNX.2.00.1009221310500.4570@nippy.intranet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 27783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinmattock@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16894

On 09/21/2010 08:25 PM, Finn Thain wrote:
>
> On Tue, 21 Sep 2010, Justin P. Mattock wrote:
>
>> Below is an update from the original, with changes to the broken web
>> addresses and removal of archive.org and moved to a seperate patch for
>> you guys to decide if you want to use this and/or just leave the old url
>> in and leave it at that..
>> Please dont apply this to anything just comments and fixes for now,
>
> You can use [RFC] in the Subject line instead of [PATCH] to indicate this.
>

alright..

>
>> diff --git a/arch/m68k/mac/macboing.c b/arch/m68k/mac/macboing.c
>> index 8f06408..234d9ee 100644
>> --- a/arch/m68k/mac/macboing.c
>> +++ b/arch/m68k/mac/macboing.c
>> @@ -114,7 +114,8 @@ static void mac_init_asc( void )
>>   			 *   16-bit I/O functionality.  The PowerBook 500 series computers
>>   			 *   support 16-bit stereo output, but only mono input."
>>   			 *
>> -			 *   http://til.info.apple.com/techinfo.nsf/artnum/n16405
>> +			 *   Article number 16405:
>> +			 *   http://support.apple.com/kb/TA32601
>>   			 *
>>   			 * --David Kilzer
>>   			 */
>
> "TIL article number 16405" would allow people to find the document by
> number...
>

so putting this "TIL article number 16405" is correct instead of Article 
number 16405:

>
>> diff --git a/arch/m68k/q40/README b/arch/m68k/q40/README
>> index 6bdbf48..92806c0 100644
>> --- a/arch/m68k/q40/README
>> +++ b/arch/m68k/q40/README
>> @@ -3,7 +3,7 @@ Linux for the Q40
>>
>>   You may try http://www.geocities.com/SiliconValley/Bay/2602/ for
>>   some up to date information. Booter and other tools will be also
>> -available from this place or ftp.uni-erlangen.de/linux/680x0/q40/
>> +available from this place or http://www.linux-m68k.org/mail.html
>>   and mirrors.
>>
>>   Hints to documentation usually refer to the linux source tree in
>
> No. We already discussed this change. Please refer back to my review of
> the first version of the patch. You got it right in the second version
> (that I also reviewed), but now you've gone back to the first version...
>
> Finn
>

pretty bad.. I don't know what happened there..


Justin P. Mattock
