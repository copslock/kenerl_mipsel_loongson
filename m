Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 12:35:16 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:26492 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022109AbZC2LfJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Mar 2009 12:35:09 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 074603EC9; Sun, 29 Mar 2009 04:35:06 -0700 (PDT)
Message-ID: <49CF5CE6.1070003@ru.mvista.com>
Date:	Sun, 29 Mar 2009 15:35:02 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] Alchemy: platform updates
References: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net>
In-Reply-To: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

> Patch overview:
>
> #1: eliminate alchemy/common/platform.c.  Add platform device
>     registration to all boards instead.
>   

  I'm strongly voting against this, as it causes totally unneeded code 
duplication. Please don't apply.

>     I realize this is a lot of (needless) code duplication at first,
>     but it seems a lot cleaner to me if each board registered the
>     devices it needs/wants.
>   

   No, it's certainly a step backwards. You could make the common code 
more flexible by checking what devices are enabled and registering them 
selectively as I have already suggested several months ago. That would 
be the clean solution unlike your code bloat.

WBR, Sergei
