Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 03:10:25 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:61364 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493478AbZKICKS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 03:10:18 +0100
Received: by ewy12 with SMTP id 12so2853651ewy.0
        for <multiple recipients>; Sun, 08 Nov 2009 18:10:11 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=+WrPRlO4P9cpE3gY3O6uBwhwLeIyBGAQLXj6m/J5WyA=;
        b=do4QebKyVs7Iouj+MJIioHPMXrYbJYPKPzMHCTfitb8h8XsOJFPWb45iRiA5AFJIi1
         VU8XBxxlllSqx167QzQcrgS9zcgqNo82IxvQbQjPqWSvMXZDIyNWvsQbypMv1nv3IplS
         lPIfo11XBZDRxWxfTT/PATdKgBW1EGYviCnXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qxrPxYA9r99mUwTrKJAkijIUFB+NcxqW8ADhfuwAcRBxktPuizBRB+I7TiagPL9MYQ
         wv7C2xo6XBmWm3i0q2fa77tzy7B0gnntplgcwQkE3JcyqGFMTFiHhjNZFjx7neivOJFz
         2YqPVXmxs1qQHpjY5vMw6eAz0eoXX6QfZGLZk=
Received: by 10.216.88.202 with SMTP id a52mr2362570wef.101.1257732611281;
        Sun, 08 Nov 2009 18:10:11 -0800 (PST)
Received: from nowhere (ADijon-552-1-106-222.w90-33.abo.wanadoo.fr [90.33.185.222])
        by mx.google.com with ESMTPS id 10sm4966144eyd.8.2009.11.08.18.10.07
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 18:10:08 -0800 (PST)
Received: by nowhere (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128/128 bits))
	fweisbec@gmail.com; Mon,  9 Nov 2009 03:10:14 +0100 (CET)
Date:	Mon, 9 Nov 2009 03:10:12 +0100
From:	Frederic Weisbecker <fweisbec@gmail.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Subject: Re: [PATCH -v6 01/13] tracing: convert trace_clock_local() as weak
	function
Message-ID: <20091109021009.GB13153@nowhere>
References: <cover.1256569489.git.wuzhangjin@gmail.com> <747deea2f18d5ccffe842df95a9dd1c86251a958.1256569489.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <747deea2f18d5ccffe842df95a9dd1c86251a958.1256569489.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Oct 26, 2009 at 11:13:18PM +0800, Wu Zhangjin wrote:
> trace_clock_local() is based on the arch-specific sched_clock(), in X86,
> it is tsc(64bit) based, which can give very high precision(about 1ns
> with 1GHz). but in MIPS, the sched_clock() is jiffies based, which can
> give only 10ms precison with 1000 HZ. which is not enough for tracing,
> especially for Real Time system.
> 
> so, we need to implement a MIPS specific sched_clock() to get higher
> precision. There is a tsc like clock counter register in MIPS, whose
> frequency is half of the processor, so, if the cpu frequency is 800MHz,
> the time precision reaches 2.5ns, which is very good for tracing, even
> for Real Time system.
> 
> but 'Cause it is only 32bit long, which will rollover quickly, so, such
> a sched_clock() will bring with extra load, which is not good for the
> whole system. so, we only need to implement a arch-specific
> trace_clock_local() for tracing. as a preparation, we convert it as a
> weak function.
> 
> The MIPS specific trace_clock_local() is coming in the next two patches.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>


Yep, if trace_clock_local() had to be a strict alias
to sched_clock(), we would have simply used sched_clock().

If an arch need to implement it another way, then yeah making
it weak is a good thing.

Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
