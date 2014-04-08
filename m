Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 00:49:09 +0200 (CEST)
Received: from gateway01.websitewelcome.com ([67.18.53.19]:42057 "EHLO
        gateway01.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821285AbaDHWtHEPJ0g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Apr 2014 00:49:07 +0200
Received: by gateway01.websitewelcome.com (Postfix, from userid 5007)
        id 12D1AD41A9326; Tue,  8 Apr 2014 17:49:05 -0500 (CDT)
Received: from gator3163.hostgator.com (gator3163.hostgator.com [50.87.144.199])
        by gateway01.websitewelcome.com (Postfix) with ESMTP id EC0CED41A9275
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 17:49:04 -0500 (CDT)
Received: from [216.239.45.67] (port=51876 helo=kkissell.mtv.corp.google.com)
        by gator3163.hostgator.com with esmtpsa (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
        (Exim 4.80.1)
        (envelope-from <kevink@paralogos.com>)
        id 1WXepE-0000p0-1f
        for linux-mips@linux-mips.org; Tue, 08 Apr 2014 17:49:04 -0500
Message-ID: <53447CDF.3000902@paralogos.com>
Date:   Tue, 08 Apr 2014 15:49:03 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Remove SMTC Support
References: <1396954750-24762-1-git-send-email-markos.chandras@imgtec.com> <20140408144436.GT17197@linux-mips.org>
In-Reply-To: <20140408144436.GT17197@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3163.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-BWhitelist: no
X-Source-IP: 216.239.45.67
X-Exim-ID: 1WXepE-0000p0-1f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (kkissell.mtv.corp.google.com) [216.239.45.67]:51876
X-Source-Auth: kevink@kevink.net
X-Email-Count: 5
X-Source-Cap: a2tpc3NlbGw7a2tpc3NlbGw7Z2F0b3IzMTYzLmhvc3RnYXRvci5jb20=
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
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

On 04/08/2014 07:44 AM, Ralf Baechle wrote:
> On Tue, Apr 08, 2014 at 11:59:08AM +0100, Markos Chandras wrote:
>
>> This patchset removes the MIPS SMTC support.
> While not really a fix I've applied this to my 3.15 fix branch.  At least
> it will avoid us having to fix it up for 3.15 :-)
>
> That said, SMTC was a remarkable hack and ingenious proof of the MT
> architecture.
Sigh. I was rather proud of it.  If it's being excised (and I don't 
begrudge people the right to deprecate it), I guess it means I can 
unsubscribe from the mailing list, as supporting MT hacks was the main 
reason I hung around at all after leaving MIPS.
> Still a sore spot is CONFIG_MIPS_MT_FPAFF with all its uglyness it
> scatters over the tree, in particular the wrapper around the syscall
> entry point.  I wonder if nowadays with the work that's been done on
> supporting inhomogenous SMP systems (ARM biglittle) there's now a
> better way to handle this sort of issue.
Even at the time, I'd identified a cleaner way to deal with this sort of 
thing, but the maintainer for the code in question wouldn't give me the 
time of day, so I solved the problem as well as the politics of Linux 
allowed.  As I understand it, the MIPS FP Affinity hack still 
outperformed some rather more complex solutions that contemporary 
inhomogeneous (is that different from heterogeneous?) MT machines (e.g. 
Niagara) were using.

/K.
