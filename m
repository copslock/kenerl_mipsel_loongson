Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 12:34:16 +0100 (CET)
Received: from mail-ew0-f224.google.com ([209.85.219.224]:45975 "EHLO
        mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492507Ab0CILeN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Mar 2010 12:34:13 +0100
Received: by ewy24 with SMTP id 24so1006882ewy.27
        for <linux-mips@linux-mips.org>; Tue, 09 Mar 2010 03:34:06 -0800 (PST)
Received: by 10.213.37.82 with SMTP id w18mr4210152ebd.97.1268134446140;
        Tue, 09 Mar 2010 03:34:06 -0800 (PST)
Received: from [192.168.2.2] (ppp91-77-52-186.pppoe.mtu-net.ru [91.77.52.186])
        by mx.google.com with ESMTPS id 15sm3054865ewy.0.2010.03.09.03.34.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 03:34:05 -0800 (PST)
Message-ID: <4B963210.7030906@ru.mvista.com>
Date:   Tue, 09 Mar 2010 14:33:36 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: move MMC driver registration to board
 code.
References: <1268076181-29642-1-git-send-email-manuel.lauss@gmail.com> <1268076181-29642-3-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1268076181-29642-3-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

> Where it really belongs to.
>   

   I disagree (again). SoC platform devices dont belong with the board code.

WBR, Sergei
