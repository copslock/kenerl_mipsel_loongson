Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8IIgO704264
	for linux-mips-outgoing; Tue, 18 Sep 2001 11:42:24 -0700
Received: from nevyn.them.org (NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8IIgIe04256
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 11:42:22 -0700
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 15jPoH-0001fB-00; Tue, 18 Sep 2001 14:41:29 -0400
Date: Tue, 18 Sep 2001 14:41:29 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Siders, Keith" <keith_siders@toshibatv.com>
Cc: "'Zhang Fuxin'" <fxzhang@ict.ac.cn>, linux-mips@oss.sgi.com
Subject: Re: How to access kernel memory?
Message-ID: <20010918144129.A6259@nevyn.them.org>
References: <7DF7BFDC95ECD411B4010090278A44CA1B72E5@ATVX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <7DF7BFDC95ECD411B4010090278A44CA1B72E5@ATVX>; from keith_siders@toshibatv.com on Tue, Sep 18, 2001 at 09:59:07AM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Sep 18, 2001 at 09:59:07AM -0500, Siders, Keith wrote:
> I have just the opposite requirement. I need to allow any running process
> and its threads to be "hot-patched" with executable code. I know you're
> thinking "why?". I can't tell you that. I can only say  it's a firm
> requirement, and I could use some helpful ideas.

You can probably do all you need in this case with ptrace() - the
existing ptrace will not be quite adequate for large data sets,
especially if you need some atomicity, but it should have all the
sample kernel code you need.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
