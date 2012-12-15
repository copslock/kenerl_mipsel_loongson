Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Dec 2012 06:16:32 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:54456 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816206Ab2LOFQPtpCFI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Dec 2012 06:16:15 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id qBF5G9N8006772;
        Fri, 14 Dec 2012 21:16:09 -0800
X-WSS-ID: 0MF23YR-01-2RR-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.67])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 220D736465A;
        Fri, 14 Dec 2012 21:16:02 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([fe80::2897:a30d:a923:303%16]) with mapi id
 14.01.0270.001; Fri, 14 Dec 2012 21:15:58 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Kevin D. Kissell" <kevink@paralogos.com>
Subject: RE: [PATCH v99,01/13] MIPS: microMIPS: Add support for microMIPS
 instructions.
Thread-Topic: [PATCH v99,01/13] MIPS: microMIPS: Add support for microMIPS
 instructions.
Thread-Index: AQHN1DiHCvL61O110EKCn4uZDGaFTZgNfKEAgAB++gCAC2ENog==
Date:   Sat, 15 Dec 2012 05:15:56 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146AB43B@exchdb03.mips.com>
References: <1354856737-28678-1-git-send-email-sjhill@mips.com>
 <1354856737-28678-2-git-send-email-sjhill@mips.com>
 <CAJiQ=7BKXMbRZqwxPnFqFS3nUuGr819zQbuhbAspOZvpCYpnFw@mail.gmail.com>,<20121207152438.GC25923@linux-mips.org>
In-Reply-To: <20121207152438.GC25923@linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: 7o0zcoJgP0DjKlARO/J+Jg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

>> The microMIPS patch nearly quadruples the number of instruction
>> formats in the mips_instruction union, so it might be worth
>> considering questions like:
>>
>> 1) Is this the optimal way to represent this information, or have we
>> reached a point where it is worth adding more complex "infrastructure"
>> that would support a more compact instruction definition format?
>>
>> 2) Is there a better way to handle the LE/BE bitfield problem, than to
>> duplicate each of the 28+ structs?
>
> Something based on #defines, for example.  Back in the dark ages I
> figured bitfields would be nicer way to represent instruction formats.
> Against the warning words of I think Kevin Kissel I went for the bitfields
> and this would be a good opportunity to change direction.
>
Oh sure, why not. I mean I've only rewritten this patch at least 10 times. What's one more time? :) If one or all of you would expound on what your design ideas are, that would be great. Again, not to sound like a scratched CD, but I am still shooting for this code to get into 3.9, so please reply soon. Thanks.

-Steve
