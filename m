Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2014 14:31:00 +0100 (CET)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:59045 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012297AbaJaNa6enect (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2014 14:30:58 +0100
Received: by mail-wi0-f173.google.com with SMTP id n3so1312190wiv.12
        for <multiple recipients>; Fri, 31 Oct 2014 06:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5HdWq67Hy1P7VUSeMke4FuvLslly+7+kxDNbgsV+Gdo=;
        b=KzLRrbY7pXM/GE+o190wLcG3pRB58cQdJoUrqnLMZFY2+45v6A3wmixuQv4vPvKnYC
         /em/hzbbCxgFck/DjBq3TR9zqkVYvhvQAxM+9buR7o+Vc3ZuBDmf7bDzCBjzm+zzMBV2
         cHHbWkmoOGJ2zpwQsJl9rgSZtfDSGh9e93XA4YWFgZYtruJuKIEZuJi7Yez0t7RLifZW
         706F1ZRj86eOmV1seSrPcRhorddNPT6haHTtRwIyIviLNG1Fw8jNx7V/e73nSuDt945Q
         nmE43oVyoXk/J2DACBDvRbLpOERxCKqbHrGoyTvBDoksV6xzLTyeCmCk1wYBt00VlwTU
         FPQg==
X-Received: by 10.180.74.76 with SMTP id r12mr4064100wiv.6.1414762253281; Fri,
 31 Oct 2014 06:30:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.217.55.200 with HTTP; Fri, 31 Oct 2014 06:30:13 -0700 (PDT)
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320F603F9@LEMAIL01.le.imgtec.org>
References: <1414700683-121426-1-git-send-email-manuel.lauss@gmail.com>
 <54537551.6080404@imgtec.com> <6D39441BF12EF246A7ABCE6654B0235320F603F9@LEMAIL01.le.imgtec.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 31 Oct 2014 14:30:13 +0100
Message-ID: <CAOLZvyFkP-wDZcv4u9gbwciTeCpYg=khL48+cs3hAkdxauyYTg@mail.gmail.com>
Subject: Re: [RFC PATCH v5] MIPS: fix build with binutils 2.24.51+
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Okay, let me build a 64bit toolchain and I'll see what I can do about
that error.

Manuel
