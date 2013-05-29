Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 May 2013 03:30:37 +0200 (CEST)
Received: from intranet.asianux.com ([58.214.24.6]:26809 "EHLO
        intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834882Ab3E2BafLgB8M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 May 2013 03:30:35 +0200
Received: by intranet.asianux.com (Postfix, from userid 103)
        id D58E31840335; Wed, 29 May 2013 09:30:27 +0800 (CST)
Received: from [10.1.0.143] (unknown [219.143.36.82])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by intranet.asianux.com (Postfix) with ESMTP id A0B961840270;
        Wed, 29 May 2013 09:30:27 +0800 (CST)
Message-ID: <51A55A01.4070306@asianux.com>
Date:   Wed, 29 May 2013 09:29:37 +0800
From:   Chen Gang <gang.chen@asianux.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] arch: mips: lantiq: using strlcpy() instead of strncpy()
References: <51A1BF15.7070905@asianux.com> <51A4A33E.3000605@openwrt.org>
In-Reply-To: <51A4A33E.3000605@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <gang.chen@asianux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gang.chen@asianux.com
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

On 05/28/2013 08:29 PM, John Crispin wrote:
> On 26/05/13 09:51, Chen Gang wrote:
>> 'compatible' is used by strlen() in __of_device_is_compatible().
>>
>> So for NUL terminated string, need always be sure of ended by zero.
>>
>> 'of_ids' is not a structure in "include/uapi/*", so not need initialize
>> all bytes, just use strlcpy() instead of strncpy().
>>
>>
>> Signed-off-by: Chen Gang<gang.chen@asianux.com>
> 
> Acked-by: John Crispin <blogic@openwrt.org>


Thanks.

-- 
Chen Gang

Asianux Corporation
