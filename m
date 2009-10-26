Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 17:35:35 +0100 (CET)
Received: from qw-out-1920.google.com ([74.125.92.145]:47496 "EHLO
	qw-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493225AbZJZQfW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 17:35:22 +0100
Received: by qw-out-1920.google.com with SMTP id 5so1763820qwc.54
        for <multiple recipients>; Mon, 26 Oct 2009 09:35:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=TAMMi8VvU0zqY/nPWVbfYTa7wb+wgQsxz9edI/6QPC4=;
        b=Y6RRHdE6J/hVpjgGe8t1Th5nDvCVklGHt/L5OHvzvuTvxjCddCA5GqlJg7xnirGmyM
         PCOcn/0JUM4ye800DmximdpuCiI50ORRK5LipX0Sfc82UqBWIYSJpTHobu9NR0owHENF
         V9wCyRWZYg+pifqsG+kLEssQ+oQ4n74vO/b/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=XaAwX015DJkpoPUm1vNYannQQuKLRWTgbUNRybNIJ5GBYzDeyw3NtIDihGZpuvqO5W
         W7kRiqX8OpIzSLkZWLUw3RG2JjFnQojPvY4eF/ALmWspJ55iLRd1JsI0c8mFFivvdgNl
         XLesV7rKVJx2gvwt8Zc8g2YYYK0O9X2kKVdu4=
Received: by 10.224.50.11 with SMTP id x11mr7367853qaf.248.1256574921493;
        Mon, 26 Oct 2009 09:35:21 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 4sm16679989qwe.37.2009.10.26.09.35.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 09:35:20 -0700 (PDT)
Subject: Re: [PATCH -v6 07/13] tracing: add dynamic function tracer support
 for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	rostedt@goodmis.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
In-Reply-To: <1256573175.26028.310.camel@gandalf.stny.rr.com>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
	 <747deea2f18d5ccffe842df95a9dd1c86251a958.1256569489.git.wuzhangjin@gmail.com>
	 <3f47087b70a965fd679b17a59521671296457df1.1256569489.git.wuzhangjin@gmail.com>
	 <f290e125634d164ec65b09b24b269815f78455ab.1256569489.git.wuzhangjin@gmail.com>
	 <07dc907ec62353b1aca99b2850d3b2e4b734189a.1256569489.git.wuzhangjin@gmail.com>
	 <374da7039d2e1b97083edd8bcd7811356884d427.1256569489.git.wuzhangjin@gmail.com>
	 <3c82af564d70be05b92687949ed134ce034bf8db.1256569489.git.wuzhangjin@gmail.com>
	 <a11775df0ec9665fab5861f4fa63a3e192b9ffec.1256569489.git.wuzhangjin@gmail.com>
	 <1256573175.26028.310.camel@gandalf.stny.rr.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Tue, 27 Oct 2009 00:35:10 +0800
Message-Id: <1256574910.5642.228.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

[...]
> > +
> > +NESTED(ftrace_caller, PT_SIZE, ra)
> > +	.globl _mcount
> > +_mcount:
> > +	j	ftrace_stub
> > +	nop
> > +	lw	t0, function_trace_stop
> > +	bnez	t0, ftrace_stub
> > +	nop
> > +
> > +	MCOUNT_SAVE_REGS
> > +
> > +	MCOUNT_SET_ARGS
> > +	.globl ftrace_call
> > +ftrace_call:
> > +	nop	/* a placeholder for the call to a real tracing function */
> > +	nop	/* Do not touch me, I'm in the dealy slot of "jal func" */
> 
> Indent the second nop ;-)
> 

Yup, later in -v7.

> > +    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_HI16\\s+_mcount\$";
> > +    $objdump .= " -Melf-trad".$endian."mips ";
> > +
> > +    if ($endian eq "big") {
> > +	    $endian = " -EB ";
> > +	    $ld .= " -melf".$bits."btsmip";
> > +    } else {
> > +	    $endian = " -EL ";
> > +	    $ld .= " -melf".$bits."ltsmip";
> > +    }
> > +
> > +    $cc .= " -mno-abicalls -fno-pic -mabi=" . $bits . $endian;
> > +    $ld .= $endian;
> > +
> > +    if ($bits == 64) {
> > +	    $function_regex =
> > +		"^([0-9a-fA-F]+)\\s+<(.|[^\$]L.*?|\$[^L].*?|[^\$][^L].*?)>:";
> > +	    $type = ".dword";
> > +    }
> > +
> >  } else {
> >      die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
> >  }
> 
> So if I convert mips to do what ppc does, we can remove the long jump
> thing, right?
> 

If remove the long jump, we at least to change the $mcount_regex in
scripts/recordmcount.pl, the addr + 12 in arch/mips/include/asm/ftrace.h
and the _mcount & ftrace_caller in mcount.S and the ftrace_make_nop &
ftrace_make_call in arch/mips/kernel/ftrace.c back to the -v4 version.

I think this method of supporting module is not that BAD, no obvious
overhead added except the "lui...addiu..." and two more "nop"
instructions. and it's very understandable, so, just use this version?

Regards,
	Wu Zhangjin
