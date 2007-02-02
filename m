Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 20:18:43 +0000 (GMT)
Received: from an-out-0708.google.com ([209.85.132.251]:39686 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20039264AbXBBUSh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 20:18:37 +0000
Received: by an-out-0708.google.com with SMTP id c8so686729ana
        for <linux-mips@linux-mips.org>; Fri, 02 Feb 2007 12:18:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HufPr8SAQGtodUjxdB89Yx09Wtlo1N4ZvYfpppK7tLH4pUk1zb/9vzQw7grHekg/1v+cNn0JhaHesFoEZuvdvBRRdJmHCkoQAc8enRFVDU5eOMj/AuRntejDGO+6t6s8ttx7kiaOyW1UGrEPcj9ypCmeTdBgLp+miAoKANlKm+8=
Received: by 10.114.185.8 with SMTP id i8mr394085waf.1170447514538;
        Fri, 02 Feb 2007 12:18:34 -0800 (PST)
Received: by 10.114.134.16 with HTTP; Fri, 2 Feb 2007 12:18:34 -0800 (PST)
Message-ID: <cda58cb80702021218w23abcecet28a81444eea35265@mail.gmail.com>
Date:	Fri, 2 Feb 2007 21:18:34 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Daniel Jacobowitz" <dan@debian.org>
Subject: Re: Question about signal syscalls !
Cc:	"David Daney" <ddaney@avtrex.com>,
	"Ralf Baechle" <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20070202165356.GA30584@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com>
	 <20070201135734.GB12728@linux-mips.org>
	 <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com>
	 <45C21CFE.9060804@avtrex.com>
	 <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com>
	 <45C3611D.7000702@avtrex.com>
	 <cda58cb80702020836t54ab54bam1b83dd7c1dacb4d8@mail.gmail.com>
	 <20070202165356.GA30584@nevyn.them.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/2/07, Daniel Jacobowitz <dan@debian.org> wrote:
> On Fri, Feb 02, 2007 at 05:36:30PM +0100, Franck Bui-Huu wrote:
> > And now I'm starting to think that we don't need to save static regs in
> > setup_sigcontext() either...
>
> It's possible not to (iirc at least one arch does that) but please
>

crazy idea: do you think it could be possible not to when dealing with
interrupts ?

-- 
               Franck
