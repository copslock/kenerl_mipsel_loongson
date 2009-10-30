Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2009 03:16:31 +0100 (CET)
Received: from mail-iw0-f195.google.com ([209.85.223.195]:45934 "EHLO
	mail-iw0-f195.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492913AbZJ3CQY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2009 03:16:24 +0100
Received: by iwn33 with SMTP id 33so1828525iwn.21
        for <linux-mips@linux-mips.org>; Thu, 29 Oct 2009 19:16:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=o4NfNjxtRR8nwS+veC4K11pMwDICyPmyJiKmEXsZDfg=;
        b=c/XUr7gEqLtuSF3tGyvAHbbEzOc6Xp7aqEIcSo2to3PAtwbhWnX1RKI9FK4xwcoewd
         pN8hZS81xABGEhbkQtLX/LSsYII1FF22zFhORFcrUhpjtlUlvB1BCz+qWxnOYgCK2dEX
         63R8j+W8i5PuAOzk8xolv/tDMOXpf3NR9O2Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=VFFCltLBsjyySUUmzHhJTyccjad0CZ5Fv4hcu/giqICapXGM8Bk9j6RapQfP9Exrn5
         V69hKIisBtEq3R0MwcR5ZMTKL2g+jinngl8YPmCxEdrLFbU/MzmW9ig7qV0U8aL1aRaJ
         1RixbnofkTh/ih2yWduU9VRfj71dUfu39ZE1k=
MIME-Version: 1.0
Received: by 10.231.81.148 with SMTP id x20mr2591453ibk.2.1256868974864; Thu, 
	29 Oct 2009 19:16:14 -0700 (PDT)
In-Reply-To: <1256797212-7794-1-git-send-email-wuzhangjin@gmail.com>
References: <1256797212-7794-1-git-send-email-wuzhangjin@gmail.com>
Date:	Fri, 30 Oct 2009 10:16:14 +0800
Message-ID: <a2dc26810910291916x1556eb21uecaa8bdeeb98baae@mail.gmail.com>
Subject: Re: [PATCH -v1] MIPS: a few of fixups and cleanups for the compressed 
	kernel support
From:	Chih-hung Lu <winfred.lu@gmail.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <winfred.lu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: winfred.lu@gmail.com
Precedence: bulk
X-list: linux-mips

2009/10/29 Wu Zhangjin <wuzhangjin@gmail.com>:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
>
> This patch indents the instructions in the delay slot of the file which
> has a ".set noreorder" added.
>
> and also, the "addu a0, 4" instruction is replaced by "addiu a0, a0, 4".
Hi,

May I ask a question,
what is the difference between "addu a0, 4" and "addiu a0, a0, 4"?
They look same to me.
Thank you.

Regards,
Winfred Lu
