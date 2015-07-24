Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jul 2015 17:46:57 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:50171 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010479AbbGXPqy6Wsvx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jul 2015 17:46:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=G8h0IJvUJ5PpgYObn01To/5kjX5o5MWGUIUraLwVNyw=;
        b=pNgDvCLLcpVkBdoDTPjTj5lcO9ExTNiOoiLLJh7btILk6Qhd3n4xXov3aG4jipTyA2t0C2WPHrPtHfAMHuf38jQxZuCf4km6et5YaCC2GSST/TqLWzIRXvgue97R2FJfKlnhNH2lgRM+qHAJgYFQOnn7KXidgPUXYwXTufrtBVk=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:37044 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1ZIfBK-003HmO-Ob; Fri, 24 Jul 2015 15:46:43 +0000
Message-ID: <55B25DDE.8090107@roeck-us.net>
Date:   Fri, 24 Jul 2015 08:46:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Eric B Munson <emunson@akamai.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-am33-list@redhat.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
        linux-parisc@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 2/6] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
References: <1437508781-28655-1-git-send-email-emunson@akamai.com> <1437508781-28655-3-git-send-email-emunson@akamai.com> <20150721134441.d69e4e1099bd43e56835b3c5@linux-foundation.org> <1437528316.16792.7.camel@ellerman.id.au> <20150722141501.GA3203@akamai.com> <20150723065830.GA5919@linux-mips.org> <20150724143936.GE9203@akamai.com>
In-Reply-To: <20150724143936.GE9203@akamai.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=0.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 07/24/2015 07:39 AM, Eric B Munson wrote:
> On Thu, 23 Jul 2015, Ralf Baechle wrote:
>
>> On Wed, Jul 22, 2015 at 10:15:01AM -0400, Eric B Munson wrote:
>>
>>>>
>>>> You haven't wired it up properly on powerpc, but I haven't mentioned it because
>>>> I'd rather we did it.
>>>>
>>>> cheers
>>>
>>> It looks like I will be spinning a V5, so I will drop all but the x86
>>> system calls additions in that version.
>>
>> The MIPS bits are looking good however, so
>>
>> Acked-by: Ralf Baechle <ralf@linux-mips.org>
>>
>> With my ack, will you keep them or maybe carry them as a separate patch?
>
> I will keep the MIPS additions as a separate patch in the series, though
> I have dropped two of the new syscalls after some discussion.  So I will
> not include your ack on the new patch.
>
> Eric
>

Hi Eric,

next-20150724 still has some failures due to this patch set. Are those
being looked at (I know parisc builds fail, but there may be others) ?

Thanks,
Guenter
