Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g250JZN04520
	for linux-mips-outgoing; Mon, 4 Mar 2002 16:19:35 -0800
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g250JW904516;
	Mon, 4 Mar 2002 16:19:32 -0800
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id PAA30416;
	Mon, 4 Mar 2002 15:19:32 -0800 (PST)
Date: Mon, 4 Mar 2002 15:19:31 -0800
From: Geoffrey Espin <espin@idiom.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: William Jhun <wjhun@ayrnetworks.com>, linux-mips@oss.sgi.com
Subject: Re: Compressed images?
Message-ID: <20020304151931.B9117@idiom.com>
References: <20020304120803.A1247@ayrnetworks.com> <20020304145709.A1332@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <20020304145709.A1332@oss.sgi.com>; from Ralf Baechle on Mon, Mar 04, 2002 at 02:57:09PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Mar 04, 2002 at 02:57:09PM -0800, Ralf Baechle wrote:
>                                                Right now we've got more
> than half a dozen variations of code to support compressed images throughout
> the kernel.  So I'm not going to accept any new patches for compressed
> images before this mess has been cleaned.  Volunteers :-)

Do you mean just the 'ad hoc' MIPS schemes, or across the whole gamut of
Linux architectures?

The problem isn't so much the compression mechanics, but the BSP/LSP.

It would be helpful if there was one architecture that was
considered the 'ideal'.  Though I haven't actually used it:
arch/ppc/boot appears very flexible, and adheres to a strict
layout and naming convention.

Geoff
--
Geoffrey Espin
espin@idiom.com
