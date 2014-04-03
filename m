Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2014 05:06:25 +0200 (CEST)
Received: from mail-qg0-f51.google.com ([209.85.192.51]:43969 "EHLO
        mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671AbaDCDGFeFbow (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Apr 2014 05:06:05 +0200
Received: by mail-qg0-f51.google.com with SMTP id q108so1155656qgd.38
        for <multiple recipients>; Wed, 02 Apr 2014 20:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MYbGonDoN1B1FuwSEOMOrHKSWhwHM27OXVVOxm119Qk=;
        b=dDEBex+Ze1XsWYAhD60UxFk7dEz8P/z5yYN+N46rU3iQBB5PunUEXuMl79zy61r2+p
         gKHBtOVohy3LBhEGYMBcnVorCtDxiNhmjppEGvwU8y30cMzwLqugQz42KS3rJ1sp4+X0
         wnN5yk9GghPx4aTh+GSc6cnScMuWmOUYj7QngVaiqEazANlKul8NF/AFmfcYVturXcPs
         fObIvTy7cdDclsIzp0KXadUkfLe0nLSWSnNkPQAWKGDXe+mqhJUagyaFU3U0i9FPTM0d
         XR0hYxdgh/4wdYjmF6O8rY8UOwF6qoZluKcQKMzC7HxqKoxhHqeERWLpjsQtaLMzqVPl
         fDnw==
X-Received: by 10.140.94.116 with SMTP id f107mr4568488qge.64.1396494358703;
 Wed, 02 Apr 2014 20:05:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.207.65 with HTTP; Wed, 2 Apr 2014 20:05:38 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1404010020510.27402@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1404010020510.27402@eddie.linux-mips.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Wed, 2 Apr 2014 20:05:38 -0700
Message-ID: <CAEdQ38GaAvF+arbHQnuo3WJdeoKGUbUZ3dS+OQpffhi7dxvP+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: __delay CPU_DADDI_WORKAROUNDS bug fix
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Mon, Mar 31, 2014 at 4:57 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> linux-mips-delay-nodaddi-fix.patch
> Index: linux-20140329-4maxp64/arch/mips/lib/delay.c
> ===================================================================
> --- linux-20140329-4maxp64.orig/arch/mips/lib/delay.c
> +++ linux-20140329-4maxp64/arch/mips/lib/delay.c

No comments about the patch. I'm simply curious why you don't use git?
