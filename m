Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76FMN011195
	for linux-mips-outgoing; Mon, 6 Aug 2001 08:22:23 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76FMMV11192
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 08:22:22 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id B7A70125C3; Mon,  6 Aug 2001 08:22:19 -0700 (PDT)
Date: Mon, 6 Aug 2001 08:22:19 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Eric Christopher <echristo@redhat.com>
Cc: gcc@gcc.gnu.org, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
Message-ID: <20010806082219.A15666@lucon.org>
References: <20010805094806.A3146@lucon.org> <997107178.1253.7.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <997107178.1253.7.camel@ghostwheel.cygnus.com>; from echristo@redhat.com on Mon, Aug 06, 2001 at 03:12:56PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 06, 2001 at 03:12:56PM +0100, Eric Christopher wrote:
> 
> > I am working on will be the first gcc 3.x for Linux/mips. So there
> > shouldn't be any problems. Am I right?
> 
> I _think_ you are ok doing this.
> 
> I just noticed from your patch that you set the size to 32-bits.  Please
> set it to BITS_PER_WORD.
> 

BITS_PER_WORD is not right. That is what prompted me to make the
change.  There are a few things about the MIPS ABI:

1. We do follow the ABI part.
2. We care much less about the API part. That is in the section 6 where
wchar_t is defined.
3. On mips, sizeof (int) == sizeof (long int).

But BITS_PER_WORD can be 32 or 64, depending on TARGET_LONG64. As for
WCHAR_TYPE, it should be `int' regardless of TARGET_LONG64. For most of
the 64bit Linux targets, sizeof (int) should be 32bit. That means
WCHAR_TYPE_SIZE should be 32 for mips.


H.J.
