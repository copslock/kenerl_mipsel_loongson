Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2011 13:19:31 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:39574 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491013Ab1CNMT2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Mar 2011 13:19:28 +0100
Received: by vws8 with SMTP id 8so2471435vws.36
        for <linux-mips@linux-mips.org>; Mon, 14 Mar 2011 05:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Ny2wlvJPZ3YRD6KvjbKm0oEl2qHVcOrRSpJRYIOv0Ig=;
        b=aq0xF0cIJXmd3F/5br9yKaWg6Nc33yp16oDpl0xcX0cqtC3YXDNSfEtnLOmZ5E7f+F
         MOlgOUCfv91h/G1RtY90p+qRNLxkvqG2Y+UDqJODux4hjp8xua/EwD9PsGQlpspZiy6N
         gwbYCTHA3tR3zKBFxGXYpNvYIfNrdCegMjgWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GyTO1NQ/DjlWVVE0pakZLNB3+sQ4CWfhxTYqRZ9iuPRqRwE4+WXjKEurl7Z/tkH4f2
         EEV3WoN2LSEMrw+Qwy9Gx/b/4MV8HJofjzSRAH3/nlh8tOjocqjr1tvw3Et/iS69gXID
         eiHyPNhUeLnbsvdXzqMYee3O3Lhav+ai65SD0=
MIME-Version: 1.0
Received: by 10.52.98.97 with SMTP id eh1mr9797842vdb.148.1300105162751; Mon,
 14 Mar 2011 05:19:22 -0700 (PDT)
Received: by 10.52.157.36 with HTTP; Mon, 14 Mar 2011 05:19:22 -0700 (PDT)
In-Reply-To: <20110312182714.GC2217@jayachandranc.netlogicmicro.com>
References: <20110312182714.GC2217@jayachandranc.netlogicmicro.com>
Date:   Mon, 14 Mar 2011 20:19:22 +0800
Message-ID: <AANLkTime__o2bGyUn1-CsY4O=VhniN14u_fHYYxYz=VQ@mail.gmail.com>
Subject: Re: [PATCH] Support for Netlogic XLR/XLS processors
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Will kexec be supported on XLS/XLR/XLP ?
