Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8K5vkN13827
	for linux-mips-outgoing; Wed, 19 Sep 2001 22:57:46 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8K5vhe13823
	for <linux-mips@oss.sgi.com>; Wed, 19 Sep 2001 22:57:43 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f8K5vgr08350
	for linux-mips@oss.sgi.com; Thu, 20 Sep 2001 01:57:42 -0400
Date: Thu, 20 Sep 2001 01:57:42 -0400
From: Jim Paris <jim@jtan.com>
To: linux-mips@oss.sgi.com
Subject: native gcc-3.0.1?
Message-ID: <20010920015742.A8317@neurosis.mit.edu>
Reply-To: jim@jtan.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Does anyone have gcc-3.0.1 built as a native MIPS compiler?
I have a 3.0.1 cross-compiler that seems to work fine, but when I
cross-compiled a native gcc-3.0.1, it doesn't work:

# cat hello.c
main() 
{
    printf("hello, world\n");
}
# gcc -c hello.c
hello.c: In function 'main':
hello.c:4: Internal error: Illegal instruction
Please submit a full bug report
with preprocessed source if appropriate.
See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.

It's possible that

1) My kernel is broken.  I doubt this, only because the other
   possibilities seem more likely; I suppose I could add debugging
   output to all of the places where the kernel generates SIGILL
2) My cross-compiler is broken.  But, everything else it's compiled
   has worked fine, including relatively complicated programs like
   strace and bash.

It could also be that gcc-3.0.1 is simply broken when running natively
on MIPS.  Has anyone done this?  Any luck?

It's also possible (and I think likely) that my cross-compiler is
making wrong assumptions about the target system (since ./configure
can be pretty dumb when it comes to setting up a cross compile).  If
anyone has built gcc-3.0 or gcc-3.0.1 natively on MIPS, can you send
me the config.cache from your build?

I tried using my gcc-3.0.1 cross-compiler to build a native gcc-2.95.3
instead, but the newer GCCs doesn't seem to happy about building old
ones.  Grr..

-jim
