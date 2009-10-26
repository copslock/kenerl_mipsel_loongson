Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 01:43:01 +0100 (CET)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:55009 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492994AbZJZAmy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Oct 2009 01:42:54 +0100
Received: by fxm25 with SMTP id 25so11991110fxm.0
        for <multiple recipients>; Sun, 25 Oct 2009 17:42:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cT9xVAPofCEkWFyYALZUJSjI6B+hM5Ya1rxeJGBKWWk=;
        b=ckWUFh4HxjKLeeO2AAFfm6E8hwmubA/Ohc3NB0api/F2sXcR9IZrxz3dqZfHKW3Qro
         JnP8xpSDDdOv9AQ4TY71ez7zGqO1gIkJxZpk9seiKAn7XDsUV+W/I9Wx1VVHeOqUPF7V
         J+G/UNm28qR6+fjFSAp3FCM57FQLtZg1dgVX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Go6Z2AH26fE+XRbK9QCShYidFdl3crhnKrTRm3QvVCJ47ghqt7qa3z+JAwnbmwASVi
         4AbLFxDveNdQ7fTnrRKI/9d4Z9RX5SKVgAOD0KTN7nozuLjAeeMfdV7W6imcD+JLCkDZ
         5BrxcNpHo/4i6fp7kALSexkhwjC/eWsWaejRA=
MIME-Version: 1.0
Received: by 10.223.7.21 with SMTP id b21mr206271fab.104.1256517769501; Sun, 
	25 Oct 2009 17:42:49 -0700 (PDT)
In-Reply-To: <cover.1256482555.git.wuzhangjin@gmail.com>
References: <cover.1256482555.git.wuzhangjin@gmail.com>
Date:	Mon, 26 Oct 2009 01:42:49 +0100
Message-ID: <c62985530910251742n77dea8acgc00baf6a4075ee8d@mail.gmail.com>
Subject: Re: [PATCH -v5 00/11] ftrace for MIPS
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
Precedence: bulk
X-list: linux-mips

2009/10/25 Wu Zhangjin <wuzhangjin@gmail.com>:
> Under the help of the -mlong-calls option of gcc, This revision comes with the
> module tracing support. and there are also lots of cleanups and fixes.
> therefore, it is ready to upstream.
>
> Currently, function graph tracer support have some overhead for searching the
> stack address of the return address(ra). we hope the PROFILE_BEFORE_PROLOGUE
> macro will be enabled by default in the next version of gcc, and then the
> overhead can be removed via hijacking the ra register directly for both
> non-leaf and leaf function.
>
> Thanks very much to the people in the CC list for their feedbacks, all the
> lastest changes goes to this git repo:
>
> git://dev.lemote.com/rt4ls.git  linux-mips/dev/ftrace-upstream
>
> Welcome to play with it and give more feedbacks.
>
> Thanks & Regards,
>       Wu Zhangjin
>
> Wu Zhangjin (11):
>  tracing: convert trace_clock_local() as weak function
>  MIPS: add mips_timecounter_read() to get high precision timestamp
>  tracing: add MIPS specific trace_clock_local()
>  tracing: add static function tracer support for MIPS
>  tracing: enable HAVE_FUNCTION_TRACE_MCOUNT_TEST for MIPS
>  tracing: add an endian argument to scripts/recordmcount.pl
>  tracing: add dynamic function tracer support for MIPS
>  tracing: not trace mips_timecounter_init() in MIPS
>  tracing: add IRQENTRY_EXIT for MIPS
>  tracing: add function graph tracer support for MIPS


I can't find this one in the series. Did you forget it or am I somehow
missing it?

Thanks.
