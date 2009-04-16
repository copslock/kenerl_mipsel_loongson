Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Apr 2009 02:40:37 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.187]:25188 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20025546AbZDPBkb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Apr 2009 02:40:31 +0100
Received: by ti-out-0910.google.com with SMTP id 11so62383tim.20
        for <multiple recipients>; Wed, 15 Apr 2009 18:40:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Ots2vzT39BRfGlsn5D6sVUKoDSGtTd88gdsqJjAfsQw=;
        b=u8taylewXnpm3bWGBJFMMNPRO4R2R9NsODq5Wac9JpO4N/rzf93ESmH98n7kMlm30U
         uwjgczdS67PQalUhJUr8nQ5nPt0SqvVlhLKnVSzEvD9uS4PQerMMh4be5BXE3CqbfI+7
         fHPmp2jnJxamDDZpNtQpvZSxDCMQT/z1eykrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=wpPCGNWSjG7k9zntIympnf/aSzsFtGTcsFY9WgL1igelwWfgGp1DaAmrirWT7v0Fu5
         6dWqZR79/5iogAIDf6x/1mMe9Qt4bUk3NH3eC2ooYUz+hfR2ilNE1L0OIo0FcwIKUQ82
         Ozcthm9YHjClcwkXU+7lFKkH/Ejzaiqv+O5w8=
Received: by 10.110.52.5 with SMTP id z5mr836091tiz.44.1239846027259;
        Wed, 15 Apr 2009 18:40:27 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id 14sm1460334tim.7.2009.04.15.18.40.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Apr 2009 18:40:26 -0700 (PDT)
Subject: Re: [PATCH] ftrace porting of linux-2.6.29 for mips
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Chris Dearman <chris@mips.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <49E61AC3.2050402@mips.com>
References: <b00321320904021847w5ab3acb6nd1cd554c251ef8f6@mail.gmail.com>
	 <20090403113315.GC6629@adriano.hkcable.com.hk>
	 <b00321320904030503w8fe0165t2aded6727f35e24c@mail.gmail.com>
	 <b00321320904030551p774d295lce3581c23d9d8c26@mail.gmail.com>
	 <20090403141158.GA27751@adriano.hkcable.com.hk>
	 <b00321320904030753s2e10503fud4ba50b0fda13d8f@mail.gmail.com>
	 <20090403160304.GB27751@adriano.hkcable.com.hk>
	 <20090403180652.GC27751@adriano.hkcable.com.hk>
	 <20090414124001.GB28950@adriano.hkcable.com.hk> <49E61AC3.2050402@mips.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 16 Apr 2009 09:40:15 +0800
Message-Id: <1239846015.3538.104.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-04-15 at 10:34 -0700, Chris Dearman wrote:
> Zhang Le wrote:
> > I got ftrace working on fuloong 2f box, finally.
> > 
> > The patch could be get here:
> > http://repo.or.cz/w/linux-2.6/linux-loongson.git?a=shortlog;h=refs/heads/linux-2.6.29-stable-ftrace-from-wu
> > 
> > It is the second last patch in the above git repo.
> 
> I pulled this patch into my local tree to try it out. The attached patch 
> removes spurious warnings about linking pic and non-pic object files.
> 
> It might be better to pass KBUILD_CFLAGS into the script to get the same 
> build options as the rest of the kernel. Was there a reason not to do this?
> 

This is a "history problem", for not modify the original source code of
scripts/recordmcount.pl a lot, I just added a line to pass 
the "endian" argument in from scripts/Makefile.build

ifdef CONFIG_FTRACE_MCOUNT_RECORD
cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
+     "$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
     "$(if $(CONFIG_64BIT),64,32)" \
     "$(OBJDUMP)" "$(OBJCOPY)" "$(CC)" "$(LD)" "$(NM)" "$(RM)" "$(MV)"
"$(@)";
endif

but current method is not flexible, currently, the other compile/link
options are ignored or hard-coded there. so, a substitution of
implementation method should be considered. but pass KBUILD_CFLAGS seems
not enough for we need make up the options for cc, ld, objdump, objcopy
tools in scripts/recordmcount.pl. perhaps CFLAGS, LDFLAGS and something
else should be passed from scripts/Makefile.build to
scripts/recordmcount.pl respectively.  

thanks!
Wu Zhangjin
