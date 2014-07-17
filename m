Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 00:30:09 +0200 (CEST)
Received: from mail-oa0-f51.google.com ([209.85.219.51]:40789 "EHLO
        mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861338AbaGQWaEUnHCR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 00:30:04 +0200
Received: by mail-oa0-f51.google.com with SMTP id o6so1771274oag.38
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=67Z7WJQliMtR5IoOm9xi1rg5HQtW9U8YdxHTAgbT9L0=;
        b=XTFVvdTS5ex2AG6mIoUxvfahqQg0KU0UKR6ozhJ51+/J0PwR8PnvocdvgeiDlgXEQ6
         IO8Vbmyl+xDyXRASdzc5/paTx5XYtAq+zQKcMT2QtHeGH78f9rYYGou2hsjiy4chIcKH
         6hjI5lBKX3kIsnwM9gL39gQ86axnvL4mr1TCWKd3XaElQhXV30UZ+9bR08ADV1tPvIFY
         A10g7zqWLzEgGiXybmM0X4jJF1jQdGi4ath79ubKAkZoHm1S3MCWuBTWJ83Hm2+064b0
         dt8Pc/FAMM2tTkbRKjHnvALuMs0+o/cAOlPGDFZDYijdbk6kzBK4rMkX+8O5usdz9DOC
         rt7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=67Z7WJQliMtR5IoOm9xi1rg5HQtW9U8YdxHTAgbT9L0=;
        b=n3KG8eIj7+CYJjIlHDmIuRvbj0W+jo4svkczRByO3AQgUCbeLq0ibRN77XKq2ho5B3
         u6po84WfdoEy3krZswo/KVK4ynCMN1yn5xs1HeVfaS18qYXgmbl7MtCcRa5RrqbP7JZI
         dPRLmeB2pyxaFiguhQrg8oOqE5z8gVyAU1yqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to:cc:content-type;
        bh=67Z7WJQliMtR5IoOm9xi1rg5HQtW9U8YdxHTAgbT9L0=;
        b=Cx+6EMBpyjH3mg5wcr5M0AuPRzKjmYUAFNS0nDWpIJRTQCHfhoxaUpMR/GVK8TtXlG
         wniKCgv22QBinekveGTnJBTCcSV5UnJzE9jYUs3/JYRluI0yjyAqbkRjRuqgRIWs5McW
         OBKUtgazXhnLuyraTzZZZeu9fhVA7HGW7cJW1knCyjcBp4zLXQ3RghZXC7uLb6O9gxSO
         OyEYR0FvYYP1O7gDtJh8+zcSyXul7r5Dp6zuAitKOn/fim7+fOPZGIQ/S8A1Pd8IaS6K
         TY9hzZQGyeYpd/IPdmKMvFsQ7vj8g5phyHe6GADEpRAAZDqrXFK665uU+fAei7H237s6
         Fc9Q==
X-Gm-Message-State: ALoCoQmX8/65VPpDBO7NGbGznV6Mhaz6rAxPGhlpNYcRDF/b1eF+3zepl5vCCU2Pw5L11SCUitqI
MIME-Version: 1.0
X-Received: by 10.182.81.99 with SMTP id z3mr240335obx.79.1405636197784; Thu,
 17 Jul 2014 15:29:57 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Thu, 17 Jul 2014 15:29:57 -0700 (PDT)
Date:   Thu, 17 Jul 2014 15:29:57 -0700
X-Google-Sender-Auth: NgsoIT7dFzFxC9ZjdvZBTKzELf8
Message-ID: <CAGXu5jJJ7dqC-or=ZhKKj8=eA5itKX4aLRsnxmFZvwnyRcrUrw@mail.gmail.com>
Subject: MIPS seccomp and changing syscalls
From:   Kees Cook <keescook@chromium.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

Hi,

I recently fixed a bug in seccomp on ARM that I think may be present
in the MIPS implementation too. In arch/mips/kernel/ptrace.c
syscall_trace_enter, the syscall variable is used (and returned), but
the syscall may be changed by either secure_computing or
tracehook_report_syscall_entry (via ptracers which can block and
change the registers). (I would note that "ret" is also set but never
used, so tracehook_report_syscall_entry failures actually won't get
noticed.)

The discussion about this bug on ARM is here:
https://lkml.org/lkml/2014/6/20/439

I don't yet have a working MIPS environment to test this on, but it
feels like the same bug. (Though, for testing, what's the right way to
change syscall during PTRACE_SYSCALL? On x86 it's the orig_ax
register, on ARM it's a arch-specific ptrace function
(PTRACE_SET_SYSCALL).

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
