Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 19:21:56 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:39124 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903668Ab1KHSVs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2011 19:21:48 +0100
Received: by iapp10 with SMTP id p10so1034406iap.36
        for <multiple recipients>; Tue, 08 Nov 2011 10:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=ryrbmiv+afOZO7SPUuWyex/2HtB9+M6wHIx7TAJ4xms=;
        b=CSrWJM8H5YB4ePJ5S28Me5TuS3A00dVIYAaPDlVRU9zruC3L3uZ141Wkd6X07XW5T9
         32lvvbZGAC8oNvaiU6cdPs9MuKjzeX/HXX2j8mff+DSwNsyttDQ1RYS0ANWy9dd4yw9x
         vF5rsJuJR0d3yPZOBsA1SA4The6Plww0ub8pg=
Received: by 10.231.28.106 with SMTP id l42mr12466109ibc.66.1320776502784;
        Tue, 08 Nov 2011 10:21:42 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id jm11sm3155517ibb.1.2011.11.08.10.21.40
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Nov 2011 10:21:41 -0800 (PST)
Message-ID: <4EB97333.1050403@gmail.com>
Date:   Tue, 08 Nov 2011 10:21:39 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Michal Marek <mmarek@suse.cz>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Arnaud Lacombe <lacombar@gmail.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Daney, David" <David.Daney@caviumnetworks.com>
Subject: Re: [PATCH] Kbuild: append missing-syscalls to the default target
 list
References: <1314234210-11090-1-git-send-email-lacombar@gmail.com> <4E69FEC9.2080204@suse.cz> <CACqU3MUFyn_jh2pN4GLENqcGVUzAwcMJUR_WLY2EtqOhMheceQ@mail.gmail.com> <20111101232233.GA32441@sepie.suse.cz> <20111107204448.GA9949@linux-mips.org> <20111107211900.GB6264@sepie.suse.cz> <20111107233330.GA26705@linux-mips.org> <4EB8E75D.1010706@suse.cz>
In-Reply-To: <4EB8E75D.1010706@suse.cz>
Content-Type: multipart/mixed;
 boundary="------------000701030504060000030705"
X-archive-position: 31437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7028

This is a multi-part message in MIME format.
--------------000701030504060000030705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2011 12:25 AM, Michal Marek wrote:
> On 8.11.2011 00:33, Ralf Baechle wrote:
>> On Mon, Nov 07, 2011 at 10:19:00PM +0100, Michal Marek wrote:
>>
>>> Wild guess - does this patch help?
>>>
>>>
>>> diff --git a/Kbuild b/Kbuild
>>> index 4caab4f..77c191a 100644
>>> --- a/Kbuild
>>> +++ b/Kbuild
>>> @@ -94,7 +94,7 @@ targets += missing-syscalls
>>>   quiet_cmd_syscalls = CALL    $<
>>>         cmd_syscalls = $(CONFIG_SHELL) $<  $(CC) $(c_flags)
>>>
>>> -missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
>>> +missing-syscalls: scripts/checksyscalls.sh $(offsets-file) $(bounds-file) FORCE
>>>   	$(call cmd,syscalls)
>>>
>>>   # Keep these two files during make clean
>>
>> No, it didn't.
>>
>>> If not, please attach logs of make V=1 with clean Linus' tree and with
>>> 5f7efb4c6da9f90cb306923ced2a6494d065a595 reverted.
>>
>> $ git checkout 31555213f03bca37d2c02e10946296052f4ecfcd
>> $ git revert 5f7efb4c6da9f90cb306923ced2a6494d065a595
>> $ make ARCH=mips ip27_defconfig
>> $ make ARCH=mips V=1 2>&1 | tee log
>
> Thanks, can you also post a log without the revert?
>

The problem is that compiler options meant to be used only for the 
compiling done by scripts/checksyscalls.sh are now leaking into the 
compilation of other parts of the kernel (asm-offsets.c), where they 
wreak havoc.

Something like the attached is what I think needs to be done.

David Daney

--------------000701030504060000030705
Content-Type: text/plain;
 name="0001-kbuild-Fix-missing-system-calls-check-on-mips.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-kbuild-Fix-missing-system-calls-check-on-mips.patch"

>From e23608d2612092a8576d408425f6719f0860f5ff Mon Sep 17 00:00:00 2001
From: David Daney <david.daney@cavium.com>
Date: Tue, 8 Nov 2011 10:20:10 -0800
Subject: [PATCH] kbuild: Fix missing system calls check on mips.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 Kbuild             |    2 +-
 arch/mips/Makefile |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Kbuild b/Kbuild
index 4caab4f..b8b708a 100644
--- a/Kbuild
+++ b/Kbuild
@@ -92,7 +92,7 @@ always += missing-syscalls
 targets += missing-syscalls
 
 quiet_cmd_syscalls = CALL    $<
-      cmd_syscalls = $(CONFIG_SHELL) $< $(CC) $(c_flags)
+      cmd_syscalls = $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscalls_flags)
 
 missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
 	$(call cmd,syscalls)
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 9b4cb00..0be3186 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -286,11 +286,11 @@ CLEAN_FILES += vmlinux.32 vmlinux.64
 archprepare:
 ifdef CONFIG_MIPS32_N32
 	@echo '  Checking missing-syscalls for N32'
-	$(Q)$(MAKE) $(build)=. missing-syscalls ccflags-y="-mabi=n32"
+	$(Q)$(MAKE) $(build)=. missing-syscalls missing_syscalls_flags="-mabi=n32"
 endif
 ifdef CONFIG_MIPS32_O32
 	@echo '  Checking missing-syscalls for O32'
-	$(Q)$(MAKE) $(build)=. missing-syscalls ccflags-y="-mabi=32"
+	$(Q)$(MAKE) $(build)=. missing-syscalls missing_syscalls_flags="-mabi=32"
 endif
 
 install:
-- 
1.7.2.3


--------------000701030504060000030705--
