Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 12:02:37 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:18043 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20030335AbZC2LCa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Mar 2009 12:02:30 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id E4C443EC9; Sun, 29 Mar 2009 04:02:25 -0700 (PDT)
Message-ID: <49CF553D.7070903@ru.mvista.com>
Date:	Sun, 29 Mar 2009 15:02:21 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/6] Alchemy updates for 2.6.30
References: <1237999773-5174-1-git-send-email-mano@roarinelk.homelinux.net>
In-Reply-To: <1237999773-5174-1-git-send-email-mano@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

> Here is another set of patches which aim to improve Alchemy and DB1200 support.
> (doesn't apply against Kevin Hickey's DB1300 patches)
>   

[...]

> #5    I dislike the alchemy/common/platform.c file because it makes passing
>       platform data to drivers ugly (the platdata struct and the consumer
>       are in different files)
>   

   I think it's rather smart scheme -- prevents duplication. Please 
don't change it.

>  and I also don't like the fact that every conceivable piece of alchemy hardware has a driver registered whether I like it or not.

   Only platform device, not the driver. User entirely controls what 
drivers are built.

> To not change existing behaviour, the platform.c file is now invoked by the board Makefiles instead of the one in common/.

WBR, Sergei
