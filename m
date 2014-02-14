Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2014 02:34:11 +0100 (CET)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:40249 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868549AbaBNBeHOIH0N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Feb 2014 02:34:07 +0100
Received: by mail-wi0-f182.google.com with SMTP id f8so9478756wiw.3
        for <multiple recipients>; Thu, 13 Feb 2014 17:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mOVe9JtYil+EibkSI7G+9udHsZCjL/0QzkbKa5B+ckc=;
        b=NZmxS7pIpFV9HV+wx5PHdto/G0PX6ZOxkLoVieKP0Wm4W/MtPaHltOF+WeK6At5vHE
         QDuckUAf3Vw7PELyeQJx1dTnmf8NaCOIEGittUEmitg+zMp5QMH33af4Sa3MDM9XAnSE
         sk8w0riK5Y10v9W9RV5cJtY83MAb7Dseb4EuNRBJkCK3pu42qwtuLVEna2aqmi7/3pKF
         HVaGCvShqri8f098bCq6cZ8z59dd9QNFTn8Kjk1bcaEDrLPYUnrJDIyVjFww4Dc3HdO5
         obzCcPbEWj1XN/2nnGQKYR5AZyB0wdqCKDkKG9dZVlWRyv7AG3qxE+5ZAGp9SEuZtMUM
         1BtQ==
X-Received: by 10.194.178.135 with SMTP id cy7mr646024wjc.21.1392341641488;
 Thu, 13 Feb 2014 17:34:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.80.2 with HTTP; Thu, 13 Feb 2014 17:33:31 -0800 (PST)
In-Reply-To: <52FD0F46.6040503@gmail.com>
References: <1392312460-24902-1-git-send-email-markos.chandras@imgtec.com> <52FD0F46.6040503@gmail.com>
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Thu, 13 Feb 2014 20:33:31 -0500
X-Google-Sender-Auth: qbcvSjML7RjpgbiaPGCH6lhLPt4
Message-ID: <CAP=VYLr1D-DQz8U4naa5aEL_AFa_JkO5e+TgFSxpsd_2t3dahQ@mail.gmail.com>
Subject: Re: [PATCH] samples/seccomp/Makefile: Do not build tests if
 cross-compiling for MIPS
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        linux-kernel@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <paul.gortmaker@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

On Thu, Feb 13, 2014 at 1:30 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> Really I think we should add a Kconfig item for this and disable the whole
> directory for targets that do not support it.

Can we do something based on  CONFIG_CROSS_COMPILE vs. adding more Kconfig?

Paul.
--

>
> David Daney
>
>
>
> On 02/13/2014 09:27 AM, Markos Chandras wrote:
>>
>> The Makefile is designed to use the host toolchain so it may be
>> unsafe to build the tests if the kernel has been configured and built
>> for another architecture. This fixes a build problem when the kernel has
>> been configured and built for the MIPS architecture but the host is
>> not MIPS (cross-compiled). The MIPS syscalls are only defined
>> if one of the following is true:
>>
>> 1) _MIPS_SIM == _MIPS_SIM_ABI64
>> 2) _MIPS_SIM == _MIPS_SIM_ABI32
>> 3) _MIPS_SIM == _MIPS_SIM_NABI32
>>
>> Of course, none of these make sense on a non-MIPS toolchain and the
>> following build problem occurs when building on a non-MIPS host.
>>
>> linux/usr/include/linux/kexec.h:50:
>> userspace cannot reference function or variable defined in the kernel
>> samples/seccomp/bpf-direct.c: In function 'emulator':
>> samples/seccomp/bpf-direct.c:76:17: error:
>> '__NR_write' undeclared (first use in this function)
>>
>> Cc: linux-next@vger.kernel.org
>> Cc: linux-kernel@linux-mips.org
>> Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>> This problem is only reproducible on the linux-next tree at the moment
>> ---
>>   samples/seccomp/Makefile | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
>> index 7203e66..f6bda1c 100644
>> --- a/samples/seccomp/Makefile
>> +++ b/samples/seccomp/Makefile
>> @@ -17,9 +17,14 @@ HOSTCFLAGS_bpf-direct.o += -I$(objtree)/usr/include
>>   HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
>>   bpf-direct-objs := bpf-direct.o
>>   +# MIPS system calls are defined based on the -mabi that is passed
>> +# to the toolchain which may or may not be a valid option
>> +# for the host toolchain. So disable tests if target architecture
>> +# is mips but the host isn't.
>> +ifndef CONFIG_MIPS
>>   # Try to match the kernel target.
>> -ifndef CONFIG_64BIT
>>   ifndef CROSS_COMPILE
>> +ifndef CONFIG_64BIT
>>     # s390 has -m31 flag to build 31 bit binaries
>>   ifndef CONFIG_S390
>> @@ -40,3 +45,4 @@ endif
>>     # Tell kbuild to always build the programs
>>   always := $(hostprogs-y)
>> +endif
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-next" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
