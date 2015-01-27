Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2015 20:57:17 +0100 (CET)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:65388 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011533AbbA0T5PvpuTW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2015 20:57:15 +0100
Received: by mail-ig0-f169.google.com with SMTP id hl2so3692299igb.0;
        Tue, 27 Jan 2015 11:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+ximEDb+veNyoS9hwfcZyf5Sby6QJA0mAm4qbgC6qls=;
        b=sFJlXvpYNOuJArwK07E+1znt1HqUNwGHEB1FtEoRpEWejIi4Y2PZNlIyuvkQ8CZrYh
         FaVkFcfqfEMUvCL0ASWeoUuonlQNjOXrgsgsnlxrLe1e+gEAp1ODb0F1613590zR0Du1
         H/Dh9ruLzO4Bf625XXQkv8xeC1RzfgT/NTYqlsGe5CyFFl1hB/7oHJmZva+OHPwNa2Sj
         P/yFNqDmVJJigF8V+aqx+C9SJEL0PxMg7aNi6ZwyhnXiPHUkF/QKgxT5nWA2aFnbusli
         +satCWPQ7G4YThClB4RaNVtSBwGiuKZlv+BXT9F9mGksgjAFAH5Vj9I1VWQwJL9dRelO
         SICA==
X-Received: by 10.42.4.201 with SMTP id 9mr4237506ict.23.1422388629811;
        Tue, 27 Jan 2015 11:57:09 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id f103sm1254696ioj.9.2015.01.27.11.57.08
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 Jan 2015 11:57:09 -0800 (PST)
Message-ID: <54C7ED94.6070507@gmail.com>
Date:   Tue, 27 Jan 2015 11:57:08 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org> <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org> <20150126131621.GB31322@linux-mips.org> <alpine.LFD.2.11.1501261358540.28301@eddie.linux-mips.org> <54C68429.4030701@gmail.com> <alpine.LFD.2.11.1501261904310.28301@eddie.linux-mips.org> <54C69FCE.80002@gmail.com> <alpine.LFD.2.11.1501262345320.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501262345320.28301@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45491
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

On 01/27/2015 08:15 AM, Maciej W. Rozycki wrote:
> On Mon, 26 Jan 2015, David Daney wrote:
>
>>>    Well, read(2), write(2) and similar calls operate on byte streams, these
>>> are endianness agnostic (like the text of this e-mail for example is --
>>> it's stored in memory of a byte-addressed computer the same way regardless
>>> of its processor's endianness).
>>
>> This is precisely the point I was attempting to make.  What you say here is
>> *not* correct with respect to MIPS as specified in the architecture reference
>> mentioned above.  The byte streams are scrambled up when viewed from contexts
>> of opposite endianness.
>>
>> Byte streams are *not* endian agnostic, but aligned 64-bit loads and stores
>> are.
>>
>> It is bizarre, and perhaps almost mind bending, but that seems to be how it is
>> specified.  Certainly the OCTEON implementation works this way.
>
>   Well, I think this observation:
>
> "2.2.2.2 Memory Operation Functions
>
> "Regardless of byte ordering (big- or little-endian), the address of a
> halfword, word, or doubleword is the smallest byte address of the bytes
> that form the object.  For big-endian ordering this is the
> most-significant byte; for a little-endian ordering this is the
> least-significant byte."
>
> contradicts your claim [...]

One can argue about the meaning of the text in the reference manual. 
But in the end, the behavior of real processors is what we are forced to 
deal with.

In the case of all existing OCTEON processors, there is no Status[RE] 
bit, but you can switch the endianess of the entire CPU under software 
control.  I am really making statements based on how they actually work, 
not assertions about the meaning of the specification.  However, I do 
believe that this is what is specified.

If you have access to processors with a working Status[RE] bit, you 
could empirically determine how they work.

David Daney
