Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 21:01:05 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.230]:52991 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022468AbXCWVBC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 21:01:02 +0000
Received: by wr-out-0506.google.com with SMTP id i31so1054540wra
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2007 14:00:00 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N+TzGWL90wa+6U6c5QM77QV25MfpllsDKjxGi6aBZ1cvbY/EO+TAsJhe7jbPJP8OfNjbvNc5Xydcg/Z0s5w9paTfCzvBuAEpA8Psevkg3F62nWodJIU5ttHOzv+nLZtbN2Rqrw2b4S2/yzy6NmNvBeVtmK/P0Cibu9TbK52A3p4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gzgDZtLq1LTlZ/+TZJJ5O2hobQKJPyPix6kNkhr9kbknKck8P2jX7pinyWmYg0HEZH7J/gUAPpo2ZlOU9XacVmA7fQl/fK/rbc91gRd8xxlf6PLSt1dPGTpF6sp6ccbqJT02K85NaeSd3Z1Dx8NAlvvx0g0cuOcFFO2zZBmnlpc=
Received: by 10.114.198.1 with SMTP id v1mr1397996waf.1174683600417;
        Fri, 23 Mar 2007 14:00:00 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Fri, 23 Mar 2007 14:00:00 -0700 (PDT)
Message-ID: <cda58cb80703231400n24023fahca5dee9608f90bba@mail.gmail.com>
Date:	Fri, 23 Mar 2007 22:00:00 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: flush_anon_page for MIPS
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070323152001.GA19477@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E1HUVlw-00034H-00@dorka.pomaz.szeredi.hu>
	 <20070323141939.GB17311@linux-mips.org>
	 <cda58cb80703230747w524409d7m3ee7753e676b0683@mail.gmail.com>
	 <20070323152001.GA19477@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/23/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> Let me illustrate this with a little example.  Assume we have a page at
> physical address 0x5000, a page size of 4kB, an 8kB direct mapped cache
> and 32-byte cache lines.  Then address bits 0..4 will be the byte index
> into the cache line, address bits 5..12 will index the cache array.  So
> now let's map our page into userspace, at address 0x12340000.  In KSEG0
> it is accessible at 0x80005000.  Now, compute the cache index for both
> addresses compare and curse ...
>

Yes but since the kernel page address is fixed, why not choosing
userspace page addresses to share the same kernel cache index ?
-- 
               Franck
