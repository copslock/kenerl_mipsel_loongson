Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 19:37:07 +0100 (BST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:35075 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024752AbZE2ShA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2009 19:37:00 +0100
Received: by pxi17 with SMTP id 17so5633596pxi.22
        for <multiple recipients>; Fri, 29 May 2009 11:36:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=NITk+rdIVdWl+JgF8yd06F1/iXTKrheIV2kJs0i22xA=;
        b=x8eZfH8unawrdzTfwD8H8SqIuHnwCuj8hPuiZ5r/Ekqw07bxuHWur0FblELGu76hsQ
         pvO3zPdxMekXeUMnWAguF4kZLnP+Ok9eAN0zEQZ4j8nBNFkxrw6HIVAXajxcs5oMjV+X
         empw5igHvM435ANB4oTFc7DYC9Bx4xDhnGFdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=V3pbSq3bTrCo48MyzJ7FpFMfCsiJETrGpfwTSSSBXxLdDJvj9x4JTY4u0nXHT1WVZY
         5OV4Ba8GRW6JLyYFNdd/aG14tNMM+9FTjh7ISikHAyIJm53AliOLVTsnyyBauKfd0STJ
         285+J2Uf1Drkcwfz2GMumKyB/2DRYNTYfR+RA=
Received: by 10.114.145.17 with SMTP id s17mr4448638wad.120.1243622213092;
        Fri, 29 May 2009 11:36:53 -0700 (PDT)
Received: from ?192.168.1.100? ([219.246.59.144])
        by mx.google.com with ESMTPS id l28sm2562429waf.19.2009.05.29.11.36.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 11:36:51 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] mips dynamic function tracer support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Steven Rostedt <rostedt@goodmis.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <1243617723.18071.18.camel@falcon>
References: <cover.1243604390.git.wuzj@lemote.com>
	 <a00a91f6fc79b7d20b5b2193086e879dcafded46.1243604390.git.wuzj@lemote.com>
	 <alpine.DEB.2.00.0905291122260.31247@gandalf.stny.rr.com>
	 <1243617723.18071.18.camel@falcon>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 30 May 2009 02:36:46 +0800
Message-Id: <1243622206.18071.28.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-05-30 at 01:44 +0800, Wu Zhangjin wrote:
> On Fri, 2009-05-29 at 11:24 -0400, Steven Rostedt wrote:
> > On Fri, 29 May 2009, wuzhangjin@gmail.com wrote:
> > > diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> > > index 409596e..a5d2ace 100755
> > > --- a/scripts/recordmcount.pl
> > > +++ b/scripts/recordmcount.pl
> > > @@ -213,6 +213,17 @@ if ($arch eq "x86_64") {
> > >      if ($is_module eq "0") {
> > >          $cc .= " -mconstant-gp";
> > >      }
> > > +
> > > +} elsif ($arch eq "mips") {
> > > +	$mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
> > > +	$ld .= " -melf".$bits."btsmip";
> > > +
> > > +	$cc .= " -mno-abicalls -fno-pic ";
> > > +
> > > +    if ($bits == 64) {
> > > +		$type = ".dword";
> > > +    }
> > > +
> > >  } else {
> > >      die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
> > >  }
> > > @@ -441,12 +452,12 @@ if ($#converts >= 0) {
> > >      #
> > >      # Step 5: set up each local function as a global
> > >      #
> > > -    `$objcopy $globallist $inputfile $globalobj`;
> > > +    `$objcopy $globallist $inputfile $globalobj 2>&1 >/dev/null`;
> > >  
> > >      #
> > >      # Step 6: Link the global version to our list.
> > >      #
> > > -    `$ld -r $globalobj $mcount_o -o $globalmix`;
> > > +    `$ld -r $globalobj $mcount_o -o $globalmix 2>&1 >/dev/null`;
> > 
> > We still need to find out why these are giving errors. I don't like the 
> > idea of hiding errors that might be useful. The better way is to change 
> > the code to avoid having any warnings or errors.
> > 
> 
> ooh, there is really a bug in scripts/recordmcount.pl, just fixed it.
> 
> warnings like this(only in mips/64bit):
> 
>  CC      fs/proc/devices.o
> mipsel-linux-gnu-objcopy: 'fs/proc/.tmp_gl_devices.o': No such file
> mipsel-linux-gnu-ld: fs/proc/.tmp_gl_devices.o: No such file: No such
> file or directory
> rm: cannot remove `fs/proc/.tmp_gl_devices.o': No such file or directory
> rm: cannot remove `fs/proc/.tmp_mx_devices.o': No such file or directory
> 
> so i checked the source code and let it print something:
> 
>      #
>      # Step 5: set up each local function as a global
>      #
> +    print "$objcopy $globallist $inputfile $globalobj\n";
>      `$objcopy $globallist $inputfile $globalobj`;
> 
> something like this is printed:
> 
> mipsel-linux-gnu-objcopy  --globalize-symbol $L12
> arch/mips/kernel/irq_cpu.o arch/mips/kernel/.tmp_gl_irq_cpu.o
> mipsel-linux-gnu-objcopy: 'arch/mips/kernel/.tmp_gl_irq_cpu.o': No such
> file
> mipsel-linux-gnu-ld: arch/mips/kernel/.tmp_gl_irq_cpu.o: No such file:
> No such file or directory
> rm: cannot remove `arch/mips/kernel/.tmp_gl_irq_cpu.o': No such file or
> directory
> rm: cannot remove `arch/mips/kernel/.tmp_mx_irq_cpu.o': No such file or
> directory
> 
> 
> did you see the symbol: $L12, which should be quoted, otherwise, it will
> be interpreted as the value of a variable L12(the whole $L12 should be a
> string), this $L12 will be an empty string. so, the whole command
> becomes:
> 
> mipsel-linux-gnu-objcopy --globalize-symbol arch/mips/kernel/irq_cpu.o
> arch/mips/kernel/.tmp_gl_irq_cpu.o
> 
> the last string .../.tmp_gl_irq_cpu.o becomes the input file, but it's
> not there, that is the warning.
> 
> fix it like this:
> 
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index 59ea43a..907110e 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -451,8 +451,8 @@ if ($#converts >= 0) {
>      my $locallist = "";
>  
>      foreach my $con (@converts) {
> -       $globallist .= " --globalize-symbol $con";
> -       $locallist .= " --localize-symbol $con";
> +       $globallist .= " --globalize-symbol \"$con\"";
> +       $locallist .= " --localize-symbol \"$con\"";
>      }
>  
>      my $globalobj = $dirname . "/.tmp_gl_" . $filename;
> 
> I will add this as the third patch, is it okay?
> 

sorry, this fix not work, can not link the kernel:

arch/mips/kernel/built-in.o:(__mcount_loc+0x3a0): undefined reference to
`$L12'
arch/mips/kernel/built-in.o:(__mcount_loc+0x3a8): undefined reference to
`$L12'

I think we should ignore these symbols, should we?

> Best Wishes,
> --- Wu Zhangjin
