Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2007 14:46:46 +0000 (GMT)
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:11928 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021679AbXCPOqj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Mar 2007 14:46:39 +0000
Received: (qmail 45025 invoked from network); 16 Mar 2007 14:45:25 -0000
Received: from unknown (HELO lucon.org) (hjjean@sbcglobal.net@75.61.83.235 with login)
  by smtp101.sbc.mail.mud.yahoo.com with SMTP; 16 Mar 2007 14:45:25 -0000
X-YMail-OSG: zxf1obYVM1las8FBdBIYFQ0uXQBhvwnIwPwFSDd6SbzJXeH4RR4WLiK3evrhcV8xXNnpP654RIuFvinmdmbyuGe8Gwj1NA0sh5eLmuB4K8Zb7_MArfurS3MqrKr5S1VjgvevlEte1ZZMcic-
Received: by lucon.org (Postfix, from userid 500)
	id 34D0246EEB1; Fri, 16 Mar 2007 07:45:24 -0700 (PDT)
Date:	Fri, 16 Mar 2007 07:45:24 -0700
From:	"H. J. Lu" <hjl@lucon.org>
To:	Paul Koning <pkoning@equallogic.com>
Cc:	bug-binutils@gnu.org, linux-mips@linux-mips.org
Subject: Re: 'final link failed: Bad value' when building Linux/MIPS kernels.
Message-ID: <20070316144524.GA32203@lucon.org>
References: <45FA027E.2080901@realitydiluted.com> <17914.38675.653000.256@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17914.38675.653000.256@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.2.2i
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 16, 2007 at 09:09:39AM -0400, Paul Koning wrote:
> >>>>> "Steven" == Steven J Hill <sjhill@realitydiluted.com> writes:
> 
>  Steven> Greetings.  I have been chasing down a binutils regression
>  Steven> that is preventing me from building a Linux/MIPS kernel using
>  Steven> a gcc-4.2 based toolchain. Here is the snippet of output when
>  Steven> building a 2.6.12 kernel for my platform:
> 
>  Steven>      LD      drivers/mtd/maps/built-in.o
>  Steven>      LD      drivers/mtd/nand/built-in.o
>  Steven>      LD      drivers/mtd/built-in.o
>  Steven>    mipsel-linux-uclibc-ld: final link failed: Bad value
>  Steven>    make[1]: *** [drivers/mtd/built-in.o] Error 1
>  Steven>    make: *** [_module_drivers/mtd] Error 2
> 
> I've run into the same message when building things for a NetBSD/MIPS
> target.   I had assumed it was some error on my end.  
> 
> The problem with this message is that it is completely content-free.
> It doesn't contain a meaningful problem statement, and it doesn't say
> anything at all about where the problem is.  It doesn't even indicate
> what input file triggered the problem!   How is a user supposed to fix
> a failed build when this error message appears?  

Please file a bug report with all input files for the linker. I
will at least provide clear diagnostic messages.


H.J.
