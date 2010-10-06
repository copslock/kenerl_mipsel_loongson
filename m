Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2010 17:22:25 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:44943 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491041Ab0JFPWU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Oct 2010 17:22:20 +0200
Received: by pzk32 with SMTP id 32so3572035pzk.36
        for <multiple recipients>; Wed, 06 Oct 2010 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=iXp14WBDID+2aGz+eVl4yo3HrS8XLwtdI+PSMgqGtPY=;
        b=CKN4D2K6DlupTFgn2Zq59zE8wwvwJBLPmFwIIi8oUC+6wPEvRid8hsJ3PGiwU4MzSU
         puliTNVi6hV2y4SH5oV4DP92dEfrNkStkS8Qle6joPWPqR06cVPtnhQXfiwfHcD29uyP
         MMJYXJAttDhRBMg3zDzREzEgj31lOG4MAFzk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=IVFy7eugbt3b+epJtEejQoZ7Ai1mgp7RH0i+wRSZUDKnBW3u54F+QDTXtKiCpwHGF7
         2Ww2WX5qIZmcjSvUeOL8Ijwz4kQ106GmwcxTEO0txqBi6HAEtJ+4swM7Qqs0zLxcd40z
         tDyOUpzrWU2qq5XRmRn4MUP5yulOMGbxh2AWs=
Received: by 10.114.79.10 with SMTP id c10mr15518065wab.220.1286378533215;
        Wed, 06 Oct 2010 08:22:13 -0700 (PDT)
Received: from localhost (KD118154228076.ppp-bb.dion.ne.jp [118.154.228.76])
        by mx.google.com with ESMTPS id r37sm1580033wak.11.2010.10.06.08.22.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 08:22:11 -0700 (PDT)
Date:   Thu, 7 Oct 2010 00:25:54 +0900
From:   Adam Jiang <jiang.adam@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mips: irq: add stackoverflow detection
Message-ID: <20101006152554.GC13400@capricorn-x61>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
        Sergei Shtylyov <sshtylyov@mvista.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
References: <1286361676-10743-1-git-send-email-jiang.adam@gmail.com>
 <4CAC5537.9040904@mvista.com>
 <20101006112114.GA19856@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101006112114.GA19856@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jiang.adam@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.adam@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Oct 06, 2010 at 12:21:15PM +0100, Ralf Baechle wrote:
> On Wed, Oct 06, 2010 at 02:53:43PM +0400, Sergei Shtylyov wrote:
> 
> > >Add stackoverflow detection to mips arch
> > 
> >    There's no such word: stackoverflow. Space is needed.
> > 
> > >This is the 3rd version of the smiple patch. 2K is too big for many
> > >system, so I Modified the warning line by following Ralf's suggestion.
> > 
> > >Signed-off-by: Adam Jiang<jiang.adam@gmail.com>
> > [...]
> > 
> > >diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> > >index c6345f5..b43edb7 100644
> > >--- a/arch/mips/kernel/irq.c
> > >+++ b/arch/mips/kernel/irq.c
> > >@@ -151,6 +151,28 @@ void __init init_IRQ(void)
> > >  #endif
> > >  }
> > >
> > >+#ifdef CONFIG_DEBUG_STACKOVERFLOW
> > >+static inline void check_stack_overflow(void)
> > >+{
> > >+	unsigned long sp;
> > >+
> > >+	asm volatile("move %0, $sp" : "=r" (sp));
> > >+	sp = sp & THREAD_MASK;
> > 
> >    Why not:
> > 
> > 	sp &= THREAD_MASK;
> > 
> >    It's C, after all! :-)
> 
> I already had accepted his previous version with minor changes so I've
> combined the two.

Thanks Ralf. I am very glad I can do this small piece of code for Linux
kernel, though with many faults. :) No doubt I will try to do much more
then.

Best regards,
/Adam
