Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2009 07:20:14 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:34219 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491944AbZKVGUH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Nov 2009 07:20:07 +0100
Received: by pxi3 with SMTP id 3so3307236pxi.22
        for <multiple recipients>; Sat, 21 Nov 2009 22:19:59 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=6CplcoNzTLyiMQiucYCWrd5mnXTgOAGtA/yOH3yFtF4=;
        b=Tq/qOlqTq1Q6v/29ZUWq5tVnXWbFuz8Jz9YIyJpVpVItI8B+NMuX1W25kc5sN0jTIQ
         EchhRiu8tmwJipAvxLXmb74VF2KJdBmIMuTG4eep6NyeC6SveY1DBTtC1ebZJIjzPn76
         VcyJ+73fyLPB89tYyJaJxytDp0PJmtlx1SL4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=vel+NNd38R8RcQa6aKhR0hD+6we9vlqHJBrdpoZRmZlvl3KdS1zIL19jNWKyPVRz0x
         lQar2sN8h6n7P16otf1iWHhiGDIPQBtEQZemS0u473PI5tCsPO1qvdy3fSj+aZPvEqO1
         c0YtasRrRI7wO09ViXpWNAT/v4AfVQBD6Vow4=
Received: by 10.114.237.37 with SMTP id k37mr5515011wah.31.1258870799389;
        Sat, 21 Nov 2009 22:19:59 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm2113899pzk.8.2009.11.21.22.19.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 22:19:57 -0800 (PST)
Subject: Re: [PATCH v9 07/10] tracing: add dynamic function graph tracer
 for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	rostedt@goodmis.org, Nicholas Mc Guire <der.herr@hofr.at>,
	zhangfx@lemote.com, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <20091120172438.GG6869@linux-mips.org>
References: <cover.1258719323.git.wuzhangjin@gmail.com>
	 <c08257b0ef370f6e04ff9719bf7499bae28c70f4.1258719323.git.wuzhangjin@gmail.com>
	 <20091120172438.GG6869@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Sun, 22 Nov 2009 14:19:37 +0800
Message-ID: <1258870777.2833.2.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-11-20 at 17:24 +0000, Ralf Baechle wrote:
> On Fri, Nov 20, 2009 at 08:34:35PM +0800, Wu Zhangjin wrote:
> 
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > This patch make function graph tracer work with dynamic function tracer.
> > 
> > To share the source code of dynamic function tracer(MCOUNT_SAVE_REGS),
> > and avoid restoring the whole saved registers, we need to restore the ra
> > register from the stack.
> > 
> > (NOTE: This not work with 32bit! need to ensure why!)
> > 

Hi, Ralf, Could you please remove the above "NOTE", just test your
-queue repository with the latest sched_clock() in 32bit, it works well.
so, that NOTE is out-of-date.

Thanks & Best Regards,
	Wu Zhangjin
