Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2006 14:50:28 +0200 (CEST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:37764 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133555AbWFAMuS
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Jun 2006 14:50:18 +0200
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k51Co5hs013881;
	Thu, 1 Jun 2006 05:50:06 -0700 (PDT)
Received: from ukservices1.mips.com (ukservices1 [192.168.192.240])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id k51Co4P9014062;
	Thu, 1 Jun 2006 05:50:05 -0700 (PDT)
Received: from highbury.mips.com ([192.168.192.236])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Flmce-0006wN-00; Thu, 01 Jun 2006 13:49:56 +0100
Message-ID: <447EE274.7060207@mips.com>
Date:	Thu, 01 Jun 2006 13:49:56 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To:	zhuzhenhua <zzh.hust@gmail.com>
CC:	Thiemo Seufer <ths@networkno.de>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: BFD: Warning: Writing section `.text' to huge (ie negative) file
 offset 0xa1ffff10
References: <50c9a2250605312319v7480f2el36d9c0a052c85d5f@mail.gmail.com>	 <20060601092413.GL1717@networkno.de> <50c9a2250606010356s63f6d6e7j255c77660d6f472a@mail.gmail.com>
In-Reply-To: <50c9a2250606010356s63f6d6e7j255c77660d6f472a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



zhuzhenhua wrote:
> On 6/1/06, Thiemo Seufer <ths@networkno.de> wrote:
>> zhuzhenhua wrote:
>> > i have write a code to link at 0xa2000000(uncached address)
>> > but when link i get the error as
>> > "BFD: Warning: Writing section `.text' to huge (ie negative) file
>> > offset 0xa1ffff10.
>> > BFD: Warning: Writing section `.data' to huge (ie negative) file
>> > offset 0xa200b050.
>> > BFD: Warning: Writing section `.reginfo' to huge (ie negative) file
>> > offset 0xa200c980.
>> > mipsel-linux-objcopy: /root/project/brec_flash/release/brec_flash.bin:
>> > File truncated
>> > make: *** [brec_flash] Error 1"
>> >
>> > my link.xn as follow:
>> >
>> > OUTPUT_ARCH(mips)
>> > ENTRY(brec_flash_entry)
>> > SECTIONS
>> > {
>> > .text 0xa2000000 :
>>
>> Use
>>
>>  . = 0xa2000000;
>>  .text :
>>
>> instead. "info ld" explains the subtle difference.
>>
>>
>> Thiemo
>>
>
> do you mean use
> . = 0xa2000000;
> .text :
> to replace
> .text 0xa2000000 :
> ?
> i modify as that, and it still get the same message
>

I think the problem is not with the linker, but in your use of objcopy
to convert your ELF file to a raw binary file.

1) What arguments are you giving to mipsel-linux-objcopy?

2) What is the output from mipsel-linux-objdump -h run on your
intermediate ELF object file?


Nigel

-- 
Nigel Stephens            e. nigel@mips.com
MIPS Technologies         p. +44 1223 203110
Building 7200             f. +44 1223 203181
Cambridge Research Park   m. +44 7976 686470
Beach Road, Waterbeach    w. http://www.mips.com
Cambridge CB5 9TL, UK
