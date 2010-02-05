Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2010 21:29:22 +0100 (CET)
Received: from mail-fx0-f216.google.com ([209.85.220.216]:52801 "EHLO
        mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492866Ab0BEU3T convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Feb 2010 21:29:19 +0100
Received: by fxm8 with SMTP id 8so2843462fxm.26
        for <linux-mips@linux-mips.org>; Fri, 05 Feb 2010 12:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zsV8Tb54eX4Oee3bTSEu13hF27faAt0sYklbXbiZDTo=;
        b=hRKiTLSIEDdl8IcfbKuqDNheZjcWFC+9jIOiugNNdXe2Z5mJFBuQm0xBn5RReTlMR6
         izE+QAncEcKEcPohY7E2LFUr9unFD1eW3aDZPh2ebvbol3RK4DVXizrPdWpfXJ6j6WJZ
         L+k4+/eFlVnmNROwjL5SlFSSnw18i/C1kKi0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dH3qQOO3PvTplJVi7oHQ8OCwMzaiXMdanRPeJjaeKwTN1GP/q1jJrl4cdH1MDVJKAe
         VWxe6tW+V2N0OMaar77RK5Ukp2KbjwMxN5oyti/rieGz/rTdRLZQqWp28SjlvxANytoQ
         Au2J2L13rGq9J/uGGPC/YRK81wu65/HsT5J7M=
MIME-Version: 1.0
Received: by 10.223.143.23 with SMTP id s23mr827970fau.50.1265401752997; Fri, 
        05 Feb 2010 12:29:12 -0800 (PST)
In-Reply-To: <4B6C5714.3080603@caviumnetworks.com>
References: <4101f55c1002050005t1d7e1b09qe988e39932dfc411@mail.gmail.com>
         <4B6C5714.3080603@caviumnetworks.com>
Date:   Fri, 5 Feb 2010 20:29:12 +0000
Message-ID: <4101f55c1002051229x73ddcb83ofd5d7acd44100737@mail.gmail.com>
Subject: Re: Switch FPU emulator trap to BREAK instruction
From:   Muthu Kumaran <muthukumaranbe@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <muthukumaranbe@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muthukumaranbe@gmail.com
Precedence: bulk
X-list: linux-mips

On 5 February 2010 17:36, David Daney <ddaney@caviumnetworks.com> wrote:
> Muthu Kumaran wrote:
>>
>> I am using 2.6.18 linux version on MIPS32 core. One of the application
>> is using intensive floating point operations. This hardware doesn't
>> have FPU and also the application is not compiled for software
>> floating point support.
>> Hence, it is using the floating point emulation.
>>
>> While running that application, On a timer interrupt there is a normal
>> integer div instruction which gives wrong result in the HI register.
>>
>> However, when I applied the following patch, this problem disappeared.
>>
>> http://kerneltrap.org/mailarchive/git-commits-head/2008/10/30/3873324
>>
>> When I looked into the patch, handling of invalid instruction
>> exception is moved from trap to break.
>
> Incorrect analysis.  It was changed from an Adress Error (ADE) exception to
> a BREAK.
>
I am sorry, I interpreted from the heading.  The following being
inserted to emulate the delay slot.
#define AdELOAD 0x8c000001	/* lw $0,1($0) */

>
>> There is no other behavioural change in this patch. I really don't
>> understand the need for this patch, May I ask someone to explain the
>> background information behind this patch? Is this for any known issue?
>>
>
> The change log states the reason.  FPU emulator delay slot emulation was
> failing on some systems.
>
Thanks.
In the morning, Ralf had pointed me "This is required only for the
Cavium cnMIPS core; for all other cores
this is just a more elegant implementation."

I think, I put the question in wrong sentence. I intended to ask
whether this fix impact MIPS32 core.
Ralf also pointed me that this fix has nothing to do with the div
error that I am seeing. If I dont have this patch, when I run
intensive floating point operating, I am getting wrong result in HI
register for a div operation.
