Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2009 12:06:33 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:47975 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492243AbZKLLG0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Nov 2009 12:06:26 +0100
Received: by pxi6 with SMTP id 6so1974126pxi.0
        for <multiple recipients>; Thu, 12 Nov 2009 03:06:15 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=sJLZBxUAEEKTRK7KlOedWuGY6rArQHaIocpxsg1DMY4=;
        b=goSJ31a3s2+OZLfdtkb1N9/vj3fpadPiWPWDWWVviAZHortpNXjNRDm2OWK5g5oFXK
         YQVHM1kiism9emGBdalg953TTMcyk0ptykkk61h7tFiFvSsY9ehkg9QBxW3iCuq4zMHf
         WVIPqpD9nWyXhUwNy8egnfB9/AsTNwdksobFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=iAcn9J5I7Iyx4FEZtfKu6hJoyzmTuku5ZKoFWZZ1IzvFzusiWJHBCdBHkU55nAuE/N
         VAtfBhCmAXm9LBqkBCIjqm2U8xx2pQME0LELfrjrRAG/s/beaJDablRMjBnGdTqrTqHU
         mn3gzo8G8r5b8CZT4d3gCXRlQXdgz2YxIPnS0=
Received: by 10.114.187.24 with SMTP id k24mr6034680waf.34.1258023974935;
        Thu, 12 Nov 2009 03:06:14 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm1593001pzk.5.2009.11.12.03.06.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 03:06:13 -0800 (PST)
Subject: Re: [PATCH v7 04/17] tracing: add static function tracer support
 for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org, zhangfx@lemote.com, zhouqg@gmail.com,
	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>
In-Reply-To: <cefe074f5eb3cfbc2e0bb41b0c1f61fcd0190d90.1257779502.git.wuzhangjin@gmail.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com>
	 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com>
	 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com>
	 <cefe074f5eb3cfbc2e0bb41b0c1f61fcd0190d90.1257779502.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Thu, 12 Nov 2009 19:06:05 +0800
Message-ID: <1258023965.3113.79.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, All

On Mon, 2009-11-09 at 23:31 +0800, Wu Zhangjin wrote:
[...]
> 
> And to support module tracing, we need to enable -mlong-calls for the
> long call from modules space to kernel space. -mlong-calls load the
> address of _mcount to a register and then jump to it, so, the address is
> allowed to be 32bit long, but without -mlong-calls, for the instruction
> "jal _mcount" only left 26bit for the address of _mcount, which is not
> enough for jumping from the module space to kernel space.
[...]
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
[...]
> +else
> +cflags-y := -mlong-calls
> +endif

Just made dynamic ftracer work without the above patch.

Will send it out as v8 later.

any more feedbacks to this v7 patchset?

Thanks & Regards,
	Wu Zhangjin
