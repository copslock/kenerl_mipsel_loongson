Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2010 12:11:49 +0100 (CET)
Received: from mail-fx0-f214.google.com ([209.85.220.214]:46728 "EHLO
        mail-fx0-f214.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493037Ab0AYLLq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jan 2010 12:11:46 +0100
Received: by fxm6 with SMTP id 6so1486420fxm.27
        for <linux-mips@linux-mips.org>; Mon, 25 Jan 2010 03:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=9/SLI+LIfTeFxA7xhvhJYowOG4m7+q3iRAgYvFfNyTs=;
        b=NjQwHhrTKoP0rnLx2QdrgvskwtOxY6nYfdCgo81t0W2PbuwJOJvlg0H3g6kyYlGARd
         JlFWLTGnPYlix6eHsn1T4Lp55hQ3Fg6WQg2Qlv59zujqbISs+YjM4xYmjk5gKPqryfcv
         REc9FDLxb653zVRvr7VZXxzpSxPAVNYXccZI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rYMrxd26KI3ONoc8sKqI7YEcuIYQ3X6e841XTLuoKV6VAThI05ch92+8+e0RsYWW3C
         39ITeAZHU9ry2vrNjPGm9rMqINweiVE9uVsa11OgurAIRM5e2GGRMKgHSkKlUfW1cFs2
         4xSPNI5O7FuaUpY1Oaw9dWgh6JELJU9bzOptc=
MIME-Version: 1.0
Received: by 10.223.95.74 with SMTP id c10mr6605925fan.82.1264417901033; Mon, 
        25 Jan 2010 03:11:41 -0800 (PST)
In-Reply-To: <6675c11001242150v44795f7axd4c9c09a5ed8a8ab@mail.gmail.com>
References: <6675c11001242150v44795f7axd4c9c09a5ed8a8ab@mail.gmail.com>
Date:   Mon, 25 Jan 2010 13:11:40 +0200
Message-ID: <90edad821001250311y33b79ab1m19dd201c52d38207@mail.gmail.com>
Subject: Re: binary concatenation
From:   Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:     hernan lopez pardo <hernanlopezpardo@gmail.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 25648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15911

On Mon, Jan 25, 2010 at 7:50 AM, hernan lopez pardo
<hernanlopezpardo@gmail.com> wrote:
> Hello, simple question
>
> $t1 = 101
> $t2 = 11
>
> How I do for concatenate $t1, $t2 for obtain $t3 = 10111 ?.

In pseudo-code:

shl t1, t1, 2
or t3, t1, t2

Hope that helps.

Dmitri
