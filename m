Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2010 00:15:35 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:48194 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491829Ab0E0WPc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 May 2010 00:15:32 +0200
Received: by pxi1 with SMTP id 1so262433pxi.36
        for <multiple recipients>; Thu, 27 May 2010 15:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=n3KTv2ECTDuR/f7n/77/dAEifeK4+DOlEcblBOY4SmE=;
        b=Uc1ivRPpyCIIzkTFNu5Z6QQ2M8YJSPxC8KoAfLOEBIL5Ougzn+Q2jqbLBKm/UdSpAn
         VnlLzPKCxfMqX8uOaEqyc25+RsRhzsTJhlnAwxEbA0zf0nUmQAsFS8hzqnDZSS2s21py
         VfNhpUmk3Mvrw3mddK5QbSUJYVUHlmJpYRzaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=awxV3+2HUBgh/ZqeorreDK2LY8cy58Wl7syXu5DXDKsOyvMgZaebsZ7TF4S5tN/U+l
         KH2LvJUDlzQlIiviS8xVIUbEiRYA0Ujnl9hKsWy9Dsz8e7eXBv4V+ucE3xmyH8sDVrbr
         8/Zlr4RlZ7H91ORBPQ9Orszmsaun7Q/kUW7fc=
Received: by 10.143.85.9 with SMTP id n9mr471961wfl.4.1274998524398;
        Thu, 27 May 2010 15:15:24 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id y27sm941228wfi.5.2010.05.27.15.15.22
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 15:15:23 -0700 (PDT)
Message-ID: <4BFEEEFA.9020003@gmail.com>
Date:   Thu, 27 May 2010 15:15:22 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 03/12] MIPS: add support for software performance events
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com> <1274965420-5091-4-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1274965420-5091-4-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/27/2010 06:03 AM, Deng-Cheng Zhu wrote:
> Software events are required as part of the measurable stuff by the
> Linux performance counter subsystem. Here is the list of events added by
> this patch:
> PERF_COUNT_SW_PAGE_FAULTS
> PERF_COUNT_SW_PAGE_FAULTS_MIN
> PERF_COUNT_SW_PAGE_FAULTS_MAJ
> PERF_COUNT_SW_ALIGNMENT_FAULTS
> PERF_COUNT_SW_EMULATION_FAULTS
>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>

Acked-by: David Daney <ddaney@caviumnetworks.com>

> ---
>   arch/mips/Kconfig            |    2 ++
>   arch/mips/kernel/traps.c     |   18 +++++++++++++++---
>   arch/mips/kernel/unaligned.c |    5 +++++
>   arch/mips/math-emu/cp1emu.c  |    3 +++
>   arch/mips/mm/fault.c         |   11 +++++++++--
>   5 files changed, 34 insertions(+), 5 deletions(-)
>
[...]
