Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 04:33:47 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:60839 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27005162AbbBDDdp3YBne (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 04:33:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=aFlBWjcla1Qje7J+quqoMfzBFJg9uOsHMAQN33p1zX8=;
        b=gaS7Sf5XEUP9uvIegSFvuwnV2QAQORsPmLOPXvWwZXekn2gdZHA7P5yhZmCmamC9dOtKnubdrxVh3esfJh267ugcAgPYbjsfnjiVqtiE3cP2Rzx03cKFC58BNBktPgO11nPrYk0bZdWlJGQ56P2Ot47Az45hqz8EpTswSK7WYYA=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YIqiK-000ZyS-TT
        for linux-mips@linux-mips.org; Wed, 04 Feb 2015 03:33:23 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:56564 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YIqi8-000ZhM-QZ; Wed, 04 Feb 2015 03:33:07 +0000
Message-ID: <54D192EE.6070302@roeck-us.net>
Date:   Tue, 03 Feb 2015 19:33:02 -0800
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Matthew Wilcox <matthew.r.wilcox@intel.com>
Subject: Re: mips: Re-introduce copy_user_page
References: <1422681807-28395-1-git-send-email-linux@roeck-us.net> <54D11608.2070408@imgtec.com>
In-Reply-To: <54D11608.2070408@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020201.54D192FD.0083,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 4
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45640
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

On 02/03/2015 10:40 AM, Leonid Yegoshin wrote:
> On 01/30/2015 09:23 PM, Guenter Roeck wrote:
>> Commit bcd022801ee5 ("MIPS: Fix COW D-cache aliasing on fork") replaced
>> the inline function copy_user_page for mips with an external reference,
>> but neglected to introduce the actual non-inline function. Restore it.
>>
>> Fixes: bcd022801ee5 ("MIPS: Fix COW D-cache aliasing on fork")
>> Fixes: 4927b7d77c00 ("dax,ext2: replace the XIP page fault handler with the DAX page fault handler")
>> Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>> Cc: Matthew Wilcox <matthew.r.wilcox@intel.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>
>
> Why do you use copy_user_page?
> It doesn't work properly in HIGHMEM environment and it is excluded from MIPS because of that, I believe.
>
> You should use copy_user_highpage() for user pages.
>

Then maybe mips should not declare it the function external, the commit log
of the patch removing it should have mentioned that and why it was removed,
and there should be a clear statement somewhere stating that copy_user_page
shall not be used. I don't find such a statement anywhere in the kernel.

Guenter
