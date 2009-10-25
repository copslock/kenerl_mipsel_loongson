Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2009 11:49:12 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:48428 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492113AbZJYKtF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2009 11:49:05 +0100
Received: by pzk35 with SMTP id 35so7406759pzk.22
        for <multiple recipients>; Sun, 25 Oct 2009 03:48:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=ciV8w4+4hf6SvnHKeIerg69s4B6xh3PhJ5Hcr6NzeUw=;
        b=O7ORTSCcZFaHxK4N4VXM7ELIzcI82OSjUAE0u3mx3lztrPUWx6fnowStGJy04qrHTp
         Swdkdfh4CD1vdgfaiztZ7yNYRhUqy9h9Xd6GHHiOKxbK5VW1OayV1V6LBBEpRMOM3P+Y
         ZFb7EGwWLYtWYVlwA0CVP8od+edkknNkfweic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=FKVAjr2PfkHzaJii2HLKM1iIpmE9+yCSblsnONMoz6yr45Q0iUo3v3OHjwh/NSuE00
         Q5EyRTjd6ttDYVNntBqAkV3zILYXm5sElYgSKRTDCcWx+oJl0FBA5dJrPrPYdO1hSk4W
         EUpu8NRBd2tgjgzPfchd0zZbWWN1em17xb6JA=
Received: by 10.115.133.38 with SMTP id k38mr19766510wan.120.1256467736008;
        Sun, 25 Oct 2009 03:48:56 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm158824pzk.5.2009.10.25.03.48.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 03:48:54 -0700 (PDT)
Subject: Re: [PATCH -v4 9/9] tracing: add function graph tracer support for
 MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	pajko <kpajko79@gmail.com>
Cc:	linux-kernel@vger.kernel.org,
	GCC Patches <gcc-patches@gcc.gnu.org>, wuzhangjin@gmail.com,
	Adam Nemet <anemet@caviumnetworks.com>, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>
In-Reply-To: <26008418.post@talk.nabble.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>
	 <af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com>
	 <a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com>
	 <53bdfdd95ec4fa00d4cc505bb5972cf21243a14d.1256135456.git.wuzhangjin@gmail.com>
	 <26008418.post@talk.nabble.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sun, 25 Oct 2009 18:48:37 +0800
Message-Id: <1256467717.6143.13.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

(Added linux-mips mailing list and the other people to the CC list.)

On Thu, 2009-10-22 at 04:37 -0700, pajko wrote:
[...]
> > 
> 
> All this stuff can be avoided having PROFILE_BEFORE_PROLOGUE enabled in GCC
> (gcc/config/mips/mips.h), like it is done one several other architectures.
> Some of them even require it to be set for a working _mcount. 
> Putting the call of _mcount before the function prologue should make no harm
> (it's working for me), and this way RA can be hooked for function graph
> tracing
> before it is saved to stack in the function prologue. Thus there will be no
> difference between leaf and non-leaf functions.

Good idea! Seems PROFILE_BEFORE_PROLOGUE is commented by default in
gcc/config/mips/mips.h of gcc 4.4:

/* #define PROFILE_BEFORE_PROLOGUE */

if we enable this macro, the handling will be the same to non-leaf and
leaf function, so, David's patch to gcc is not need again.

> This change is no big deal as GCC has to be patched anyway to get dynamic
> ftracing (and with 4.2.1 I had to patch it to get ftracing in modules
> working
> - using -mlong-calls -, but it's possible that this is fixed in the newer
> releases).
> 

do you mean if enabling PROFILE_BEFORE_PROLOGUE, there will be some
problems with module support using -mlong-calls?

I have made dynamic ftrace support module with -mlong-calls, I think, if
we move the codes before prologue, it should have no side effect.

        lui     v1,HI16bit     (&_mcount -> v1)
        daddiu  v1,v1,LOW16bit
        move    at,ra
        jalr    v1

Regards,
	Wu Zhangjin
