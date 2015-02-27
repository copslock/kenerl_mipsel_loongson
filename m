Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 18:52:25 +0100 (CET)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34685 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007605AbbB0RwXOY5WX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 18:52:23 +0100
Received: by igal13 with SMTP id l13so2102661iga.1;
        Fri, 27 Feb 2015 09:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VHJieTBiqid3q1uixypeKNZMwKhWWSh3CKbLIe9TBWM=;
        b=AtgmMlklyRSt2m5E4DpqreRhyMvf2Mm39Ya8gWYnJcBKlbInk7DODTE7vJBce3v/Rt
         lYb9u5GI3FeajfmlVwC13lTj2RkHHi0f7q0WDFDMdPRtYNS1ZTucPteKkZYk4hq2jqzS
         ZN0Pf6ozPQY1RkcRXBHndxXFFWbMq/jg0GLuIYJI1XZ3Z+7r7ujs65FqD+nFS0zNX+Sb
         qRmfgQqjmWEoTIYlRfW8ADPI6baelXUF+UwOc3/ertdJICH51ZN/5/k47sZwFbgoI/U9
         RpWEzQsQerjV86U/WababCLSZq8Hsd9DfncRQUGTbhWA/aa8cQaTqQfTfy80Y+q1lsFU
         VOFQ==
X-Received: by 10.43.10.138 with SMTP id pa10mr13683044icb.94.1425059537743;
        Fri, 27 Feb 2015 09:52:17 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id d6sm2635875ioe.44.2015.02.27.09.52.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 27 Feb 2015 09:52:17 -0800 (PST)
Message-ID: <54F0AECF.5070501@gmail.com>
Date:   Fri, 27 Feb 2015 09:52:15 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH V7 1/3] MIPS: Rearrange PTE bits into fixed positions.
References: <1424996199-21366-1-git-send-email-Steven.Hill@imgtec.com> <1424996199-21366-2-git-send-email-Steven.Hill@imgtec.com> <54EFBF9D.4020004@gmail.com> <54EFE6B9.1050109@imgtec.com>
In-Reply-To: <54EFE6B9.1050109@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46049
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

On 02/26/2015 07:38 PM, Steven J. Hill wrote:
> On 02/26/2015 06:51 PM, David Daney wrote:
>>
>> That's not really what I meant in my previous response on the subject.
>> When I said:
>>
>>      Why not just use RI for everything, instead of taking up two bits
>>      to represent a single binary concept?
>>
>>      For the case where there is no RI hardware active, it is a purely
>>      software bit and you can easily invert the meaning and just have a
>>      _PAGE_NO_READ bit.
>>
>> I envisioned something like:
>>
>>      64-bit, all revisions:    CCC D V G RI XI [S H] M A W P
>>      32-bit, all revisions:    CCC D V G RI XI M A W P
>>
> Which is what I implemented.

I think there is still misunderstanding.

Your patches leave us with definitions for *both* _PAGE_READ *and* 
_PAGE_NO_READ defined in the source code.  My suggestion was to 
eliminate all vestiges of _PAGE_READ and _PAGE_READ_SHIFT, and unify all 
variants to use _PAGE_NO_READ

> I now only use one bit that functions
> either as _PAGE_READ or _PAGE_READ_ONLY depending on the RI/XI
> functionality present. Did you bother to read the code and understand
> it, or just look at the commit message?

I did read it, see above.
