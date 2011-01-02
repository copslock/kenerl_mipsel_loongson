Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jan 2011 11:14:26 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:34010 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491102Ab1ABJ72 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 2 Jan 2011 10:59:28 +0100
Received: by wwi17 with SMTP id 17so12675945wwi.24
        for <linux-mips@linux-mips.org>; Sun, 02 Jan 2011 01:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MAggJ9FNGjgV6OjB0u0xnM78pHkuUr2dlC9JfKfq31o=;
        b=rwCPJNgJoCwg+A5LhuCsOnGybIxaMuPEi1yZfzufHeJYGqXhjpHvB/5GAtLPeQ4om7
         fGAMfy+USiAVU6xxLeNrAAWBghuJFStNSVWrBDp+HetQY0MPwetfqE4tpcA6tErYION0
         XbwUVVDve9UvnWwFEXWqCfGDMBJKQHfz7X3tA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DbHunO4+6/OT8WFaEK6CDkebTVyl9GJROZX0a0uMWDMlxCFMnUN30FEDQR86JS9Jo0
         KjSBTa6HQAWJdhOHjxZY/0CziCb9KsDcJJl3YoT/DsVPx+TSous2oONu3NfNgBHuDLwd
         9GnuwASCvB9ItX6RXgzLI0YB0xT3Xm56vTyRs=
MIME-Version: 1.0
Received: by 10.216.177.9 with SMTP id c9mr20052715wem.34.1293962360939; Sun,
 02 Jan 2011 01:59:20 -0800 (PST)
Received: by 10.216.53.206 with HTTP; Sun, 2 Jan 2011 01:59:20 -0800 (PST)
In-Reply-To: <AANLkTims5ejcB8hmH5nE3zR5R_57oF88x=NS438ZOM3V@mail.gmail.com>
References: <AANLkTims5ejcB8hmH5nE3zR5R_57oF88x=NS438ZOM3V@mail.gmail.com>
Date:   Sun, 2 Jan 2011 17:59:20 +0800
Message-ID: <AANLkTimTXeyTdkPbSqeWDr+zGCBiz_BkCfMfh+uJXs16@mail.gmail.com>
Subject: Re: functions about dump backtrace function names in mips arch
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8BIT
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28784
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

stacktrace.c?


在 2011年1月2日星期日，loody <miloody@gmail.com> 写道：
>  Dear all:
>  If i remember correctly, when kernel panic there is a function I can
>  use to dump all the names of backtrace functions.
>  I have searched arch/mips/traps.c, but I only can see the dump
>  functions of cpu registers,
>
>  If my assumption is true, would anyone tell me what the name is or
>  what Doc I can looking for?
>  appreciate your help,
> miloody
>
>
