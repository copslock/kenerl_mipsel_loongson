Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2G3xQY26031
	for linux-mips-outgoing; Thu, 15 Mar 2001 19:59:26 -0800
Received: from dea.waldorf-gmbh.de (u-57-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.57])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2G3xNM26028
	for <linux-mips@oss.sgi.com>; Thu, 15 Mar 2001 19:59:24 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2G3uqd02303;
	Fri, 16 Mar 2001 04:56:52 +0100
Date: Fri, 16 Mar 2001 04:56:52 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Tom Appermont <tea@sonycom.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: size of ioctl
Message-ID: <20010316045652.C1607@bacchus.dhis.org>
References: <20010315141658.A914@ginger.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010315141658.A914@ginger.sonytel.be>; from tea@sonycom.com on Thu, Mar 15, 2001 at 02:16:58PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Mar 15, 2001 at 02:16:58PM +0100, Tom Appermont wrote:

> I would like to see this changed because the PCMCIA software 
> (cardmgr <-> driver services) needs to pass ioctl messages 
> around that are a lot bigger than 256 bytes. 

As of today this is only historic garbage, so _IOC_SLMASK can go away.

  Ralf
