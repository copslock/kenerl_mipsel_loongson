Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 12:34:45 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:52921 "HELO
        imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with SMTP id S1492628AbZLHLel (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 12:34:41 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
        by imap.sh.mvista.com (Postfix) with SMTP
        id E8A163ED9; Tue,  8 Dec 2009 03:34:25 -0800 (PST)
Message-ID: <4B1E39B3.5000207@ru.mvista.com>
Date:   Tue, 08 Dec 2009 14:34:11 +0300
From:   Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH resend] MIPS: more replace CL_SIZE by COMMAND_LINE_SIZE
References: <20091208165844.ddd9106f.yuasa@linux-mips.org> <20091208172444.9e48afe7.yuasa@linux-mips.org>
In-Reply-To: <20091208172444.9e48afe7.yuasa@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Yoichi Yuasa wrote:
> Sorry, I forgot one more CL_SIZE.
>   

   You should put such notes under the --- tearline, not into the patch 
description.

> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---

WBR, Sergei
