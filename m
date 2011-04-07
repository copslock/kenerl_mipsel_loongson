Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2011 16:31:52 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:42475 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491061Ab1DGObt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2011 16:31:49 +0200
Received: by fxm14 with SMTP id 14so2173143fxm.36
        for <multiple recipients>; Thu, 07 Apr 2011 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:reply-to:to:cc:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=KxTrPM2+kPlXwbMKmyrGzRGA1y12cmEGiOM7lJ3iXzM=;
        b=avJhd2HY4Saicfdd+rj96V1IO9zBmdVujWavjCguz/J1udm41PookyX4Oo0bo1kUtt
         UvB7BRs3NqH9EVqZmsTbkaoJ6QUdB80p22mz5QYwz3u3lXNvzOqW7IodAL5tCe3MGwnH
         MK5LxlxHvE9jnGgbUItRu/iPToJrM+M2RyZOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=VqwGwd1wgGgue1cPRh6X566Tdibm53nbCEtMahq+C3EVov/1yCXaT2FxaTKlxVsi86
         r1kMxXGDq+T2YaX6HI4Z25ZbiJM6Nl5qRSDuCwq9BLfuvF/F7/i6wZ9gpT1CW4JFH0G+
         L2/oSHjaRpbLRD6gfO7k55MU0oFY58TzJfy2M=
Received: by 10.204.19.3 with SMTP id y3mr823269bka.180.1302186704533;
        Thu, 07 Apr 2011 07:31:44 -0700 (PDT)
Received: from ?IPv6:::1? (shutemov.name [188.40.19.243])
        by mx.google.com with ESMTPS id w3sm1111404bkt.5.2011.04.07.07.31.42
        (version=SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 07:31:43 -0700 (PDT)
Subject: Re: [PATCH V8] MIPS: lantiq: add NOR flash support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <john@phrozen.org>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mtd@lists.infradead.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <4D9DCA62.2070606@phrozen.org>
References: <1302013192-8854-1-git-send-email-blogic@openwrt.org>
         <4D9DC4B7.2080706@mvista.com> <1302185823.2407.48.camel@localhost>
         <4D9DC904.1040105@openwrt.org>  <4D9DCA62.2070606@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 07 Apr 2011 17:28:59 +0300
Message-ID: <1302186539.2407.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
Content-Transfer-Encoding: 8bit
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2011-04-07 at 16:29 +0200, John Crispin wrote:
> On 07/04/11 16:24, John Crispin wrote:
> > On 07/04/11 16:17, Artem Bityutskiy wrote:
> >> I've taken this patch to l2 tree, but I can change it with a new version
> >> easily.
> >>
> >>
> >>   
> > let me fold the proposed changes into the patch, specially the typos :)
> > 
> > 
> 
> Hi,
> 
> forgot to mention, this patch should go upstream via the MIPS tree

Oh, then I'm dropping it.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
