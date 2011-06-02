Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2011 13:30:37 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:44576 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491187Ab1FBLad (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2011 13:30:33 +0200
Received: by wwb17 with SMTP id 17so657611wwb.24
        for <multiple recipients>; Thu, 02 Jun 2011 04:30:27 -0700 (PDT)
Received: by 10.216.143.74 with SMTP id k52mr617037wej.0.1307014227664;
        Thu, 02 Jun 2011 04:30:27 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.103.177])
        by mx.google.com with ESMTPS id t79sm267935weq.29.2011.06.02.04.30.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 04:30:25 -0700 (PDT)
Message-ID: <4DE7741B.7040507@mvista.com>
Date:   Thu, 02 Jun 2011 15:29:31 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
MIME-Version: 1.0
To:     ralf@linux-mips.org
CC:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [patch 12/14] i8253: Move remaining content and delete <asm/i8253.h>
References: <20110601180456.801265664@duck.linux-mips.net> <20110601180610.913463093@duck.linux-mips.net>
In-Reply-To: <20110601180610.913463093@duck.linux-mips.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1675

Hello.

On 01-06-2011 22:05, ralf@linux-mips.org wrote:

> There is no really good other place but one line for two out of three
> architectures that have a <asm/i8253.h> file doesn't justify this files
> existence.

    I couldn't parse that. :-)

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> To: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-mips@linux-mips.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org

WBR, Sergei
