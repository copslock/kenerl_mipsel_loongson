Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jun 2008 16:48:32 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.169]:23291 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20035065AbYFVPsZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Jun 2008 16:48:25 +0100
Received: by ug-out-1314.google.com with SMTP id 30so274066ugs.39
        for <linux-mips@linux-mips.org>; Sun, 22 Jun 2008 08:48:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type;
        bh=95v2UbGhGdLHmOJIRAzehUaYM8I6s4YKVT+pFCtGZLc=;
        b=MHcRuCwN9DsrnBsAwffYIW6PF7mCL9P8bDSk5tsucgXL110B2gxxTictEgVVHwP7d+
         i8n8pt+0WqV+3ynT3PMMUw6KJsSq5WjGvPaoTDtdkItVgA8J5H51cz2Qiw58Xei69vUU
         Vmemp60QTi8HRTZt6vuTA5+gKf53Wq89pwe24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=w9CP1VszUZnduxUOQacy82i6FoTavW527uhNb4nlk6GYlP4v4WkP+QNt1fPNsvcn74
         ZZG+214xby+1tr+NsyznZFzerfqP8HT3dB6XWYHPYDsmXp3ncJed1Y/7EQFfTLuJDDnc
         dTTfgXT+3BrRQkooS956GKuN7wyuDEY0/wG9E=
Received: by 10.210.71.12 with SMTP id t12mr5015389eba.36.1214149703208;
        Sun, 22 Jun 2008 08:48:23 -0700 (PDT)
Received: by 10.210.23.7 with HTTP; Sun, 22 Jun 2008 08:48:23 -0700 (PDT)
Message-ID: <b2b2f2320806220848q179ace2y211701af50d3e650@mail.gmail.com>
Date:	Sun, 22 Jun 2008 09:48:23 -0600
From:	"Shane McDonald" <mcdonald.shane@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Question about the new "cca" kernel parameter
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8660_9086322.1214149703202"
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_8660_9086322.1214149703202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello:

  In the run-up to the 2.6.26 series of RCs, commit
351336929ccf222ae38ff0cb7a8dd5fd5c6236a0, [MIPS] Allow setting of the cache
attribute at run time, introduced a new kernel parameter, cca, which you can
use to specify the cache coherency attribute to be used in the system.  This
replaces the previous config parameter, CONFIG_MIPS_UNCACHED, to allow
finer-grained control over the CCA to be used.

  I'm running into a problem with this code, in that when I don't specify
the cca parameter on my boot line, it selects a default value that is not
the same as was used in 2.6.25 and previous kernel versions.  Before, the
CCA would be set to a value specified in the constant PAGE_CACHABLE_DEFAULT,
defined in include/asm-mips/pgtable-bits.h.  The relevant code in 2.6.25
was:

#ifdef CONFIG_MIPS_UNCACHED
#define PAGE_CACHABLE_DEFAULT   _CACHE_UNCACHED
#elif defined(CONFIG_DMA_NONCOHERENT)
#define PAGE_CACHABLE_DEFAULT   _CACHE_CACHABLE_NONCOHERENT
#elif defined(CONFIG_CPU_RM9000)
#define PAGE_CACHABLE_DEFAULT   _CACHE_CWB
#else
#define PAGE_CACHABLE_DEFAULT   _CACHE_CACHABLE_COW
#endif

For my system, CONFIG_DMA_NONCOHERENT is defined, so the CCA is set to
_CACHE_CACHABLE_NONCOHERENT (value of 3, writeback, on my PMC-Sierra
RM7035C-based system).

  After the commit, the CCA, if not set on the kernel boot line, is set to
the current value of the K0 field of the coprocessor 0 Config register.  In
my system's case, this code comes from the function coherency_setup() in
arch/mips/mm/c-r4k.c:

        if (cca < 0 || cca > 7)
                cca = read_c0_config() & CONF_CM_CMASK;
        _page_cachable_default = cca << _CACHE_SHIFT;

On my system, when this code is executed, the K0 field has a value of 0
(write-through without write-allocate) -- I'm not sure if this has been set
previously during the Linux bootup sequence, or if it would have been set
from the boot monitor (PMON in my case, for which I have no source code
specific to my system), or if it is using the default processor reset values
(undefined on my processor).  Anyways, the result is that my system uses a
CCA setting of 0 rather than 3, and I see much slower performance than I did
under 2.6.25.  Of course, I can specify "cca=3" on the command line to use
the previous setting, but I think it would be much nicer if this was handled
in the code.

  OK, so I guess what my question is, what would be the best way to fix
