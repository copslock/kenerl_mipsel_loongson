Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 01:28:56 +0100 (CET)
Received: from mail-ua0-f196.google.com ([209.85.217.196]:32937 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993417AbcLIA2qv5yK0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2016 01:28:46 +0100
Received: by mail-ua0-f196.google.com with SMTP id 20so249478uak.0
        for <linux-mips@linux-mips.org>; Thu, 08 Dec 2016 16:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ol3CzxSNpd8NSExk1rfinE8NnXRv7qIdLwExKtb8lDo=;
        b=P2a8nvWX+xcDlrs3uKXAt+89tMZyisteiF+06p4KDhLOBEfuBCa2CeeuwRRPUr/+sh
         8JugzWlSjwjgXhN7Xk+np9KqKkJOZhhnKCJT0GwAUuozQniB3/ffGpEsRlxZAiG5b3w6
         v10JcIL65YexNfcGm2g/H57yE/brxmNjm5AjoTPvm6TiDVriuh6fuhXEoT98dilglS9n
         UQn6SjSpDCDb1dVhTvdcmP2rCRSYVA5/EIpQhYz7fa9Jy8lzc4tBEiUHpckUVDYGS1yr
         h1++LZW9WCN00yDgd5sdM81dxDEIp0YrCbJ09qml9NzGlZTMZ6Esorte//8OBtiSFBbU
         WTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ol3CzxSNpd8NSExk1rfinE8NnXRv7qIdLwExKtb8lDo=;
        b=AXUluuqhBMigKDbx8IxgyoYVpCRH/xZ+g7tTwNT0M97cbiR32xpuAL0zFpbfGZEO/n
         mm4FRqZFikbMAc2PMvVroOPGLWvvN4gk2zUl8BB2oictaN1KJw+fSODAPiEVTTCLrbEv
         TYN5iKng/sdSg93AqyL68N1dD8JCOBt6gKxqpbDaF570ip9cl5di88GmIVFOUS6uE7LW
         gCzl44N6Iu9qj9QUirlqfi1bpFuQHL3VVbNREARxzV+hqwJfkPb2GQq7FtZL3W2ZgIP8
         UV4txSwkloxrQw0UZa1HjYqYozAl2zT2bQKC3Am2FrvjJG2F/kLM23AkeXx7XVrfJfar
         U3WA==
X-Gm-Message-State: AKaTC01THPHpkQ4MTBTSPLSyydLls30ftP6/QMVG0uxA6K3d3bvrRAQ1/za8DJ4DTT7ri7ltLj/bG47HadJbXQ==
X-Received: by 10.176.86.205 with SMTP id c13mr47778923uab.151.1481243321008;
 Thu, 08 Dec 2016 16:28:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.8.5 with HTTP; Thu, 8 Dec 2016 16:28:40 -0800 (PST)
In-Reply-To: <5849EC43.2070802@imgtec.com>
References: <20161208011626.20885-1-justinpopo6@gmail.com> <5849EC43.2070802@imgtec.com>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Thu, 8 Dec 2016 16:28:40 -0800
Message-ID: <CAJx26kW0e-HC0VUTObZ5Or+XjFvE9KmtOToKbFvKYvhE--Vw5A@mail.gmail.com>
Subject: Re: [RFC] MIPS: Add cacheinfo support
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     linux-mips@linux-mips.org, bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <justinpopo6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinpopo6@gmail.com
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

On Thu, Dec 8, 2016 at 3:26 PM, Leonid Yegoshin
<Leonid.Yegoshin@imgtec.com> wrote:
> On 12/07/2016 05:16 PM, Justin Chen wrote:
>>
>> From: Justin Chen <justin.chen@broadcom.com>
>>
>> Add cacheinfo support for MIPS architectures.
>>
>> Use information from the cpuinfo_mips struct to populate the
>> cacheinfo struct. This allows an architecture agnostic approach,
>> however this also means if cache information is not properly
>> populated within the cpuinfo_mips struct, there is nothing
>> we can do. (I.E. c-r3k.c)
>>
>>
>
> Justin, for architecture agnostic approach of work with caches the
> cpuinfo_mips lacks more information:
>
> 1.  L1I-L1D coherency status (is L1I coherent to L1D)
> 2.  L1D-L2 coherency status (is L1D coherent to L2)
> 3.  L1I-L2 coherency status (is L1I coherent to L2)
> 4.  L1I refill from L1D (snoops L1D) or L2 (may require L1D flush)?
> 5.  L1D cache aliasing disabled by HW
> 6.  L1I cache aliasing disabled by HW
> 7.  Barrier existence and it's type between various cache flushes as is as
> between cache flush and final (completed) state.
> 8.  Cache ownership (current: assumed that sibling CPUs share L1 - may be
> shared_cpu_map?)
> 9.  Is address cache flush operation global in system or pure local?
> 10. Is index cache flush operation global in system or pure local?
>
> Without that the proposed cpuinfo_mips struct is basically useless.
>
> Regards,
> - Leonid

Thanks for the comments Leonid.

We should consider the scope of this patch. The information we are
trying to expose to userspace is limited to the struct cacheinfo
located at include/linux/cacheinfo.c (of course this can always be
expanded). So the question is what information would be useful to
expose to userspace.
Some justification for exposing the current information in the
cacheinfo struct could be: (Pulled from another email chain)
"Agreed. So far I have got requests from GCC, JIT and graphics guys.
IIUC they need this to support cache flushing for user applications like
gcc trampolines and JIT compilers. I am also told that having knowledge
of cache architecture can help optimal code strategies, though I don't
have much details on that."
https://patchwork.kernel.org/patch/5867721/

There may be justification for including the points you mentioned
above, but I believe that is outside the scope of this patch. The
cache information exposed in this patch is limited, but I do not
believe it is useless. The points above can be added, but it will
require a rework of the base cacheinfo driver. driver/base/cacheinfo.c

Thanks,
Justin
