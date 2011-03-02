Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2011 18:36:33 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:44153 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491182Ab1CBRga (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2011 18:36:30 +0100
Received: by bwz1 with SMTP id 1so394569bwz.36
        for <multiple recipients>; Wed, 02 Mar 2011 09:36:23 -0800 (PST)
Received: by 10.204.61.10 with SMTP id r10mr251899bkh.195.1299087383496;
        Wed, 02 Mar 2011 09:36:23 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id x6sm138173bkv.0.2011.03.02.09.36.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2011 09:36:22 -0800 (PST)
Message-ID: <4D6E7FBC.6040805@mvista.com>
Date:   Wed, 02 Mar 2011 20:34:52 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org> <1298996006-15960-6-git-send-email-blogic@openwrt.org> <4D6E286D.9050100@mvista.com> <20110302142933.GA18221@linux-mips.org>
In-Reply-To: <20110302142933.GA18221@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>> +	switch (cmd) {
>>> +	case WDIOC_GETSUPPORT:
>>> +		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
>>> +				sizeof(ident)) ? -EFAULT : 0;

>>    Doesn't copy_to_user() return 0 or -EFAULT?

> No and that's a common cause of bugs.  copy_{from,to}_user returns the
> number of characters that could be be copied so the conversion to an
> error code is needed here.

    But then the code above would be wrong. Actually, it returns the number of 
bytes that could NOT be copied as I now see.

> The function takes a void argument and there is no benefit from casting
> to the full struct watchdog_info __user * pointer type other than maybe
> clarity to the human reader.

    Indeed.

>   Ralf

WBR, Sergei
