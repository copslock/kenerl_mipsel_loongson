Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Feb 2011 02:12:38 +0100 (CET)
Received: from ixqw-mail-out.ixiacom.com ([66.77.12.12]:28764 "EHLO
        ixqw-mail-out.ixiacom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491926Ab1BABMf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Feb 2011 02:12:35 +0100
Received: from [10.64.33.43] (10.64.33.43) by IXCA-HC1.ixiacom.com
 (10.200.2.55) with Microsoft SMTP Server (TLS) id 8.1.358.0; Mon, 31 Jan 2011
 17:12:28 -0800
Message-ID: <4D475DFC.1040401@ixiacom.com>
Date:   Mon, 31 Jan 2011 17:12:28 -0800
From:   Earl Chew <echew@ixiacom.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Filling in struct mips64_watch_regs from a 32 bit process
References: <4D4756B5.4010100@ixiacom.com> <4D475BCB.9050403@caviumnetworks.com>
In-Reply-To: <4D475BCB.9050403@caviumnetworks.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <EChew@ixiacom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echew@ixiacom.com
Precedence: bulk
X-list: linux-mips

>> I notice that a 32 bit process running on a 64 bit kernel is expected to
>> know that it should fill in mips64_watch_regs --- even though it is running
>> against a 32 bit ABI.
>>
>> Is this an oversight, or am I missing something ?
> 
> It is intentional.

Oh I see ... I have to call PTRACE_SET_WATCH_REGS first in order to figure
out whether the kernel is expecting me to use pt_watch_style_mips32 or
pt_watch_style_mips64.

Thanks.

Earl
