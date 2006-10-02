Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Oct 2006 17:00:50 +0100 (BST)
Received: from omx1-ext.sgi.com ([192.48.179.11]:13959 "EHLO
	omx1.americas.sgi.com") by ftp.linux-mips.org with ESMTP
	id S20038834AbWJBQAs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Oct 2006 17:00:48 +0100
Received: from imr2.americas.sgi.com (imr2.americas.sgi.com [198.149.16.18])
	by omx1.americas.sgi.com (8.12.10/8.12.9/linux-outbound_gateway-1.1) with ESMTP id k92G0inx022557;
	Mon, 2 Oct 2006 11:00:44 -0500
Received: from spindle.corp.sgi.com (spindle.corp.sgi.com [198.29.75.13])
	by imr2.americas.sgi.com (8.12.9/8.12.10/SGI_generic_relay-1.2) with ESMTP id k92FtTDu57879940;
	Mon, 2 Oct 2006 08:55:29 -0700 (PDT)
Received: from schroedinger.engr.sgi.com (schroedinger.engr.sgi.com [163.154.5.55])
	by spindle.corp.sgi.com (SGI-8.12.5/8.12.9/generic_config-1.2) with ESMTP id k92G0hnB59520631;
	Mon, 2 Oct 2006 09:00:43 -0700 (PDT)
Received: from christoph (helo=localhost)
	by schroedinger.engr.sgi.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1GUQDj-0003CC-00; Mon, 02 Oct 2006 09:00:43 -0700
Date:	Mon, 2 Oct 2006 09:00:43 -0700 (PDT)
From:	Christoph Lameter <clameter@sgi.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	girishvg@gmail.com, linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix size of zones_size and zholes_size array
In-Reply-To: <20061001.233306.126574447.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0610020900040.12258@schroedinger.engr.sgi.com>
References: <20060930.033406.104030456.anemo@mba.ocn.ne.jp>
 <E3B3A030-E8D0-4BC3-8924-E88B3B43E53F@gmail.com> <20061001.233306.126574447.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <christoph@schroedinger.engr.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clameter@sgi.com
Precedence: bulk
X-list: linux-mips

On Sun, 1 Oct 2006, Atsushi Nemoto wrote:

> > Nemoto~san, this was your patch earlier.
> > 
> >   void __init paging_init(void)
> >   {
> > -	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
> > +	unsigned long zones_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
> >   	unsigned long max_dma, high, low;
> > +#ifdef CONFIG_SPARSEMEM
> > +	unsigned long zholes_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
> > +	unsigned long i, j, pfn;
> > +#endif
> 
> Yes.  This is correct.  And then there was a conflict on this commit.

Looks fine to me too. In that case you can drop the piece of my patch.
