Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 02:15:31 +0200 (CEST)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33419 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029173AbcELAP2S4Ava (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 02:15:28 +0200
Received: by mail-pa0-f67.google.com with SMTP id gh9so4632068pac.0;
        Wed, 11 May 2016 17:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=hwdSuWLNj6jcjbxSJ6ElvxPeAUuaYKCvqIKzSdENk4A=;
        b=a11oKknYruJkR8tqUfcbyIOy9R5lBX2XQIR77oEfQOCX1pWKQnHV/1gHBQ57/7nhYo
         3knrrb2EPd/zeb20E+nJ9xi7KLnw8imky7zxVbw8uK2UDZ1x1dkhbvf4Rqr3N3J9tBew
         mS9HtGtY6X0tQfgFy1a8J/aDyOKCSouDwxlz640l7khNEit5BWQWzDWqBkWNmyILwhkX
         162mJxXkvQ7r+HTH33efb04Jep1WbRyz6JBBr8T1UykYIic5aQJy0nSLFa9K0dsoeYzD
         HIXqLrtVwphYi/zJ5CqcZ3C7Nz0SHVSUw3rhzakG+tiQRCU0dWi8YfVZaKT9ZXboJpJe
         Txkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=hwdSuWLNj6jcjbxSJ6ElvxPeAUuaYKCvqIKzSdENk4A=;
        b=R5Uczm84T+ybkKpon/hNHOPzY9WtiDoL5ziOc9BXRbbg8jerlcx9pSHqrroyTXNdR9
         q2I0NtKV8gcZnYACekRcrA6734T04PIqyvvqHLQ4D/M+/m2fAgoM5Ma82bWtflv+u1/7
         CoFEGDYjFDLPq4O9dOwmtIsXvXkyXXY+9Uim99v+s6vI8fxJKpkxyJ52cp6Q5HQ5a6fg
         rjjrsaFwoLU5OI3DtWyYuBGpuTUhOwvsApSD7Dh3UBpmbSpUZQ7qoqK8t3yWF5XiIT8W
         dLXuJT/CUhbqe9gq8UMGF47zY/OR/UHGaRnP4XaatIDHBRnwbZMDVyc7emxSnJLUOUw4
         PV+A==
X-Gm-Message-State: AOPr4FWk7QqeMng1QB/lVL9rPdoauUvcoD+SAVb+osPex4x9a26Xc1XPR9Hveskw3aGTVA==
X-Received: by 10.66.231.73 with SMTP id te9mr9380077pac.62.1463012122156;
        Wed, 11 May 2016 17:15:22 -0700 (PDT)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id v185sm14869758pfb.72.2016.05.11.17.15.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 May 2016 17:15:20 -0700 (PDT)
Message-ID: <5733CB17.9000904@gmail.com>
Date:   Wed, 11 May 2016 17:15:19 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 3/6] MIPS: Add guest CP0 accessors
References: <1462978232-10670-1-git-send-email-james.hogan@imgtec.com> <1462978232-10670-4-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1462978232-10670-4-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53387
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

On 05/11/2016 07:50 AM, James Hogan wrote:
> Add guest CP0 accessors and guest TLB operations along the same lines as
> the existing macros and functions for the root CP0.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

Not tested, but this looks correct.

We are tying ourselves to binutils versions that understand the "virt" 
instructions, but that is probably OK.

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/include/asm/mipsregs.h | 341 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 330 insertions(+), 11 deletions(-)
>
[...]
