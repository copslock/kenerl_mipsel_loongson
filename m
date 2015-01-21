Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 11:22:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57150 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011377AbbAUKWiLpplB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 11:22:38 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AA5F23418279B;
        Wed, 21 Jan 2015 10:22:30 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 21 Jan 2015 10:22:32 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 21 Jan
 2015 10:22:30 +0000
Message-ID: <54BF7DE6.6050704@imgtec.com>
Date:   Wed, 21 Jan 2015 10:22:30 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>,
        David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org> <54BF14D2.70006@gentoo.org>
In-Reply-To: <54BF14D2.70006@gentoo.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45395
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

On 01/21/2015 02:54 AM, Joshua Kinard wrote:
> On 01/20/2015 21:45, Joshua Kinard wrote:
>> On 01/20/2015 18:05, David Daney wrote:
>>> On 01/19/2015 01:02 AM, Joshua Kinard wrote:
>>>> From: Joshua Kinard <kumba@gentoo.org>
>>>>
>>>> This is a small patch to display the CPU byteorder that the kernel was compiled
>>>> with in /proc/cpuinfo.
>>>
>>> What would use this?  Or in other words, why is this needed?
>>
>> It was a patch I started including years ago in Gentoo's mips-sources, and just
>> never thought much about.  I know it was submitted several times in the past,
>> but I can't recall what, if any objection was ever made.  No harm in sending it
>> in again...
> 
> Clarification, submitted several times in the past by others.  I think I sent
> it in once prior, but never got review or feedback.
> 
I believe this patch is mostly useful for cores that can boot in both LE
and BE so being able to tell the byteorder from cpuinfo can be helpful
at times. Having readelf and other tools in your userland may not always
be the case, but you surely have "cat" :)

So that patch looks good to me but i think the #ifdefs can be avoided.
Can we use

if (config_enabled(CONFIG_CPU_BIG_ENDIAN) {
} else {
}

stuff instead?

-- 
markos
