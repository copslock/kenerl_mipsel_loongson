Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2DAIMa04819
	for linux-mips-outgoing; Wed, 13 Mar 2002 02:18:22 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2DAII904816
	for <linux-mips@oss.sgi.com>; Wed, 13 Mar 2002 02:18:18 -0800
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id 1B7A4B4EC; Wed, 13 Mar 2002 10:18:17 +0100 (CET)
Date: Wed, 13 Mar 2002 10:18:17 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Nicolas Sauzede <nicolas.sauzede@t2m.fr>
Cc: linux-mips@oss.sgi.com
Subject: Re: fetched 2.4.16 source tree
Message-ID: <20020313101816.A5310@gandalf.physik.uni-konstanz.de>
Reply-To: debian-mips@lists.debian.org
Mail-Followup-To: Nicolas Sauzede <nicolas.sauzede@t2m.fr>,
	linux-mips@oss.sgi.com
References: <000701c1ca6e$40741fd0$fa4d3254@T2M.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000701c1ca6e$40741fd0$fa4d3254@T2M.lan>; from nicolas.sauzede@t2m.fr on Wed, Mar 13, 2002 at 10:05:41AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Nicolas,
On Wed, Mar 13, 2002 at 10:05:41AM +0100, Nicolas Sauzede wrote:
> I've got a working debian linux on my Indy, and I fetched the
> [kernel-source-2.4.16_2.4.16-1_all.deb] package
> but I couldn't recompile it !
> There are lots of warning and errors, both for kernel/modules
> I began patching (succesfully) ones concerning scsi, but there still remains
> keyboard and other part failing to compile..
> 
> Do I have to apply some special patch ??
The diff between mainline and the oss mips kernel is about 4MB so yes,
you need additional patches.

> I just D/L [kernel-patch-2.4.16-mips_2.4.16-0.011212.1_all.deb] => is it it
> ? Is it the best patch, for compiling sources on my Indy ?
kernel-patch-2.4.17 is latest. The manpage of make-kpkg describes how to
apply these patches automagically during build.
This is somewhat debian specific, let's move this over to the
debian-mips list.
 -- Guido
