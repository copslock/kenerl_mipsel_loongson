Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2010 15:39:16 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:45273 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491149Ab0I3NjN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Sep 2010 15:39:13 +0200
Received: by bwz19 with SMTP id 19so1812390bwz.36
        for <multiple recipients>; Thu, 30 Sep 2010 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0ipPoBihnMYxmRO9ogErC58U+Mr2DTbGPwLLUIYHkzo=;
        b=x32ixBkxCH6pVBHKOyJ7yYn5GrINmvS5XNKXtfgPkwN5eAHipKtWjFPdtKL7e6Fig6
         bMjq0Pv1eP728ZCuil/CV/zNZiWC7XCseJ/+JxNHiHIZ8QjL3JEYYlMuwv0CCuxmzb4W
         c7nXGXkl0h6e9kX1U43ZA44gJiRZoLqchtcuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J49lzZfcEmbnavg+BeMpvinK0KE0fqPITzapo9p/J1SdndJ+zQDK9SVI44vNOqISpD
         TDztJPG7iGeirFRAyDqVx4phkgSgrlkLoAcS5GR6rXgw2JuaQm7BHW5vIEOPhb7kpVmW
         ZQ/X2bI4dMpAHOi/03qmsppG/5NSl7n+uRXBI=
MIME-Version: 1.0
Received: by 10.204.81.203 with SMTP id y11mr2477724bkk.152.1285853952826;
 Thu, 30 Sep 2010 06:39:12 -0700 (PDT)
Received: by 10.204.64.212 with HTTP; Thu, 30 Sep 2010 06:39:12 -0700 (PDT)
In-Reply-To: <20100930092608.GA6059@elte.hu>
References: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com>
        <1285837760-10362-7-git-send-email-dengcheng.zhu@gmail.com>
        <20100930092608.GA6059@elte.hu>
Date:   Thu, 30 Sep 2010 21:39:12 +0800
Message-ID: <AANLkTinFV8QWHKS104E0Y3Hzqg6VqNzYZL7AkPDD3yWK@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] MIPS: add support for hardware performance events (mipsxx)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Ingo Molnar <mingo@elte.hu>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, acme@redhat.com,
        jamie.iles@picochip.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 27905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 24212

No problem. It's done.


Deng-Cheng


2010/9/30 Ingo Molnar <mingo@elte.hu>:
>
> * Deng-Cheng Zhu <dengcheng.zhu@gmail.com> wrote:
>
>> To test the functionality of Perf-event, you may want to compile the
>> tool "perf" for your MIPS platform. You can refer to the following
>> URL:
>> http://www.linux-mips.org/archives/linux-mips/2010-04/msg00158.html
>>
>> Please note: Before that patch is accepted, you can choose a
>> "specific" rmb() which is suitable for your platform -- an example is
>> provided in the description of that patch.
>>
>> You also need to customize the CFLAGS and LDFLAGS in
>> tools/perf/Makefile for your libs, includes, etc.
>
> Mind submitting this patch to the perf maintainers as well, so that by
> the time MIPS kernel-side support hits mainline the tools/perf/ side
> will be usable 'out of box' ?
>
> Thanks,
>
>        Ingo
>
