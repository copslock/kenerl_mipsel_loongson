Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f91A7np13340
	for linux-mips-outgoing; Mon, 1 Oct 2001 03:07:49 -0700
Received: from sunsite.ms.mff.cuni.cz (sunsite.ms.mff.cuni.cz [195.113.19.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f91A7iD13336
	for <linux-mips@oss.sgi.com>; Mon, 1 Oct 2001 03:07:44 -0700
Received: (from jj@localhost)
	by sunsite.ms.mff.cuni.cz (8.9.3/8.9.3) id MAA20642;
	Mon, 1 Oct 2001 12:10:53 +0200
Date: Mon, 1 Oct 2001 12:10:53 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Kjeld Borch Egevang <kjelde@mips.com>
Cc: "H . J . Lu" <hjl@lucon.org>,
   GNU C Library <libc-alpha@sourceware.cygnus.com>,
   linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: Re: PATCH: Update sysdeps/mips/fpu/libm-test-ulps
Message-ID: <20011001121053.F3251@sunsite.ms.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20010914111751.A17316@lucon.org> <Pine.LNX.4.30.0110011106360.16270-100000@coplin19.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.30.0110011106360.16270-100000@coplin19.mips.com>; from Kjeld Borch Egevang on Mon, Oct 01, 2001 at 11:38:16AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Oct 01, 2001 at 11:38:16AM +0200, Kjeld Borch Egevang wrote:
> I discovered a problem in glibc-2.2.4-11.2.src.rpm concerning QNaN and
> SNaN (quiet not-a-number and signalling not-a-number). It seems that
> NaN's are always interpreted the Intel-way.
> 
> In glibc-2.2.4/soft-fp/quad.h it says:
> 
> #define _FP_QNANBIT_Q           \
>         ((_FP_W_TYPE)1 << (_FP_FRACBITS_Q-2) % _FP_W_TYPE_SIZE)
> 
> But this is not correct on MIPS processors, where SNaNs has the bit set
> and QNaNs has the bit cleared.  Changing the definition above to 0 doesn't
> seem to solve the problem (I probably haven't found the root of the
> problem).

If you're changing _FP_QNANBIT_Q definition and testing it on double NaNs,
then certainly nothing should change.
The way soft-fp interprets Quiet NaNs is not just Intel-way, e.g. SPARC,
Alpha work the same way. E.g. on SPARC, signalling NaN is exp=max,
f=.0xxxxxxxxxx...xxx where at least one of the x bits is set, quiet NaN is
exp=max, f=.1xxxxxxxxxx...xxxxxx.
If MIPS has it backwards, then the solution definitely is not to set
_FP_QNANBIT_* there to 0, but instead define some boolean macro in
sfp-machine.h (_FP_QNAN_SET?, _FP_QNAN_SET == 1 iff Quiet Nan has
_FP_QNANBIT set, 0 otherwise) and use it in the soft-fp/* macros,
particularly in op-comon.h:
-        if (!(_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs))            \
+	 if (!(_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs) == !_FP_QNAN_SET)            \

-      _FP_FRAC_HIGH_RAW_##fs(X) |= _FP_QNANBIT_##fs;            \
+      if (_FP_QNAN_SET)					 \
+      _FP_FRAC_HIGH_RAW_##fs(X) |= _FP_QNANBIT_##fs;            \
+      else
+      _FP_FRAC_HIGH_RAW_##fs(X) &= ~_FP_QNANBIT_##fs;            \

-          && !(_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs))   \
+          && !(_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs) == !_FP_QNAN_SET)   \

and sed 's/_FP_QNANBIT_D/(_FP_QNAN_SET ? _FP_QNANBIT_D : 0)/g' soft-fp/testit.c

> The following piece of code gives the wrong result on a MIPS processor:
> 
> --------------------  cut here --------------
> #include <math.h>
> 
> typedef union {
>     long long ll;
>     double d;
> } t_number;
> 
> int main()
> {
>     t_number x, z;
> 
>     x.ll = 0x7ff7ffffffffffff; /* QNaN */
>     z.d = sqrt(x.d);
>     printf("%e %016llx\n", z.d, z.ll);
> }
> --------------------  cut here --------------
> 
> 
> The result is a signalling NaN:
> 
> nan 7ff8000000000000
> 
> (I expected 0x7ff7ffffffffffff)

	Jakub
