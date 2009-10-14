Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 21:12:45 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:44934 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493679AbZJNTMj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 21:12:39 +0200
Received: by fxm21 with SMTP id 21so110002fxm.33
        for <multiple recipients>; Wed, 14 Oct 2009 12:12:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=nfBzU0ZSaPoeGCbHmnPIiu/ElEYslIjwQ8sM3qouupM=;
        b=szEGjJWIz6NXH7cYRWkS2MGfHSXwnqdxsAmJX/KQOroL0QG/Ex9wYVFFX1eL0gvvNo
         mUxMAwlYmdF6SlPzgSPAtsCZMZ3u57sp587EmnILxfIeSmFDQwPCG6wEZuOertT9SW7n
         8s5NwqGl1HGClQq1WEBjwvRvbdpTRMf4Rn/co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kaeToyzOAyEBwScZtWcWcUwb2aSi1mLHcc59rf4YNjTL8P9ytEWdqHdEpeZV9vOKA1
         ZwrhZFjkc+w1k96IcXgh7SCScs31XziFF9a5Hauj2dyVw/yXMX39Kv3KkhVqXUCs5Fgu
         YH6DOSvFMpaSkRFTDiWVtqvMn4oW/jG7brFXw=
MIME-Version: 1.0
Received: by 10.223.15.73 with SMTP id j9mr2034212faa.85.1255547552882; Wed, 
	14 Oct 2009 12:12:32 -0700 (PDT)
In-Reply-To: <1255546939-3302-4-git-send-email-dmitri.vorobiev@movial.com>
References: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com>
	 <1255546939-3302-4-git-send-email-dmitri.vorobiev@movial.com>
Date:	Wed, 14 Oct 2009 21:12:32 +0200
Message-ID: <f861ec6f0910141212h562eda08le338842f90690419@mail.gmail.com>
Subject: Re: [PATCH 3/3] [MIPS] remove an unused header file
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=00151747be34e35fcd0475e9f123
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

--00151747be34e35fcd0475e9f123
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Oct 14, 2009 at 9:02 PM, Dmitri Vorobiev <dmitri.vorobiev@movial.com>
wrote:
> Nobody includes arch/mips/include/asm/mach-au1x00/prom.h, so remove
> this header file now.

My compiler disagrees:


  CC      arch/mips/alchemy/devboards/prom.o
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/alchemy/devboards/prom.c:34:18:
error: prom.h: No such file or directory
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/alchemy/devboards/prom.c:
In function 'prom_init':


It's pulled in through "#include <prom.h>" directives in the alchemy code.
The MIPS
Makefile adds mach directories to the gcc include paths so that this works.

        Manuel

--00151747be34e35fcd0475e9f123
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2009 at 9:02 PM, Dmitri Vorobiev &lt;<a href=3D"mailto:dmit=
ri.vorobiev@movial.com">dmitri.vorobiev@movial.com</a>&gt; wrote:<br>&gt; N=
obody includes arch/mips/include/asm/mach-au1x00/prom.h, so remove<br>&gt; =
this header file now.<br>
<br>My compiler disagrees:<br><br><br>=A0 CC=A0=A0=A0=A0=A0 arch/mips/alche=
my/devboards/prom.o<br>/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arc=
h/mips/alchemy/devboards/prom.c:34:18: error: prom.h: No such file or direc=
tory<br>
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/alchemy/devboard=
s/prom.c: In function &#39;prom_init&#39;:<br><br><br>It&#39;s pulled in th=
rough &quot;#include &lt;prom.h&gt;&quot; directives in the alchemy code.=
=A0 The MIPS<br>
Makefile adds mach directories to the gcc include paths so that this works.=
<br><br>=A0=A0=A0=A0=A0=A0=A0 Manuel<br>

--00151747be34e35fcd0475e9f123--
