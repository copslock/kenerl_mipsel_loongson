Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAR7FoK08463
	for linux-mips-outgoing; Mon, 26 Nov 2001 23:15:50 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAR7Fmo08460
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 23:15:49 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAR6Fi031355;
	Tue, 27 Nov 2001 17:15:44 +1100
Date: Tue, 27 Nov 2001 17:15:44 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] const mips_io_port_base !?
Message-ID: <20011127171544.A29424@dea.linux-mips.net>
References: <20011127010214.B21296@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011127010214.B21296@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Nov 27, 2001 at 01:02:14AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 27, 2001 at 01:02:14AM +0100, Florian Lohoff wrote:

Blame whoever designed C that there is no sane way to give a variable an
attribute like "will never change again after the first initalization thus
keeping the value in a register beyond function calls and any other kind
of memory barrier is ok".  This inconsistence merily achieves a better
optimization of the code; the set_* function is intended to hide this cute
little standard violation away ...

  Ralf
