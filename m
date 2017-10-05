Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 09:58:34 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:35182
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbdJEH61T1IAc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 09:58:27 +0200
Received: by mail-wr0-x241.google.com with SMTP id y44so4123117wry.2;
        Thu, 05 Oct 2017 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iyubx1KQ7TyStQ7ljkvx1oVzAfp0b0bdlo9lWsTqsQM=;
        b=USYwBSE2JlH1WwRljSi4T3F0nMo8demgyS0krxhBWduZdzLy42+lCmy4ZKikMyi9O9
         IscSO+tnHguzEXo/s1kJdmLgGjZTyliMEFqh4VfpGaSc8JVfZ+2oqL+vskTtJLqlgwhB
         TqP2QL+jBnPh539lHDFl4r/JxwpApyuNhTC5BtrM1uKd6ZK+kpZETdOeEsW3nFYQHWIK
         jwY+vNlZcDMVHkIztdO1QzvzGgQm9G3ItCZ+WB5braWI9Ek17q3e92uVgYAJ2Qsmoeb7
         /qy9Ohkr4aN+EGy0/zAbtE0aI5GhuGVX+sANyTBtcREsQ98SBhwmqijkXiXana8qekGl
         7X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iyubx1KQ7TyStQ7ljkvx1oVzAfp0b0bdlo9lWsTqsQM=;
        b=awD4lIAJDbAM4eDmdQfQzNgCkmu1L0WHr/qgv3P40+2ZVn/wksiPi/dIwU1SBOg1fg
         SIztzcgLhIS4NObS23gWK1KnrKOEMVhZeSMr5yfR9VjWNaT/9CHSp6L7OosLttbBA44c
         9C8cCCxmnnV1eJU2+4TgkacNL7+0fo/DgoiK++PXrg0hC3BQkgj3g6wJ45eloIGkAZXj
         dw9T53mbL/nSSqGy7wm9dTwgU7H+2MgfuRiEEVB+VEY10dTAzSjP/59B1xvjOff5j2q4
         ifA1kFi9VG8DT7VpuI+zxd1Q6cWROPwsXy8mublG/FzrPFdc6ZVMZGcJelOcfL1opySC
         2tdA==
X-Gm-Message-State: AHPjjUgAHsvC9YagN/QIyDJLz189PwmGV95610Els/pF0HHmBy0PuWoI
        YcM+5fvpo0p/JWts+Z6BIVo=
X-Google-Smtp-Source: AOwi7QAcTo/57QMLjJ7QHNXDtcxNhPD8M7ATmG/yWTSOdKpZ+icEJ70iQyrQymO9LM/dgipN+8pSOA==
X-Received: by 10.223.157.142 with SMTP id p14mr21187720wre.104.1507190301889;
        Thu, 05 Oct 2017 00:58:21 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i13sm13198176wre.93.2017.10.05.00.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 00:58:21 -0700 (PDT)
Date:   Thu, 5 Oct 2017 09:58:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH] mm, arch: remove empty_bad_page*
Message-ID: <20171005075819.nehorwiced7emgfi@gmail.com>
References: <20171004150045.30755-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004150045.30755-1-mhocko@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Michal Hocko <mhocko@kernel.org> wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> empty_bad_page and empty_bad_pte_table seems to be a relict from old
> days which is not used by any code for a long time. I have tried to find
> when exactly but this is not really all that straightforward due to many
> code movements - traces disappear around 2.4 times.
> 
> Anyway no code really references neither empty_bad_page nor
> empty_bad_pte_table. We only allocate the storage which is not used by
> anybody so remove them.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: <uclinux-h8-devel@lists.sourceforge.jp>
> Cc: <linux-mips@linux-mips.org>
> Cc: <linux-sh@vger.kernel.org>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

For the x86 bits:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
