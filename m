Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 23:43:56 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:61571 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903810Ab1KUWnq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 23:43:46 +0100
Received: by faar25 with SMTP id r25so8155111faa.36
        for <multiple recipients>; Mon, 21 Nov 2011 14:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Mhmf1v9O4gEn8SFS9HcVxetH2At4cphLnM2SQYopBOU=;
        b=uHpacWBBMLkwkCPx9oXt90GZdtY32heJKQgVnj1QWnVx3GiFL6z+zFSau6tJWSPIAx
         2gy5GH+sCBaMTrOKH4bvVZXYwJ29Wsw8Jt0QEroS/k0r7z5UgqYZEW7Jlxh3yw/Klbdo
         I/3dFycSnIsgEnm8HDn4S5y9E+M5zFNwcBrvA=
Received: by 10.180.105.102 with SMTP id gl6mr16112405wib.46.1321915421062;
 Mon, 21 Nov 2011 14:43:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.216.151.168 with HTTP; Mon, 21 Nov 2011 14:43:19 -0800 (PST)
In-Reply-To: <4ECACF68.3020701@gmail.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
 <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com>
 <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com> <4ECACF68.3020701@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Nov 2011 14:43:19 -0800
X-Google-Sender-Auth: 4nJ396d7TGSmnGCruP_G8itBPmE
Message-ID: <CA+55aFwZxqHfEOemj+OJNKCj2toqGf3rkK-9iuS39L7iZsoH1Q@mail.gmail.com>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and HPAGE_SIZE
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        linux-arch@vger.kernel.org, Robin Holt <holt@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17966

On Mon, Nov 21, 2011 at 2:23 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>
> This whole comment strikes me as somewhat dishonest, as at the time David
> Rientjes wrote it, he knew that there were dependencies on these symbols in
> the linux-next tree.
>
> Now we can add these:
> +#define HPAGE_SHIFT    ({ BUG(); 0; })
> +#define HPAGE_SIZE     ({ BUG(); 0; })
> +#define HPAGE_MASK     ({ BUG(); 0; })

Hell no.

We don't do run-time BUG() things. No way, no how.

If that #define cannot be used, then it damn well shouldn't be defined at all.

David's patch is clearly the right thing to do. Don't try to send me
the above kind of insane crap.

                     Linus
