Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 20:38:28 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:21514 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S3465573AbWHATiT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Aug 2006 20:38:19 +0100
Received: by ug-out-1314.google.com with SMTP id m2so1679618ugc
        for <linux-mips@linux-mips.org>; Tue, 01 Aug 2006 12:38:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qDuQsE7GVQe4IP7uwh8gDnUO1Ml1OXvkMVSVMgcSK3w47rlrOk52ewgoAeAiPvrfPSMD8g02+Vm+7mOXAZ1kapCXRxy2r12Mjos0Qwpgo01JqklwvNLS1drA1ZpOoLhHJ4n6mMjMEeLlzGVzoduZckABvZEALqbsFbcJnfxqj1M=
Received: by 10.67.100.12 with SMTP id c12mr52445ugm;
        Tue, 01 Aug 2006 12:38:18 -0700 (PDT)
Received: by 10.67.87.8 with HTTP; Tue, 1 Aug 2006 12:38:18 -0700 (PDT)
Message-ID: <cda58cb80608011238q5b0e0eacje28f921d6e1c7700@mail.gmail.com>
Date:	Tue, 1 Aug 2006 21:38:18 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 7/7] Allow unwind_stack() to return ra for leaf function
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20060802.004848.97296551.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
	 <1154424439969-git-send-email-vagabon.xyz@gmail.com>
	 <20060802.004848.97296551.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/8/1, Atsushi Nemoto <anemo@mba.ocn.ne.jp>:
> On Tue,  1 Aug 2006 11:27:17 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > Since get_frame_info() is more robust, unwind_stack() can
> > returns ra value for leaf functions.
>
> I think it is still fragile.  The get_frame_info() might misdetect
> nested function as leaf.  For example, I can craft this code:
>

Considering (wrongly) a nested function as a leaf one is not a big
issue. "ra" reg should _always_ store a valid address (nested or not).
The only (small) impact would be to skip an entry when showing the
backtrace.

-- 
               Franck
