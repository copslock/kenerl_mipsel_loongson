Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 03:22:31 +0100 (CET)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35285 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011205AbcASCW3YGmJl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2016 03:22:29 +0100
Received: by mail-ob0-f178.google.com with SMTP id py5so208174581obc.2;
        Mon, 18 Jan 2016 18:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=yIEk3sUTehFaFtzUIDXwmkhsKzl+ph68P5trGrJ/tOo=;
        b=e/o99JxgRDs+jYM33pDukkUNT4pKeBmcAmXk0KiLnzHgV56yA8Ojrmb7IQx56xuHWj
         AVP+J8QeT5EXJkxBun6zlgIyuTtSzhI6A5d4/N6iBIGkJhmksa80gv+KsvuqDifIEUdo
         WxfgEaJgf+LxDns+77TcQfHpoqnCSSCk2loiBzYJNu8JTdFE+RI+jUQyReCGvxozOpgk
         MEDIEAomS2l5SYScDfm5XcxmAOhIUFmJGVtuFhMa9cu3etB2xerWvsZWkksG+GQ/MRbf
         FkChUWOrThDFJnnp24aGD8mbZGm74MjF6vNwgSzlMmLHAyrStNGbxnB3Nio7qEg0cMjq
         Y+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=yIEk3sUTehFaFtzUIDXwmkhsKzl+ph68P5trGrJ/tOo=;
        b=ETVNGeTtze766JqvzlNC4QztTwfMSotbVj5426xnfr5CX2lpPqEonIOoi5pHEjwFTS
         625a2+lENh8besWLBypeBxq9ecL+A0IYUyyRYTP9cjlyB2eMHIeM74GIpM+6wHsYQ5YM
         W7SZQGb7l/mJHOG2VS+GxJTGhmxr2YAGFaSUx3FP2SHrdsOR9KbapPVYJ2Hj95JOab6Y
         154AmSERfEomrNr0c2kXBYdj/rKxaTwrK7erjL5eZkkCBlaCZBM8/eVm4Pr4ieKSlaxC
         hKh1E/SAoL2pRMEZJdxunqF4ehoKPGMGyrEffvhEJ/B4RfMbLbn6keoc6wbQ2/J9LgNf
         Hk5Q==
X-Gm-Message-State: ALoCoQn7ze9r1wpIHIbZtIVZSSSbeXQeduTC4sirOQWqB98ulhdDzFwS6QfHQMJsNyaYdR+c3B0xtaMguP7MJCPMdbxTobpyuA==
X-Received: by 10.60.81.103 with SMTP id z7mr22038764oex.59.1453170143500;
        Mon, 18 Jan 2016 18:22:23 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:cd6b:e613:d25b:c85f? ([2001:470:d:73f:cd6b:e613:d25b:c85f])
        by smtp.googlemail.com with ESMTPSA id a65sm14410828oih.14.2016.01.18.18.22.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jan 2016 18:22:22 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: =?UTF-8?Q?Re:_cannot_build_Linux_4.4:_arch/mips/kernel/signal.c:142?=
 =?UTF-8?Q?:12:_error:_=e2=80=98struct_ucontext=e2=80=99_has_no_member_named?=
 =?UTF-8?B?IOKAmHVjX2V4dGNvbnRleHTigJk=?=
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
References: <569B9CFE.1090007@gmx.de> <569BA9BB.3080508@gmx.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <569D9DDD.7080909@gmail.com>
Date:   Mon, 18 Jan 2016 18:22:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <569BA9BB.3080508@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Le 17/01/2016 06:48, Heinrich Schuchardt a écrit :
> On 01/17/2016 02:54 PM, Heinrich Schuchardt wrote:
>>
>> HEAD is now at afd2ff9... Linux 4.4
>> arch/mips/kernel/signal.c: In function ‘sc_to_extcontext’:
>> arch/mips/kernel/signal.c:142:12: error: ‘struct ucontext’ has no member
>> named ‘uc_extcontext’
>>   return &uc->uc_extcontext;
>>             ^
>> In file included from include/linux/poll.h:11:0,
>>                  from include/linux/ring_buffer.h:7,
>>                  from include/linux/trace_events.h:5,
>>                  from include/trace/syscall.h:6,
>>                  from include/linux/syscalls.h:81,
>>                  from arch/mips/kernel/signal.c:26:
>> arch/mips/kernel/signal.c: In function ‘save_msa_extcontext’:
>> arch/mips/kernel/signal.c:170:40: error: dereferencing pointer to
>> incomplete type
>>
> 
> The problem stemmed from make not recognizing that this file was outdated:
> 
> Oct 16  2014 arch/mips/include/generated/asm/ucontext.h
> 
> Shouldn't make automatically regenerate outdated files?

The reduced test case can be simplified to these steps:

git co f1fe2d21f4e1aca8644cea888dc618f0183ad671\^1
configure your kernel
ARCH=mips make arch/mips/kernel/signal.o
git co f1fe2d21f4e1aca8644cea888dc618f0183ad671
ARCH=mips make arch/mips/kernel/signal.o

The problem seems to be that if there was a previous build which
resulted in creating an asm-generic wrapper for a file
(arch/mips/include/generated/asm/ucontext.h in that case), but this file
was later moved into an arch-specific, non asm-generic header file, then
we are just not going to automatically remove this auto-generated
wrapper, and generate the new one.

This seems to be aggravated by the fact that commit
f1fe2d21f4e1aca8644cea888dc618f0183ad671 does not add ucontext.h to
arch/mips/include/uapi/Kbuild, Paul, James is that intentional?

After trying to mess a bit with a clean solution, I just gave up and
decided that this was not worth fixing since it is a very infrequent
problem.
-- 
Florian
