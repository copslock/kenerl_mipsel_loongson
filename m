Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g49I29wJ005105
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 9 May 2002 11:02:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g49I29aD005104
	for linux-mips-outgoing; Thu, 9 May 2002 11:02:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g49I25wJ005101
	for <linux-mips@oss.sgi.com>; Thu, 9 May 2002 11:02:05 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g49I3M7M018668;
	Thu, 9 May 2002 11:03:22 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g49I3L7O018664;
	Thu, 9 May 2002 11:03:21 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Thu, 9 May 2002 11:03:21 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Tim Moss <mips@to11.net>
cc: Karsten Merker <karsten@excalibur.cologne.de>, linux-mips@oss.sgi.com
Subject: Re: Debian on Indy.
In-Reply-To: <20020509172805.GI23999@hmpiii2.trinity200.org>
Message-ID: <Pine.LNX.4.10.10205091055260.9983-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> Apparently, on Thu, May 09, 2002 at 07:19:45PM +0200, Karsten Merker wrote:
> > On Thu, May 09, 2002 at 09:40:11AM -0700, James Simmons wrote:
> > > 
> > > I just recently attempted to install debian on a new indy I just got. I
> > > entered the prom boot console and typed bootp()/tftpboot/tfptboot.img. It
> > > failed. What steps am I missing?
> > 
> > Without more information on how it failed that is difficult to tell.
> > Any logfile entries on the bootp/tftp server?
> > Have you looked at http://www.linux-mips.org/technical_faq.html?
> > There you can find a list of possible problems when netbooting an Indy.
> > 
> http://ftp.debian.org/debian/dists/woody/main/disks-mips/current/doc/ch-install-methods.en.html#s-install-tftp
> 
> In particular, make sure to set the two /proc settings on the tftp
> server:
>      echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc
>      echo "2048 32767" > /proc/sys/net/ipv4/ip_local_port_ran


Okay. Got it to boot. Now it fails with a bunch of SCSI errors. After it
complained it hanged. Any ideas or do you need th exact SCSI errors?
