Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAJA5lN14178
	for linux-mips-outgoing; Mon, 19 Nov 2001 02:05:47 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAJA5hW14171
	for <linux-mips@oss.sgi.com>; Mon, 19 Nov 2001 02:05:43 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAJ95Ff27568;
	Mon, 19 Nov 2001 20:05:15 +1100
Date: Mon, 19 Nov 2001 20:05:15 +1100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: renc stone <renwei@huawei.com>
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: ld error " linking PIC files with non-PIC files "
Message-ID: <20011119200514.A26473@dea.linux-mips.net>
References: <20011026161259.54925.qmail@web11908.mail.yahoo.com> <20011113200948.75977.qmail@web11908.mail.yahoo.com> <20011114111834.B10410@dea.linux-mips.net> <000a01c170d0$e8662000$101d690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000a01c170d0$e8662000$101d690a@huawei.com>; from renwei@huawei.com on Mon, Nov 19, 2001 at 04:05:09PM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 19, 2001 at 04:05:09PM +0800, renc stone wrote:

> That's the same problem as mine.
> I try to use 64bit long long div& mod in one module,
> and find I miss some _divdi3 and something like that.
> 
> when I try to link my module with libgcc.a, in my mipsel-glibc 2.95.3,
> the ld report the same thing.
> 
> Does it mean I can't use 64bit div in module? How to get rid of this error?

Again, it's a grave mistake to mix pic and non-pic libraries.

To solve this you must either supply your own non-pic versions of the
routines in question or - and better - try to avoid them.  In your case
take a look at <asm/div64.h> which supplies a 64-bit by 32-bit division
routine.

  Ralf