this, or am I the only one who is seeing this problem?  I could whip up a
patch for c-r4k.c that restores the previous behaviour as defined in
2.6.25's pgtable-bits.h, or I could set something up in my platform-specific
code to use a different value.  Suggestions?

  For the record, my system is a PMC-Sierra RM2881 "Xiao Hu" evaluation
board with a RM7035C processor.  It is based on the old ITE 8172G evaluation
board, whose support had become subject to bitrot and was finally removed in
2.6.19.  Support for the Xiao Hu is not in the l-m.o tree.

  Thanks for any guidance that you can provide me!

Shane McDonald

------=_Part_8660_9086322.1214149703202
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello:<br><br>&nbsp; In the run-up to the 2.6.26 series of RCs, commit 3513=
36929ccf222ae38ff0cb7a8dd5fd5c6236a0, [MIPS] Allow setting of the cache att=
ribute at run time, introduced a new kernel parameter, cca, which you can u=
se to specify the cache coherency attribute to be used in the system.&nbsp;=
 This replaces the previous config parameter, CONFIG_MIPS_UNCACHED, to allo=
w finer-grained control over the CCA to be used.<br>
<br>&nbsp; I&#39;m running into a problem with this code, in that when I do=
n&#39;t specify the cca parameter on my boot line, it selects a default val=
ue that is not the same as was used in 2.6.25 and previous kernel versions.=
&nbsp; Before, the CCA would be set to a value specified in the constant PA=
GE_CACHABLE_DEFAULT, defined in include/asm-mips/pgtable-bits.h.&nbsp; The =
relevant code in 2.6.25 was:<br>
<br>#ifdef CONFIG_MIPS_UNCACHED<br>#define PAGE_CACHABLE_DEFAULT&nbsp;&nbsp=
; _CACHE_UNCACHED<br>#elif defined(CONFIG_DMA_NONCOHERENT)<br>#define PAGE_=
CACHABLE_DEFAULT&nbsp;&nbsp; _CACHE_CACHABLE_NONCOHERENT<br>#elif defined(C=
ONFIG_CPU_RM9000)<br>
#define PAGE_CACHABLE_DEFAULT&nbsp;&nbsp; _CACHE_CWB<br>#else<br>#define PA=
GE_CACHABLE_DEFAULT&nbsp;&nbsp; _CACHE_CACHABLE_COW<br>#endif<br><br>For my=
 system, CONFIG_DMA_NONCOHERENT is defined, so the CCA is set to _CACHE_CAC=
HABLE_NONCOHERENT (value of 3, writeback, on my PMC-Sierra RM7035C-based sy=
stem).<br>
<br>&nbsp; After the commit, the CCA, if not set on the kernel boot line, i=
s set to the current value of the K0 field of the coprocessor 0 Config regi=
ster.&nbsp; In my system&#39;s case, this code comes from the function cohe=
rency_setup() in arch/mips/mm/c-r4k.c:<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cca &lt; 0 || cca &gt; 7=
)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cca =3D read_c0_config() &amp; CONF_CM_CMASK;<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _page_cachable_default =3D cca &lt;&l=
t; _CACHE_SHIFT;<br><br>On my system, when this code is executed, the K0 fi=
eld has a value of 0 (write-through without write-allocate) -- I&#39;m not =
sure if this has been set previously during the Linux bootup sequence, or i=
f it would have been set from the boot monitor (PMON in my case, for which =
I have no source code specific to my system), or if it is using the default=
 processor reset values (undefined on my processor).&nbsp; Anyways, the res=
ult is that my system uses a CCA setting of 0 rather than 3, and I see much=
 slower performance than I did under <a href=3D"http://2.6.25.">2.6.25.</a>=
&nbsp; Of course, I can specify &quot;cca=3D3&quot; on the command line to =
use the previous setting, but I think it would be much nicer if this was ha=
ndled in the code.<br>
<br>&nbsp; OK, so I guess what my question is, what would be the best way t=
o fix this, or am I the only one who is seeing this problem?&nbsp; I could =
whip up a patch for c-r4k.c that restores the previous behaviour as defined=
 in 2.6.25&#39;s pgtable-bits.h, or I could set something up in my platform=
-specific code to use a different value.&nbsp; Suggestions?<br>
<br>&nbsp; For the record, my system is a PMC-Sierra RM2881 &quot;Xiao Hu&q=
uot; evaluation board with a RM7035C processor.&nbsp; It is based on the ol=
d ITE 8172G evaluation board, whose support had become subject to bitrot an=
d was finally removed in <a href=3D"http://2.6.19.">2.6.19.</a>&nbsp; Suppo=
rt for the Xiao Hu is not in the l-m.o tree.<br>
<br>&nbsp; Thanks for any guidance that you can provide me!<br><br>Shane Mc=
Donald<br>

------=_Part_8660_9086322.1214149703202--
