Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Sep 2011 04:48:25 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:33264 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490953Ab1IXCsS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Sep 2011 04:48:18 +0200
Received: by yxi11 with SMTP id 11so3760073yxi.36
        for <multiple recipients>; Fri, 23 Sep 2011 19:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=U0xBISoedDuwV1b+ZzE+1xdWQT3YXwXZVwDkKqNpYkA=;
        b=Vjaa5ZrdP0c/kDh5sCh+Ot5omnrDwdMhalt2dmAWWnxnwSRN/OAW/UdedzwASMqtJN
         1sAxbBTr5TPWzbHiRCR6XLDTcBsymtPL2Dq9Xe5sDXs+URN2gN0WyvCVZQ3KP4C/01o6
         gbHjwzkFAetX/aCWgLIvF+uihTCWbCKQCVX2A=
MIME-Version: 1.0
Received: by 10.236.129.165 with SMTP id h25mr25809775yhi.38.1316832492519;
 Fri, 23 Sep 2011 19:48:12 -0700 (PDT)
Received: by 10.236.69.232 with HTTP; Fri, 23 Sep 2011 19:48:12 -0700 (PDT)
In-Reply-To: <1316712727-7478-1-git-send-email-david.daney@cavium.com>
References: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
        <1316712727-7478-1-git-send-email-david.daney@cavium.com>
Date:   Sat, 24 Sep 2011 10:48:12 +0800
Message-ID: <CAOfQC9_qZe5UjXUxSiBAitJFPqYgvLOFCZHxXRUsCKV+aMar-g@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] MIPS: perf: Cleanup formatting in arch/mips/kernel/perf_event.c
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: multipart/alternative; boundary=20cf301af35ff2005404ada6f42b
X-archive-position: 31144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13760

--20cf301af35ff2005404ada6f42b
Content-Type: text/plain; charset=ISO-8859-1

2011/9/23 David Daney <david.daney@cavium.com>

> Get rid of a bunch of useless inline declarations, and join a bunch of
> improperly split lines.


This looks good.


Deng-Cheng

--20cf301af35ff2005404ada6f42b
Content-Type: text/html; charset=ISO-8859-1

<div class="gmail_quote">2011/9/23 David Daney <span dir="ltr">&lt;<a href="mailto:david.daney@cavium.com">david.daney@cavium.com</a>&gt;</span><br><blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
Get rid of a bunch of useless inline declarations, and join a bunch of<br>
improperly split lines.
</blockquote><div><br>This looks good.<br><br><br>Deng-Cheng<br><br></div></div>

--20cf301af35ff2005404ada6f42b--
