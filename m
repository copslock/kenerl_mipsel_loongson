Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2V1CYY13800
	for linux-mips-outgoing; Fri, 30 Mar 2001 17:12:34 -0800
Received: from dea.waldorf-gmbh.de (u-155-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.155])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2V1CVM13797
	for <linux-mips@oss.sgi.com>; Fri, 30 Mar 2001 17:12:32 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2V1CHV18339;
	Sat, 31 Mar 2001 03:12:17 +0200
Date: Sat, 31 Mar 2001 03:12:17 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Brady Brown <bbrown@ti.com>
Cc: SGI news group <linux-mips@oss.sgi.com>
Subject: Re: Tip build error
Message-ID: <20010331031217.A17423@bacchus.dhis.org>
References: <3AC39EC4.BB1E24B8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AC39EC4.BB1E24B8@ti.com>; from bbrown@ti.com on Thu, Mar 29, 2001 at 01:44:52PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Mar 29, 2001 at 01:44:52PM -0700, Brady Brown wrote:

> I pulled the CVS tip yesterday and had problems building it for ATLAS
> because of the changes to the set_cp0_config arguments. Patch below to
> arch/mips/mm/mips32.c of how I fixed this. I think this is the intended
> new use?

No, set_cp0_status only sets bits, clear_cp0_status clears bits,
change_cp0_status is the old set_cp0_status function.

I fixed this in CVS.

  Ralf
