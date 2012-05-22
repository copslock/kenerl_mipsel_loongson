Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2012 07:34:18 +0200 (CEST)
Received: from mail-qc0-f177.google.com ([209.85.216.177]:38697 "EHLO
        mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901163Ab2EVFeL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 May 2012 07:34:11 +0200
Received: by qcsu28 with SMTP id u28so4409712qcs.36
        for <multiple recipients>; Mon, 21 May 2012 22:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AuZUiukdYPGg1MCzL9t0TH1nm/kHrJfB/Oej4pXiaQ0=;
        b=cDWEIy+Na5P7YICxFqBeShH4k0A7PpIDl5Z1SuC97F+ScVXuM50ZIZ+KJFTptO9Sdm
         vYuOmVQv+wPwOUKTCLMAYrhgCzvvoI8xbytVewVF2MMcDMDGt65pMrD5+/IxSx+9oWml
         M4hBun9DMafcFlhwhjWIZFCgs4ZE1Ds99ViiWNr1i0j6L7xsSa05HqzjEUDBlTuGO823
         /0YSdPywNMcYUlLtyfUG4pywOQE9HeGeUjfmAYcMxHUhvEsQCqvK5hd0i0URMaxDvn/r
         IAXlYeGY5nk4L+miC0GiuzSwtcSO1hhflHjnsj3rxQQSzTORiYA5vZftFIvKlZn+rpMo
         1SHw==
Received: by 10.224.44.136 with SMTP id a8mr42703849qaf.34.1337664844896;
        Mon, 21 May 2012 22:34:04 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id gb7sm43524625qab.12.2012.05.21.22.34.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 May 2012 22:34:03 -0700 (PDT)
Date:   Tue, 22 May 2012 13:33:54 +0800
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, david.daney@cavium.com
Subject: Re: [PATCH 6/8] MIPS: call set_cpu_online() on the uping cpu with
 irq disabled
Message-ID: <20120522053354.GA12098@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
References: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
 <1337580008-7280-7-git-send-email-yong.zhang0@gmail.com>
 <4FBA1961.2050504@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4FBA1961.2050504@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, May 21, 2012 at 02:30:57PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 21-05-2012 10:00, Yong Zhang wrote:
> 
> >From: Yong Zhang<yong.zhang@windriver.com>
> 
> >To prevent a problem as commit 5fbd036b [sched: Cleanup cpu_active madness]
> >and commit 2baab4e9 [sched: Fix select_fallback_rq() vs cpu_active/cpu_online]
> >try to resolve, move set_cpu_online() to the brought up CPU and with irq
>                                                ^^^^^^^^^^
>    Now the same change in the subject please.

Ah, yes, forgot that.

Thanks,
Yong
