Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7GFuGRw027590
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 16 Aug 2002 08:56:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7GFuFCr027589
	for linux-mips-outgoing; Fri, 16 Aug 2002 08:56:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-146.ka.dial.de.ignite.net [62.180.196.146])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7GFu6Rw027580
	for <linux-mips@oss.sgi.com>; Fri, 16 Aug 2002 08:56:11 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g7GFwba02794;
	Fri, 16 Aug 2002 17:58:37 +0200
Date: Fri, 16 Aug 2002 17:58:37 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Curtis Robinson <curtis@oushi.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: SGI O2 R5000
Message-ID: <20020816175837.B2597@linux-mips.org>
References: <20020816162112.GB29649@therocky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020816162112.GB29649@therocky>; from curtis@oushi.org on Fri, Aug 16, 2002 at 11:21:12AM -0500
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 16, 2002 at 11:21:12AM -0500, Curtis Robinson wrote:

> I know this question is probably asked alot.
> I tried looking at some of the mailing list archives.
> I wanted to know if it is possible to install Linux on SGI 02 R5000's
> I noticed there was support for R5000s, but not for R5000 that had CPU-controlled secondary
> cache.  I couldnt figure out how to find out if the 02 I have is one or the other.

O2 uses the builtin cache controller which people are currently adding
support for.

  Ralf
