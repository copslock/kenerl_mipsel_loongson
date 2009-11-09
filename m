Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 12:53:16 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:60798 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492497AbZKILxJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 12:53:09 +0100
Received: by ewy12 with SMTP id 12so3144975ewy.0
        for <multiple recipients>; Mon, 09 Nov 2009 03:53:03 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=GAwjg/DDm6HMGzISlvwJc9e34jHJkJpGFWWyx2jyEeM=;
        b=H58w08NY2ZpEX/qTzC1VtvNhyzJNN+Pre8ecYcc15Mah8Fvpg++3328Fh+diFiuYmW
         dpOxSnBQin39aSqXsMzW0aFPwCV99YHFyuG+5648CNPQct4Z/N5R2X/eGJ3JVzSJ7tBG
         c3S3P+xiKStIOJoIgosf6bnalcjIlBoo+ky/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=svLAzQjd0sYCKZMUX4GPzkN5dyorQLlGzsEYWxCq/1EgqVmTMc9APEZ2sPTvrG4s0P
         /JAIB2JG4jyglbr5NQQMInLGgODWhYtwEdsQUyrpHmmdN7UMgi6BLxhfaK+zVBaLHtSG
         qDdjxp8EiQTccIaNwV1Z+SiI8W/r/zJ+F2fdQ=
Received: by 10.213.102.65 with SMTP id f1mr3205017ebo.61.1257767582885;
        Mon, 09 Nov 2009 03:53:02 -0800 (PST)
Received: from nowhere (ADijon-552-1-106-222.w90-33.abo.wanadoo.fr [90.33.185.222])
        by mx.google.com with ESMTPS id 7sm6072152eyg.33.2009.11.09.03.53.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 03:53:01 -0800 (PST)
Received: by nowhere (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128/128 bits))
	fweisbec@gmail.com; Mon,  9 Nov 2009 12:53:07 +0100 (CET)
Date:	Mon, 9 Nov 2009 12:53:05 +0100
From:	Frederic Weisbecker <fweisbec@gmail.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Subject: Re: [PATCH -v5 08/11] tracing: not trace mips_timecounter_init()
	in MIPS
Message-ID: <20091109115303.GB5206@nowhere>
References: <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com> <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com> <72f2270f7b6e01ca7a4cdf4ac8c21778e5d9652f.1256483735.git.wuzhangjin@gmail.com> <cover.1256483735.git.wuzhangjin@gmail.com> <6140dd8f4e1783e5ac30977cf008bb98e4698322.1256483735.git.wuzhangjin@gmail.com> <49b3c441a57f4db423732f81432a3450ccb3240e.1256483735.git.wuzhangjin@gmail.com> <c62985530910251727o23beafcco539870e4b2f84637@mail.gmail.com> <1256550156.5642.148.camel@falcon> <20091102214351.GI4880@nowhere> <1257741072.3451.27.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257741072.3451.27.camel@falcon.domain.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Nov 09, 2009 at 12:31:12PM +0800, Wu Zhangjin wrote:
> I think if we use something like __mips_notrace here, we may get lots of
> __ARCH_notraces here too, 'Cause some other platforms(at least, as I
> know, Microblaze will do it too) may also need to add one here, it will
> become:
> 
> __mips_notrace __ARCH1_notrace __ARCH2_notrace .... foo() {...}
> 
> A little ugly ;)


Yeah :)
I thought Mips would be the only one to do that.

 
> and If a new platform need it's __ARCH_notrace, they need to touch the
> common part of ftrace, more side-effects!
> 
> but with __arch_notrace, the archs only need to touch it's own part,
> Although there is a side-effect as you mentioned above ;)
>
> So, what should we do?
> 
> Regards,
> 	Wu Zhangjin
>

Why not __time ?
As it's normal that such few functions that are used to read the timecounter
have fair chances to be __no_trace on archs like MIPS. Interested
archs would just need to override a default stub __time.
