Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 11:45:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38526 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006674AbaHZJpVong1w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 11:45:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A162B274A3237;
        Tue, 26 Aug 2014 10:45:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 26 Aug 2014 10:45:14 +0100
Received: from [192.168.154.158] (192.168.154.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 26 Aug
 2014 10:45:13 +0100
Message-ID: <53FC5729.7060306@imgtec.com>
Date:   Tue, 26 Aug 2014 10:45:13 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-mips <linux-mips@linux-mips.org>,
        "Aurelien Jarno" <aurelien@aurel32.net>,
        "Markos (GMail)" <markos.chandras@gmail.com>,
        Paul <paul.burton@imgtec.com>,
        Rob Kendrick <rob.kendrick@codethink.co.uk>,
        Alex Smith <alex@alex-smith.me.uk>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: Please add my temporary MIPS fixes branch to linux-next
References: <53D9169D.3020705@imgtec.com> <53E8A470.1050603@imgtec.com> <20140823202447.GB6818@drone.musicnaut.iki.fi>
In-Reply-To: <20140823202447.GB6818@drone.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.158]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42246
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

On 08/23/2014 09:24 PM, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, Aug 11, 2014 at 12:09:36PM +0100, James Hogan wrote:
>> On 30/07/14 17:00, James Hogan wrote:
>>> Hi Stephen & MIPS people
>>>
>>> v3.16 is fast approaching and there are quite a few important MIPS
>>> patches pending. Since Ralf appears to be unavailable at the moment I've
>>> reviewed and applied some of those patches which are least controversial
>>> to a fixes branch with the intention of sending a pull request to Ralf &
>>> Linus so that one of them can hopefully merge it before the release.
>>
>> I sent you a pull request for these fixes prior to v3.16 but
>> unfortunately they still missed the release, and only two of the patches
>> were applied in the main v3.17 MIPS merge.
>>
>> What are you intentions for the remaining fixes from Markos & Aaro?
> 
> Ralf, any comments? I think at least this fix is imporant,
> because currently users can hang OCTEON systems simply by lauching
> multiple readers of the proc file:
> 
> https://git.kernel.org/cgit/linux/kernel/git/jhogan/mips.git/commit/?id=08a9c3c9afcf6e8975fc1c9a97e871e6a039c25a
> 
> A.
> 
Hi,

I plan to send GregKH another set of fixes to backport to 3.16, and
since this patch is now in mainline[1], I will include this one as well.

[1]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=608308682addfdc7b8e2aee88f0e028331d88e4d

-- 
markos
