Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6AG5Tq29451
	for linux-mips-outgoing; Tue, 10 Jul 2001 09:05:29 -0700
Received: from dea.waldorf-gmbh.de (u-58-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.58])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6AG5RV29448
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 09:05:27 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6AFvWD31134;
	Tue, 10 Jul 2001 17:57:32 +0200
Date: Tue, 10 Jul 2001 17:57:32 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Barry Wu <wqb123@yahoo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Can mipsel linux support module?
Message-ID: <20010710175732.B29473@bacchus.dhis.org>
References: <20010707234715.80453.qmail@web13903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010707234715.80453.qmail@web13903.mail.yahoo.com>; from wqb123@yahoo.com on Sat, Jul 07, 2001 at 04:47:15PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 07, 2001 at 04:47:15PM -0700, Barry Wu wrote:

> I just port mipsel linux 2.2.12 to our hardware
> evaluation board. I want to modify a module
> to a character device driver. But I do not know
> how to do and which files to update. 
> Can mipsel linux support module? If so, which rpm
> do I have to download and where can I find them?
> If not, how can I  change a module to a character 
> device driver?

Latest modutils package from ftp.kernel.org should work out of the box.

  Ralf
