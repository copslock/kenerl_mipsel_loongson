Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6OGNW123570
	for linux-mips-outgoing; Tue, 24 Jul 2001 09:23:32 -0700
Received: from dea.waldorf-gmbh.de (u-69-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6OGNUO23565
	for <linux-mips@oss.sgi.com>; Tue, 24 Jul 2001 09:23:30 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6OGNCV30868;
	Tue, 24 Jul 2001 18:23:12 +0200
Date: Tue, 24 Jul 2001 18:23:12 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Andrew Thornton <andrew.thornton@insignia.com>
Cc: James Simmons <jsimmons@transvirtual.com>,
   Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: ATI Victoria on Malta
Message-ID: <20010724182312.E27225@bacchus.dhis.org>
References: <00b201c11443$f02eae40$d11110ac@snow.isltd.insignia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00b201c11443$f02eae40$d11110ac@snow.isltd.insignia.com>; from andrew.thornton@insignia.com on Tue, Jul 24, 2001 at 02:24:16PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 24, 2001 at 02:24:16PM +0100, Andrew Thornton wrote:

> OK. I'm afraid I haven't got that much time to spare on this, which is why I
> asked if anyone else had managed this!
> 
> What I've got is linux-2.4.3.mips-src-01.00.tar.gz (from ftp.mips.com)
> patched to make the FPU emulator work reliably (taken from the mail list),

Sorry to destroy your illusions but we've got still a bunch of rather
tricky bugs in the fp emulation code.

  Ralf
