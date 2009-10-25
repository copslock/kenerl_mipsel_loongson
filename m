Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2009 15:23:00 +0100 (CET)
Received: from mail-px0-f187.google.com ([209.85.216.187]:53084 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492374AbZJYOWx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2009 15:22:53 +0100
Received: by pxi17 with SMTP id 17so566461pxi.21
        for <multiple recipients>; Sun, 25 Oct 2009 07:22:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Sau/RyEn42TsgodGkilMI9ZUiNRa8ZzmJDiHudxPAWc=;
        b=Dbg9cyK6xieS8w24+P/YHb7CCs5kwyRMrjWGzeuALFiesQfmYjQO0B4qzMvmpQKUVe
         Ti6wxySAU6jJBGGT9rOELpIpEFOt/Fh8vbQ6P/izzD2DGeEgaypvdWLWX0luEuK3Stez
         pZYhlDZbNP+jxGXUrw9PWMYjD90Zdwfz9FGnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=tNjvgXPO1zu1eQPVEbsJh1xkq6AbdXIFfyhfFI2yhXFu7/qYAQoGeYKXS6G74h4EdN
         jjgnL8TskI+S1Fx8KsDCjbUtFnre6bCtq0a9fkrETMnUjHTEmzz3DC50ShkuO5ZOqh+U
         m0QF37sMuTpHeeWcZb4qI0aiI+SLkaaqyJiak=
Received: by 10.114.3.29 with SMTP id 29mr20300825wac.208.1256480563063;
        Sun, 25 Oct 2009 07:22:43 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm756582pxi.9.2009.10.25.07.22.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 07:22:42 -0700 (PDT)
Subject: Re: [PATCH -v4 9/9] tracing: add function graph tracer support for
 MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Patrik Kluba <kpajko79@gmail.com>
Cc:	linux-kernel@vger.kernel.org,
	GCC Patches <gcc-patches@gcc.gnu.org>,
	Adam Nemet <anemet@caviumnetworks.com>, rostedt@goodmis.org,
	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>
In-Reply-To: <7a39cd850910250637h200e2dd2i4f725d55bb88c212@mail.gmail.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>
	 <af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com>
	 <a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com>
	 <53bdfdd95ec4fa00d4cc505bb5972cf21243a14d.1256135456.git.wuzhangjin@gmail.com>
	 <26008418.post@talk.nabble.com> <1256467717.6143.13.camel@falcon>
	 <7a39cd850910250637h200e2dd2i4f725d55bb88c212@mail.gmail.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sun, 25 Oct 2009 22:22:25 +0800
Message-Id: <1256480545.5874.11.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2009-10-25 at 14:37 +0100, Patrik Kluba wrote:
> On Sun, Oct 25, 2009 at 11:48 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> >
> > do you mean if enabling PROFILE_BEFORE_PROLOGUE, there will be some
> > problems with module support using -mlong-calls?
> >
> 
> No, there are no problems. I've tested it on friday, and function
> graph tracing was working correctly.
> I meant to say that 4.2.1 we use does not generate correct profile
> calls from kernel modules. Maybe this issue was fixed in newer
> releases, I did not check. I've applied a patch (don't remember where
> have I found that, maybe it was created by you) to our toolchain
> several months ago.

I have never sent a patch to gcc before :-) but perhaps somebody have
fixed it for us. so, the left job is hoping somebody enable
PROFILE_BEFORE_PROLOGUE for MIPS in the next version of gcc if there is
no side effect, and then we can hijack the return address of non-leaf &
leaf function directly in the same way in _mcount.

> 
> I was thinking about dynamic tracing, and I think a toolchain patch
> can be avoided completely. We only need to make difference between
> "jal _mcount" and "jalr v1"-style mcount calls when replacing them
> with "nop" instructions in the code-patching function called by
> ftrace_convert_nops(). This can be done in 2 ways:
> 1) keeping old instructions - takes extra memory, not an option
> 2) using 2 separate instructions to replace with. One of them could be
> the normal NOP instruction, which expands to "sll r0, r0, 0". For the
> other we could use "sll r0, r0, 1" but as it has already special
> meaning (SSNOP) a better candidate could be something like "sll r1,
> r1, 0". This way we can decide which instruction to patch in when
> tracing is enabled for a function, eg. when the code patcher
> encounters a "sll r0, r0, 0" it emits a function call using JAL and
> when it encounters "sll r1, r1, 0" it emits a function call using
> "JALR v1".

If only thinking about dynamic tracing, no patch for gcc needed,
-mlong-calls is enough, I have done it via a "stupid" trick, will send
the patchset out asap :-)

Regards,
	Wu Zhangjin
