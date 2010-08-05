Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2010 04:00:25 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:63041 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493290Ab0HEB6P convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Aug 2010 03:58:15 +0200
Received: by ewy9 with SMTP id 9so2582285ewy.36
        for <linux-mips@linux-mips.org>; Wed, 04 Aug 2010 18:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ffF5+c6j4fmYeLHm26OLC/O3Bq0iJNEihdI25s0OI9A=;
        b=j5wc4n+RzKPw6q7S4vOLmlWmqnqA6hw6qFEIX9MJA1GnXyCkb1Eh1SHnQa9cok060K
         61vYL87o8dxrJipRujeYOvSUY+BI+ObHU/Rsn0rT+jimeGHfeU9hzSIF+e8+Faovh1AC
         tc9hUsy5dWXpnzaFQmvq73nql1cH3ic4iBGqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rMrdtocG8mkDBMsvXED4ah/KbdPLiuNEAOJoUFlN2mauS7eBHoVC8lCffRiNAgyYxH
         1cIhBe7NIctnpcTsH2MyXXZGbWNDHL7qguip9ynNj+q9BlRs7XAhLP+lM86Vx4MHm0sQ
         iBGuSl8BIjI9eFQ4zey6fKTyVZr7GduUL8y8w=
MIME-Version: 1.0
Received: by 10.14.48.71 with SMTP id u47mr1084654eeb.59.1280973495282; Wed, 
        04 Aug 2010 18:58:15 -0700 (PDT)
Received: by 10.14.127.13 with HTTP; Wed, 4 Aug 2010 18:58:15 -0700 (PDT)
In-Reply-To: <4C5986BC.9000307@paralogos.com>
References: <AANLkTinCjSTE7sYa7JdqwAEe-4nZJKAvVfg5q4YVVqC7@mail.gmail.com>
        <4C592027.8010902@paralogos.com>
        <AANLkTinVxFnNzQaHUCqxTQk708MEuUAiEuRGGPN8WcuS@mail.gmail.com>
        <4C5986BC.9000307@paralogos.com>
Date:   Thu, 5 Aug 2010 09:58:15 +0800
Message-ID: <AANLkTikchix6Zice7mPWCFtfMXpRe0PQVbykGtoPb2vD@mail.gmail.com>
Subject: Re: [Q] enabling FPU for vpe1
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27586
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

You are correct. I did miss something earlier. The NCP1 needs to be
set. Thanks, Kevin.


Deng-Cheng



2010/8/4 Kevin D. Kissell <kevink@paralogos.com>:
> You can only set the TC's CU bits if the VPE to which the TC is bound has
> access to the coprocessor.  See sections 8.2 andf 6.7 of the currently
> online spec, and read the MIPS MT Principles of Operation document, if you
> can find it.
>
> On 08/04/10 03:14, Deng-Cheng Zhu wrote:
>>
>> Thanks for looking into this.
>>
>> I did do that. But the CU1 bit of TC#1 (in VPE#1) can not be set by
>> TC#0 or itself. Looks like VPE#1 is not seeing the FPU at all...
>>
>>
>> Deng-Cheng
>>
>>
>> 2010/8/4 Kevin D. Kissell<kevink@paralogos.com>:
>>
>>>
>>> Check the MIPS MT spec.  If I recall correctly, it's possible to enable
>>> access to the FPU by either VPE by setting the right bits while the
>>> processor is in the MT configuration mode.
>>>
>>> Deng-Cheng Zhu wrote:
>>>
>>>>
>>>> Hi,
>>>>
>>>>
>>>> I'm working on a 34Kf CPU. I understand that only one TC can use the
>>>> FPU at any given time.
>>>>
>>>> My question is: If a TC is attached to the 2nd VPE (i.e. VPE1), can I
>>>> enable FPU for it?
>>>>
>>>> I experimented on this, but failed to do it. Am I missing something?
>>>>
>>>>
>>>> Thanks
>>>>
>>>> Deng-Cheng
>>>>
>>>>
>>>>
>>>
>>>
>
>
