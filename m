Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5J9H9nC012982
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 02:17:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5J9H9jR012981
	for linux-mips-outgoing; Wed, 19 Jun 2002 02:17:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-131.ka.dial.de.ignite.net [62.180.196.131])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5J9H5nC012978
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 02:17:07 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5J9Hbl21969;
	Wed, 19 Jun 2002 11:17:37 +0200
Date: Wed, 19 Jun 2002 11:17:37 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: __access_ok
Message-ID: <20020619111737.B21533@dea.linux-mips.net>
References: <3D0DCDCB.252F5565@mips.com> <3D0E3E9C.4070702@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D0E3E9C.4070702@mvista.com>; from jsun@mvista.com on Mon, Jun 17, 2002 at 12:55:08PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 17, 2002 at 12:55:08PM -0700, Jun Sun wrote:

> Just to be nit-picking, the end point should be (addr + size - 1).

You better don't use the last bit of userspace and make that (addr + size).
Saves several kB on the entire kernel.

  Ralf
