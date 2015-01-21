Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 12:27:04 +0100 (CET)
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:60162 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011344AbbAUL1DHrxK4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 12:27:03 +0100
Received: from resomta-ch2-07v.sys.comcast.net ([69.252.207.103])
        by resqmta-ch2-02v.sys.comcast.net with comcast
        id ibSw1p0032EPM3101bSwgt; Wed, 21 Jan 2015 11:26:56 +0000
Received: from [192.168.1.13] ([73.212.71.42])
        by resomta-ch2-07v.sys.comcast.net with comcast
        id ibSv1p00E0uk1nt01bSwrL; Wed, 21 Jan 2015 11:26:56 +0000
Message-ID: <54BF8CF7.407@gentoo.org>
Date:   Wed, 21 Jan 2015 06:26:47 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org> <54BF14D2.70006@gentoo.org> <54BF7DE6.6050704@imgtec.com>
In-Reply-To: <54BF7DE6.6050704@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1421839616;
        bh=tfraweSpEeiuAgKV56edAYJeGjThkQBUYRdKhO9JOTg=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=IHXfqa5cCxzvzFpzzHF91dGQdhCjcptSjsPB72S0HXxiJyHSjytrtMqYU6tf4T1Dx
         2pBBb4u0XRYOsD9CUnhuFTcn+z8JmSBMyauK57JYAWxbU2dfZxLhJUEJuT2xaxI3tv
         AcqaGUHkA9q+fA3ggVFe1FFbhYd4NtrFfMBjuj/zttOwQISsG8w3S5ithHxlcazA/T
         AqaEOdRxDJlGHkqs5fZ8F+kSnroDKJ7QOxSWraFAZB5orMjydUqniNau0l6ImTLczF
         JsOvhFvm15wbaI6L9AT3ANpOmZPin+KLTEk9gOoBOV3dDTmP162FPbK3SOr+j6dCy7
         a5STkQWI1Ei3A==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 01/21/2015 05:22, Markos Chandras wrote:
> On 01/21/2015 02:54 AM, Joshua Kinard wrote:
>> On 01/20/2015 21:45, Joshua Kinard wrote:
>>> On 01/20/2015 18:05, David Daney wrote:
>>>> On 01/19/2015 01:02 AM, Joshua Kinard wrote:
>>>>> From: Joshua Kinard <kumba@gentoo.org>
>>>>>
>>>>> This is a small patch to display the CPU byteorder that the kernel was compiled
>>>>> with in /proc/cpuinfo.
>>>>
>>>> What would use this?  Or in other words, why is this needed?
>>>
>>> It was a patch I started including years ago in Gentoo's mips-sources, and just
>>> never thought much about.  I know it was submitted several times in the past,
>>> but I can't recall what, if any objection was ever made.  No harm in sending it
>>> in again...
>>
>> Clarification, submitted several times in the past by others.  I think I sent
>> it in once prior, but never got review or feedback.
>>
> I believe this patch is mostly useful for cores that can boot in both LE
> and BE so being able to tell the byteorder from cpuinfo can be helpful
> at times. Having readelf and other tools in your userland may not always
> be the case, but you surely have "cat" :)
> 
> So that patch looks good to me but i think the #ifdefs can be avoided.
> Can we use
> 
> if (config_enabled(CONFIG_CPU_BIG_ENDIAN) {
> } else {
> }
> 
> stuff instead?

Sure, I just tested on the Octane, and it works fine.  I'll send a v2 shortly.

--J
