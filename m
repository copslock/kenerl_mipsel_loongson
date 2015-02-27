Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 20:20:18 +0100 (CET)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:44508 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007622AbbB0TUQsvBVu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 20:20:16 +0100
Received: by iecar1 with SMTP id ar1so33417033iec.11
        for <linux-mips@linux-mips.org>; Fri, 27 Feb 2015 11:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gBVDLxPii85D7S6Zw0FnxUVEFPpJ2OSEPy4tduJQhIc=;
        b=fQAbhbejE65eg1fYZnfjqaF7+wMXRsY6116E2BbBobyDS4iJpWtdhffSBkkvzdKPL6
         6D+WTMLa/mUA+IP76PsMH72uwJv/LnM+tuda2wCVhGixiHiTk+x2mG8LXqU9uJLxz0/J
         vQyxtF0bJdMrOMxh54jKk7V24G2pVJYlBOpgt35p53kinn9bVLdXkBMFP/01AgtY9pRs
         meuJDYFmbtIEcUveYsKBMho/jQNSU9saH9XDGdMffMic45kyK34mG0GKw9QPYehBcOO0
         ++PUX7WQXmlMj1UI1J8lBfXCG2RDig685uUdDRSI8VmWCWENEmCdpCaUKXHOywIFUlWn
         aloA==
X-Received: by 10.42.138.199 with SMTP id d7mr17264043icu.3.1425064811336;
        Fri, 27 Feb 2015 11:20:11 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id o1sm1739052igv.18.2015.02.27.11.20.09
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 27 Feb 2015 11:20:09 -0800 (PST)
Message-ID: <54F0C368.1040409@gmail.com>
Date:   Fri, 27 Feb 2015 11:20:08 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH V7 1/3] MIPS: Rearrange PTE bits into fixed positions.
References: <1424996199-21366-1-git-send-email-Steven.Hill@imgtec.com> <1424996199-21366-2-git-send-email-Steven.Hill@imgtec.com> <54EFBF9D.4020004@gmail.com> <54EFE6B9.1050109@imgtec.com> <54F0AECF.5070501@gmail.com> <54F0BFD0.2050901@imgtec.com>
In-Reply-To: <54F0BFD0.2050901@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46051
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

On 02/27/2015 11:04 AM, Steven J. Hill wrote:
> On 02/27/2015 11:52 AM, David Daney wrote:
>>
>> I think there is still misunderstanding.
>>
>> Your patches leave us with definitions for *both* _PAGE_READ *and*
>> _PAGE_NO_READ defined in the source code.  My suggestion was to
>> eliminate all vestiges of _PAGE_READ and _PAGE_READ_SHIFT, and unify
>> all variants to use _PAGE_NO_READ
>>
> Okay, I see what you are after. I think it is worth doing, but I would
> really like to get XPA into 4.0 along with this patch as it is. I will

4.0 seems to be long gone with respect to adding new features, although 
Ralf would obviously make the final decision.
