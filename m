Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78F2lf11410
	for linux-mips-outgoing; Wed, 8 Aug 2001 08:02:47 -0700
Received: from thor ([207.246.91.243])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78F2gV11392;
	Wed, 8 Aug 2001 08:02:42 -0700
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA23865; Wed, 8 Aug 2001 11:02:44 -0400
Date: Wed, 8 Aug 2001 11:02:44 -0400
From: "J. Scott Kasten" <jsk@tetracon-eng.net>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Brandon Barker <bebarker@meginc.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Indy 64 or 32 bit?
In-Reply-To: <20010808121706.A602@bacchus.dhis.org>
Message-ID: <Pine.SGI.4.33.0108081042090.23638-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



On Wed, 8 Aug 2001, Ralf Baechle wrote:

> On Tue, Aug 07, 2001 at 08:45:17PM -0400, J. Scott Kasten wrote:

> Right circumstances = almost always.  Actually Linux makes sure that it's
> indeed always.

As long as our data doesn't make sparse use of the VM address space,
yes...  I always have to think of the worst case.  ;-)

> > Some of the old hands here could tell you better how Irix behaves on those
> > boxes.  I know you can compile code with 64 bit int and pointers and it
> > will run on those boxes under Irix, but there is a little more to it than
> > that.
>
> That's not supported on all systems.  An Indy for example is limited to
> 128mb RAM as shipped by SGI (256 with aftermarket parts).  There is no
> point in supporting 64-bit address space on such a system and so SGI doesn't
> support only N32.

Well, that actually brings to mind a nagging question I've had in regards
to just what N32 is.  Here's an example app and creative use of gcc:

/* Note: stdio.h deliberately left out to bypass some syntax issues. */

int main(int argc, char *agv[]) {
        int i, *j;

        printf(
          "sizeof(int) = %1d, sizeof(*) = %1d\n",
          sizeof(i),
          sizeof(j)
        );

        j = &i;
        *j = 10;
        i++;

        printf(
          "Result: %1d\n",
          (int) *j
        );

        return (0);
}

Compile:

   gcc -mips3 -mint64 test.c -o test

The file command says:

  test:           ELF N32 MSB mips-3 dynamic executable (not stripped) MIPS - version 1

Run:

  sizeof(int) = 8, sizeof(*) = 8
  Result: 11

If we look at the assembly, we see a sign extended 64 bit load, and a 64
bit add.  So we are indeed generating 64 bit instructions, at least in
some cases.

        dli $3,0xa # 10
        <snip>
        daddu $3,$2,1

Does N32 legitimately allow 64 bit instructions, or is this an example of
code that I've truely "munged" togeather?  It clearly works, at least in
this trivial case.

I'm just trying to solidify my understanding of what Irix is supposed to
do.
