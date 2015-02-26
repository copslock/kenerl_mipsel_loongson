Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 21:04:19 +0100 (CET)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:38430 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007479AbbBZUESJvAyZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 21:04:18 +0100
Received: by iecrd18 with SMTP id rd18so20346256iec.5;
        Thu, 26 Feb 2015 12:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qo0cpqHDCUGPG9oOBDbbhdnIu4JawwGhaGuEfnXxGlY=;
        b=CAfTV/weeKITHo39zLlP9nd5DL61pBCurv6gymbiF9j0T2/Z0PQKDab9LO2Sq8tL5o
         ns0mMI4SzTDsfdO1X6texgdYIJT6jVbCuaJZZRqbpHWdMkPWa1GPzXEi7uLKT9oJgvKS
         sYZnwrYPgMp0SXVfsOd07/jfHhYcMDrVJ5GiDG5vTbzScJOqdlfNjTqnQi866TFpUCct
         RWoal4qt+1pkhFvYhgBd9UbOOD9Fnb4zC2Prmo1Sn+E4gF4eAR1SXdo4LO1E9x69Lquj
         UGMOMqlH+LgW5L7vQqlkvS4+ore4VI3NTsB2GflWnmjg+J4pl6aCHjvsyFqZBPBB5TlF
         dCtg==
X-Received: by 10.43.107.196 with SMTP id dz4mr12000434icc.54.1424981052527;
        Thu, 26 Feb 2015 12:04:12 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id o8sm12112469igp.11.2015.02.26.12.04.11
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 26 Feb 2015 12:04:12 -0800 (PST)
Message-ID: <54EF7C3A.3030202@gmail.com>
Date:   Thu, 26 Feb 2015 12:04:10 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH V6 1/3] MIPS: Rearrange PTE bits into fixed positions.
References: <1424977294-49507-1-git-send-email-Steven.Hill@imgtec.com> <1424977294-49507-2-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1424977294-49507-2-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46009
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

On 02/26/2015 11:01 AM, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@imgtec.com>
>
> This patch rearranges the PTE bits into fixed positions for R2
> and later cores. In the past, the TLB handling code did runtime
> checking of RI/XI and adjusted the shifts and rotates in order
> to fit the largest PFN value into the PTE. The checking now
> occurs when building the TLB handler, thus eliminating those
> checks. These new arrangements also define the largest possible
> PFN value that can fit in the PTE. HUGE page support is only
> available on 64-bit platforms.
>
> The new layouts of the PTE bits are the following:
>
>     64-bit, R1 or earlier:     CCC D V G [S H] M A W R P
>     32-bit, R1 or earler:      CCC D V G M A W R P
>     64-bit, R2 or later:       CCC D V G RI XI [S H] M A W R P
>     32-bit, R2 or later:       CCC D V G RI XI M A W R P
>
> In the case of cores that support the RI/XI bits, the value of
> the R bit is ignored.
>

Why not just use RI for everything, instead of taking up two bits to 
represent a single binary concept?

For the case where there is no RI hardware active, it is a purely 
software bit and you can easily invert the meaning and just have a 
_PAGE_NO_READ bit.

Also how does this change interact with __swp_type/_swp_offset/__swp_entry?

David Daney
