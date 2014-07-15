Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2014 20:51:11 +0200 (CEST)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:49590 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860083AbaGOSvIp4gNZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2014 20:51:08 +0200
Received: by mail-ig0-f181.google.com with SMTP id h3so3253542igd.2
        for <linux-mips@linux-mips.org>; Tue, 15 Jul 2014 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PZiOzWT4nfiE57cyB/d3qEq35gMnhOaGafBR1UpClik=;
        b=ydi8a8e3Ub7s7aOXWH0VV3SpzkefJO5YqB7iWXRY5Ur9Vzn/5XapHmIaOv9YcDAIgq
         GNSEzl954PebHfQUr2GJ9g6CSCVSZt/7kJh0QpaSXuUhUhXiNQZqg4YhA+31K/GD4gNi
         Hv/abxIm0OgXDWskHSLAt18/Kwf09d6ZKCL98V//g7KieQg1sqDuZ8XVe0K4PD37PhnK
         xf5XgS9Yd4x1UHVVnKrsezYd3S3L2YMMXNEyfQxnv+p9BEB7OYIg0XkVhxS32uAEWnza
         jL6RHMr3uANIkCytg6KIfx14FL6UURkF5+vPemfUnHHiUlhTAYPoqZpf9bL41Q/wQ5z+
         GMgA==
X-Received: by 10.42.78.143 with SMTP id n15mr31702891ick.17.1405450262634;
        Tue, 15 Jul 2014 11:51:02 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id tp2sm37085626igb.7.2014.07.15.11.50.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 11:50:52 -0700 (PDT)
Message-ID: <53C5780B.1090602@gmail.com>
Date:   Tue, 15 Jul 2014 11:50:51 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/3] Use dedicated RI/XI exceptions for MIPSR5 cores
References: <1405429797-18281-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1405429797-18281-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 07/15/2014 06:09 AM, Markos Chandras wrote:
> Hi,
>
> This patchset adds support for unique RI/XI exceptions. This feature has
> been added in MIPSr5. Using this feature, we reduce the time it takes
> to deal with a TLB exception caused by the RI/XI bits since the TLB load
> handler is skipped and we use the tlb_do_page_failt_0 path directly.
>
> This patch depends on the Hardware Page Table Walker (HTW) patchset
> http://www.linux-mips.org/archives/linux-mips/2014-07/msg00195.html

They are unrelated features, why the dependency?


>
> Leonid Yegoshin (3):
>    MIPS: Add new option for unique RI/XI exceptions
>    MIPS: Use dedicated exception handler if CPU supports RI/XI exceptions
>    MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions

There is code in mm/fault.c that generates the SIGSEGV for the RI/XI 
violations.  If we are using the dedicated RI/XI exception vectors, that 
code no longer has to make assumptions about what caused the exception.

I wonder if this should be reworked so that we don't make any 
assumptions about the cause of the exception.

David Daney


>
>   arch/mips/include/asm/cpu-features.h | 3 +++
>   arch/mips/include/asm/cpu.h          | 1 +
>   arch/mips/include/asm/mipsregs.h     | 1 +
>   arch/mips/kernel/cpu-probe.c         | 9 +++++++++
>   arch/mips/kernel/traps.c             | 7 +++++++
>   arch/mips/mm/tlbex.c                 | 4 ++--
>   6 files changed, 23 insertions(+), 2 deletions(-)
>
