Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2006 10:10:12 +0100 (BST)
Received: from mx1.redhat.com ([66.187.233.31]:51158 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S20027619AbWH3JKK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 30 Aug 2006 10:10:10 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k7U9A2GE007031;
	Wed, 30 Aug 2006 05:10:02 -0400
Received: from pobox.surrey.redhat.com (pobox.surrey.redhat.com [172.16.10.17])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k7U9A0Yt012808;
	Wed, 30 Aug 2006 05:10:01 -0400
Received: from warthog.cambridge.redhat.com (warthog.cambridge.redhat.com [172.16.18.73])
	by pobox.surrey.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k7U99xMo004344;
	Wed, 30 Aug 2006 10:09:59 +0100
Received: from warthog.cambridge.redhat.com (localhost.localdomain [127.0.0.1])
	by warthog.cambridge.redhat.com (8.13.7/8.13.4) with ESMTP id k7U99sOM020540;
	Wed, 30 Aug 2006 10:09:54 +0100
From:	David Howells <dhowells@redhat.com>
In-Reply-To: <20060828085244.GA13544@flint.arm.linux.org.uk> 
References: <20060828085244.GA13544@flint.arm.linux.org.uk> 
To:	Russell King <rmk+lkml@arm.linux.org.uk>
Cc:	linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
	linuxppc-embedded@ozlabs.org, paulkf@microgate.com,
	takata@linux-m32r.org, linux-kernel@vger.kernel.org
Subject: Re: [CFT:PATCH] Removing possible wrong asm/serial.h inclusions 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date:	Wed, 30 Aug 2006 10:09:54 +0100
Message-ID: <20539.1156928994@warthog.cambridge.redhat.com>
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhowells@redhat.com
Precedence: bulk
X-list: linux-mips

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> --- a/arch/frv/kernel/setup.c
> +++ b/arch/frv/kernel/setup.c
> @@ -31,7 +31,6 @@
>  #include <linux/serial_reg.h>
>  
>  #include <asm/setup.h>
> -#include <asm/serial.h>
>  #include <asm/irq.h>
>  #include <asm/sections.h>
>  #include <asm/pgalloc.h>

Acked-By: David Howells <dhowells@redhat.com>
