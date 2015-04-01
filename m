Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 20:38:11 +0200 (CEST)
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:36394 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014965AbbDASiJ3pOCZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 20:38:09 +0200
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-04v.sys.comcast.net with comcast
        id Aida1q00526dK1R01ie0RT; Wed, 01 Apr 2015 18:38:00 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-01v.sys.comcast.net with comcast
        id Aidz1q00W42s2jH01idzHR; Wed, 01 Apr 2015 18:38:00 +0000
Message-ID: <551C3AFE.20803@gentoo.org>
Date:   Wed, 01 Apr 2015 14:37:50 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: MIPS: Select CONFIG_MIPS_O32_FP64_SUPPORT if 64bit kernel
 and o32
References: <551B9513.5020606@gentoo.org> <551BA5ED.7060106@imgtec.com>
In-Reply-To: <551BA5ED.7060106@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1427913480;
        bh=uu2Ffo9OzllpjWmJhTcTiRBvYf5DvAT8CNRPTX/z2+A=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=qAU4vuvYQoSoWif/mj21ywHlfuba+oTNx9BuYzd3s7ZnLbZlr/+vGCY1VH8haLhR0
         XLFe4qe8N+TVlypV/KchYeX3pKiUki3r8iuyXhwz3MPIk5hIwpFRqrI/5/fCPOGFz7
         qHuSwKhe2N3zMN3OFhsClD7JECGpMg9YL6yUV4OVRgvHbfaZMbXHzMhklKhA2lKo4X
         yLk+y0kTsGG1QAMS/XYOhpn+hu0kCbcnJVxUylpdL+QNsSCvucjApbPZXPVWd+/71Y
         jcqCRIpnLfgIOTStnDzDME3iCqMhXS/YHOPbQvHOL1UddUi8BStHaevnrl4JE1Gaz2
         hbM9PKgSDZK+w==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46693
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

On 04/01/2015 04:01, Markos Chandras wrote:
> On 04/01/2015 07:49 AM, Joshua Kinard wrote:
>> From: Joshua Kinard <kumba@gentoo.org>
>>
>> Select CONFIG_MIPS_O32_FP64_SUPPORT by default if CONFIG_64BIT and
>> CONFIG_MIPS32_O32 are selected.  This avoids breaking things when
>> booting into an o32 userland under a 64bit kernel.  Symptoms of not
>> selecting CONFIG_MIPS_O32_FP64_SUPPORT can include OpenSSH claiming that
>> the "PRNG is not seeded" and Python programs to fail with either a
>> SIGSEGV or errors regarding "float NaN".
>>
>> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
>> ---
>>  arch/mips/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> mips-fix-o32-fp64-on-mips64.patch
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 294f82e..1b826ed 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -2736,6 +2736,7 @@ config MIPS32_O32
>>  	select COMPAT
>>  	select MIPS32_COMPAT
>>  	select SYSVIPC_COMPAT if SYSVIPC
>> +	select MIPS_O32_FP64_SUPPORT if 64BIT
>>  	help
>>  	  Select this option if you want to run o32 binaries.  These are pure
>>  	  32-bit binaries as used by the 32-bit Linux/MIPS port.  Most of
>>
>>
> Hi,
> 
> No this is not a good solution. This has already been fixed in
> mips-for-linux-next and might make it to 4.0 in time
> 
> https://patchwork.linux-mips.org/patch/9344/
> 
> can you try that patch instead?

This appears to fix the problem.  I definitely suggest this get into 4.0, or
some machines out there are going to break if CONFIG_MIPS_O32_FP64_SUPPORT
isn't selected.  This one was stumping me for a few hours last night...

Thanks!,

--J
