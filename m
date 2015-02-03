Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 01:17:42 +0100 (CET)
Received: from mail-la0-f49.google.com ([209.85.215.49]:45087 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012430AbbBCARlSvKxu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Feb 2015 01:17:41 +0100
Received: by mail-la0-f49.google.com with SMTP id gf13so46365355lab.8
        for <linux-mips@linux-mips.org>; Mon, 02 Feb 2015 16:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aLSbYqPPVRgwaCeEULYZH0nhsrHcu7UvSXJgmk5xMJQ=;
        b=SqcvBBWJzwRqpO6CLlPaTl9L09OcBUXjgzb1TmaqXizkEaKANWm3D9FuXLVUKx8xWF
         djwyb+MWNAww4HEhi2GahKIMNiC6h1P1ff7VrZDNjXJQOd9vFOEFUgz8KXv+QSnLkWR/
         /80JzsNOllt0yTTmGXoC393EgnmrZhG/DGFX1C4uuq3l9mQKDS0tcaFOSUccLGtd0ayR
         j0pdxkcHq3FC3tpGQch4AmIG9UxwHlO2xfjvDCipS7zDvxPMyB1Bau9hLUrBzqmWQ75d
         BxkOX0pIVhp/j5eOUOyQm3gKi59R6AfR+JMocDqAE0LSWad+mpj0bhNy5+QptzW9J6oe
         D5pQ==
X-Received: by 10.112.211.168 with SMTP id nd8mr22188423lbc.18.1422922655994;
        Mon, 02 Feb 2015 16:17:35 -0800 (PST)
Received: from [192.168.0.100] ([213.138.85.113])
        by mx.google.com with ESMTPSA id xn1sm4709759lbb.27.2015.02.02.16.17.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2015 16:17:34 -0800 (PST)
Message-ID: <54D0139D.8060601@gmail.com>
Date:   Tue, 03 Feb 2015 03:17:33 +0300
From:   Oleg Kolosov <bazurbat@gmail.com>
Organization: Art System
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     =?windows-1252?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Few questions about porting Linux to SMP86xx boards
References: <54CEACC1.1040701@gmail.com> <54CF9577.6040004@imgtec.com> <yw1x1tm8b3j4.fsf@unicorn.mansr.com>
In-Reply-To: <yw1x1tm8b3j4.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <bazurbat@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bazurbat@gmail.com
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

On 02/02/15 20:56, Måns Rullgård wrote:
> "Steven J. Hill" <Steven.Hill@imgtec.com> writes:
> 
>> On 02/01/2015 04:46 PM, Oleg Kolosov wrote:
>>> Hello MIPS gurus!
>>>
>> Hello.
>>
>>> I'm adding support for Sigma Designs SMP8652/SMP8654 (Tango3 family,
>>> MIPS 24kf CPU) to newer kernel. I've selectively adapted patches from
>>> 2.6.32.15 (the latest officially available for us) to the latest mips
>>> 3.18 stable branch and things seem to work (it boots, runs simple test
>>> programs), but there are few questions which I was not able to resolve
>>> yet with my limited experience:
>>>
>> It is good to hear somebody is working with that hardware. I have
>> uploaded all the Sigma source that we were given along with their root
>> file system images. A lot is for the 8910, but there is stuff in there
>> for the 86xx family as well.
>>
>> Steve
>>
>> http://www.linux-mips.org/pub/linux/mips/people/sjhill/Sigma/

Thanks a lot! I've been curious if there are some improvements.
Unfortunately, all the same workarounds faithfully merged. But still,
looks like there might be some useful bits - like cpu feature overrides.

> 
> I have a bunch of cleaned/rewritten 86xx drivers for 3.19 here:
> https://github.com/mansr/linux-tangox
> 

Wow! You are my hero! Even DT bindings and I2C driver - dreams came
true. Nice and clean - without all those horrible ifdefs and
gbus_write's sprinkled everywhere. After so much struggle - it is like
revelation. I will thoroughly study your solution.

-- 
Regards, Oleg
Art System
