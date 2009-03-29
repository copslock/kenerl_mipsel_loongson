Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 12:37:09 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:31612 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023362AbZC2LhC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Mar 2009 12:37:02 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 2E9F13EC9; Sun, 29 Mar 2009 04:37:00 -0700 (PDT)
Message-ID: <49CF5D58.70907@ru.mvista.com>
Date:	Sun, 29 Mar 2009 15:36:56 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/3] Alchemy: get rid of common/platform.c
References: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net> <1238318822-4772-2-git-send-email-mano@roarinelk.homelinux.net>
In-Reply-To: <1238318822-4772-2-git-send-email-mano@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:
> Move device registration out of common/platform.c into the individual
> boards' platform.c files.
>
> Every board should register the devices it wants to use (i.e. on one
> of my Au1200 systems UART1 is unused [pinmux problems] and its
> functionality is provided by an external device.  This also results
> in a completely useless ttyS1 entry; I want this entry gone without
> having to add a lot more #ifdef <platform> lines to common/platform.c).
>   

  No #ifdef's would be needed at all if you check what devices are 
enabled before registering.

> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>   

   NAK.

WBR. Sergei
