Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 03:56:06 +0100 (CET)
Received: from mail-ob0-f194.google.com ([209.85.214.194]:33278 "EHLO
        mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012402AbcBKC4ERJbOt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 03:56:04 +0100
Received: by mail-ob0-f194.google.com with SMTP id o4so4140679obb.0
        for <linux-mips@linux-mips.org>; Wed, 10 Feb 2016 18:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=hWv3B83y8Udey/AFVZRvkkFkFEXPi3+qJyjgdoD2N+4=;
        b=CHY85zscBlzj2RqNXrDns28+GN4Rb+Exuc6XpFk9IR6Zaw9ZxCaIujBi3Q7ZFpMwZC
         c+km2UTx819oSL9dy2TtXvcQjDcj5VzgYtZmiT7JqevDzF98eMfTMu2lN7jnavjYplZ2
         Yp/qEVw7cFGfejoMXUY2YRWC8jWofexs7cXlwO5sgBjnpVt+QkdfBUmrmMfkgYZqn4qA
         ltTqYHOjiJUGUI6oL2JjyjZXs+nrk9Gy90Qg9VMU7xFpoYW00oAaMrwPCdW9/lgnGUQ7
         Yj7Bi7J8qB6cue2uAmGSauKSH5AT37P3YfXfyOVlJLL1JmTluN3rz/F/Eli1y0h5rbdS
         dYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=hWv3B83y8Udey/AFVZRvkkFkFEXPi3+qJyjgdoD2N+4=;
        b=J8s8nS/CziLotGZ6WjyffWzhVAaxFV4WyIam+pRnsvss9jP4FB1iomw9ZinsaBo47L
         UNz3VDjNN5unAYaWmjoq61jV/npVUucCa/miYNFaPdsIEQFYjaYVcgXIAKhKovtFgMSO
         ekLhxDgVUqO3TGYDbEhJHD970etaTVJUPqam6phY60AOG8qhokPwVKyu4FAsZWy6/gs2
         G8wUukVxxVr/Odf15+PNFzMyrXF9nc5JDK4zcpg1rCBmMt81QXufUGVOPEIqcvWn6gC/
         rjUzyGpcmwI+TZ3D63RlM+bzl6Kvs0K7ir7rIwN/k22Vt/IT1PlN2okn0Wi88KNLTpRH
         ro1w==
X-Gm-Message-State: AG10YOT7wBDNkNbSlsprPB5pW0f/0fFw0iw0+HH9p+4nl1SMnaHlUwZkuwQiu/Zp0BGfDw==
X-Received: by 10.60.67.166 with SMTP id o6mr41679730oet.77.1455159358366;
        Wed, 10 Feb 2016 18:55:58 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:602a:b7e7:faa0:100? ([2001:470:d:73f:602a:b7e7:faa0:100])
        by smtp.googlemail.com with ESMTPSA id wt9sm3486585obb.18.2016.02.10.18.55.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Feb 2016 18:55:57 -0800 (PST)
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
To:     David Daney <ddaney@caviumnetworks.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com>
 <56BB7B2F.60307@caviumnetworks.com>
 <20160210234907.GC1640@darkstar.musicnaut.iki.fi>
 <56BBD6AD.2090902@caviumnetworks.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mmc@vger.kernel.org, david.daney@cavium.com,
        ulf.hansson@linaro.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Zubair.Kakakhel@imgtec.com,
        Aleksey Makarov <aleksey.makarov@caviumnetworks.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56BBF83B.8020908@gmail.com>
Date:   Wed, 10 Feb 2016 18:55:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <56BBD6AD.2090902@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51987
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

Le 10/02/2016 16:32, David Daney a écrit :
> On 02/10/2016 03:49 PM, Aaro Koskinen wrote:
>> Hi,
>>
>> On Wed, Feb 10, 2016 at 10:02:23AM -0800, David Daney wrote:
>>> On 02/10/2016 09:36 AM, Matt Redfearn wrote:
>>>> +        pr_warn(FW_WARN "%s: Legacy property '%s'. Please remove\n",
>>>> +            node->full_name, legacy_name);
>>>
>>> I don't like this warning message.
>>>
>>> The vast majority of people that see it will not be able to change their
>>> firmware.  So it will be forever cluttering up their boot logs.
>>
>> Until they switch to use APPENDED_DTB. :-)
>>
> 
> I am philosophically opposed to making the DTB an internal kernel
> implementation detail.
> 
> For OCTEON boards, it is an ABI between the boot firmware and the
> kernel, and is impractical to change.
> 
> One could argue that many years ago, when the decision was made (by me),
> that we should have opted to carry in the kernel source code tree the
> DTS files for all OCTEON boards ever made, but we did not do that.  Due
> to the non-reversibility of time, the decision is hard to reverse.
> 
> In the case of this MMC driver, the only real difference is that two
> properties have legacy names that later had differing "official" names.
>  The overhead of carrying the legacy bindings is very low.

Since there is an existing FDT patching infrastructure in
arch/mips/cavium-octeon/ would not that be a place where you could put
an adaptation layer between your legacy firmware properties and the
upstream binding?
-- 
Florian
