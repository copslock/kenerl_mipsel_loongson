Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 17:16:49 +0100 (CET)
Received: from mail-qy0-f202.google.com ([209.85.221.202]:47975 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493220AbZJZQQn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 17:16:43 +0100
Received: by qyk40 with SMTP id 40so1446028qyk.22
        for <multiple recipients>; Mon, 26 Oct 2009 09:16:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=ZeRPFbkNde/Yh2OIY1iDcaCmEPoDWcjMMcN8X+xltPg=;
        b=r3gUjrsbQ6OE/OG4MCeUKtBtKFTzIAEUXcZo+Lx1Cj9rA/Eq7DEQ3U61EIqtqzPQy5
         9NXVpPfhKytczd+I+RU9D7cGzkLUPTnaJPFOcEoqXgm3RA0YyIideA2xuU8EwokjLM7q
         CkMeX1RaUItBm2N4KBlZ+t5w2C8R2Ae+AmoRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=cFeY5DlNYKpF/LF1IhXMthBEDZ90zS7FJhc9JGsc14wcLCmbkSLqK1jEqadhgXMrip
         qalFSaBhsqTMonSxLHUlkoLVXluLy/l6AUiSAYw0Afoz+U3uFjuEleAWTcmEEQa28aoj
         2xXy1/NDyCDG+4WwBF98YPw5InoEzMLeFRhz4=
Received: by 10.224.82.11 with SMTP id z11mr7336875qak.87.1256573794442;
        Mon, 26 Oct 2009 09:16:34 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm4005004qyk.4.2009.10.26.09.16.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 09:16:31 -0700 (PDT)
Subject: Re: [PATCH -v6 05/13] tracing: enable
 HAVE_FUNCTION_TRACE_MCOUNT_TEST for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <fweisbec@gmail.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
In-Reply-To: <4AE5C344.4020104@ru.mvista.com>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
	 <747deea2f18d5ccffe842df95a9dd1c86251a958.1256569489.git.wuzhangjin@gmail.com>
	 <3f47087b70a965fd679b17a59521671296457df1.1256569489.git.wuzhangjin@gmail.com>
	 <f290e125634d164ec65b09b24b269815f78455ab.1256569489.git.wuzhangjin@gmail.com>
	 <07dc907ec62353b1aca99b2850d3b2e4b734189a.1256569489.git.wuzhangjin@gmail.com>
	 <374da7039d2e1b97083edd8bcd7811356884d427.1256569489.git.wuzhangjin@gmail.com>
	 <4AE5C344.4020104@ru.mvista.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Tue, 27 Oct 2009 00:16:20 +0800
Message-Id: <1256573780.5642.216.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-10-26 at 18:41 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> Wu Zhangjin wrote:
> 
> > There is an exisiting common ftrace_test_stop_func() in
> > kernel/trace/ftrace.c, which is used to check the global variable
> > ftrace_trace_stop to determine whether stop the function tracing.
> 
> > This patch implepment the MIPS specific one to speedup the procedure.
> 
> > Thanks goes to Zhang Le for Cleaning it up.
> 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> [...]
> 
> > diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
> > index 0c39bc8..5dfaca8 100644
> > --- a/arch/mips/kernel/mcount.S
> > +++ b/arch/mips/kernel/mcount.S
> > @@ -64,6 +64,10 @@
> >  	.endm
> >  
> >  NESTED(_mcount, PT_SIZE, ra)
> > +	lw	t0, function_trace_stop
> > +	bnez	t0, ftrace_stub
> > +	nop
> 
> 1) unless .set noreorder is specified in this file, explicit nop is not needed;
> 
> 2) delay slot instruction is usually denoted by adding extra space on its 
> left, like this:
> 
> 	bnez	t0, ftrace_stub
> 	 nop
> 

Okay, Will add an extra space for them later, thanks!

Regards,
	Wu Zhangjin
