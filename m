Received:  by oss.sgi.com id <S553813AbRCJTHG>;
	Sat, 10 Mar 2001 11:07:06 -0800
Received: from u-152-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.152]:37381
        "EHLO u-152-20.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553802AbRCJTGo>; Sat, 10 Mar 2001 11:06:44 -0800
Received: from dea ([193.98.169.28]:1427 "EHLO dea.waldorf-gmbh.de")
	by bacchus.dhis.org with ESMTP id <S867055AbRCJTG3>;
	Sat, 10 Mar 2001 20:06:29 +0100
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2AIPwo20402;
	Sat, 10 Mar 2001 19:25:58 +0100
Date:	Sat, 10 Mar 2001 19:25:58 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	nick@snowman.net, linux-mips@oss.sgi.com
Subject: Re: Problem makeing an O2 run bootp
Message-ID: <20010310192557.E15966@bacchus.dhis.org>
References: <20010306135856.E1184@bacchus.dhis.org> <Pine.LNX.4.21.0103062231010.23542-100000@ns> <20010308025751.G5830@hork>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010308025751.G5830@hork>; from csr6702@grace.rit.edu on Thu, Mar 08, 2001 at 02:57:51AM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Mar 08, 2001 at 02:57:51AM -0500, Chris Ruvolo wrote:

> On Tue, Mar 06, 2001 at 10:36:45PM -0500, nick@snowman.net wrote:
> > I've got an o2 that I'm trying to make netboot, and it seems to work,
> > however the o2 never acks the tftp packets.  The tcpdump is attached.  If
> > anyone has suggestions/ideas I'd love to hear them.  I booted the o2 and
> > ran "bootp():" from the arc prompt.
> 
> I had the same problem with my Indy.  I think this is in the HOWTO now, but
> in case you missed it..  If you are running your tftpd on Linux >= 2.3.x 
> 
> echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc
> 
> Worked for me.

Yep, it's in there:

  7.6.  My machine doesn't download the kernel when I try to netboot


  Your machine is replying to the BOOTP packets (you may verify this
  using a packet sniffer like tcpdump or ethereal), but doesn't download
  the kernel from your BOOTP server. This happens if your boot server is
  running a kernel of the 2.3 series or higher. The problem may be
  circumvented by doing a "echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc"
  as root on your boot server.

  Ralf
