Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 15:15:33 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:57366 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491015Ab0E0NP3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 15:15:29 +0200
Received: by gyb11 with SMTP id 11so4176045gyb.36
        for <multiple recipients>; Thu, 27 May 2010 06:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=bpqlMt05FZCyJomRqfRh5ng3sGQejAh6Sv1d9zpI0cQ=;
        b=dNF8umJTw+tL0agQH4vQn3XJqbb1mk+c0zV9p7Jd6k/5R/2twbHvKd3YfrQexbE6mX
         zP3hfAsRCDIEmGuiW2hKgigT62Xkne+RoM7HNEPZatzQX/iqdy+163PypcapLD/p62DC
         FV5LIhyJDfSkJoBEcSl7knAESdAcf6GJk/xYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=viNNElaen7P3fBGeqkFW4Hjo6/oFle2nZzSDIYPGpFhc5AHptgDkbi7YMrLuBFv8Kc
         sok7FCAbXlWbiG3iOUfiVVE0qcXURWk97P8lfxErW5ogsnVwhBuUMGwvJi0u9UsbeBj2
         kFqEq7B4cvJIS5q42YqZv2xzMF4l/jB+tg4do=
MIME-Version: 1.0
Received: by 10.150.252.8 with SMTP id z8mr164897ybh.3.1274966122160; Thu, 27 
        May 2010 06:15:22 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Thu, 27 May 2010 06:15:22 -0700 (PDT)
In-Reply-To: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
Date:   Thu, 27 May 2010 21:15:22 +0800
Message-ID: <AANLkTim3fLhGGSvuFGEJbAng0Nj3-aJE2dN8Cx2WJU_H@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] MIPS performance event support v5
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     dengcheng.zhu@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf


According to the feedback received during the development of the previous
versions of Perf-events, changes to the code are getting slight. So I
think it's a good time to ask you to help review the code.

The patches 1~7 can be reviewed/applied/tested independently. And 8~12 are
trying to make Oprofile use Perf-events framework as backend, and are
depended on perf_event_rm9000.c and perf_event_loongson2.c to be added in.


Thanks for your time,

Deng-Cheng
