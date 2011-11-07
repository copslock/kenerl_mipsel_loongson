Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2011 03:11:15 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:54530 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904218Ab1KGCLH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2011 03:11:07 +0100
Received: by faaq17 with SMTP id q17so6026765faa.36
        for <multiple recipients>; Sun, 06 Nov 2011 18:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=I8dTfWIy7m9ma+zddz/sC4ebo+630Ih9aGSSoenRoBQ=;
        b=GKiZogJQY199bcD6y68EyZLdw0GcT6ycq37QU+Ni2u4uIGFZDDonaN/1K0JoCalgt0
         +AujMgc3YVA+/lT9nJNTsYLyh3W+QieAIBccm8NhvRjI6ZB9vQck5aRcsSo4tjAuwRrx
         +Kyo79YY3EqYcnO8Ii1soqpCfVmFD3hjmzMAc=
Received: by 10.223.81.196 with SMTP id y4mr43501866fak.6.1320631861807;
        Sun, 06 Nov 2011 18:11:01 -0800 (PST)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id p14sm29246209faf.20.2011.11.06.18.10.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 18:10:58 -0800 (PST)
Date:   Mon, 7 Nov 2011 10:10:48 +0800
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-mips@linux-mips.org, sfr@canb.auug.org.au
Subject: Re: [PATCH 12/49] MIPS: irq: Remove IRQF_DISABLED
Message-ID: <20111107021048.GA3027@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
References: <1319277421-9203-1-git-send-email-yong.zhang0@gmail.com>
 <1319277421-9203-13-git-send-email-yong.zhang0@gmail.com>
 <20111104122106.GA7581@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20111104122106.GA7581@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4910

On Fri, Nov 04, 2011 at 12:21:06PM +0000, Ralf Baechle wrote:
> Thanks, queued for 3.3.  I resolved a conflict in dbdma.c and remove
> one IRQF_DISABLED which had been missed in arch/mips/kernel/perf_event.c.

Thanks, Ralf.

And FYI, my patch is based on next-20111014 when I made it.

Seems Stephen Rothwell(Cc'ing) meet some conflict. Could
you please visit it?

Thanks,
Yong
