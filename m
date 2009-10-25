Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2009 16:55:51 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.148]:26101 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492598AbZJYPzo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2009 16:55:44 +0100
Received: by ey-out-1920.google.com with SMTP id 26so549134eyw.52
        for <multiple recipients>; Sun, 25 Oct 2009 08:55:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:to:mail-followup-to:cc
         :subject:references:from:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=9qjHH/hCyaGfibzFvolR8KWlQt21TldYXtHb0Egpitc=;
        b=a8IHwLUwOqWtl8pultXhCciUexI+yMl62sasKwwa/a0rIRbq7iXR2U4uz7AP7cro97
         2AmSWjDN4Wvt7BrYKxrZP9sa8p67oNqOmb7U5BcwzMtoXYgtfsZflHU7VnUo6ph6ioyj
         H1lDntfsyc+nXZKgV/8YXvCak57TtEhqvedU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=to:mail-followup-to:cc:subject:references:from:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=BO8pF0lxauexkC0RaDocu4em969cfEOq4UVtL+EgxWwr52ZWRE2BoRZO/mzdz2R2dG
         E9RanD/Yz25wOoCMFVVqIkQOpInUrGhEm2dRnFtneWKxuQ6llgmx/aJsyKiM+AQ+hjlj
         HyQdjiGPnnxEBlukNqE1Q3NyKRTEZPh+cOoEY=
Received: by 10.210.96.12 with SMTP id t12mr3287807ebb.71.1256486141364;
        Sun, 25 Oct 2009 08:55:41 -0700 (PDT)
Received: from localhost (rsandifo.gotadsl.co.uk [82.133.89.107])
        by mx.google.com with ESMTPS id 5sm10059655eyh.42.2009.10.25.08.55.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:55:40 -0700 (PDT)
To:	wuzhangjin@gmail.com
Mail-Followup-To: wuzhangjin@gmail.com,pajko <kpajko79@gmail.com>,  linux-kernel@vger.kernel.org, GCC Patches <gcc-patches@gcc.gnu.org>, Adam Nemet <anemet@caviumnetworks.com>,  rostedt@goodmis.org, linux-mips@linux-mips.org,  Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Nicholas Mc Guire <der.herr@hofr.at>, David Daney <ddaney@caviumnetworks.com>, rdsandiford@googlemail.com
Cc:	pajko <kpajko79@gmail.com>, linux-kernel@vger.kernel.org,
	GCC Patches <gcc-patches@gcc.gnu.org>,
	Adam Nemet <anemet@caviumnetworks.com>, rostedt@goodmis.org,
	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH -v4 9/9] tracing: add function graph tracer support for MIPS
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	<2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	<3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	<96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>
	<af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com>
	<a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com>
	<53bdfdd95ec4fa00d4cc505bb5972cf21243a14d.1256135456.git.wuzhangjin@gmail.com>
	<26008418.post@talk.nabble.com> <1256467717.6143.13.camel@falcon>
From:	Richard Sandiford <rdsandiford@googlemail.com>
Date:	Sun, 25 Oct 2009 15:55:34 +0000
In-Reply-To: <1256467717.6143.13.camel@falcon> (Wu Zhangjin's message of "Sun\, 25 Oct 2009 18\:48\:37 +0800")
Message-ID: <87hbtn1n9l.fsf@firetop.home>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin <wuzhangjin@gmail.com> writes:
> (Added linux-mips mailing list and the other people to the CC list.)
>
> On Thu, 2009-10-22 at 04:37 -0700, pajko wrote:
> [...]
>> > 
>> 
>> All this stuff can be avoided having PROFILE_BEFORE_PROLOGUE enabled in GCC
>> (gcc/config/mips/mips.h), like it is done one several other architectures.
>> Some of them even require it to be set for a working _mcount. 
>> Putting the call of _mcount before the function prologue should make no harm
>> (it's working for me), and this way RA can be hooked for function graph
>> tracing
>> before it is saved to stack in the function prologue. Thus there will be no
>> difference between leaf and non-leaf functions.
>
> Good idea! Seems PROFILE_BEFORE_PROLOGUE is commented by default in
> gcc/config/mips/mips.h of gcc 4.4:
>
> /* #define PROFILE_BEFORE_PROLOGUE */
>
> if we enable this macro, the handling will be the same to non-leaf and
> leaf function, so, David's patch to gcc is not need again.

Defining PROFILE_BEFORE_PROLOGUE isn't correct for abicalls code,
because "jal _mcount" is a macro that loads _mcount from the
GOT into $25.  We don't have access to $28 at the beginning of
the function, and we mustn't clobber the incoming value of $25.
So we could only make this change for non-abicalls code.

It's then a choice between (a) having new non-abicalls-specific
behaviour or (b) going with David's patch.  The advantage of
(a) is that the linux code is slightly simpler.  The disadvantage
is that it makes the _mcount interface differ between -mabicalls
and -mno-abicalls.  And IMO the disadvantage outweights the advantage.
If this new behaviour is useful for linux, it could easily be useful
for userspace too.  And with the new PLT support, non-shared abicalls
code is supposed to be link-compatible with non-abicalls code.

I think David's patch is the way to go.

Richard
