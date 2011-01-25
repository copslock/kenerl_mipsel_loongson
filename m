Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 13:15:58 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:56278 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491760Ab1AYMPz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 13:15:55 +0100
Received: by yxd30 with SMTP id 30so1311674yxd.36
        for <multiple recipients>; Tue, 25 Jan 2011 04:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=lyDwAla7Kr7OGNSHlGBo0r79yl/otVdaIQkRjeLN79E=;
        b=Ave5GH6NA8OcQPrhokIc6WEbbSdNeXOj7XD3vlkabZ0On0NrZ63rhVwfXQSXqNMdP1
         VnFeyNlLil5lBZvLuQGiOp1z13ZVOfV7gn5M3VqvoWSm6SZuXVuBTVBPFGgc4hm8WBfL
         dF93VdBVxbyxkV+visOl9FuTnGw7ut5xZA1ZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=kZNY5/HtJBHDfw+gBgu4U9ASNQ6POF/0vQI0lwGzS6HCHYkppF0ivfyy7Ik+DP558B
         Qm6JgCVQs5j0pRTtgdxTxXRQlDBSxQffeBemBt/ccjAcVVi9guho8xWbU7IMJoAsdY9B
         xaFsgsd446KipXVFH+qzp1n9/6IDJCfo8hHBA=
Received: by 10.150.11.2 with SMTP id 2mr6260437ybk.195.1295957749826;
        Tue, 25 Jan 2011 04:15:49 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id m49sm344249yha.2.2011.01.25.04.15.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 04:15:48 -0800 (PST)
Subject: Re: [PATCH 6/6] Cpu features overrides for msp platforms.
From:   Anoop P A <anoop.pa@gmail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <4D3EBD8F.2060608@mvista.com>
References: <1295943797-20467-1-git-send-email-anoop.pa@gmail.com>
         <4D3EBD8F.2060608@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 25 Jan 2011 18:02:03 +0530
Message-ID: <1295958724.27661.545.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2011-01-25 at 15:09 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 25-01-2011 11:23, Anoop P.A wrote:
> 
> > From: Anoop P A<anoop.pa@gmail.com>
> 
> 
> > Signed-off-by: Anoop P A<anoop.pa@gmail.com>
> [...]
> 
> > diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/cpu-feature-overrides.h b/arch/mips/include/asm/pmc-sierra/msp71xx/cpu-feature-overrides.h
> > new file mode 100644
> > index 0000000..a80801b
> > --- /dev/null
> > +++ b/arch/mips/include/asm/pmc-sierra/msp71xx/cpu-feature-overrides.h
> > @@ -0,0 +1,21 @@
> > +/*
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + *
> > + * Copyright (C) 2003, 04, 07 Ralf Baechle (ralf@linux-mips.org)
> 
>     If you're the author, how come it's Ralf's copyright here?

I just copied that file from some other platform. 

> 
> WBR, Sergei
