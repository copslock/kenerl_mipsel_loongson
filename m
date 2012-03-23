Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2012 16:53:47 +0100 (CET)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:41401 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903645Ab2CWPxa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2012 16:53:30 +0100
Received: by wgbdr12 with SMTP id dr12so1964615wgb.24
        for <multiple recipients>; Fri, 23 Mar 2012 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=VPhYLDJPneZ0P6gUrHlX4wNILCSqKg2JnH1/69P/D1E=;
        b=NZ1TIEjBRDu84cRGMu9AJcr8oIA7vPg2SYucnn4kUBpZkzS38aiADGwL6Js3Fs4yKa
         NA8SIsRh7xKB8Ga/t7pMuS5/Y3p7/g2UZLOC4ii2jD5nSn3t+eyHnXzOF3CQVm2LlI6D
         YC1/V8JW/AdPi8DluT+fts3aOnv5Q0lydA4mMzy+DmxSPrEbfStKN83UP+K3/csXF/4r
         9gfQbwpSD1KSbNPxK2JnKltkXbk5IEXMl2+JQjwErr8VGvImAA6CDxpAnXHkbOqXz/Sr
         ymyLdjRcqgLPRBEqGsAjP5U7QdKBdVwRUmHP46cg6RW7Exjnk+cmgIiz2DNaNve06yJ7
         ZobQ==
Received: by 10.180.96.228 with SMTP id dv4mr7691118wib.14.1332518005089; Fri,
 23 Mar 2012 08:53:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.180.103.163 with HTTP; Fri, 23 Mar 2012 08:53:04 -0700 (PDT)
In-Reply-To: <4F6C170A.4070305@linux.vnet.ibm.com>
References: <20120322095502.30866.75756.sendpatchset@codeblue> <4F6C170A.4070305@linux.vnet.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Mar 2012 08:53:04 -0700
X-Google-Sender-Auth: 6YL5vu6hVji0V6UpdjbHWigOhqc
Message-ID: <CA+55aFyOMzHJgVU4MivMnUovF7+obxBE2-paq5h+hX_vsq3wzQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] config: simplify INLINE_SPIN_UNLOCK
To:     Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Mar 22, 2012 at 11:24 PM, Raghavendra K T
<raghavendra.kt@linux.vnet.ibm.com> wrote:
>
> Linus, Please let me know if this is what you were looking for or Did I
> really mess it up :(

Yeah, this was what I was looking for. It seems much simpler to me,
and allows the individual odd config options to just do the "select
uninline" instead of having to have some complex logic about other
config options in the inlining option itself.

                   Linus
