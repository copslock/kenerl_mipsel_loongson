Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Oct 2014 04:09:36 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34999 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006940AbaJCCJeFV3i4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Oct 2014 04:09:34 +0200
Received: by mail-pa0-f52.google.com with SMTP id fb1so643956pad.39
        for <multiple recipients>; Thu, 02 Oct 2014 19:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Bux4qBShFIT8Cw3fIFMnDMUWildJNe7C6FPCyCG9HS0=;
        b=NWkgxwowI3dzLZMFpYkwxoD6TU/V7P6HTmnYduYOF7Xoax5erkBSXRzKkxVbQwi8Uz
         PiCQa4f6UiRQswWbdg1ZdEnsuD7jGKEido1cHd19YtnuYQSgwab7vWB64MYCNXE1J5OW
         iyY7Fz37qAL7fjBobB2mDFgvQoUKbumc27E6TLKNNPyvwDSgO9F0SZl1SdF4E1gbRVkc
         YI5DuuFjw+0iBWxx6+kz5OXPBSgnqqmuBzT/6Wd3/Iwio5/+lYLN25Yn5yr8qN/GAjL9
         GUHT/YZ3DDkp34MqWIMi1aza0XIod2N+9k3p523io2Md8UvGk3J+V3K9K/sSMqqO28xE
         jpgQ==
X-Received: by 10.66.97.41 with SMTP id dx9mr3697393pab.65.1412302167410;
        Thu, 02 Oct 2014 19:09:27 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id rb7sm5174013pbb.84.2014.10.02.19.09.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2014 19:09:26 -0700 (PDT)
Message-ID: <542E0554.5050508@gmail.com>
Date:   Thu, 02 Oct 2014 19:09:24 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org, blogic@openwrt.org
Subject: Re: [PATCH] MIPS: DTS: add a .gitignore file to ignore .dtb
References: <1412296187-2370-1-git-send-email-f.fainelli@gmail.com> <542DFB3E.30802@gmail.com>
In-Reply-To: <542DFB3E.30802@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 10/02/2014 06:26 PM, David Daney wrote:
> On 10/02/2014 05:29 PM, Florian Fainelli wrote:
>> Build for Broadcom XLP revealed that we are not ignoring DTB files and
>> that would clobber the git status output. Fix that by adding a
>> .gitignore file in arch/mips/boot/dts/.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   arch/mips/boot/dts/.gitignore | 1 +
>>   1 file changed, 1 insertion(+)
>>   create mode 100644 arch/mips/boot/dts/.gitignore
>>
>> diff --git a/arch/mips/boot/dts/.gitignore
>> b/arch/mips/boot/dts/.gitignore
>> new file mode 100644
>> index 000000000000..b60ed208c779
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/.gitignore
>> @@ -0,0 +1 @@
>> +*.dtb
> 
> Do we check in .dtb files anywhere in the kernel tree?

Every architecture supporting DT basically added its own .gitignore file
to all relevant directories, but I see no reason why this could not be
generalized.

> 
> If not, this could be moved to a higher level (perhaps top level)
> .gitignore

Good point, thanks!

> 
> David Daney
> 
> 
>>
> 
