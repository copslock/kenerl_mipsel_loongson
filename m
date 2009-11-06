Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 17:18:56 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.148]:50098 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492939AbZKFQSt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 17:18:49 +0100
Received: by ey-out-1920.google.com with SMTP id 26so252385eyw.52
        for <linux-mips@linux-mips.org>; Fri, 06 Nov 2009 08:18:47 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=QqzD6zHmfa1/WAXJ/NKaDumw9p2kslWA5L7MKQURKZ0=;
        b=YNZimz0ang+4LoHhxUKHp3/SaAaodzYwwN95OB/iIEAoV+aQFPPC1aIZQ6vBWLa8CJ
         i7jjNVfr7K8ikNjIVxmBDYod61Y5h2WbA44ObgEyaGTjODYOMmIor79WOjshbwXo6N+Q
         lukiKSawso8tx2Q89RJ9xddUBL9gNDViUkRVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=tYE1I+ymgC//CMps86AHthFPMw1ZhspHlDKt1u4jmSs55MEM6/0Y+2gbzcZjEJ4Z5w
         x1zd+szhK0INfmPaSU7tIRDMS2Q+V8Kb2ts8B5AlfONCo0ZKErX74zjFaNtGWMdkkD63
         I3ySLZ+JnxbxMRSgLnKE/GWDNhPhvYiJh0qh0=
Received: by 10.216.86.83 with SMTP id v61mr843927wee.80.1257524327540;
        Fri, 06 Nov 2009 08:18:47 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id q9sm386029gve.15.2009.11.06.08.18.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 08:18:46 -0800 (PST)
Subject: Re: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
References: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Sat, 07 Nov 2009 00:18:46 +0800
Message-ID: <1257524326.8766.8.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-11-07 at 01:08 +0900, Atsushi Nemoto wrote:
> Recently COMMAND_LINE_SIZE (CL_SIZE) was extended to 4096 from 512.
> (commit 22242681 "MIPS: Extend COMMAND_LINE_SIZE")
> 
> This cause warning if something like buf[CL_SIZE] was declared as a
> local variable, for example in prom_init_cmdline() on some platforms.
> 
> And since many Makefiles in arch/mips enables -Werror, this cause
> build failure.
> 
> How can we avoid this error?
> 
> - do not use local array? (but dynamic allocation cannot be used in
>   such an early stage.  static array?)
> - are there any way to disable -Wframe-larger-than for the file or function?
> - make COMMAND_LINE_SIZE customizable?
> - use non default CONFIG_FRAME_WARN?
> 
> Any comments or suggestions?

does "static" helps this problem?

Regards,
	Wu Zhangjin
