Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2014 14:31:17 +0100 (CET)
Received: from mail-lb0-f175.google.com ([209.85.217.175]:61663 "EHLO
        mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825729AbaAMNbNwzDPE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jan 2014 14:31:13 +0100
Received: by mail-lb0-f175.google.com with SMTP id w6so5285165lbh.20
        for <linux-mips@linux-mips.org>; Mon, 13 Jan 2014 05:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=fB6ewQq00a9RqzWR35XoeiXUh8jhRokjsPJKA+NpgSo=;
        b=PfUT+1zBvEroRH9F7GoEo6wAQBuEq1Ft6L/S0fIgquv9WqPknviEeL6f46UN39EMsp
         u8HBQvkUXch2C+1PNiyYKvI/vhzWWgrdMtcZoNZzPhPeKZDeOVn3e1sLt4m2UpGlmpNE
         5gbxp3xhprryXkzmjBGcCx/P8+0owIpUrZlSyn6PitZsQ26ZOM+YlkijArWSqz5aUWi8
         +h3oeNIsq8WuabzGVFM0ehFYJhwmquGfgXmoTaisKowBcw7ATk8SLJuFsDi2WWC7vaZ7
         b9AxMQnQym4itRCsozwAP9+7Nm+hfwYOF5/gU3r0xbWN1pHVO2F7V57PKWA7Fd/DGewg
         2Aeg==
X-Gm-Message-State: ALoCoQm7GH7Axluroom6WH3mQJDH+N8n70ftuNND8Dn0OhRDowlVPafXl6FT9yZhpJmD4JUwjcxY
X-Received: by 10.112.131.103 with SMTP id ol7mr304396lbb.72.1389619867413;
        Mon, 13 Jan 2014 05:31:07 -0800 (PST)
Received: from [192.168.2.4] (ppp91-76-81-163.pppoe.mtu-net.ru. [91.76.81.163])
        by mx.google.com with ESMTPSA id tc8sm9656488lbb.9.2014.01.13.05.31.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 Jan 2014 05:31:07 -0800 (PST)
Message-ID: <52D3EA9B.6020404@cogentembedded.com>
Date:   Mon, 13 Jan 2014 17:31:07 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Alexandre Oliva <oliva@gnu.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [3.13-rc regression] Unbreak Loongson2 and r4k-generic flush
 icache range
References: <ord2jwnmwd.fsf@livre.home>
In-Reply-To: <ord2jwnmwd.fsf@livre.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 13-01-2014 15:26, Alexandre Oliva wrote:

> Commit 14bd8c08, that replaced Loongson2-specific ifdefs with cpu tests,

    Please also specify that commit's summary line in parens.

> inverted the CPU test in local_r4k_flush_icache_range.  Loongson2 won't
> boot up using the generic icache flush code.  Presumably other CPUs
> might face other problems when presented with Loongson2-specific icache
> flush code too.  This patch enabled my Yeeloong to boot up successfully
> a 3.13-rc kernel for the first time, after a long git bisect session.

> Signed-off-by: Alexandre Oliva <lxoliva@fsfla.org>

    Fix for this issue has been posted long ago:

http://marc.info/?l=linux-mips&m=138575576803890

WBR, Sergei
