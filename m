Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAS7tYL05849
	for linux-mips-outgoing; Tue, 27 Nov 2001 23:55:34 -0800
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAS7tUo05846
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 23:55:30 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id AE91D125C8; Tue, 27 Nov 2001 22:55:25 -0800 (PST)
Date: Tue, 27 Nov 2001 22:55:25 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: linux-gcc@vger.kernel.org, gcc@gcc.gnu.org,
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
Message-ID: <20011127225525.A10977@lucon.org>
References: <20011126212859.A17557@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011126212859.A17557@lucon.org>; from hjl@lucon.org on Mon, Nov 26, 2001 at 09:28:59PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 26, 2001 at 09:28:59PM -0800, H . J . Lu wrote:
> This is the beta release of binutils 2.11.92.0.12 for Linux, which is
> based on binutils 2001 1121 in CVS on sourecware.cygnus.com plus
> various changes. It is purely for Linux.
> 

I am planning to make a bug fix release before this weekend. I have
only one patch so far:

http://sources.redhat.com/ml/binutils/2001-11/msg00691.html

Please let me know there are any regressions over the previous Linux
binutils.

Thanks.


H.J.
