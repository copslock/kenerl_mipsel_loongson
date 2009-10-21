Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 15:20:40 +0200 (CEST)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:56129 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493504AbZJUNUe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 15:20:34 +0200
Received: by fxm25 with SMTP id 25so7982275fxm.0
        for <multiple recipients>; Wed, 21 Oct 2009 06:20:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Mr64Z5cIPhdJ0ndh94LOfiyklqM7jghBpL+gwskxlLM=;
        b=uYgjJWFLPbZ7x/AvAMoCMpXcdPvQOts2HEm33/vF7QsLiqOLtdDxyfLhiJdI9V1yrf
         RwcJa6sEws7B6rY60uqhjCdwSKWTH1I6rf07kj6JrIoUJGbJHx7FwHBj0GxmFqRxhidD
         bBVlJcExZeuJcZXxBZsVdCjAcYAWPwh0UbE+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ckqE4p2CWyjMfZg0Vgj0qa8Vl92sNLy0wORmds6vM2aZ1rp3JRJRuNXlc97IybJOO3
         EXOuwNKYjSWyiUYJBXw+z9WJsYjguO4La6yqtrrS1RaztHz3pmkfIyqw1oUnz8mVTJnP
         nlJrxhtaw5yLEZlvTvADM3k+ZEx62V423SknM=
Received: by 10.204.13.210 with SMTP id d18mr8003276bka.211.1256131225673;
        Wed, 21 Oct 2009 06:20:25 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id e11sm266550fga.22.2009.10.21.06.20.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 06:20:24 -0700 (PDT)
Subject: Re: ftrace for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <4ADF093D.10403@ru.mvista.com>
References: <1255995599.17795.15.camel@falcon>
	 <1255997319.18347.576.camel@gandalf.stny.rr.com>
	 <1256052667.8149.56.camel@falcon>
	 <1256055714.18347.1608.camel@gandalf.stny.rr.com>
	 <4ADF093D.10403@ru.mvista.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Wed, 21 Oct 2009 21:20:11 +0800
Message-Id: <1256131211.11274.1.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-10-21 at 17:14 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Steven Rostedt wrote:
> 
> >>Need to check which registers is missing when saving/restoring for
> >>_mcount:
> 
> >>NESTED(ftrace_graph_caller, PT_SIZE, ra) 
> >>        MCOUNT_SAVE_REGS
> >>        PTR_S   v0, PT_R2(sp)
> >>
> >>        MCOUNT_SET_ARGS
> >>        jal     prepare_ftrace_return
> >>        nop
> >>
> >>        /* overwrite the parent as &return_to_handler: v0 -> $1(at) */
> >>        move    $1,     v0  
> 
> > I'm confused here? I'm not exactly sure what the above is doing. Is $1 a
> > register (AT)?
> 
>     Yes.

Have replaced it by AT, thanks!

> 
> > And how is this register used before calling mcount?
> 
> >>        PTR_L   v0, PT_R2(sp)
> >>        MCOUNT_RESTORE_REGS
> >>        RETURN_BACK
> >>        END(ftrace_graph_caller)
> 
> >>        .align  2
> >>        .globl  return_to_handler
> >>return_to_handler:
> >>        PTR_SUBU        sp, PT_SIZE
> >>        PTR_S   v0, PT_R2(sp)
> 
> > BTW, is v0 the only return register? I know x86 can return two different
> > registers depending on what it returns. What happens if a function
> > returns a 64 bit value on a 32bit box? Does it use two registers for
> > that?
> 
>     Yes, there's also v1 register.
> 

Thanks, added.

Regards,
	Wu Zhangjin
