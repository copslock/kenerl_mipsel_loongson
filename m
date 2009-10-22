Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 23:10:09 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:56240 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493335AbZJVVKC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 23:10:02 +0200
Received: by ewy12 with SMTP id 12so9349779ewy.0
        for <multiple recipients>; Thu, 22 Oct 2009 14:09:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=2VqvCfKnzjq3cObpkhC6zNjWWxZvnqhlaihqzw1YMZY=;
        b=ll4IFe+HcpuLos1//7Y94+mVDTebHXM1eMU9jJSMRyDw47mcdYoGCIw01g12KQRgJd
         UHkwjwbxsjDIxxkW4Odt5YiMJLctZkVhfCdx9AZYLgcV/ws+BKs7aPkTg0ZcUi98yTvv
         Cyi4yE4TJi3kBhW/A1ztOMGwKbXwGOsCUEEVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GL/3V7M9VOSRoFx2pnvn/iwZm3JRpA0WvH2RQN2wtyXWeWw2JaIICd0OOZ3iML1g0/
         BEawQCqN79yQ/1Mg/4B34FATxEWrMB5yE2MFoYBR6bRKbrLGRl7gpCH1n/EBkj0X3Txa
         2KlGZHxtsrWyDiAGGG1KUqBRSVkDDpzmgzqbI=
Received: by 10.211.154.18 with SMTP id g18mr4687210ebo.70.1256245796492;
        Thu, 22 Oct 2009 14:09:56 -0700 (PDT)
Received: from nowhere (ADijon-552-1-49-221.w92-138.abo.wanadoo.fr [92.138.48.221])
        by mx.google.com with ESMTPS id 7sm4527341eyb.40.2009.10.22.14.09.52
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 14:09:54 -0700 (PDT)
Received: by nowhere (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128/128 bits))
	fweisbec@gmail.com; Thu, 22 Oct 2009 23:09:54 +0200 (CEST)
Date:	Thu, 22 Oct 2009 23:09:52 +0200
From:	Frederic Weisbecker <fweisbec@gmail.com>
To:	Steven Rostedt <rostedt@goodmis.org>
Cc:	Adam Nemet <anemet@caviumnetworks.com>,
	David Daney <ddaney@caviumnetworks.com>, wuzhangjin@gmail.com,
	Richard Sandiford <rdsandiford@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH -v4 4/9] tracing: add static function tracer support
	for MIPS
Message-ID: <20091022210950.GA10041@nowhere>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com> <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com> <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com> <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com> <1256138686.18347.3039.camel@gandalf.stny.rr.com> <1256233679.23653.7.camel@falcon> <4AE0A5BE.8000601@caviumnetworks.com> <19168.49354.525249.654494@ropi.home> <1256244726.20866.802.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1256244726.20866.802.camel@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Oct 22, 2009 at 04:52:06PM -0400, Steven Rostedt wrote:
> On Thu, 2009-10-22 at 13:30 -0700, Adam Nemet wrote:
> > 
> > Speaking of performance, -pg also affects the instruction scheduling freedom
> > of the compiler in the prologue.  With profiling, we limit optimizations not
> > to move instructions in and out of the prologue.
> > 
> > Also note that for functions invoked via tail call you won't get an exit
> > event.  E.g. if bar is tail-called from foo:
> > 
> >   foo entered
> >   bar entered
> >   foo/bar exited
> > 
> > However, this is not MIPS-specific and you can always disable tail calls
> > with -fno-optimize-sibling-calls.


Ouch..

 
> The question is, would bar have a _mcount call? So far, we have not had
> any issues with this on either x86 nor PPC.


Nothing would prevent that I guess. I mean, we are doing a very specific
use of -pg, and common uses wouldn't require to disable the mcount call on
bar in this situation, so it's not something that -pg is supposed to care
about.


> /me knocks on wood.


Me too (but not so hard...)
