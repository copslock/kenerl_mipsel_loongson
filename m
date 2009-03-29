Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 12:04:58 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:22395 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20031867AbZC2LEv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Mar 2009 12:04:51 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CA8A23EC9; Sun, 29 Mar 2009 04:04:48 -0700 (PDT)
Message-ID: <49CF55CD.5000201@ru.mvista.com>
Date:	Sun, 29 Mar 2009 15:04:45 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 5/6] Alchemy: don't unconditionally register all alchemy
 platform devices
References: <1237999773-5174-1-git-send-email-mano@roarinelk.homelinux.net> <1237999773-5174-2-git-send-email-mano@roarinelk.homelinux.net> <1237999773-5174-3-git-send-email-mano@roarinelk.homelinux.net> <1237999773-5174-4-git-send-email-mano@roarinelk.homelinux.net> <1237999773-5174-5-git-send-email-mano@roarinelk.homelinux.net> <1237999773-5174-6-git-send-email-mano@roarinelk.homelinux.net>
In-Reply-To: <1237999773-5174-6-git-send-email-mano@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

> Not every board may want to register all available alchemy drivers;
>   

   They only register devices, not drivers.

> besides it makes passing platform_data ugly since the device registration
> and its platform data are in separate files.  I don't like that.
>   

  I do like it. We've been doing the same with DaVinci/OMAP-L137 code 
now... :-)

> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>   

WBR, Sergei
