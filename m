Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78DPRP30005
	for linux-mips-outgoing; Wed, 8 Aug 2001 06:25:27 -0700
Received: from dea.waldorf-gmbh.de (u-168-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.168])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78DP9V29964
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 06:25:12 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f78DN9d03359;
	Wed, 8 Aug 2001 15:23:09 +0200
Date: Wed, 8 Aug 2001 15:23:09 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Phil Thompson <Phil.Thompson@pace.co.uk>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: Patch for i8259.c
Message-ID: <20010808152309.A3264@bacchus.dhis.org>
References: <54045BFDAD47D5118A850002A5095CC30AC56D@exchange1.cam.pace.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC56D@exchange1.cam.pace.co.uk>; from Phil.Thompson@pace.co.uk on Wed, Aug 08, 2001 at 11:24:51AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 11:24:51AM +0100, Phil Thompson wrote:

> Attached is a patch for i8259.c which fixes a problem where irq2 is setup
> before the irq_desc array is initialised.

Thanks, applied!

  Ralf
