Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0FGkxP24580
	for linux-mips-outgoing; Tue, 15 Jan 2002 08:46:59 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0FGktP24577
	for <linux-mips@oss.sgi.com>; Tue, 15 Jan 2002 08:46:55 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 6D647125C1; Tue, 15 Jan 2002 07:46:52 -0800 (PST)
Date: Tue, 15 Jan 2002 07:46:52 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Brian Murphy <brian.murphy@eicon.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
Message-ID: <20020115074652.A18875@lucon.org>
References: <20020112222721.B26661@lucon.org> <Pine.GSO.3.96.1020114123630.10091C-100000@delta.ds2.pg.gda.pl> <20020114095028.C30946@lucon.org> <3C442721.76843A70@eicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C442721.76843A70@eicon.com>; from brian.murphy@eicon.com on Tue, Jan 15, 2002 at 01:57:05PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jan 15, 2002 at 01:57:05PM +0100, Brian Murphy wrote:
> "H . J . Lu" wrote:
> 
> > I should have made myself clearer. I do have X rpms. In fact, my RedHat
> > 7.1 mips port has XFree86 4.1 rpms. I just don't use them on my machine.
> > I simply can't afford to put X on it. My mips box is used to track gcc
> > 3.1, which breaks on Linux/mips almost every week, if not everyday. It
> > takes 2 days for me bootstrap/check gcc 3.1 on that box. I need
> > something simple to reproduce it.
> > 
> > H.J.
> 
> Is it possible for us to help? We have some machines here (Lasat
> Masquerade Pro)
> which have NEC VR5000 CPU's running at 266 MHz fitted with harddisk and
> running
> a 2.4.17 kernel. We currently have the debian mips distribution
> installed on 
> them. Perhaps the scripts you use to build/test gcc could be run on one
> of 
> these machines?

If you have some spare mips machines and want to help, you can check
out the gcc main trunk from CVS:

http://gcc.gnu.org/

You can build/check it and send in the test result. It has to be done
continuously since any checkin can break gcc on Linux/mips. You can
also check out glibc from CVS:

http://sources.redhat.com

and build/check it. The failed glibc tests should be sent to the glibc
mailing list.


H.J.
