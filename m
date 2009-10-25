Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2009 14:37:21 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:52571 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492344AbZJYNhN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2009 14:37:13 +0100
Received: by bwz21 with SMTP id 21so1576660bwz.24
        for <multiple recipients>; Sun, 25 Oct 2009 06:37:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=2QNJxoBczyo0+PwwlAFKopZadxel7WmrhVfEoOUVNrw=;
        b=DCaI8c9eEcjpNX/UWbdG+2Nyf5bsZqI5H3NZ/qwtUE9BadTsEjCqSUn2WkYtjzPROr
         0HCMCy8pi41WHgWkI+QxzB5hCKvqbBnxqmpHL4JnzCbwct1FoIKvZ6DrwjkalujR8nUc
         Ly2+MleZk97Kpuf8yHAPGf5FqGGibLOy2NPIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Yz067+QliCEouoiKnqzUI1IVoAeEPZDPr+6rei/Ul3mgGm34L1tWxMp4hAWTFp6G3r
         QqyOO9h8hFfWqfBhzZxVZREiq+4HSB19jojfJkGsQJ6MLGw1Wzm9CPoG1bcWq9OzHOeM
         waeQE/Giwij67YJvsh44xQRtxpFObwKs+5oOQ=
MIME-Version: 1.0
Received: by 10.204.5.138 with SMTP id 10mr4728480bkv.110.1256477827788; Sun, 
	25 Oct 2009 06:37:07 -0700 (PDT)
In-Reply-To: <1256467717.6143.13.camel@falcon>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>
	 <af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com>
	 <a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com>
	 <53bdfdd95ec4fa00d4cc505bb5972cf21243a14d.1256135456.git.wuzhangjin@gmail.com>
	 <26008418.post@talk.nabble.com> <1256467717.6143.13.camel@falcon>
Date:	Sun, 25 Oct 2009 14:37:07 +0100
Message-ID: <7a39cd850910250637h200e2dd2i4f725d55bb88c212@mail.gmail.com>
Subject: Re: [PATCH -v4 9/9] tracing: add function graph tracer support for 
	MIPS
From:	Patrik Kluba <kpajko79@gmail.com>
To:	wuzhangjin@gmail.com
Cc:	linux-kernel@vger.kernel.org,
	GCC Patches <gcc-patches@gcc.gnu.org>,
	Adam Nemet <anemet@caviumnetworks.com>, rostedt@goodmis.org,
	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <kpajko79@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kpajko79@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, Oct 25, 2009 at 11:48 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
>
> do you mean if enabling PROFILE_BEFORE_PROLOGUE, there will be some
> problems with module support using -mlong-calls?
>

No, there are no problems. I've tested it on friday, and function
graph tracing was working correctly.
I meant to say that 4.2.1 we use does not generate correct profile
calls from kernel modules. Maybe this issue was fixed in newer
releases, I did not check. I've applied a patch (don't remember where
have I found that, maybe it was created by you) to our toolchain
several months ago.

I was thinking about dynamic tracing, and I think a toolchain patch
can be avoided completely. We only need to make difference between
"jal _mcount" and "jalr v1"-style mcount calls when replacing them
with "nop" instructions in the code-patching function called by
ftrace_convert_nops(). This can be done in 2 ways:
1) keeping old instructions - takes extra memory, not an option
2) using 2 separate instructions to replace with. One of them could be
the normal NOP instruction, which expands to "sll r0, r0, 0". For the
other we could use "sll r0, r0, 1" but as it has already special
meaning (SSNOP) a better candidate could be something like "sll r1,
r1, 0". This way we can decide which instruction to patch in when
tracing is enabled for a function, eg. when the code patcher
encounters a "sll r0, r0, 0" it emits a function call using JAL and
when it encounters "sll r1, r1, 0" it emits a function call using
"JALR v1".

Regards,
Patrik
