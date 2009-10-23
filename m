Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2009 03:09:33 +0200 (CEST)
Received: from qw-out-1920.google.com ([74.125.92.145]:11735 "EHLO
	qw-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493845AbZJWBJ1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2009 03:09:27 +0200
Received: by qw-out-1920.google.com with SMTP id 5so1222445qwc.54
        for <multiple recipients>; Thu, 22 Oct 2009 18:09:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=oJ3fXtS6Jk2/SjcW5k+hm5togEaGiHuLuwdwDAJnLlQ=;
        b=kYo00AQ2O6/3/QoCfHEgkY8Sa+/0pFclAFTaI82vxWD+0QAYWhvDP4/UyLOjmUDNKP
         BYI00wcg0Cr6ZTO8ka2CrEeMH0pQj+88jrLBF+sSeXaGLu2e/VGiWCR/hUmCZJhF5ENA
         g/WxDoeR3XMwVtnFNVRpM/cVSd59okkmk2jIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ic096U9Ff+4RbliutfMdGRG5TdwQzjqfZBd/v509t+nF01hQTBFVs7VLn1WZ16C7o+
         RyCoAvazgNlXn5jw/4JYgikD5lOQqCYdZTHMkeOZptS1TEX21ZN+uEW8Pi0Nh4voLCzH
         6jzk1HlNMRmaM9KNo4BDq0/gwJ3dsDqBLejdE=
Received: by 10.224.44.2 with SMTP id y2mr5024562qae.125.1256260164902;
        Thu, 22 Oct 2009 18:09:24 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 7sm6796710qwf.16.2009.10.22.18.09.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 18:09:24 -0700 (PDT)
Subject: Re: [PATCH -v4 4/9] tracing: add static function tracer support
 for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	rostedt@goodmis.org
Cc:	Adam Nemet <anemet@caviumnetworks.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <1256248517.20866.806.camel@gandalf.stny.rr.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	 <1256138686.18347.3039.camel@gandalf.stny.rr.com>
	 <1256233679.23653.7.camel@falcon> <4AE0A5BE.8000601@caviumnetworks.com>
	 <19168.49354.525249.654494@ropi.home>
	 <1256244726.20866.802.camel@gandalf.stny.rr.com>
	 <19168.52948.22223.757259@ropi.home>
	 <1256248517.20866.806.camel@gandalf.stny.rr.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 23 Oct 2009 09:09:06 +0800
Message-Id: <1256260146.6381.4.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-10-22 at 17:55 -0400, Steven Rostedt wrote:
> On Thu, 2009-10-22 at 14:29 -0700, Adam Nemet wrote:
> > Steven Rostedt writes:
> > > On Thu, 2009-10-22 at 13:30 -0700, Adam Nemet wrote:
> > > > Also note that for functions invoked via tail call you won't get an exit
> > > > event.  E.g. if bar is tail-called from foo:
> > > > 
> > > >   foo entered
> > > >   bar entered
> > > >   foo/bar exited
> > > > 
> > > > However, this is not MIPS-specific and you can always disable tail calls
> > > > with -fno-optimize-sibling-calls.
> > > 
> > > The question is, would bar have a _mcount call? So far, we have not had
> > > any issues with this on either x86 nor PPC.
> > 
> > Yes, bar will have an _mcount call.  The difference is that bar will return to
> > foo's caller directly rather than to foo first.
> 
> I guess the best bet is to have CONFIG_FUNCTION_GRAPH enable
> -fno-optimize-sibling-calls and be done with it.
> 

Hello, This did for us:

Makefile:

ifdef CONFIG_FRAME_POINTER
KBUILD_CFLAGS   += -fno-omit-frame-pointer -fno-optimize-sibling-calls
else
KBUILD_CFLAGS   += -fomit-frame-pointer
endif

So, the only thing we need to do is enabling CONFIG_FRAME_POINTER.
Seems it was selected by FTRACE by default.

Regards,
	Wu Zhangjin
