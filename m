Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2010 00:44:53 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:33305 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491839Ab0E0Wot (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 May 2010 00:44:49 +0200
Received: by pxi1 with SMTP id 1so272477pxi.36
        for <multiple recipients>; Thu, 27 May 2010 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ncugqt7P4mtV12qPPUzr1ozYrp/ObhUghqz71kKOsCk=;
        b=H7tCRGZ7Co4d+0hxmNiQ7aOR+YX8AreuWHc6Ge3ihKIUWmuLaLxzi3TlpF29DdN5lc
         pgNzpCxqh1sCkXt48d3q5XhrRPR1cFtckfor1QpkYZdBwYBqYRK6Q5CfV03PdMB5fwxe
         QQssWRY29TW41i9FIPX8jr5N4wf8ST634hRGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=okfwZyanvLpW5qKghT097/gvLJCprC/Yh4GxnXY3LjKpwMilziJsPRvFL7w/HoiIpj
         +HtpICQSbkL19WG7y7hBeXoKHkkh99Yap3+1jcA4N2t+Jx8VfkORVVaiWXEXujVl3tRC
         2/3xnR4XPuikE8PsM9fYY3VZOogH7j0dwVMCY=
Received: by 10.141.213.22 with SMTP id p22mr331436rvq.131.1275000281888;
        Thu, 27 May 2010 15:44:41 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id q10sm1477648rvp.8.2010.05.27.15.44.40
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 15:44:41 -0700 (PDT)
Message-ID: <4BFEF5D7.4050502@gmail.com>
Date:   Thu, 27 May 2010 15:44:39 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 06/12] MIPS: add support for hardware performance events
 (mipsxx)
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com> <1274965420-5091-7-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1274965420-5091-7-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/27/2010 06:03 AM, Deng-Cheng Zhu wrote:
> This patch adds the mipsxx Perf-event support based on the skeleton.
> Generic hardware events and cache events are now fully implemented for
> the 24K/34K/74K/1004K cores. To support other cores in mipsxx (such as
> R10000/SB1), the generic hardware event tables and cache event tables
> need to be filled out. To support other CPUs which have different PMU
> than mipsxx, such as RM9000 and LOONGSON2, the additional files
> perf_event_$cpu.c need to be created.
>
> To test the functionality of Perf-event, you may want to compile the tool
> "perf" for your MIPS platform. You can refer to the following URL:
> http://www.linux-mips.org/archives/linux-mips/2010-04/msg00158.html
>
> Please note: Before that patch is accepted, you can choose a "specific"
> rmb() which is suitable for your platform -- an example is provided in
> the description of that patch.
>
> You also need to customize the CFLAGS and LDFLAGS in tools/perf/Makefile
> for your libs, includes, etc.
>
> In case you encounter the boot failure in SMVP kernel on multi-threading
> CPUs, you may take a look at:
> http://www.linux-mips.org/git?p=linux-mti.git;a=commitdiff;h=5460815027d802697b879644c74f0e8365254020
>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
> ---
>   arch/mips/kernel/perf_event.c        |    2 +
>   arch/mips/kernel/perf_event_mipsxx.c |  719 ++++++++++++++++++++++++++++++++++
>   2 files changed, 721 insertions(+), 0 deletions(-)
>   create mode 100644 arch/mips/kernel/perf_event_mipsxx.c
>

General comments:

Can you separate the code that reads and writes the performance counter 
registers from the definitions of the various counters themselves?

Also take into account that the counter registers may be either 32 or 64 
bits wide.  The interfaces you are defining should take that into 
account even if the specific implementations only work with 32-bit 
registers.

Thanks,
David Daney
