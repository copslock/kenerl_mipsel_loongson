Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 21:13:53 +0200 (CEST)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:49218 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493750AbZJVTNp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 21:13:45 +0200
Received: by fxm25 with SMTP id 25so9834192fxm.0
        for <multiple recipients>; Thu, 22 Oct 2009 12:13:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=JvspWnW02r2md57rO2pcGOYO1Dmk40iKrikzBLs4e8g=;
        b=ISqyWKj62uyzuXk2c++0DhYcYZBckfrc+rvmVxFRHiN/+zMOsVpHd+uyLVA17o4MmN
         HvbsPE62rQ3WiR3TTz24Q+wgOJmxQyAWDULlJuEPTL7bKpKyMn44JocfUEuf0Rm6LZr2
         rA39vaEgiL7C9ftOLqu4hvsivIalrBCnZU598=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=E+i5ewnceXTFOtdqDHOKR83fgYq0C6/Zhp9N6WMgUNbe6VsMqpbxdpd3d/vKthCTvZ
         BlyShgFOmQi0KIbWVncrvmDUF/QVwbCnRST3AClbr9ZUF2agBAzfKZ+b1A1rUkAXxdI2
         /5krL4ryyiW2NreXTwPXVMekfe6h49z8Gw+jQ=
Received: by 10.204.34.199 with SMTP id m7mr10030607bkd.48.1256238819345;
        Thu, 22 Oct 2009 12:13:39 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id k29sm2434213fkk.25.2009.10.22.12.13.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 12:13:38 -0700 (PDT)
Subject: Re: [PATCH -v4 4/9] tracing: add static function tracer support
 for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Richard Sandiford <rdsandiford@googlemail.com>,
	Adam Nemet <anemet@caviumnetworks.com>, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <4AE0A5BE.8000601@caviumnetworks.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	 <1256138686.18347.3039.camel@gandalf.stny.rr.com>
	 <1256233679.23653.7.camel@falcon>  <4AE0A5BE.8000601@caviumnetworks.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 23 Oct 2009 03:13:21 +0800
Message-Id: <1256238801.4848.6.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 2009-10-22 at 11:34 -0700, David Daney wrote:
> Wu Zhangjin wrote:
> > On Wed, 2009-10-21 at 11:24 -0400, Steven Rostedt wrote:
> [...]
> >>> +
> >>> +NESTED(_mcount, PT_SIZE, ra)
> >>> +	RESTORE_SP_FOR_32BIT
> >>> +	PTR_LA	t0, ftrace_stub
> >>> +	PTR_L	t1, ftrace_trace_function /* please don't use t1 later, safe? */
> >> Is t0 and t1 safe for mcount to use? Remember, mcount does not follow
> >> the dynamics of C function ABI.
> > 
> > So, perhaps we can use the saved registers(a0,a1...) instead.
> > 
> 
> a0..a7 may not always be saved.

I mean I have saved/restored them as the _mcount of /lib/libc.so.6 for
MIPS did, so I can use them safely.

> 
> You can use at, v0, v1 and all the temporary registers.  Note that for 
> the 64-bit ABIs sometimes the names t0-t4 shadow a4-a7.  So for a 64-bit 
> kernel, you can use: $1, $2, $3, $12, $13, $14, $15, $24, $25, noting 
> that at == $1 and contains the callers ra.  For a 32-bit kernel you can 
> add $8, $9, $10, and $11
> 

In a generic function, they should be okay, but _mcount is a little
specific. so, Not sure these rules are suitable to it or not.

> This whole thing seems a little fragile.
> 
> I think it might be a good idea to get input from Richard Sandiford, 
> and/or Adam Nemet about this approach (so I add them to the CC).
> 
> This e-mail thread starts here:
> 
> http://www.linux-mips.org/archives/linux-mips/2009-10/msg00286.html
> 
> and here:
> 
> http://www.linux-mips.org/archives/linux-mips/2009-10/msg00290.html

looking forward to their reply, thanks!

Regards!
	Wu Zhangjin
