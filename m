Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GAMD218552
	for linux-mips-outgoing; Mon, 16 Jul 2001 03:22:13 -0700
Received: from laxmls03.socal.rr.com (laxmls03.socal.rr.com [24.30.163.17])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GAM7V18546
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 03:22:08 -0700
Received: from compiler (sc-66-74-235-241.socal.rr.com [66.74.235.241])
	by laxmls03.socal.rr.com (8.11.2/8.11.1) with SMTP id f6GALZV14520;
	Mon, 16 Jul 2001 03:21:37 -0700 (PDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Shane Nay <shane@minirl.com>
To: James Simmons <jsimmons@transvirtual.com>, Pavel Machek <pavel@suse.cz>
Subject: Re: [ANNOUNCE] Secondary mips tree.
Date: Mon, 16 Jul 2001 03:22:40 -0700
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
References: <Pine.LNX.4.10.10107130800230.30223-100000@transvirtual.com>
In-Reply-To: <Pine.LNX.4.10.10107130800230.30223-100000@transvirtual.com>
MIME-Version: 1.0
Message-Id: <0107160322400A.02677@compiler>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Friday 13 July 2001 08:01, James Simmons wrote:
> > Good. I should definitely take a look. [Do you care about vr4130 or about
> > tx3912, too?]
>
> Yes. If you want to work on it no problem.

Huh, Very Cool.  I was getting ready to queue up a huge IRDA forward port in 
linux-vr to the 2.4.6 version.  (Still el-crashola on me right now)  The one 
in the present repository likes to overwrite userspace applications pretty 
much at randomn.

Maybe after things simmer down I'll port the Agenda hardware platform over to 
your repository, and Agenda can switch to using that.  linux-vr has been 
really really stale since we froze at our present version for toolchain 
reasons.  Those toolchain problems were fixed ages ago, but Mike & Brad who 
had been responsible for forward porting the kernel stopped doing that work 
for the most part.

Thanks,
Shane Nay.
