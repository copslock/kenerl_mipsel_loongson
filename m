Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBAM0nP17212
	for linux-mips-outgoing; Mon, 10 Dec 2001 14:00:49 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBAM0go17207;
	Mon, 10 Dec 2001 14:00:43 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA01710; Mon, 10 Dec 2001 12:56:13 -0800 (PST)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA03969;
	Mon, 10 Dec 2001 21:24:55 +0100 (MET)
Date: Mon, 10 Dec 2001 21:24:54 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Ben Elliston <bje@redhat.com>, "H . J . Lu" <hjl@lucon.org>,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from /proc/cpuinfo?)
In-Reply-To: <20011210162826.D24680@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1011210211533.24010J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 10 Dec 2001, Ralf Baechle wrote:

> Agreed but the basic idea is good.  Also this solution is suitable for
> crosscompilation unlike the /proc/cpuinfo thing and doesn't rely on
> properly installed libraries and headers might possibly of interest for
> building standalone software.

 Hmm, I don't think config.guess is ever used for cross-compilation as the
script's purpose is to guess the host and you need to specify one
explicitly for a cross-compilation to happen.  Anyway it's saner not to
use build system properties to guess host system ones.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
