Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 14:36:53 +0200 (CEST)
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35390 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026276AbcDRMguc4nRF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 14:36:50 +0200
Received: by mail-lf0-f43.google.com with SMTP id c126so214874006lfb.2
        for <linux-mips@linux-mips.org>; Mon, 18 Apr 2016 05:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3/eAn4KfJ+DIFVpXJ9RY4pC/xnDBF/IZL7fIbEPkA1w=;
        b=BR3oiwWUublgGL43L0hzdeHKzoI/kHW+M4h6S+opt/DFOcZO7IfDvGe1OJAx+Lei9F
         obeBB7X8RdA7MU0yRJlLP3s2QAJLhVpDjmGLjBwo1ehW+n6bf3kN0KuwVzUwBiLJHgMl
         Au0CMijw0X4PmG7g0o6kmfmj6nF8lTR0luquUcUefouXw7jr0H6AXfy2kNEvrsJt8gUV
         S3I9jPvthJ0CnqIrrucRZJRbGgn4x5EJtCfvQwcyHuIzJd6QDUIuHTYFAAno6nmdK+vd
         Nvpnlhmrz5IJuU2I62tg5ARl43QePyWwwdgGK/jqd0OBY4d/9Ckurirrnnp4oSi20gfU
         7k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3/eAn4KfJ+DIFVpXJ9RY4pC/xnDBF/IZL7fIbEPkA1w=;
        b=MJekDEVQsSRB4eY6OTsL2O699YY6G/KKqIciMwxR+NKEiSvNA3gKy0V00CUh2yzA6r
         9NGCVYbM8jzK4pQgauOwXPAXq6bGOkhwoTURTa2MeH8d5qnlH1jy3wtFK8YgEWufa7F5
         5zKMRW0IPnW09+G0EdNJynOLs3LxOpFs+pKQK4UEl3I27JFHht8IV8hQbOC0Cdt0nW6N
         tNz9JX5mnpBtBTuvT3e88gE7Ar5KdkfC46y7otNRtNGBDit9yj9heZIIVmrOVKy/y3dd
         8FdTlgoRS55i9asmEBWoEfrtXPU0J9w+pzJCQ+FSaQA734rw3fm6aIhPZ3r2lprgeadK
         CATA==
X-Gm-Message-State: AOPr4FU0nPpLsW91THQhjaBuKbbiABpLJW9xjCErHUn5QDHLMrUb+Nhvd1ZGD045E5DjxA==
X-Received: by 10.112.25.42 with SMTP id z10mr2649367lbf.63.1460983005065;
        Mon, 18 Apr 2016 05:36:45 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.85.4])
        by smtp.gmail.com with ESMTPSA id u10sm2867840lbu.13.2016.04.18.05.36.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Apr 2016 05:36:43 -0700 (PDT)
Subject: Re: [PATCH v2 03/13] MIPS: Remove redundant asm/pgtable-bits.h
 inclusions
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
References: <1460972133-16973-1-git-send-email-paul.burton@imgtec.com>
 <1460972133-16973-4-git-send-email-paul.burton@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-kernel@vger.kernel.org, Jonas Gorski <jogo@openwrt.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Alex Smith <alex.smith@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5714D4DB.8050606@cogentembedded.com>
Date:   Mon, 18 Apr 2016 15:36:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <1460972133-16973-4-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 4/18/2016 12:35 PM, Paul Burton wrote:

> asm/pgtable-bits.h is included in 2 assembly files and thus has to
> in either of the assembly files that include it.
 >

    Missed a line again? :-)

> Remove the redundant inclusions such that asm/pgtable-bits.h doesn't
> need to #ifdef around C code, for cleanliness & and in preparation for

    "& and"?

> later patches which will add more C.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Reviewed-by: James Hogan <james.hogan@imgtec.com>

[...]

MBR, Sergei
