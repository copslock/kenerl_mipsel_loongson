Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARGlFt23651
	for linux-mips-outgoing; Tue, 27 Nov 2001 08:47:15 -0800
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARGlAo23646
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 08:47:10 -0800
Received: from localhost.localdomain (taarna.cygnus.com [205.180.230.102])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id HAA10220
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 07:47:08 -0800 (PST)
Received: (from aldyh@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id fARFn8e05821;
	Tue, 27 Nov 2001 09:49:08 -0600
X-Authentication-Warning: localhost.localdomain: aldyh set sender to aldyh@redhat.com using -f
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-gcc@vger.kernel.org, gcc@gcc.gnu.org,
   GNU C Library <libc-alpha@sourceware.cygnus.com>,
   Kenneth Albanowski <kjahds@kjahds.com>, Mat Hostetter <mat@lcs.mit.edu>,
   Andy Dougherty <doughera@lafcol.lafayette.edu>,
   Warner Losh <imp@village.org>, linux-mips@oss.sgi.com,
   Ron Guilmette <rfg@monkeys.com>,
   "Polstra; John" <linux-binutils-in@polstra.com>,
   "Hazelwood; Galen" <galenh@micron.net>,
   Ralf Baechle <ralf@mailhost.uni-koblenz.de>,
   Linas Vepstas <linas@linas.org>, Feher Janos <aries@hal2000.terra.vein.hu>,
   Leonard Zubkoff <lnz@dandelion.com>, "Steven J. Hill" <sjhill@cotw.com>,
   Murat_Berk@bmc.com
Subject: Re: The Linux binutils 2.11.92.0.12 is released.
References: <20011126212859.A17557@lucon.org>
From: Aldy Hernandez <aldyh@redhat.com>
Date: 27 Nov 2001 09:49:08 -0600
In-Reply-To: <20011126212859.A17557@lucon.org>
Message-ID: <m3zo58uscr.fsf@litecycle.cc.andrews.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> "H" == H J Lu <hjl@lucon.org> writes:

 > This is the beta release of binutils 2.11.92.0.12 for Linux, which is
 > based on binutils 2001 1121 in CVS on sourecware.cygnus.com plus
 > various changes. It is purely for Linux.

Ok, i am completely new to this... But why is it that we need a
separate binutils for linux?  Can't we stabilize what we have in
sources cvs and distribute this?

It seems like this is a duplication of work.

I'm sure i'm missing something.

Please enlighten me.
Aldy
