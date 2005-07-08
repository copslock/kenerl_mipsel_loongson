Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 16:04:39 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:32005 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226358AbVGHPEV>; Fri, 8 Jul 2005 16:04:21 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 94226F59BA; Fri,  8 Jul 2005 17:04:52 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26863-10; Fri,  8 Jul 2005 17:04:52 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5FF96F59A6; Fri,  8 Jul 2005 17:04:52 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j68F4uR5001015;
	Fri, 8 Jul 2005 17:04:56 +0200
Date:	Fri, 8 Jul 2005 16:05:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Richard Sandiford <richard@codesourcery.com>
Cc:	Ralf Baechle DL5RB <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <87zmsx4do1.fsf@talisman.home>
Message-ID: <Pine.LNX.4.61L.0507081553040.25104@blysk.ds.pg.gda.pl>
References: <20050707091937Z8226163-3678+1737@linux-mips.org>
 <Pine.LNX.4.61L.0507071227170.3205@blysk.ds.pg.gda.pl> <20050707121235.GV1645@hattusa.textio>
 <Pine.LNX.4.61L.0507071314010.3205@blysk.ds.pg.gda.pl> <20050707122226.GW1645@hattusa.textio>
 <Pine.LNX.4.61L.0507071356450.3205@blysk.ds.pg.gda.pl> <20050707162959.GQ2822@linux-mips.org>
 <87zmsx4do1.fsf@talisman.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/972/Fri Jul  8 15:43:11 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 8 Jul 2005, Richard Sandiford wrote:

> Right.  I've always thought of them as the canonical options for gcc
> as well.  I think the only reason internal compilers like cc1 have
> -mel and -meb is because gcc's target options system has traditionally
> required every target option to begin with "-m".  (That's no longer
> a restriction in 4.1 FWIW.)

 I'm not sure relaxing this restriction is actually a good idea -- there 
may be tools external to GCC that make this assumption for additional 
handling of options passed to GCC.  I could imagine libtool being 
sensitive, for example (but that's just an assumption -- I haven't checked 
it).  And this classification of options -- "-f*" for optimization tweaks 
and "-m*" for target-dependent ones -- seems to be useful for humans (or 
at least one), too, as one does not to have to resort to documentation for 
every option encountered in Makefiles to have an idea about it.

> So contrary to what was said upthread, I've always treated
> the omission of these options from invoke.texi as deliberate.

 OK, I stand corrected.

> They're really internal compiler flags rather than user flags.

 Which actually happen to work...

> You should use -EL and -EB instead.

 ... unlike these.

 FWIW, I prepared the following patch for GCC 3.4.x the other day -- would 
you care to verify whether it's still needed for 4.x?  It may be worth 
applying to 3.4, too -- I think the branch hasn't got closed yet, has it?

2005-07-08  Maciej W. Rozycki  <macro@mips.com>

	* config/mips/linux.h (CC1_SPEC): Override defaults from
	config/linux.h.

 Unfortunately it won't let us remove the newly introduced hackery from 
Linux as (unlike you) we need to support versions back to 2.95.x.  
Therefore I sustain my proposal to use "-mel" and "-meb" as more reliable 
-- I'm pretty sure they used to work for 2.95.x, too.

  Maciej

gcc-3.4.4-20050617-linux-cc1-spec-0.patch
--- gcc/gcc/config/mips/linux.h	30 Jul 2004 15:33:08 -0000
+++ gcc/gcc/config/mips/linux.h	17 Jun 2005 19:59:20 -0000
@@ -101,6 +101,16 @@ Boston, MA 02111-1307, USA.  */
 %{fPIC|fPIE|fpic|fpie:-D__PIC__ -D__pic__} \
 %{pthread:-D_REENTRANT}"
 
+/* Merged from linux.h and mips/mips.h.  */
+#undef CC1_SPEC
+#define CC1_SPEC "\
+%{profile:-p} \
+%{gline:%{!g:%{!g0:%{!g1:%{!g2: -g1}}}}} \
+%{mips16*:%{!fno-section-relative-addressing:-fsection-relative-addressing -fno-common}} \
+%{fsection-relative-addressing:-fno-common} \
+%{G*} %{EB:-meb} %{EL:-mel} %{EB:%{EL:%emay not use both -EB and -EL}} \
+%(subtarget_cc1_spec)"
+
 /* From iris5.h */
 /* -G is incompatible with -KPIC which is the default, so only allow objects
    in the small data section if the user explicitly asks for it.  */
