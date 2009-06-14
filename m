Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jun 2009 14:35:36 +0200 (CEST)
Received: from mail-ew0-f221.google.com ([209.85.219.221]:55414 "EHLO
	mail-ew0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492081AbZFNMfa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Jun 2009 14:35:30 +0200
Received: by ewy21 with SMTP id 21so1704222ewy.0
        for <multiple recipients>; Sun, 14 Jun 2009 05:34:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=C8XidLopmqtuoN+vScvDWMSL/uAVHYnl28UvTLlxZWI=;
        b=g5/z9RAzxzcAPdwl0EoO6c84r3+dq2brgdTluXoA7t1Fi8gMwMh2rKjP/SHwJ6uOjk
         7iSZhOUpXxeBJQsjL+llSMdqAqSObzA0KMZGEOmzifIDAwL7CHcwvT4FO7Q4dMYCJoRz
         h45Yrdr8nDX3SvDatMZAhA1brm++xol1dyDRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Dt3HnN1JKUlRGAHSny6jra3co/CudyCevfqNsqTpXaQ5jI3/L3+9usWwLjhmj1KmOG
         ILhBWAONwR2fCKAvGiIkbTZpEvD+ZYKit2kOjYi7480cCfY88R7Kna8gMu8fdLpOmcnK
         pmXD8uX9enJV11ye0EPwlCaFTbZyGRi22L+6A=
Received: by 10.210.66.13 with SMTP id o13mr3451777eba.4.1244982895302;
        Sun, 14 Jun 2009 05:34:55 -0700 (PDT)
Received: from nowhere (ADijon-552-1-4-111.w92-138.abo.wanadoo.fr [92.138.19.111])
        by mx.google.com with ESMTPS id 10sm40599eyd.37.2009.06.14.05.34.53
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 05:34:54 -0700 (PDT)
Received: by nowhere (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128/128 bits))
	fweisbec@gmail.com; Sun, 14 Jun 2009 14:34:54 +0200 (CEST)
Date:	Sun, 14 Jun 2009 14:34:52 +0200
From:	Frederic Weisbecker <fweisbec@gmail.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-kernel@vger.kernel.org,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Wu Zhangjin <wuzj@lemote.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] tracing: fix undeclared 'PAGE_SIZE' in
	include/linux/trace_seq.h
Message-ID: <20090614123451.GA6039@nowhere>
References: <1244962350-28702-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1244962350-28702-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, Jun 14, 2009 at 02:52:30PM +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzj@lemote.com>
> 
> when compiling linux-mips with kmemtrace enabled, there will be an
> error:
> 
> include/linux/trace_seq.h:12: error: 'PAGE_SIZE' undeclared here (not in
> 				a function)
> 
> I checked the source code and found trace_seq.h used PAGE_SIZE but not
> included the relative header file, so, fix it via adding the header file
> <asm/page.h>
> 
> Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>
> Signed-off-by: Wu Zhangjin <wuzj@lemote.com>


Acked-by: Frederic Weisbecker <fweisbec@gmail.com>


> ---
>  include/linux/trace_seq.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
> index c68bccb..c134dd1 100644
> --- a/include/linux/trace_seq.h
> +++ b/include/linux/trace_seq.h
> @@ -3,6 +3,8 @@
>  
>  #include <linux/fs.h>
>  
> +#include <asm/page.h>
> +
>  /*
>   * Trace sequences are used to allow a function to call several other functions
>   * to create a string of data to use (up to a max of PAGE_SIZE.
> -- 
> 1.6.0.4
> 
