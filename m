Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 19:18:17 +0100 (CET)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:56891 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008667AbbAUSSPaCwHW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 19:18:15 +0100
Received: by mail-ig0-f177.google.com with SMTP id h15so15169241igd.4;
        Wed, 21 Jan 2015 10:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UvjlWhwQDY3B9xeZyH5D7meovhjCtS7jLw1WvxOubZ8=;
        b=Csi7aR+lXenaBfhxHVdkCKx93hC9ty+A6jfjo1w4e9OJFeYaKxUvhPh14GYrngvVE8
         WNHgasszklvlQzpRdIcyQrdWoaRruwylUui9jzrKLgdriBVK+wlbZAwMWUlMgguBlAW6
         1aPH5gIlaMqczLdr8vrJ1bLJ/qkH+04eS/0s4g4SYceUpXx/BAnbX/iCPIcZIu0u5+VW
         ZBXMcfBoLkLQ5XnoyDiGG26oh54cnCNXqHs5TAw2Or9VgKRUofzpmj4fHchf3oQ88oki
         FBOjEA17sQpRdCeIb6hd71jDxuN7vRPptI/eOc/9nb0jSXUNQ11hBTqvvI4rBQhhwagT
         KzGA==
X-Received: by 10.50.56.70 with SMTP id y6mr5767913igp.27.1421864289829;
        Wed, 21 Jan 2015 10:18:09 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id mi3sm6427777igb.13.2015.01.21.10.18.08
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 10:18:09 -0800 (PST)
Message-ID: <54BFED60.6040505@gmail.com>
Date:   Wed, 21 Jan 2015 10:18:08 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org> <54BF14D2.70006@gentoo.org> <54BF7DE6.6050704@imgtec.com> <20150121134927.GJ1205@linux-mips.org>
In-Reply-To: <20150121134927.GJ1205@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45419
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

On 01/21/2015 05:49 AM, Ralf Baechle wrote:
> On Wed, Jan 21, 2015 at 10:22:30AM +0000, Markos Chandras wrote:
>
>>>>> What would use this?  Or in other words, why is this needed?
>>>>
>>>> It was a patch I started including years ago in Gentoo's mips-sources, and just
>>>> never thought much about.  I know it was submitted several times in the past,
>>>> but I can't recall what, if any objection was ever made.  No harm in sending it
>>>> in again...
>>>
>>> Clarification, submitted several times in the past by others.  I think I sent
>>> it in once prior, but never got review or feedback.
>>>
>> I believe this patch is mostly useful for cores that can boot in both LE
>> and BE so being able to tell the byteorder from cpuinfo can be helpful
>> at times. Having readelf and other tools in your userland may not always
>> be the case, but you surely have "cat" :)
>>
>> So that patch looks good to me but i think the #ifdefs can be avoided.
>> Can we use
>>
>> if (config_enabled(CONFIG_CPU_BIG_ENDIAN) {
>> } else {
>> }
>>
>> stuff instead?
>
> Exactly the code Joshua is submitting is what has been there until commit
> 874124ebb630 (Merge with Linux 2.4.15.) in 2001.  One reason to remove it
> was that I had a prototype of a kernel supporting the execution of
> application of native and the other byte order working and the field in
> /proc/cpuinfo was plain lying in that case.  Not a terribly relevant
> reason in retrospective but I'm wondering if just in case we should
> rename the field to kernel_byteorder?
>

This is kind of my reason for questioning adding this thing in the first 
place.

Any user of the data probably wouldn't be ready for the case you 
mention.  *And* the data is available from other sources.


>    Ralf
>
