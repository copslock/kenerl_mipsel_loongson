Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 13:47:10 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.188]:25580 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20024744AbXIDMrA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Sep 2007 13:47:00 +0100
Received: by nf-out-0910.google.com with SMTP id 30so1440252nfu
        for <linux-mips@linux-mips.org>; Tue, 04 Sep 2007 05:47:00 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PLmKz/QyMIPfLenvOFbMWe3R8LNRdIU6wpwzqHwumqDQO86LLvz8ukkP8InmNHPn1NrofOkzSNfAqQeMBO3quZpGLtJssg5E9RVazNLaiLFO4bN/+PS2lFNXqc67CQi77gzmhTlLFX52Z8yfpxYKYxjRuae9z4IwGCVzQaZmKqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OnIU74j3M6zx2b68QV2lARv39PwHYYsY+1M4HvHdAs0sggZoXDX8QpPXWMDMxIKecJk4M9J1ue75mpIo4QqJAzxy74Z5qQvY/ydsRs74RAUbF5PIbLfaPj76JzBmv7zQK65pDDUDODsejKSsKG5eEFkXD+YBssNLKEd03tOMS2Y=
Received: by 10.86.93.17 with SMTP id q17mr4296934fgb.1188910020329;
        Tue, 04 Sep 2007 05:47:00 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id k29sm8116855fkk.2007.09.04.05.46.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Sep 2007 05:46:59 -0700 (PDT)
Message-ID: <46DD53BE.2070004@gmail.com>
Date:	Tue, 04 Sep 2007 14:46:54 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: flush_kernel_dcache_page() not needed ?
References: <46D8089F.3010109@gmail.com>	<20070903.225239.61509667.anemo@mba.ocn.ne.jp>	<46DC29F0.3060200@gmail.com> <20070904.005400.52128244.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070904.005400.52128244.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Indeed.  But copy_strings() is not rare case (called on each execve),
> so there might be some constraints which make us free from the
> aliasing problem.

The point is that this _generic_ function has been created so we need
to understand if MIPS architecture needs to implement it or not,
whatever its current usages. This was actually what I was trying to
understand with this thread.

Whatever the constraints, they don't seem to be intended at all since
flush_kernel_dcache_page() is called... So even if the current code is
working fine, it seems very fragile _if_ MIPS needs to implement this
cache helper.

> I'll look at it further, but any testcase are welcome.

One thing you might want to try is:

	$ echo 0 > /proc/sys/kernel/randomize_va_space

and see if your system still works fine. This command should avoid a
data cache flush when moving the stack around. See shift_arg_pages().

With this, maybe you could give this testcase a try:

	$ /bin/echo "`seq 10000`" > seq.txt

and see if seq.txt is correct. This command should pass to echo (not
the bash builtin one) a long argument that should fill your
dcache.

That said the execve syscall code is quite 'hairy' and it may not be
suprising that after this syscall the dcache has been completly
flushed and thus make the problem disappear.

		Franck
