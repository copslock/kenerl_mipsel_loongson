Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2010 00:52:50 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:37873 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491864Ab0E0Wwr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 May 2010 00:52:47 +0200
Received: by pvg13 with SMTP id 13so272014pvg.36
        for <multiple recipients>; Thu, 27 May 2010 15:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=5g/oSmFf4C4T6l7GUJ6h14UUGInb0K1hB7zp5kCMN6w=;
        b=mK8uetPgaQwUgYh76gdoJeM1jpI9yGrs5uzMaJuZ9HCqRNWRlL3xl0bJJGButQEzcf
         bXQ74rrLHTKzbMBTKI2VkADkKlQ7nHOtF6Dbny+qwHdAbs7ogC2ZT/puybYRThpZVIdP
         A/bCyZ/JRERtIjo5j0n9dmnDRzLnfK0DiUqdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=yHZFWFz5NXHccLEs8Q8DkavtkNFN9tdCl6rpHujT7A+YvtjQ+fJd9oNl9ezNFrSyZQ
         MWllh3hoMziKQtRmy627b8+1/3xjgzcqRvBTsxlmX5NIrndsJee+KcJR3hHQe2buLDrk
         1/+uV4d3TkJRjk/b3igZR1eAwQs2Xok3FvOTU=
Received: by 10.142.119.6 with SMTP id r6mr7596094wfc.34.1275000760111;
        Thu, 27 May 2010 15:52:40 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id 22sm1306413pzk.13.2010.05.27.15.52.38
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 15:52:39 -0700 (PDT)
Message-ID: <4BFEF7B5.9090804@gmail.com>
Date:   Thu, 27 May 2010 15:52:37 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 08/12] MIPS: move mipsxx pmu helper functions to Perf-events
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com> <1274965420-5091-9-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1274965420-5091-9-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/27/2010 06:03 AM, Deng-Cheng Zhu wrote:
> This is the 1st patch starting to use Perf-events as the backend of
> Oprofile. Here we move pmu helper functions and macros between pmu.h and
> perf_event*.c for mipsxx.
>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
> ---
>   arch/mips/include/asm/pmu.h          |  160 ++--------------------------------
>   arch/mips/kernel/perf_event.c        |    2 +
>   arch/mips/kernel/perf_event_mipsxx.c |  145 +++++++++++++++++++++++++++++--
>   3 files changed, 147 insertions(+), 160 deletions(-)
>

Is is possible to fold this patch also?  I don't think we need to follow 
the exact evolution of the new files.

David Daney
