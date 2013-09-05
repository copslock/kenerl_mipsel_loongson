Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2013 20:31:21 +0200 (CEST)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:47821 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822664Ab3IESbTiSVAw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Sep 2013 20:31:19 +0200
Received: by mail-ob0-f178.google.com with SMTP id ef5so2392854obb.23
        for <multiple recipients>; Thu, 05 Sep 2013 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+jETaPyGYJB8kYZOPiBPhCdzmg6xrskZJ/Te40pZ7zY=;
        b=RKYskwa9xNTsZVqpk50dBK/9daf45RtDsRlOsOOFORrG+mvLIbIV+YcF3vsIYtFxKq
         Hk8hCghbg5sbx/qm1H87EMJ0t2yVAIKvr42PgiwBkLdWfYz3npn2B0Pr5GjrR6iH8vxw
         6WCT5z/y1vHuiHtWJgvDkqokipIJ5qINkCz139Vk5pbbVslV4bkaJPxJ4oGs7Jie8UxH
         0njUAbUrSx7VeQ44MGgoxH0Vj8JPvCw58FlecNcbjuDdYK2fkCCTvaFS/bpgMiBHBOc8
         ESoN2Mcg5bBn1u7tQgQ+WFVUpDJ/9I+YBOwAImRCwzXTnO5rKFcRC0nsIrWPni/NKD16
         K5Zw==
X-Received: by 10.60.42.3 with SMTP id j3mr1711790oel.70.1378405873413;
        Thu, 05 Sep 2013 11:31:13 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id d8sm32234404oeu.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Sep 2013 11:31:12 -0700 (PDT)
Message-ID: <5228CDEF.4010609@gmail.com>
Date:   Thu, 05 Sep 2013 11:31:11 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Prem Mallappa <prem.mallappa@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Prem Mallappa <pmallappa@caviumnetworks.com>
Subject: Re: [PATCH v2 2/2] MIPS: KEXEC: Fixes Random crashes while loading
 crashkernel
References: <1378317384-9923-1-git-send-email-pmallappa@caviumnetworks.com> <20130905181222.GC11592@linux-mips.org>
In-Reply-To: <20130905181222.GC11592@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37764
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

On 09/05/2013 11:12 AM, Ralf Baechle wrote:
> On Wed, Sep 04, 2013 at 11:26:24PM +0530, Prem Mallappa wrote:
>> Date:   Wed,  4 Sep 2013 23:26:24 +0530
>> From: Prem Mallappa <prem.mallappa@gmail.com>
>> To: linux-mips <linux-mips@linux-mips.org>
>> Cc: Prem Mallappa <pmallappa@caviumnetworks.com>
>> Subject: [PATCH v2 2/2] MIPS: KEXEC: Fixes Random crashes while loading
>
> Prem,
>
> I only see patch 2/2.  I wonder, has 1/2 been lost in transit or is there
> only the 2/2 patch?
>

V1 of 1/2 didn't need revision, so it can be applied as is:

http://patchwork.linux-mips.org/patch/5786/

David.

> Thanks,
>
>    Ralf
>
>
>
