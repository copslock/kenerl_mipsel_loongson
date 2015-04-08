Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2015 19:56:41 +0200 (CEST)
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36417 "EHLO
        mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024669AbbDHR4kDkckK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Apr 2015 19:56:40 +0200
Received: by qgeb100 with SMTP id b100so32304152qge.3
        for <linux-mips@linux-mips.org>; Wed, 08 Apr 2015 10:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=hUZBx1ziKbQqSB2BSt8xg5/F4meqx6FPzbQyfG4zKU4=;
        b=kK7bTUBJIXq/nMYwYPm4wqfKDOANqRIqOIG3CFbe0C2WFBz75W7gOF3sWafH8hzI3s
         zt9ZgYmkGY+wNo1wLQIyNBIPmNW6pe86XVDE2cLRbItnpi+ZgNU/ZQizu0BpmRXtycyN
         eC1pNiy+curVGGLV+oDOS00SvPeY/I1xddPodlx36krJBxZWiWlwVFKNfcz+5JH22MMd
         hmvNaF/5kXAsPljgCrpMMu5UXuvvJYxwgdDhunk99oWrc3JVwOVK0byVikBiVgAFWa2K
         HSKlnCPEx8PbgaOEZAuYG2DiU2xx1cZdCX77C0GRSr9jKs/geuiatgnKG4cJ6ZbEOMxM
         5e0g==
X-Gm-Message-State: ALoCoQl4omsFweEkH6MjzLNHeLGYbnehdIA++3jh/SvWV1kfcaa7oyMINjIC4kzXV2xVvH7MC4gh
X-Received: by 10.140.146.201 with SMTP id 192mr32882502qhs.77.1428515795439;
        Wed, 08 Apr 2015 10:56:35 -0700 (PDT)
Received: from [192.168.1.139] (h96-61-87-245.cntcnh.dsl.dynamic.tds.net. [96.61.87.245])
        by mx.google.com with ESMTPSA id h65sm296120qge.38.2015.04.08.10.56.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2015 10:56:35 -0700 (PDT)
Message-ID: <55256BD1.4040604@hurleysoftware.com>
Date:   Wed, 08 Apr 2015 13:56:33 -0400
From:   Peter Hurley <peter@hurleysoftware.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Grant Likely <grant.likely@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT
 properties
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-6-git-send-email-cernekee@gmail.com> <54F3914F.3080905@hurleysoftware.com> <20150328013604.488A0C4091F@trevor.secretlab.ca> <5516DE64.6000104@hurleysoftware.com> <CAJiQ=7AS5+HkHcjRsYKi-EHVc3F1fg3Zp=1fCor1HrKeSWU72Q@mail.gmail.com> <551D6208.2060009@hurleysoftware.com>
In-Reply-To: <551D6208.2060009@hurleysoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@hurleysoftware.com
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

Hi Kevin,

On 04/02/2015 11:36 AM, Peter Hurley wrote:
> On 03/28/2015 03:28 PM, Kevin Cernekee wrote:
>> Hi Peter,
>>
>> This is my latest work-in-progress, incorporating the feedback from
>> you and Grant:
>>
>> https://github.com/cernekee/linux/commits/endian
>>
>> Not sure if this code plays nice with your recent cleanups?  If we're
>> touching the same files/functions we should probably coordinate.
> 
> Ok, I'll look over your git tree and add whatever's required to
> earlycon.

Could you submit the first 5 patches from your 'endian' branch, so
that big-endian support can be added to earlycon?

Regards,
Peter Hurley
