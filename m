Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g49HQpwJ004621
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 9 May 2002 10:26:51 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g49HQpU8004620
	for linux-mips-outgoing; Thu, 9 May 2002 10:26:51 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.to11.net (adsl-64-173-206-186.dsl.renocs.nvbell.net [64.173.206.186])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g49HQmwJ004617
	for <linux-mips@oss.sgi.com>; Thu, 9 May 2002 10:26:48 -0700
Received: from hmpiii2.trinity200.org (hmpiii2.trinity200.org [10.0.0.9])
	by mail.to11.net (Postfix) with ESMTP
	id B2D98168C0; Thu,  9 May 2002 10:28:07 -0700 (PDT)
Received: from hmpiii2.trinity200.org (tmoss@localhost [127.0.0.1])
	by hmpiii2.trinity200.org (8.12.1/8.12.1/Debian -5) with ESMTP id g49HS6tc027163;
	Thu, 9 May 2002 10:28:06 -0700
Received: (from tmoss@localhost)
	by hmpiii2.trinity200.org (8.12.1/8.12.1/Debian -5) id g49HS51o027161;
	Thu, 9 May 2002 10:28:05 -0700
X-Authentication-Warning: hmpiii2.trinity200.org: tmoss set sender to mips@to11.net using -f
Date: Thu, 9 May 2002 10:28:05 -0700
From: Tim Moss <mips@to11.net>
To: Karsten Merker <karsten@excalibur.cologne.de>
Cc: James Simmons <jsimmons@transvirtual.com>, linux-mips@oss.sgi.com
Subject: Re: Debian on Indy.
Message-ID: <20020509172805.GI23999@hmpiii2.trinity200.org>
References: <Pine.LNX.4.10.10205090938350.9983-100000@www.transvirtual.com> <20020509191945.K1913@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020509191945.K1913@excalibur.cologne.de>
User-Agent: Mutt/1.3.28i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Apparently, on Thu, May 09, 2002 at 07:19:45PM +0200, Karsten Merker wrote:
> On Thu, May 09, 2002 at 09:40:11AM -0700, James Simmons wrote:
> > 
> > I just recently attempted to install debian on a new indy I just got. I
> > entered the prom boot console and typed bootp()/tftpboot/tfptboot.img. It
> > failed. What steps am I missing?
> 
> Without more information on how it failed that is difficult to tell.
> Any logfile entries on the bootp/tftp server?
> Have you looked at http://www.linux-mips.org/technical_faq.html?
> There you can find a list of possible problems when netbooting an Indy.
> 
http://ftp.debian.org/debian/dists/woody/main/disks-mips/current/doc/ch-install-methods.en.html#s-install-tftp

In particular, make sure to set the two /proc settings on the tftp
server:
     echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc
     echo "2048 32767" > /proc/sys/net/ipv4/ip_local_port_range
