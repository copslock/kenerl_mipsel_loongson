Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Sep 2014 15:52:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2769 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025782AbaIDNwvEdpVh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Sep 2014 15:52:51 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DF471F5C8AD03;
        Thu,  4 Sep 2014 14:52:41 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 4 Sep
 2014 14:52:43 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 4 Sep 2014 14:52:43 +0100
Received: from [192.168.154.67] (192.168.154.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 4 Sep
 2014 14:52:43 +0100
Message-ID: <54086EAB.3060406@imgtec.com>
Date:   Thu, 4 Sep 2014 14:52:43 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Greg KH <greg@kroah.com>
CC:     <stable@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [request for stable inclusion] MIPS fixes for 3.16
References: <53FDE583.9060908@imgtec.com> <20140827212310.GA27456@kroah.com> <53FEE049.8030906@imgtec.com>
In-Reply-To: <53FEE049.8030906@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 08/28/2014 08:54 AM, Markos Chandras wrote:
> On 08/27/2014 10:23 PM, Greg KH wrote:
>> On Wed, Aug 27, 2014 at 03:04:51PM +0100, Markos Chandras wrote:
>>> Hi Greg,
>>>
>>> Could you please apply the following patches to the 3.16.X stable kernels?
>>>
>>> - MIPS: EVA: Add new EVA header
>>> (f85b71ceabb9d8d8a9e34b045b5c43ffde3623b3)
>>> - MIPS: Malta: EVA: Rename 'eva_entry' to 'platform_eva_init'
>>> (ca4d24f7954f3746742ba350c2276ff777f21173)
>>> - MIPS: CPS: Initialize EVA before bringing up VPEs from secondary cores
>>> (6521d9a436a62e83ce57d6be6e5484e1098c1380)
>>
>> That really looks like a new feature, how is this a bugfix / regression
>> from previous kernel releases?
>>
>> thanks,
>>
>> greg k-h
>>
> Hi Greg,
> 
> The bugfix is the 3rd patch in that list. Without this patch, it is not
> possible to boot a CPS kernel when EVA is enabled. The kernel will die
> in a horrible way. The other two patches simply make the bugfix fit
> better in the existing code. So all three are needed.
> 
> Thank you
> 

Hi Greg,

Are you happy with the above explanation? If so, could you please
consider including these patches to the 3.16 stable kernels?

Thank you

-- 
markos
