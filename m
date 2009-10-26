Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 15:25:40 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:61313 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493074AbZJZOZd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 15:25:33 +0100
Received: by pzk32 with SMTP id 32so9216356pzk.21
        for <multiple recipients>; Mon, 26 Oct 2009 07:25:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=j5dXQrJt6P69e35OZdBcbL4Zl2D0v7U0t+RUPVQKWEQ=;
        b=Wq1pvTlJS6AnrLiNDpfcprB6YuFxrJCT1c4V0auG0SdsViT7YG1QD4rZ4FH0Mzi8X/
         ljwdOZJoFhWCf+CJO6asDjmBCsOh2JBiZTHruBZxUH2+uL7qo9VBrIcZ5tKrCfLRyz58
         /OF+xk8sYv+8+MRIjAqMoXiVX5E68gknB6Xqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=KrWKvOSQmFaHcCt43nTBIItf69z9IiPjUJm5WjfaJklUPozsYgk7v1pbvtXBmG1nwX
         WxkohomDfpfUWbA1VmRtEIaACeASb7X4pRCLiEaBtS441ugf8Q4OEVKpgRYmLtg5x+Zh
         xJR8tMQEbyTbOG2UOEIgmp8qtncIvPmcgJA+w=
Received: by 10.114.30.7 with SMTP id d7mr23038187wad.30.1256567124133;
        Mon, 26 Oct 2009 07:25:24 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm253922pzk.1.2009.10.26.07.25.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 07:25:23 -0700 (PDT)
Subject: Re: [PATCH -v5 02/11] MIPS: add mips_timecounter_read() to get
 high precision timestamp
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	rostedt@goodmis.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Frederic Weisbecker <fweisbec@gmail.com>
In-Reply-To: <1256565667.26028.257.camel@gandalf.stny.rr.com>
References: <cover.1256482555.git.wuzhangjin@gmail.com>
	 <028867b99ec532b84963a35e7d552becc783cafc.1256483735.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
	 <1256565667.26028.257.camel@gandalf.stny.rr.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Mon, 26 Oct 2009 22:25:08 +0800
Message-Id: <1256567108.5642.165.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 2009-10-26 at 10:01 -0400, Steven Rostedt wrote:
[...]
> Some patches touch core tracing code, and some are arch specific. Now
> the question is how do we go. I prefer that we go the path of the
> tracing tree (easier for me to test).

Just coped with the feedbacks from Frederic Weisbecker.

I will rebase the whole patches to your git repo(the following one?) and
send them out as the -v6 revision:

git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git tip/tracing/core

>  But every patch that touches MIPS
> arch, needs an Acked-by from the MIPS maintainer. Which I see is Ralf
> (on the Cc of this patch set.)
> 

Looking forward to the feedback from Ralf, Seems he is a little busy.
and also looking forward to the testing result from the other MIPS
developers, so, we can ensure ftrace for MIPS really function!

Welcome to clone this branch and test it:

git://dev.lemote.com/rt4ls.git  linux-mips/dev/ftrace-upstream

And this document will tell you how to play with it:
Documentation/trace/ftrace.txt

Thanks & Regards,
	Wu Zhangjin
