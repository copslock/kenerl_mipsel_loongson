Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6H1gqX05294
	for linux-mips-outgoing; Mon, 16 Jul 2001 18:42:52 -0700
Received: from dea.waldorf-gmbh.de (u-16-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.16])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6H1gmV05291
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 18:42:49 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6H1Kt901266;
	Tue, 17 Jul 2001 03:20:55 +0200
Date: Tue, 17 Jul 2001 03:20:55 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Greg Johnson <gjohnson@superweasel.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Linux on a 100MHz r4000 indy?
Message-ID: <20010717032055.A1236@bacchus.dhis.org>
References: <20010716163712.B12104@superweasel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010716163712.B12104@superweasel.com>; from gjohnson@superweasel.com on Mon, Jul 16, 2001 at 04:37:12PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 16, 2001 at 04:37:12PM -0400, Greg Johnson wrote:

> I also have another indy with a 175MHz r4400.  This machine seems to
> work fine even without the fast-sysmips patch.  

This could be explained if you have different libraries, the one compiled for
MIPS II, the other one only for MIPS I on these two systems.  Sure you're
running the very same binaries?

> So what's the deal?  Are the r4000 and r4400 that different?

They're very similar, almost the same silicon.

> It's my understanding that both the r4000 and the r4400 support the ll/sc
> instructions.

> Should I expect bad/broken hardware on the r4000 machine?  

Depends.  The older R4000s were really buggy silicon and we don't
have all the workarounds needed to keep them happy.  So in theory if
circumstances are just right that can explain why you have so much
fun with the R4000 machine.

When the kernel is booting it prints a a line "CPU revision is: xxx"
where xxx is a 8 digit hex number.  What number?

  Ralf
