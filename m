Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2010 18:18:47 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:38954 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491141Ab0LYRSo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Dec 2010 18:18:44 +0100
Received: by wyf22 with SMTP id 22so7570327wyf.36
        for <multiple recipients>; Sat, 25 Dec 2010 09:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=gvFWB3qtNkfbl4ok3C1oNvCAiIlcDRf+WZ627HIo494=;
        b=vCQEyQRqZUyw7mfP/0KJPJQsFq8BMVsqVEg1I14YuLXIfPqlZbv4IgdJHS4lFunN2Y
         NkXxZxgSdxngzJ4pA/oBj8VY9MqpbbT8AVUQo17oNWFh9Eqku3fiKdz0JotKLekUG0tV
         4vvnadCCRkpCZcXXJAA0WzdBxDlVT/qJ+FOpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KImrnIDfbybhOrwkaOtegknub48jvlpZUeszDvVaQeIwDOYqVP0gZ+ahRn5mIGfcBk
         8p1L25Rsyew3f5OxLRW8LNNeT0EkwhFd3I3Js0M/C3PGbBgw7h2GzyAz6pv7w4+0Aja9
         AuL+7lXD03y2N87maG6ak12ZRn7tY2a8ev/9A=
MIME-Version: 1.0
Received: by 10.216.139.224 with SMTP id c74mr2526503wej.50.1293297518496;
 Sat, 25 Dec 2010 09:18:38 -0800 (PST)
Received: by 10.216.131.88 with HTTP; Sat, 25 Dec 2010 09:18:38 -0800 (PST)
In-Reply-To: <1293290876-11731-1-git-send-email-wuzhangjin@gmail.com>
References: <1293290876-11731-1-git-send-email-wuzhangjin@gmail.com>
Date:   Sun, 26 Dec 2010 01:18:38 +0800
Message-ID: <AANLkTimk6Z8qVHeRxrCpUp6pqKjoLh+AGOD-RNsnea3H@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add current_cpu_prid() to optimize the code generation
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

The 2nd revision will be sent out with some enhancement and more
comments, so, please ignore this one.

Regards,
Wu Zhangjin

On Sat, Dec 25, 2010 at 11:27 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> current_cpu_prid(), cpu_prid_comp(), cpu_prid_imp() and cpu_prid_rev()
> are added to simplify/beautify the c->processord_id related code, as a
> result, the code generation will be optimized.
