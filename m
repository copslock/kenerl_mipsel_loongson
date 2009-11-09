Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 15:35:43 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:48329 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492713AbZKIOfg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 15:35:36 +0100
Received: by pwi15 with SMTP id 15so1986792pwi.24
        for <multiple recipients>; Mon, 09 Nov 2009 06:35:29 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=QNukXmdIEjGLhTEjg/CB3rMDHkyS30iLIB1RFDRiPxM=;
        b=RA3bCcEhfuRLPV/IqDDx9WDwbdGMvyl1rRwdhL/+wYshqtTtAiS7NmtrOre+un1Jjd
         GwMIVrqh4i8O3uLVwDjxQwX75Cm+rlGNxYs130vSkVAfhjf9K+4JGgfz2PIZNmrfgW7w
         +yMu0kwOx962yylkcbMTlW3KHVcScOEHdTxNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=YrP1anj1s52MjWaY6mM2NyrKAglHiQESqWyXLsVOXh1liEw+vXetQbvVwkKo5MPtDE
         eNS6wgFT3rjKsNv4ofI5JH5h8Pca+5J5vm606mxITZ7ChLVXubMMsfZLM6tO6tQzS+Ok
         srdoAajWuL6sgvulOSZKWEcoIhcfNEh+TeW/c=
Received: by 10.114.2.38 with SMTP id 38mr101547wab.64.1257777329483;
        Mon, 09 Nov 2009 06:35:29 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1991436pzk.2.2009.11.09.06.35.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:35:28 -0800 (PST)
Subject: Re: [PATCH -v5 08/11] tracing: not trace mips_timecounter_init()
 in MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Steven Rostedt <rostedt@goodmis.org>
Cc:	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
In-Reply-To: <1257771288.2845.11.camel@frodo>
References: <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
	 <3e0c2d7d8b8f196a8153beb41ea7f3cbf42b3d84.1256483735.git.wuzhangjin@gmail.com>
	 <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com>
	 <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com>
	 <72f2270f7b6e01ca7a4cdf4ac8c21778e5d9652f.1256483735.git.wuzhangjin@gmail.com>
	 <cover.1256483735.git.wuzhangjin@gmail.com>
	 <6140dd8f4e1783e5ac30977cf008bb98e4698322.1256483735.git.wuzhangjin@gmail.com>
	 <49b3c441a57f4db423732f81432a3450ccb3240e.1256483735.git.wuzhangjin@gmail.com>
	 <c62985530910251727o23beafcco539870e4b2f84637@mail.gmail.com>
	 <1256550156.5642.148.camel@falcon>  <20091102214351.GI4880@nowhere>
	 <1257741072.3451.27.camel@falcon.domain.org>
	 <1257771288.2845.11.camel@frodo>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Mon, 09 Nov 2009 22:35:20 +0800
Message-ID: <1257777320.3451.132.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 2009-11-09 at 07:54 -0500, Steven Rostedt wrote:
[...]
> 
> Just do it in the Makefile. We can add __arch_notrace, and then in the
> Makefile define it with the arch.
> 
> ifeq ($(ARCH), MIPS)
> 	CFLAGS_foo.o = -D__arch_notrace=notrace
> endif
> 
> And we can simply define __arch_notrace in a header:
> 
> #ifndef __arch_notrace
> # define __arch_notrace
> #endif
> 
> I much rather uglify the Makefile than the code. 
> 

Seems can not totally avoid the problem mentioned by Frederic, that is
if there are two many functions in the file, and different platforms
care about different functions ;) 

what about Frederic's __time, just replace that __arch_notrace by
__time_notrace, and only consider the time relative functions currently?
Seems this will really make the stuff simpler.

Regards,
	Wu Zhangjin
