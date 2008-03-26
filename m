Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2008 21:53:59 +0100 (CET)
Received: from web38810.mail.mud.yahoo.com ([209.191.125.101]:882 "HELO
	web38810.mail.mud.yahoo.com") by lappi.linux-mips.net with SMTP
	id S1102490AbYCZUxv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Mar 2008 21:53:51 +0100
Received: (qmail 30632 invoked by uid 60001); 26 Mar 2008 20:52:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=SIy4aSxtdi6BpAQIL0pAu6d3GtMukhoOeZ7ZKI5TSdhwnP2KcWKnjc39hwY1l7YVZgTnwwU0dIAltnZhu6HEdijflA7A02Y328WXSjHNTbypYUGEdZ0OjInFtwDHnd9ZcCUYL3Lv20efyIT53JULZthC/4C0O/7gR1btQkQhPkk=;
X-YMail-OSG: MndwsfYVM1kps35.Fk2AfEasnYAwkn0B9imQNf7cCLgFVKzh3riOPjDvKVBMOvG_x4eYTClpI33DNImliiiM6EcKbqANyEipIvNbHFJ4JZAnOehnt44-
Received: from [68.236.82.170] by web38810.mail.mud.yahoo.com via HTTP; Wed, 26 Mar 2008 13:52:42 PDT
Date:	Wed, 26 Mar 2008 13:52:42 -0700 (PDT)
From:	Larry Stefani <lstefani@yahoo.com>
Subject: Re: SB1250 locking up in init on current 2.6.16 kernel
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp, ths@networkno.de,
	flo@rfc822.org
In-Reply-To: <20080324203311.GB15294@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <926775.30590.qm@web38810.mail.mud.yahoo.com>
Return-Path: <lstefani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lstefani@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I used git bisect and narrowed the lockup to the
"[MIPS] Retire flush_icache_page from mm use." patch
(see git results below).  This is consistent with my
earlier testing and what Thiemo reported March 3 on
the linux.debian.kernel list.  I tried his patch (mark
pages tainted by PIO IDE as dirty) on 2.6.16.60, but
it didn't prevent the lockup.

Regards,
Larry Stefani
lstefani@yahoo.com

======================================================
/testkernels/linux> git bisect bad
Bisecting: 0 revisions left to test after this
[3a57f2ad7436d27dfa90717921b921fc3a168504] [MIPS]
Retire flush_icache_page from mm use.
/testkernels/linux> git bisect bad
3a57f2ad7436d27dfa90717921b921fc3a168504 is first bad
commit
commit 3a57f2ad7436d27dfa90717921b921fc3a168504
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Sat Aug 12 16:40:08 2006 +0100

    [MIPS] Retire flush_icache_page from mm use.

    On the 34K the redundant cache operations were
causing excessive stalls
    resulting in realtime code running on the second
VPE missing its deadline.
    For all other platforms this patch is just a
significant performance
    improvment as illustrated by below benchmark
numbers.

    Processor, Processes - times in microseconds -
smaller is better
   
------------------------------------------------------------------------------
    Host                 OS  Mhz null null      open
slct sig  sig  fork exec sh
                                 call  I/O stat clos
TCP  inst hndl proc proc proc
    --------- ------------- ---- ---- ---- ---- ----
---- ---- ---- ---- ---- ----
    25Kf      2.6.18-rc4     533 0.49 1.16 7.57 33.4
30.5 1.34 12.4 5497 17.K 54.K
    25Kf      2.6.18-rc4-p   533 0.49 1.16 6.68 23.0
30.7 1.36 8.55 5030 16.K 48.K
    4Kc       2.6.18-rc4      80 4.21 15.0 131. 289.
261. 16.5 258. 18.K 70.K 227K
    4Kc       2.6.18-rc4-p    80 4.34 13.1 128. 285.
262. 18.2 258. 12.K 52.K 176K
    34Kc      2.6.18-rc4      40 5.01 14.0 61.6 90.0
477. 17.9 94.7 29.K 108K 342K
    34Kc      2.6.18-rc4-p    40 4.98 13.9 61.2 89.7
475. 17.6 93.7 8758 44.K 158K
    BCM1480   2.6.18-rc4     700 0.28 0.60 3.68 5.92
16.0 0.78 5.08 931. 3163 15.K
    BCM1480   2.6.18-rc4-p   700 0.28 0.61 3.65 5.85
16.0 0.79 5.20 395. 1464 8385
    TX49-16K  2.6.18-rc3     197 0.73 2.41 19.0 37.8
82.9 2.94 17.5 4438 14.K 56.K
    TX49-16K  2.6.18-rc3-p   197 0.73 2.40 19.9 36.3
82.9 2.94 23.4 2577 9103 38.K
    TX49-32K  2.6.18-rc3     396 0.36 1.19 6.80 11.8
41.0 1.46 8.17 2738 8465 32.K
    TX49-32K  2.6.18-rc3-p   396 0.36 1.19 6.82 10.2
41.0 1.46 8.18 1330 4638 18.K

    Original patch by me with enhancements by Atsushi
Nemoto.

    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
    Signed-off-by: Atsushi Nemoto
<anemo@mba.ocn.ne.jp>
    (cherry picked from
4bbd62a93a1ab4b7d8a5b402b0c78ac265b35661 commit)

:040000 040000
6b4aeaca51e1f8974394f5c85c36cfcbf40984c9
2af41ed07f6c83962f9a4871812adb6f7c0dbee7 M      arch
:040000 040000
c2fb4be66f03aed2a1746d30f0e17922086eefdd
ab8cb20f7da9b97e72742946adfb5ab927dc777a M     
include
=====================================================



--- Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Mar 24, 2008 at 07:00:15AM -0700, Larry
> Stefani wrote:
> 
> > I've been trying to upgrade from 2.6.16.18 to
> > 2.6.16.60, but am seeing a hard lockup right
> before
> > "INIT: version 2.78 booting" on my SB1250-based
> board.
> > 
> > I found a related discussion on the Debian mailing
> > list:
> > 
> >
>
http://groups.google.com/group/linux.debian.bugs.dist/browse_thread/thread/b7159ee25106c7f9
> > 
> > However, after applying Thiemo's patch to mark
> pages
> > tainted by PIO IDE as dirty, the lockup still
> occurs.
> 
> It's a bug which should be fixed but nevertheless I
> can highly recommend
> something like a SiliconImage SATA controller - the
> onboard PIO PATA
> controller is so slow.
> 
> > I narrowed the file changes to
> > 
> >      arch/mips/mm/c-sb1.c
> >      arch/mips/mm/cache.c
> >      arch/mips/mm/init.c
> >      include/asm-mips/cache-flush.h
> >      include/asm-mips/page.h
> > 
> > between 2.6.16.27 and 2.6.16.29.  There was no
> > 2.6.16.28 tarball posted on linux-mips.org, so I
> > basically brought .27 to .29 until I found the
> > offending files.
> 
> I've pushed the tag again so now there is a tarball.
> 
> If you need to track something like this you're
> probably best with
> git bisect which should bring you right to the
> offending commit.
> 
> > Is anyone running a 2.6.16 kernel (after
> 2.6.16.27) on
> > a SB1250-based board?
> 
> Later kernels do run on bcm1480 which is close
> enough.
> 
>   Ralf
> 




      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ
