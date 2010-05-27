Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2010 01:26:45 +0200 (CEST)
Received: from mail-pz0-f173.google.com ([209.85.222.173]:64690 "EHLO
        mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S2097165Ab0E0X0k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 May 2010 01:26:40 +0200
Received: by pzk3 with SMTP id 3so221592pzk.24
        for <multiple recipients>; Thu, 27 May 2010 16:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=fskEsN1bOEvqmuBejESq5pRRaZScxbKOmUUUt5Uxgs4=;
        b=vviez5gu3078PuZzIt18TEaree3SucWKCz/vEN/ViU7O73ycEIoNxWrx4rec+NFbch
         +OFVUKQKSuy2keNVfi3ktQaDdX9WEUm4uKgzlGzldazUNc0W49+UdF0hxd+OLeVHNxuI
         29dc/9IGF3hDyu8rcREGzL4MESY4tgHl8CX5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=fDCRYxGs/Xqt8S5gk2xuVSTiKl/Jg3BMPH7XjqXT/W01uQnpIBwEpdJ3tglNWfgOQ2
         MwQp3jo9RiR6g7cPza2gL4cgz5YzimMNC/CBU0TK6cZmdQDA0AB8Rt74D05oM1RdnKuw
         fjE289fWnUqnePZMWf43xQP5HuKy7Nzksj9+A=
Received: by 10.142.210.21 with SMTP id i21mr1680850wfg.16.1275002792445;
        Thu, 27 May 2010 16:26:32 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id h18sm972119wfg.1.2010.05.27.16.26.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 16:26:31 -0700 (PDT)
Message-ID: <4BFEFFA6.8040904@gmail.com>
Date:   Thu, 27 May 2010 16:26:30 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 12/12] MIPS/Oprofile: remove old files and update Kconfig/Makefile
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com> <1274965420-5091-13-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1274965420-5091-13-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/27/2010 06:03 AM, Deng-Cheng Zhu wrote:
> Now that Oprofile uses Perf-events as backend, its old framework files
> are not needed. Kconfig is modified to let hardware performance events be
> the prerequisite of Oprofile.
>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
> ---
>   arch/mips/Kconfig                       |    4 +-
>   arch/mips/oprofile/Makefile             |    7 -
>   arch/mips/oprofile/op_impl.h            |   39 -----
>   arch/mips/oprofile/op_model_loongson2.c |  139 ------------------
>   arch/mips/oprofile/op_model_mipsxx.c    |  237 -------------------------------
>   arch/mips/oprofile/op_model_rm9000.c    |  124 ----------------
>   6 files changed, 2 insertions(+), 548 deletions(-)
>   delete mode 100644 arch/mips/oprofile/op_impl.h
>   delete mode 100644 arch/mips/oprofile/op_model_loongson2.c
>   delete mode 100644 arch/mips/oprofile/op_model_mipsxx.c
>   delete mode 100644 arch/mips/oprofile/op_model_rm9000.c
>


This patch could be folded into the previous one.

If the previous patch really makes these unused, it shouldn't leave them 
hanging around.


David Daney
